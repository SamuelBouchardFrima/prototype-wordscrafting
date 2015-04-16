package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.util.Random;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.Food;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.FoodType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.LetterType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.LetterWordPiece;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordPiece;
	import flash.utils.Dictionary;
	
	public class LetterMini extends Mini
	{
		private static var sLetterDistribution:Dictionary;
		private static var sVowel:String;
		private static var sConsonant:String;
		private static var sRandom:String;
		private static var sHighFrequency:String;
		private static var sLowFrequency:String;
		
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
				case LetterType.RANDOM:
					mSpriteColor = 0x00FF00;
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
		
		private function CreateDistributedList(aList:String, aDistribution:Dictionary):String
		{
			var distributedList:String = "";
			var emptyList:Vector.<String> = new <String>["", "", "", "", "", "", "", "", "", "", "", ""];
			var i:int, end:int;
			var char:String;
			for (i = 0, end = aList.length; i < end; ++i)
			{
				char = aList.charAt(i);
				distributedList += emptyList.slice(0, aDistribution[char] + 1).join(char);
			}
			return distributedList;
		}
		
		public function LetterMini(aType:LetterType)
		{
			super();
			
			if (!sVowel)
			{
				var distribution:Dictionary = new Dictionary();
				distribution["a"] = 9;
				distribution["b"] = 2;
				distribution["c"] = 2;
				distribution["d"] = 4;
				distribution["e"] = 12;
				distribution["f"] = 2;
				distribution["g"] = 3;
				distribution["h"] = 2;
				distribution["i"] = 9;
				distribution["j"] = 1;
				distribution["k"] = 1;
				distribution["l"] = 4;
				distribution["m"] = 2;
				distribution["n"] = 6;
				distribution["o"] = 8;
				distribution["p"] = 2;
				distribution["q"] = 1;
				distribution["r"] = 6;
				distribution["s"] = 4;
				distribution["t"] = 6;
				distribution["u"] = 4;
				distribution["v"] = 2;
				distribution["w"] = 2;
				distribution["x"] = 1;
				distribution["y"] = 2;
				distribution["z"] = 1;
				
				sVowel = CreateDistributedList("aeiou", distribution);
				sConsonant = CreateDistributedList("bcdfghjklmnpqrstvwxyz", distribution);
				sRandom = CreateDistributedList("abcdefghijklmnopqrstuvwxyz", distribution);
				sHighFrequency = CreateDistributedList("adehilnorstu", distribution);
				sLowFrequency = CreateDistributedList("bcfgjkmpqvwxyz", distribution);
				
				trace("Vowel " + sVowel);
				trace("Consonant " + sConsonant);
				trace("Random " + sRandom);
				trace("HighFrequency " + sHighFrequency);
				trace("LowFrequency " + sLowFrequency);
			}
			
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
				case FoodType.CUPCAKE:
					Type = LetterType.RANDOM;
					break;
				default:
					throw new Error("FoodType " + aFood.Type.Description + " is not handled.");
					return;
			}
		}
		
		override public function Produce(aWord:Word = null):WordPiece
		{
			if (mType == LetterType.RANDOM)
			{
				return CreateRandomWordPiece();
			}
			
			return super.Produce(aWord);
		}
		
		override protected function ValidateWordPieceType(aWordPiece:WordPiece):Boolean
		{
			switch (mType)
			{
				case LetterType.VOWEL:
					return sVowel.indexOf(aWordPiece.PieceString) != -1;
				case LetterType.CONSONANT:
					return sConsonant.indexOf(aWordPiece.PieceString) != -1;
				case LetterType.RANDOM:
					return true;
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
				case LetterType.RANDOM:
					return new LetterWordPiece(mType, Random.FromString(sRandom));
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