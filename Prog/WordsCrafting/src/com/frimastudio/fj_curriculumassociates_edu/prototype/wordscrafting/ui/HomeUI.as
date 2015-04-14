package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class HomeUI extends UI
	{
		private var mCraftingButton:UIButton;
		private var mGroomingButton:UIButton;
		private var mDictionaryButton:UIButton;
		
		public function HomeUI()
		{
			super();
			
			var buttonSize:Point = new Point(100, 100);
			
			mCraftingButton = new IconUIButton(buttonSize, Asset.CraftingButtonBitmap);
			mCraftingButton.x = 200;
			mCraftingButton.y = 300;
			addChild(mCraftingButton);
			mCraftingButton.addEventListener(MouseEvent.CLICK, OnClickCraftingButton);
			
			mGroomingButton = new IconUIButton(buttonSize, Asset.GroomingButtonBitmap);
			mGroomingButton.x = 400;
			mGroomingButton.y = 300;
			addChild(mGroomingButton);
			mGroomingButton.addEventListener(MouseEvent.CLICK, OnClickGroomingButton);
			
			mDictionaryButton = new IconUIButton(buttonSize, Asset.DictionaryButtonBitmap);
			mDictionaryButton.x = 600;
			mDictionaryButton.y = 300;
			addChild(mDictionaryButton);
			mDictionaryButton.addEventListener(MouseEvent.CLICK, OnClickDictionaryButton);
		}
		
		override public function Dispose():void
		{
			mCraftingButton.removeEventListener(MouseEvent.CLICK, OnClickCraftingButton);
			mGroomingButton.removeEventListener(MouseEvent.CLICK, OnClickGroomingButton);
			mDictionaryButton.removeEventListener(MouseEvent.CLICK, OnClickDictionaryButton);
			
			super.Dispose();
		}
		
		private function OnClickCraftingButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.CRAFTING.UIClass();
		}
		
		private function OnClickGroomingButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.GROOMING.UIClass();
		}
		
		private function OnClickDictionaryButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.DICTIONARY.UIClass();
		}
	}
}