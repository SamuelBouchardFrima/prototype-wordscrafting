package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.dictionary
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.IconUIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.MiniInteractionUI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIType;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class DictionaryUI extends MiniInteractionUI
	{
		private var mCraftingButton:UIButton;
		
		public function DictionaryUI()
		{
			super();
			
			var buttonSize:Point = new Point(50, 50);
			
			mCraftingButton = new IconUIButton(buttonSize, Asset.CraftingButtonBitmap);
			mCraftingButton.x = 750;
			mCraftingButton.y = 50;
			addChild(mCraftingButton);
			mCraftingButton.addEventListener(MouseEvent.CLICK, OnClickCraftingButton);
		}
		
		override public function Dispose():void
		{
			mCraftingButton.removeEventListener(MouseEvent.CLICK, OnClickCraftingButton);
			
			super.Dispose();
		}
		
		private function OnClickCraftingButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.CRAFTING.UIClass();
		}
	}
}