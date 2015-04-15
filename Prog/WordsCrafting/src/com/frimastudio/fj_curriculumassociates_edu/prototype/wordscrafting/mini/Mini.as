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
			
			var possibleOutput:Vector.<WordPiece> = new Vector.<WordPiece>();
			var possibleInput:Vector.<WordPiece> = new Vector.<WordPiece>();
			var i:int, endi:int;
			var j:int, endj:int;
			var possible:Boolean;
			for (i = 0, endi = aWord.PieceList.length; i < endi; ++i)
			{
				if (ValidateWordPieceType(aWord.PieceList[i]))
				{
					possible = false;
					for (j = 0, endj = mKnownWordPieceList.length; j < endj; ++j)
					{
						if (mKnownWordPieceList[j].PieceString == aWord.PieceList[i].PieceString)
						{
							possibleOutput.push(aWord.PieceList[i]);
							possible = true;
							break;
						}
					}
					if (!possible)
					{
						possibleInput.push(aWord.PieceList[i]);
					}
				}
			}
			
			if (possibleInput.length)
			{
				mKnownWordPieceList.push(Random.FromList(possibleInput));
			}
			
			trace("WordPieceList: " + mKnownWordPieceList);
			
			return (possibleOutput.length > 0 ? Random.FromList(possibleOutput) : CreateRandomWordPiece());
		}
		
		protected function ValidateWordPieceType(aWordPiece:WordPiece):Boolean
		{
			return true;
		}
		
		protected function CreateRandomWordPiece():WordPiece
		{
			throw new Error("CreateRandomWordPiece is an abstract method that requires overriding.");
			return null;
		}
	}
}