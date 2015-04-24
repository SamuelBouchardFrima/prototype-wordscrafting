package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.util.Random;
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
		
		private var mWordDictionary:Object;
		private var mWordList:Vector.<String>;
		
		public function get RandomWord():String
		{
			return Random.FromList(mWordList);
		}
		
		public function WordValidator()
		{
			if (mInstance)
			{
				throw new Error("WordValidator is a singleton, and thus not intended for instantiation. Use WordValidator.Instance instead.");
			}
			
			var data:XML = new XML(WordDictionary.GRADE_1);
			var parsedData:Array = data.text()[0].split("\n");
			var word:String;
			mWordDictionary = { };
			mWordList = new Vector.<String>();
			for (var i:int = 1, end:int = parsedData.length - 1; i < end; ++i)
			{
				word = parsedData[i].toLowerCase();
				word = word.substr(0, word.length - 1);
				
				if (word == "" || word.indexOf("'") != -1 || word.indexOf("-") != -1 || word.indexOf(" ") != -1 ||
					word.indexOf(",") != -1 || word.indexOf(";") != -1 || word.indexOf(":") != -1 ||
					word.indexOf(".") != -1 || word.indexOf("!") != -1 || word.indexOf("?") != -1)
				{
					continue;
				}
				
				mWordDictionary[word] = true;
				mWordList.push(word);
			}
		}
		
		public function Validate(aWord:String):Boolean
		{
			return mWordDictionary[aWord];
		}
	}
}