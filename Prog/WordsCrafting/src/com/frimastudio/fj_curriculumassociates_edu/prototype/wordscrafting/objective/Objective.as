package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.objective
{
	public class Objective
	{
		protected var mComplete:Boolean;
		protected var mName:String;
		
		public function get Complete():Boolean
		{
			return mComplete;
		}
		
		public function get Name():String
		{
			return mName;
		}
		
		public function Objective(aName:String)
		{
			mName = aName;
		}
		
		public function CompleteObjective(aValue:String):Boolean
		{
			throw new Error("CompleteObjective is abstract and requires overriding.");
			return mComplete;
		}
		
		public function toString():String
		{
			return "[Objective:" + mName + ":" + mComplete + "]";
		}
	}
}