package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting
{
	public class Asset
	{
		[Embed(source = "../../../../../../art/icon-home-128.png")]
		public static var HomeButtonBitmap:Class;
		[Embed(source = "../../../../../../art/icon-radio.png")]
		public static var CraftingButtonBitmap:Class;
		[Embed(source = "../../../../../../art/icon-food.png")]
		public static var GroomingButtonBitmap:Class;
		[Embed(source = "../../../../../../art/icon-book.png")]
		public static var DictionaryButtonBitmap:Class;
		
		[Embed(source = "../../../../../../art/icon-mini.png")]
		public static var MiniBitmap:Class;
		[Embed(source = "../../../../../../art/icon-pizza.png")]
		public static var PizzaButtonBitmap:Class;
		[Embed(source = "../../../../../../art/icon-coffe-maker.png")]
		public static var CoffeeButtonBitmap:Class;
		
		[Embed(source = "../../../../../../art/icon-pizza-part.png")]
		public static var PizzaFoodBitmap:Class;
		[Embed(source = "../../../../../../art/icon-coffee-cup.png")]
		public static var CoffeeFoodBitmap:Class;
		
		public function Asset()
		{
			throw new Error("Asset is a static class not intended for instantiation.");
		}
	}
}