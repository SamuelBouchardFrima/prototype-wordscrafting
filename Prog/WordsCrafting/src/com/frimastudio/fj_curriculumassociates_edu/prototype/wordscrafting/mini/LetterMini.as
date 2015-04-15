package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.util.Random;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.Food;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.FoodType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.LetterType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.LetterWordPiece;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordPiece;
	
	public class LetterMini extends Mini
	{
		private static const sVowel:String = "aeiou";
		private static const sConsonant:String = "bcdfghjklmnpqrstvwxyz";
		private static const sHighFrequency:String = "adehilnorstu";
		private static const sLowFrequency:String = "bcfgjkmpqvwxyz";
		
		private var mType:LetterType;
		
		public function get Type():LetterType
		{
			return mType;
		}
		public function set Type(aValue:LetterType):void
		{
			mType = aValue;
			
			switch (mType)
			{
				case LetterType.VOWEL:
					mSpriteColor = 0xFF0000;
					break;
				case LetterType.CONSONANT:
					mSpriteColor = 0x0000FF;
					break;
				//case LetterType.HIGH_FREQUENCY:
					//mSpriteColor = 0xFFFF00;
					//break;
				//case LetterType.LOW_FREQUENCY:
					//mSpriteColor = 0xFF00FF;
					//break;
				default:
					throw new Error("LetterType " + mType.Description + " is not handled.");
					return;
			}
		}
		
		public function LetterMini(aType:LetterType)
		{
			super();
			
			Type = aType;
			mSpriteSize = 50;
			
			var character:String, valid:Boolean;
			var i:int, end:int;
			while (mKnownWordPieceList.length < 3)
			{
				character = Random.FromString(sHighFrequency);
				valid = true;
				for (i = 0, end = mKnownWordPieceList.length; i < end; ++i)
				{
					if (mKnownWordPieceList[i].PieceString == character)
					{
						valid = false;
						break;
					}
				}
				if (valid)
				{
					mKnownWordPieceList.push(new WordPiece(character));
				}
			}
		}
		
		override public function Eat(aFood:Food):void
		{
			switch (aFood.Type)
			{
				case FoodType.PIZZA:
					Type = LetterType.VOWEL;
					break;
				case FoodType.COFFEE:
					Type = LetterType.CONSONANT;
					break;
				default:
					throw new Error("FoodType " + aFood.Type.Description + " is not handled.");
					return;
			}
		}
		
		override protected function ValidateWordPieceType(aWordPiece:WordPiece):Boolean
		{
			switch (mType)
			{
				case LetterType.VOWEL:
					return sVowel.indexOf(aWordPiece.PieceString) != -1;
				case LetterType.CONSONANT:
					return sConsonant.indexOf(aWordPiece.PieceString) != -1;
				//case LetterType.HIGH_FREQUENCY:
					//return sHighFrequency.indexOf(aWordPiece.PieceString) != -1;
				//case LetterType.LOW_FREQUENCY:
					//return sLowFrequency.indexOf(aWordPiece.PieceString) != -1;
				default:
					throw new Error("LetterType " + mType.Description + " is not handled.");
					return false;
			}
		}
		
		override protected function CreateRandomWordPiece():WordPiece
		{
			switch (mType)
			{
				case LetterType.VOWEL:
					return new LetterWordPiece(mType, Random.FromString(sVowel));
				case LetterType.CONSONANT:
					return new LetterWordPiece(mType, Random.FromString(sConsonant));
				//case LetterType.HIGH_FREQUENCY:
					//return new LetterWordPiece(mType, Random.FromString(sHighFrequency));
				//case LetterType.LOW_FREQUENCY:
					//return new LetterWordPiece(mType, Random.FromString(sLowFrequency));
				default:
					throw new Error("LetterType " + mType.Description + " is not handled.");
					return null;
			}
		}
	}
}