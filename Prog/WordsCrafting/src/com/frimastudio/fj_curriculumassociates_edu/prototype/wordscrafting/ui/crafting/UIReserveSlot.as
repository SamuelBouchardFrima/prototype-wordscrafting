package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.CraftingReserve;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordPiece;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class UIReserveSlot extends Sprite
	{
		private var mIndex:int;
		private var mTagBox:Sprite;
		private var mTag:TextField;
		private var mTagFormat:TextFormat;
		
		public function get Index():int
		{
			return mIndex;
		}
		
		public function UIReserveSlot(aIndex:int)
		{
			super();
			
			mIndex = aIndex;
			
			graphics.beginFill(0x000000, 0);
			graphics.lineStyle(1, 0xCCCCCC);
			graphics.moveTo(-30, -30);
			graphics.lineTo(30, -30);
			graphics.lineTo(30, 30);
			graphics.lineTo(-30, 30);
			graphics.lineTo(-30, -30);
			graphics.endFill();
			
			mTagBox = new Sprite();
			mTagBox.graphics.lineStyle(2, 0x999999);
			mTagBox.graphics.moveTo(-25, -25);
			mTagBox.graphics.lineTo(25, -25);
			mTagBox.graphics.lineTo(25, 25);
			mTagBox.graphics.lineTo(-25, 25);
			mTagBox.graphics.lineTo(-25, -25);
			
			mTag = new TextField();
			mTag.width = 50;
			mTag.height = 50;
			mTag.x = -25;
			mTag.y = -25;
			mTag.selectable = false;
			
			mTagFormat = new TextFormat();
			mTagFormat.size = mTag.height * 0.75;
			mTagFormat.bold = true;
			mTagFormat.align = "center";
			
			UpdateTag();
		}
		
		public function UpdateTag():void
		{
			var piece:WordPiece = CraftingReserve.Instance.ReserveList[mIndex];
			if (piece)
			{
				mTag.text = piece.PieceString;
				mTag.setTextFormat(mTagFormat);
				
				addChild(mTagBox);
				addChild(mTag);
			}
			else
			{
				if (contains(mTagBox))
				{
					removeChild(mTagBox);
					removeChild(mTag);
				}
			}
		}
	}
}