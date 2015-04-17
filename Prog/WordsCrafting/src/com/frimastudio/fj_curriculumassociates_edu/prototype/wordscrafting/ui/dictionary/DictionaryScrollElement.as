package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.dictionary
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.objective.ObjectiveManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.IconUIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIScrollElement;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordCollection;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class DictionaryScrollElement extends UIScrollElement
	{
		private var mWord:Word;
		private var mWordField:TextField;
		private var mRadioButton:UIButton;
		private var mObjectiveButton:UIButton;
		
		public function DictionaryScrollElement(aSize:Point, aWord:Word)
		{
			super(aSize);
			
			mWord = aWord;
			
			var buttonSize:Point = new Point(aSize.y - 5, aSize.y - 5);
			
			var format:TextFormat = new TextFormat();
			format.size = buttonSize.y * 0.75;
			format.align = "center";
			
			mWordField = new TextField();
			mWordField.width = aSize.x - (buttonSize.x * 2) - 12;
			mWordField.height = buttonSize.y;
			mWordField.x = 0;
			mWordField.y = buttonSize.y * -0.5;
			mWordField.text = mWord.WordString;
			mWordField.selectable = false;
			mWordField.setTextFormat(format);
			addChild(mWordField);
			
			mRadioButton = new IconUIButton(buttonSize, Asset.RadioSignalBitmap);
			mRadioButton.x = aSize.x - (buttonSize.x * 1.5) - 8;
			mRadioButton.y = 0;
			mRadioButton.addEventListener(MouseEvent.CLICK, OnClickRadioButton);
			addChild(mRadioButton);
			
			var objective:Boolean = ObjectiveManager.Instance.HasWordObjective(mWord);
			mObjectiveButton = new IconUIButton(buttonSize, Asset.ObjectiveButtonBitmap, (objective ? 0x00FF00 : 0xFF0000));
			mObjectiveButton.x = aSize.x - (buttonSize.x * 0.5) - 4;
			mObjectiveButton.y = 0;
			if (objective)
			{
				mObjectiveButton.addEventListener(MouseEvent.CLICK, OnClickObjectiveButton);
			}
			addChild(mObjectiveButton);
		}
		
		override public function Dispose():void
		{
			mRadioButton.removeEventListener(MouseEvent.CLICK, OnClickRadioButton);
			mObjectiveButton.removeEventListener(MouseEvent.CLICK, OnClickObjectiveButton);
			
			super.Dispose();
		}
		
		private function OnClickRadioButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.CRAFTING.UIClass(mWord);
		}
		
		private function OnClickObjectiveButton(aEvent:MouseEvent):void
		{
			if (ObjectiveManager.Instance.CompleteWordObjective(mWord))
			{
				WordCollection.Instance.RemoveWord(mWord);
				UIManager.Instance.CurrentUI = new UIType.OBJECTIVE.UIClass();
			}
		}
	}
}