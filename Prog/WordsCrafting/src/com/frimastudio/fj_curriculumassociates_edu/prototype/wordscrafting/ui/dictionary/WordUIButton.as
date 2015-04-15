package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.dictionary
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import flash.geom.Point;
	
	public class WordUIButton extends UIButton
	{
		private var mWord:Word;
		
		public function get WordObject():Word
		{
			return mWord;
		}
		
		public function WordUIButton(aWord:Word)
		{
			super(new Point(395, 25), aWord.WordString);
			
			mWord = aWord;
		}
	}
}