package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.util.Random;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.Food;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordPiece;
	
	public class Mini
	{
		protected var mSpriteSize:int;
		protected var mSpriteColor:int;
		protected var mKnownWordPieceList:Vector.<WordPiece>;
		
		public function get SpriteSize():int
		{
			return mSpriteSize;
		}
		
		public function get SpriteColor():int
		{
			return mSpriteColor;
		}
		
		public function Mini()
		{
			mKnownWordPieceList = new Vector.<WordPiece>();
		}
		
		public function Eat(aFood:Food):void
		{
			throw new Error("Eat is an abstract method that requires overriding.");
		}
		
		public function Produce(aWord:Word = null):WordPiece
		{
			if (!aWord)
			{
				return CreateRandomWordPiece();
			}
			
			// TODO:	fill mKnownWordPieceList with pieces of the correct type
			
			var possibleOutput:Vector.<WordPiece> = new Vector.<WordPiece>();
			for (var i:int = 0, end:int = aWord.PieceList.length; i < end; ++i)
			{
				if (mKnownWordPieceList.indexOf(aWord.PieceList[i]) != -1)
				{
					possibleOutput.push(aWord.PieceList[i]);
				}
			}
			return (possibleOutput.length > 0 ? Random.FromList(possibleOutput) : CreateRandomWordPiece());
		}
		
		protected function CreateRandomWordPiece():WordPiece
		{
			throw new Error("CreateRandomWordPiece is an abstract method that requires overriding.");
			return null;
		}
	}
}