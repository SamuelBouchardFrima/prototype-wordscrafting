package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class UIScrollElement extends Sprite
	{
		public function UIScrollElement(aSize:Point)
		{
			super();
			
			var halfSize:Point = aSize.clone();
			halfSize.normalize(aSize.length * 0.5);
			
			graphics.lineStyle(1, 0xCCCCCC);
			graphics.moveTo(4, -halfSize.y + 4);
			graphics.lineTo(aSize.x - 4, -halfSize.y + 4);
			graphics.lineTo(aSize.x - 4, halfSize.y - 4);
			graphics.lineTo(4, halfSize.y - 4);
			graphics.lineTo(4, -halfSize.y + 4);
		}
		
		public function Dispose():void
		{
		}
	}
}