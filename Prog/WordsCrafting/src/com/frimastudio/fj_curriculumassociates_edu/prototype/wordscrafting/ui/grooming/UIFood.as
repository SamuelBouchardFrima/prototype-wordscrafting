package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.grooming
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.FoodType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.IconUIButton;
	import flash.geom.Point;
	
	public class UIFood extends IconUIButton
	{
		private var mType:FoodType;
		
		public function get Type():FoodType
		{
			return mType;
		}
		
		public function UIFood(aType:FoodType)
		{
			super(new Point(50, 50), AssetPerFoodType(aType), 0xFFFFFF);
			
			mType = aType;
		}
		
		private function AssetPerFoodType(aType:FoodType):Class
		{
			switch (aType)
			{
				case FoodType.PIZZA:
					return Asset.PizzaFoodBitmap;
				case FoodType.COFFEE:
					return Asset.CoffeeFoodBitmap;
				case FoodType.CUPCAKE:
					return Asset.CupcakeFoodBitmap;
				default:
					throw new Error("Food type " + aType.Description + " not handled.");
					return null;
			}
		}
	}
}