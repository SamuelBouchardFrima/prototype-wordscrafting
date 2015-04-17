package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.objective.ObjectiveManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.HomeUI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordValidator;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordValidatorEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	
	XML.ignoreWhitespace = false;
	
	public class Main extends Sprite
	{
		public function Main():void
		{
			if (stage)
			{
				Init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, Init);
			}
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			addChild(UIManager.Instance.UIContainer);
			
			WordValidator.Instance.addEventListener(WordValidatorEvent.LOAD_COMPLETE, OnLoadCompleteWordValidator);
			WordValidator.Instance.Load();
		}
		
		private function OnLoadCompleteWordValidator(aEvent:WordValidatorEvent):void
		{
			ObjectiveManager.Instance.Init();
			
			UIManager.Instance.CurrentUI = new UIType.HOME.UIClass();
		}
	}
}