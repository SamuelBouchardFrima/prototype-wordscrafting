package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	public class IconUIButton extends UIButton
	{
		public function IconUIButton(aSize:Point, aIconAsset:Class, aColor:int = 0xFFFFFF)
		{
			super(aSize, null, aColor);
			
			var icon:Bitmap = new aIconAsset();
			icon.width = aSize.x * 0.9;
			icon.height = aSize.y * 0.9;
			icon.x = icon.width * -0.5;
			icon.y = icon.height * -0.5;
			addChild(icon);
		}
	}
}