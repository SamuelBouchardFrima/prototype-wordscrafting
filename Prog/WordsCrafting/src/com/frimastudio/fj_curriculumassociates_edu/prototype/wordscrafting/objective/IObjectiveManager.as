package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.objective
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import flash.events.IEventDispatcher;
	
	public interface IObjectiveManager extends IEventDispatcher
	{
		function get ObjectiveList():Vector.<Objective>;
		function get NextObjective():Objective;
		
		function Init():void;
		function AddObjective(aObjective:Objective):void;
		
		function HasWordObjective(aWord:Word):Boolean;
		function CompleteWordObjective(aWord:Word):Boolean;
	}
}