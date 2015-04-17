package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.dictionary
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIScrollbox;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIScrollElement;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordCollection;
	import flash.geom.Point;
	
	public class DictionaryScrollbox extends UIScrollbox
	{
		public function DictionaryScrollbox(aSize:Point)
		{
			super(aSize);
			
			for each (var word:Word in WordCollection.Instance.Collection)
			{
				AddElement(new DictionaryScrollElement(new Point(aSize.x, 30), word));
			}
		}
	}
}