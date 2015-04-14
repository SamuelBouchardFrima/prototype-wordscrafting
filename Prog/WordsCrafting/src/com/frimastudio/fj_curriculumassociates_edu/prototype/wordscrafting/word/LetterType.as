package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word {
	public class LetterType
	{
		public static var LIST:Array = [];
		public static var VOWEL:LetterType = new LetterType(0, "VOWEL");
		public static var CONSONANT:LetterType = new LetterType(1, "CONSONANT");
		//public static var HIGH_FREQUENCY:LetterType = new LetterType(2, "HIGH_FREQUENCY");
		//public static var LOW_FREQUENCY:LetterType = new LetterType(3, "LOW_FREQUENCY");
		
		private var mID:int;
		private var mDescription:String;
		
		public function get ID():int
		{
			return mID;
		}
		public function get Description():String
		{
			return mDescription;
		}
		
		public function LetterType(aID:int, aDescription:String)
		{
			mID = aID;
			mDescription = aDescription;
			
			LIST.push(this);
		}
	}
}