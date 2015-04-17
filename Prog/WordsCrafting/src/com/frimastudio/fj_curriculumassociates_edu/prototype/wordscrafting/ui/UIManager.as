package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class UIManager extends EventDispatcher implements IUIManager
	{
		private static var mInstance:UIManager = new UIManager();
		
		public static function get Instance():IUIManager
		{
			return mInstance;
		}
		
		private var mUIContainer:Sprite;
		private var mCurrentUI:UI;
		
		public function get UIContainer():Sprite
		{
			return mUIContainer;
		}
		
		public function get CurrentUI():UI
		{
			return mCurrentUI;
		}
		public function set CurrentUI(aValue:UI):void
		{
			if (mCurrentUI)
			{
				mCurrentUI.Dispose();
				mUIContainer.removeChild(mCurrentUI);
			}
			
			mCurrentUI = aValue;
			mUIContainer.addChild(mCurrentUI);
		}
		
		public function UIManager(aTarget:IEventDispatcher = null)
		{
			super(aTarget);
			
			if (mInstance)
			{
				throw new Error("UIManager is a singleton not intended for instantiation. Use UIManager.Instance instead.");
			}
			
			mUIContainer = new Sprite();
		}
	}
}