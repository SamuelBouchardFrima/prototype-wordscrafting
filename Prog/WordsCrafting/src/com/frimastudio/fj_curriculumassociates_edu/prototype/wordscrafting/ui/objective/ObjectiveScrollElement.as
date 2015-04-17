package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.objective
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.objective.Objective;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIScrollElement;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ObjectiveScrollElement extends UIScrollElement
	{
		private var mObjective:Objective;
		private var mObjectiveField:TextField;
		private var mObjectiveIcon:Bitmap;
		
		public function ObjectiveScrollElement(aSize:Point, aObjective:Objective)
		{
			super(aSize);
			
			mObjective = aObjective;
			
			var buttonSize:Point = new Point(aSize.y - 5, aSize.y - 5);
			
			var format:TextFormat = new TextFormat();
			format.size = buttonSize.y * 0.75;
			format.align = "center";
			
			mObjectiveField = new TextField();
			mObjectiveField.width = aSize.x - (buttonSize.x * 2) - 4;
			mObjectiveField.height = buttonSize.y;
			mObjectiveField.x = 0;
			mObjectiveField.y = buttonSize.y * -0.5;
			mObjectiveField.text = mObjective.Name;
			mObjectiveField.selectable = false;
			mObjectiveField.setTextFormat(format);
			addChild(mObjectiveField);
			
			mObjectiveIcon = new Asset.ObjectiveButtonBitmap();
			mObjectiveIcon.width = buttonSize.x;
			mObjectiveIcon.height = buttonSize.y;
			mObjectiveIcon.x = (buttonSize.x * -0.5) + aSize.x - (buttonSize.x * 0.5) - 4;
			mObjectiveIcon.y = (buttonSize.y * -0.5);
			addChild(mObjectiveIcon);
			
			if (mObjective.Complete)
			{
				graphics.lineStyle(0, 0, 0);
				graphics.beginFill(0x00FF00);
				graphics.drawCircle(mObjectiveIcon.x + (mObjectiveIcon.width * 0.5),
					mObjectiveIcon.y + (mObjectiveIcon.height * 0.5), buttonSize.x * 0.5);
				graphics.endFill();
			}
		}
	}
}