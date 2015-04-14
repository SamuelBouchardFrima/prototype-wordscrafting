package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class WordCraftingManager extends EventDispatcher implements IWordCraftingManager
	{
		private static var mInstance:WordCraftingManager = new WordCraftingManager();
		
		public static function get Instance():IWordCraftingManager
		{
			return mInstance;
		}
		
		public function WordCraftingManager(aTarget:IEventDispatcher = null)
		{
			super(aTarget);
			
			if (mInstance)
			{
				throw new Error("WordCraftingManager is a singleton, and thus not intended for instantiation. Use WordCraftingManager.Instance instead.");
			}
		}
	}
}