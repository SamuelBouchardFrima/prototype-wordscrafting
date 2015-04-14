package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	public class WordCollection implements IWordCollection
	{
		private static var mInstance:WordCollection = new WordCollection();
		
		public static function get Instance():IWordCollection
		{
			return mInstance;
		}
		
		public function WordCollection()
		{
			if (mInstance)
			{
				throw new Error("WordCollection is a singleton, and thus not intended for instantiation. Use WordCollection.Instance instead.");
			}
		}
	}
}