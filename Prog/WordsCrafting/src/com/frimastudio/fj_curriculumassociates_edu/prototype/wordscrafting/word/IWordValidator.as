package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import flash.events.IEventDispatcher;
	
	public interface IWordValidator extends IEventDispatcher
	{
		function get RandomWord():String;
		
		function Validate(aWord:String):Boolean;
	}	
}