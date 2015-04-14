package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class GroomingManager extends EventDispatcher implements IGroomingManager
	{
		private static var mInstance:GroomingManager = new GroomingManager();
		
		public static function get Instance():IGroomingManager
		{
			return mInstance;
		}
		
		public function GroomingManager(aTarget:IEventDispatcher = null)
		{
			super(aTarget);
			
			if (mInstance)
			{
				throw new Error("GroomingManager is a singleton, and thus not intended for instantiation. Use GroomingManager.Instance instead.");
			}
		}
	}
}