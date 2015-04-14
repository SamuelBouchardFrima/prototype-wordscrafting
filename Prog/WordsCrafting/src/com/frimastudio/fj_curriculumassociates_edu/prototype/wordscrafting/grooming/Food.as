package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming
{
	public class Food
	{
		private var mType:FoodType;
		
		public function get Type():FoodType
		{
			return mType;
		}
		
		public function Food(aType:FoodType)
		{
			mType = aType;
		}
	}
}