package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word {
	public class ComponentType
	{
		public static var LIST:Array = [];
		public static var ROOT:ComponentType = new ComponentType(0, "ROOT");
		public static var SUFFIX:ComponentType = new ComponentType(1, "SUFFIX");
		public static var PREFFIX:ComponentType = new ComponentType(2, "PREFFIX");
		public static var OTHER_AFFIX:ComponentType = new ComponentType(3, "OTHER_AFFIX");
		
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
		
		public function ComponentType(aID:int, aDescription:String)
		{
			mID = aID;
			mDescription = aDescription;
			
			LIST.push(this);
		}
	}
}