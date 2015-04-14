package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming
{
	public class FoodType
	{
		public static var LIST:Array = [];
		public static var PIZZA:FoodType = new FoodType(0, "PIZZA");
		public static var COFFEE:FoodType = new FoodType(1, "COFFEE");
		
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
		
		public function FoodType(aID:int, aDescription:String)
		{
			mID = aID;
			mDescription = aDescription;
			
			LIST.push(this);
		}
	}
}