package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.objective
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.objective.ObjectiveManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIScrollbox;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIScrollElement;
	import flash.geom.Point;
	
	public class ObjectiveScrollbox extends UIScrollbox
	{
		public function ObjectiveScrollbox(aSize:Point)
		{
			super(aSize);
			
			for (var i:int = 0, end:int = ObjectiveManager.Instance.ObjectiveList.length; i < end; ++i)
			{
				AddElement(new ObjectiveScrollElement(new Point(aSize.x, 30), ObjectiveManager.Instance.ObjectiveList[i]));
			}
		}
	}
}