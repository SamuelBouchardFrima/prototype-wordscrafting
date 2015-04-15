package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class WordValidator extends EventDispatcher implements IWordValidator
	{
		private static var mInstance:WordValidator = new WordValidator();
		
		public static function get Instance():IWordValidator
		{
			return mInstance;
		}
		
		public var mWordDictionary:Dictionary;
		
		public function WordValidator()
		{
			if (mInstance)
			{
				throw new Error("WordValidator is a singleton, and thus not intended for instantiation. Use WordValidator.Instance instead.");
			}
		}
		
		public function Load():void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, OnCompleteLoad);
			loader.load(new URLRequest("core-wordnet.xml"));
		}
		
		public function Validate(aWord:Word):Boolean
		{
			return mWordDictionary[aWord.WordString];
		}
		
		private function OnCompleteLoad(aEvent:Event):void
		{
			(aEvent.currentTarget as URLLoader).removeEventListener(Event.COMPLETE, OnCompleteLoad);
			
			mWordDictionary = new Dictionary();
			var data:XML = new XML(aEvent.target.data);
			var parsedData:Array = data.text()[0].split("[");
			var word:String;
			for (var i:int = 1, end:int = parsedData.length; i < end; i += 2)
			{
				mWordDictionary[parsedData[i].split("%")[0]] = true;
			}
			
			dispatchEvent(new WordValidatorEvent(WordValidatorEvent.LOAD_COMPLETE));
		}
	}
}