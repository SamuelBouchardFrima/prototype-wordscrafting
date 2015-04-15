package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import flash.events.IEventDispatcher;
	
	public interface IWordValidator extends IEventDispatcher
	{
		function Load():void;
		
		function Validate(aWord:String):Boolean;
	}	
}