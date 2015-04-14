package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting.CraftingUI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.dictionary.DictionaryUI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.grooming.GroomingUI;
	
	public class UIType
	{
		public static var HOME:UIType = new UIType(0, "HOME", HomeUI);
		public static var CRAFTING:UIType = new UIType(1, "CRAFTING", CraftingUI);
		public static var GROOMING:UIType = new UIType(2, "GROOMING", GroomingUI);
		public static var DICTIONARY:UIType = new UIType(3, "DICTIONARY", DictionaryUI);
		
		private var mID:int;
		private var mDescription:String;
		private var mUIClass:Class;
		
		public function get ID():int
		{
			return mID;
		}
		public function get Description():String
		{
			return mDescription;
		}
		public function get UIClass():Class
		{
			return mUIClass;
		}
		
		public function UIType(aID:int, aDescription:String, aUIClass:Class)
		{
			mID = aID;
			mDescription = aDescription;
			mUIClass = aUIClass;
		}
	}
}