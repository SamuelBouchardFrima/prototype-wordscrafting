package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import flash.events.Event;
	
	public class WordValidatorEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "WordValidatorEvent::LOAD_COMPLETE";
		
		public function WordValidatorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new WordValidatorEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("WordValidatorEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}