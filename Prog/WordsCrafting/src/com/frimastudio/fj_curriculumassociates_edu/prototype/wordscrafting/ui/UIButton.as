package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class UIButton extends Sprite
	{
		private var mSize:Point;
		private var mColor:int;
		
		public function set Color(aValue:int):void
		{
			mColor = aValue;
			
			graphics.lineStyle(2);
			graphics.beginFill(mColor);
			graphics.moveTo(mSize.x * -0.5, mSize.y * -0.5);
			graphics.lineTo(mSize.x * 0.5, mSize.y * -0.5);
			graphics.lineTo(mSize.x * 0.5, mSize.y * 0.5);
			graphics.lineTo(mSize.x * -0.5, mSize.y * 0.5);
			graphics.lineTo(mSize.x * -0.5, mSize.y * -0.5);
			graphics.endFill();
		}
		
		public function UIButton(aSize:Point, aLabel:String = null, aColor:int = 0xFFFFFF)
		{
			super();
			
			mSize = aSize;
			Color = aColor;
			
			if (aLabel)
			{
				var format:TextFormat = new TextFormat();
				format.size = aSize.y * 0.75;
				format.bold = true;
				format.align = "center";
				
				var label:TextField = new TextField();
				label.text = aLabel;
				label.x = aSize.x * -0.5;
				label.y = aSize.y * -0.5;
				label.width = aSize.x;
				label.height = aSize.y;
				label.selectable = false;
				label.setTextFormat(format);
				label.autoSize = TextFieldAutoSize.CENTER;
				addChild(label);
			}
		}
	}
}