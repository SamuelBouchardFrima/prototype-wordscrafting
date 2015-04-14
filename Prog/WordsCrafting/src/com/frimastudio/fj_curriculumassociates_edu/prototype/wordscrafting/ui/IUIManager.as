package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	public interface IUIManager extends IEventDispatcher
	{
		function get UIContainer():Sprite;
		
		function get CurrentUI():UI;
		function set CurrentUI(aValue:UI):void;
	}
}