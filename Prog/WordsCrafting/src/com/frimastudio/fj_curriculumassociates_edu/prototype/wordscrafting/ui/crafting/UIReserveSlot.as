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
		private var mTag:TextField;
		
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
			graphics.moveTo(-50, -50);
			graphics.lineTo(50, -50);
			graphics.lineTo(50, 50);
			graphics.lineTo(-50, 50);
			graphics.lineTo(-50, -50);
			graphics.endFill();
			
			mTag = new TextField();
			mTag.width = 100;
			mTag.height = 25;
			mTag.x = -50;
			mTag.y = -12.5;
			mTag.selectable = false;
			addChild(mTag);
			UpdateTag();
		}
		
		public function UpdateTag():void
		{
			mTag.text = "";
			var list:Vector.<WordPiece> = CraftingReserve.Instance.ReserveList[mIndex];
			if (list)
			{
				for (var i:int = 0, end:int = list.length; i < end; ++i)
				{
					mTag.appendText(list[i].PieceString);
				}
				
				var format:TextFormat = new TextFormat();
				format.size = mTag.height * 0.75;
				format.bold = true;
				format.align = "center";
				mTag.setTextFormat(format);
			}
		}
	}
}