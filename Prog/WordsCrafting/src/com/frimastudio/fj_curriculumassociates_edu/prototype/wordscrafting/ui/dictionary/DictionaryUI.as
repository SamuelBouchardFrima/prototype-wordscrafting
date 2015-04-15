package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.dictionary
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.IconUIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordCollection;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class DictionaryUI extends UI
	{
		private var mHomeButton:UIButton;
		private var mCraftingButton:UIButton;
		private var mCollectionWindow:Sprite;
		private var mCollection:Sprite;
		private var mWordButtonList:Vector.<UIButton>;
		private var mScrolling:Boolean;
		private var mMouseYDelta:Number;
		
		public function DictionaryUI()
		{
			super();
			
			var buttonSize:Point = new Point(50, 50);
			
			mHomeButton = new IconUIButton(buttonSize, Asset.HomeButtonBitmap);
			mHomeButton.x = 50;
			mHomeButton.y = 50;
			addChild(mHomeButton);
			mHomeButton.addEventListener(MouseEvent.CLICK, OnClickHomeButton);
			
			mCraftingButton = new IconUIButton(buttonSize, Asset.CraftingButtonBitmap);
			mCraftingButton.x = 750;
			mCraftingButton.y = 50;
			addChild(mCraftingButton);
			mCraftingButton.addEventListener(MouseEvent.CLICK, OnClickCraftingButton);
			
			graphics.lineStyle(3);
			graphics.moveTo(198, 98);
			graphics.lineTo(602, 98);
			graphics.lineTo(602, 502);
			graphics.lineTo(198, 502);
			graphics.lineTo(198, 98);
			
			mCollectionWindow = new Sprite();
			mCollectionWindow.scrollRect = new Rectangle(-200, 0, 600, 400);
			mCollectionWindow.x = 200;
			mCollectionWindow.y = 100;
			addChild(mCollectionWindow);
			
			mCollection = new Sprite();
			mCollection.x = 0;
			mCollection.y = 0;
			mCollection.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownCollection);
			mCollectionWindow.addChild(mCollection);
			
			mWordButtonList = new Vector.<UIButton>();
			var wordButton:UIButton;
			var offset:int = 15;
			for each (var word:Word in WordCollection.Instance.Collection)
			{
				wordButton = new WordUIButton(word);
				wordButton.x = 0;
				wordButton.y = offset;
				wordButton.addEventListener(MouseEvent.CLICK, OnClickWordButton);
				mCollection.addChild(wordButton);
				mWordButtonList.push(wordButton);
				offset += 30;
			}
		}
		
		override public function Dispose():void
		{
			mHomeButton.removeEventListener(MouseEvent.CLICK, OnClickHomeButton);
			mCraftingButton.removeEventListener(MouseEvent.CLICK, OnClickCraftingButton);
			mCollection.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownCollection);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			for (var i:int = 0, end:int = mWordButtonList.length; i < end; ++i)
			{
				mWordButtonList[i].removeEventListener(MouseEvent.CLICK, OnClickWordButton);
			}
			
			super.Dispose();
		}
		
		private function OnClickHomeButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.HOME.UIClass();
		}
		
		private function OnClickCraftingButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.CRAFTING.UIClass();
		}
		
		private function OnMouseDownCollection(aEvent:MouseEvent):void
		{
			mScrolling = false;
			mMouseYDelta = mouseY;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			if (mCollection.height <= 400)
			{
				return;
			}
			
			mScrolling = true;
			
			mCollection.y += mouseY - mMouseYDelta;
			mCollection.y = MathUtil.MinMax(mCollection.y, 396 - mCollection.height, 0);
			
			mMouseYDelta = mouseY;
		}
		
		private function OnMouseUp(aEvent:MouseEvent):void
		{
			if (!mScrolling)
			{
				return;
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		private function OnClickWordButton(aEvent:MouseEvent):void
		{
			if (mScrolling)
			{
				return;
			}
			
			UIManager.Instance.CurrentUI = new UIType.CRAFTING.UIClass((aEvent.currentTarget as WordUIButton).WordObject);
		}
	}
}