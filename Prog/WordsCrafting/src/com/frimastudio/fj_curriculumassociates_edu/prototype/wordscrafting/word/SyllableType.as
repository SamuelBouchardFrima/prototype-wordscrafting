package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word {
	public class SyllableType
	{
		public static var LIST:Array = [];
		public static var RHYME:SyllableType = new SyllableType(0, "RHYME");
		public static var TWO_LETTERS:SyllableType = new SyllableType(1, "TWO_LETTERS");
		public static var THREE_LETTERS:SyllableType = new SyllableType(2, "THREE_LETTERS");
		public static var FOUR_LETTERS:SyllableType = new SyllableType(3, "FOUR_LETTERS");
		
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
		
		public function SyllableType(aID:int, aDescription:String)
		{
			mID = aID;
			mDescription = aDescription;
			
			LIST.push(this);
		}
	}
}