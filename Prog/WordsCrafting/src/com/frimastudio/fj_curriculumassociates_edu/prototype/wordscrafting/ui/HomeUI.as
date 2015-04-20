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
		private var mObjectiveButton:UIButton;
		
		public function HomeUI()
		{
			super();
			
			var buttonSize:Point = new Point(100, 100);
			
			mGroomingButton = new IconUIButton(buttonSize, Asset.GroomingButtonBitmap);
			mGroomingButton.x = 175;
			mGroomingButton.y = 300;
			mGroomingButton.addEventListener(MouseEvent.CLICK, OnClickGroomingButton);
			addChild(mGroomingButton);
			
			mDictionaryButton = new IconUIButton(buttonSize, Asset.DictionaryButtonBitmap);
			mDictionaryButton.x = 325;
			mDictionaryButton.y = 300;
			mDictionaryButton.addEventListener(MouseEvent.CLICK, OnClickDictionaryButton);
			addChild(mDictionaryButton);
			
			mCraftingButton = new IconUIButton(buttonSize, Asset.CraftingButtonBitmap);
			mCraftingButton.x = 475;
			mCraftingButton.y = 300;
			mCraftingButton.addEventListener(MouseEvent.CLICK, OnClickCraftingButton);
			addChild(mCraftingButton);
			
			mObjectiveButton = new IconUIButton(buttonSize, Asset.ObjectiveButtonBitmap);
			mObjectiveButton.x = 625;
			mObjectiveButton.y = 300;
			mObjectiveButton.addEventListener(MouseEvent.CLICK, OnClickObjectiveButton);
			addChild(mObjectiveButton);
		}
		
		override public function Dispose():void
		{
			mCraftingButton.removeEventListener(MouseEvent.CLICK, OnClickCraftingButton);
			mGroomingButton.removeEventListener(MouseEvent.CLICK, OnClickGroomingButton);
			mDictionaryButton.removeEventListener(MouseEvent.CLICK, OnClickDictionaryButton);
			mObjectiveButton.removeEventListener(MouseEvent.CLICK, OnClickObjectiveButton);
			
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
		
		private function OnClickObjectiveButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.OBJECTIVE.UIClass();
		}
	}
}