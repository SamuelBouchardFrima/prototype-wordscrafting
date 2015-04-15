package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini.Mini;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini.MiniManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class MiniInteractionUI extends UI
	{
		private var mHomeButton:UIButton;
		protected var mMiniList:Vector.<Sprite>;
		
		public function MiniInteractionUI()
		{
			super();
			
			var buttonSize:Point = new Point(50, 50);
			
			mHomeButton = new IconUIButton(buttonSize, Asset.HomeButtonBitmap);
			mHomeButton.x = 50;
			mHomeButton.y = 50;
			addChild(mHomeButton);
			mHomeButton.addEventListener(MouseEvent.CLICK, OnClickHomeButton);
			
			mMiniList = new Vector.<Sprite>();
			var sprite:Sprite;
			for (var i:int = 0, end:int = MiniManager.Instance.MiniList.length; i < end; ++i)
			{
				sprite = CreateMiniSprite(MiniManager.Instance.MiniList[i]);
				sprite.x = (800 / (end + 1)) * (i + 1);
				sprite.y = 400;
				addChild(sprite);
				mMiniList.push(sprite);
			}
		}
		
		override public function Dispose():void
		{
			mHomeButton.removeEventListener(MouseEvent.CLICK, OnClickHomeButton);
			
			super.Dispose();
		}
		
		protected function CreateMiniSprite(aMini:Mini):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(aMini.SpriteColor);
			sprite.graphics.lineStyle(2, 0x000000);
			sprite.graphics.drawCircle(0, 0, aMini.SpriteSize / 2);
			sprite.graphics.endFill();
			var bitmap:Bitmap = new Asset.MiniBitmap();
			bitmap.width = aMini.SpriteSize;
			bitmap.height = aMini.SpriteSize;
			bitmap.x = bitmap.width * -0.5;
			bitmap.y = bitmap.height * -0.5;
			sprite.addChild(bitmap);
			return sprite;
		}
		
		private function OnClickHomeButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.HOME.UIClass();
		}
	}
}