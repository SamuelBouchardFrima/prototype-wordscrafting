package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.objective
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordValidator;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ObjectiveManager extends EventDispatcher implements IObjectiveManager
	{
		private static var mInstance:ObjectiveManager = new ObjectiveManager();
		
		public static function get Instance():IObjectiveManager
		{
			return mInstance;
		}
		
		private var mObjectiveList:Vector.<Objective>;
		
		public function get ObjectiveList():Vector.<Objective>
		{
			return mObjectiveList;
		}
		
		public function get NextObjective():Objective
		{
			return mObjectiveList[mObjectiveList.length - 1];
		}
		
		public function ObjectiveManager(aTarget:IEventDispatcher = null)
		{
			super(aTarget);
			
			if (mInstance)
			{
				throw new Error("ObjectiveManager is a singleton not intended for instantiation. Use ObjectiveManager.Instance instead.");
			}
			
			mObjectiveList = new Vector.<Objective>();
		}
		
		public function Init():void
		{
			AddObjective(new WordObjective(WordValidator.Instance.RandomWord));
		}
		
		public function AddObjective(aObjective:Objective):void
		{
			trace("New objective " + aObjective);
			mObjectiveList.push(aObjective);
		}
		
		public function HasWordObjective(aWord:Word):Boolean
		{
			for (var i:int = 0, end:int = mObjectiveList.length; i < end; ++i)
			{
				if (mObjectiveList[i].Name == aWord.WordString)
				{
					return true;
				}
			}
			return false;
		}
		
		public function CompleteWordObjective(aWord:Word):Boolean
		{
			for (var i:int = 0, end:int = mObjectiveList.length; i < end; ++i)
			{
				if (mObjectiveList[i].CompleteObjective(aWord.WordString))
				{
					AddObjective(new WordObjective(WordValidator.Instance.RandomWord));
					return true;
				}
			}
			return false;
		}
	}
}