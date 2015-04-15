package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import flash.utils.Dictionary;
	
	public class WordCollection implements IWordCollection
	{
		private static var mInstance:WordCollection = new WordCollection();
		
		public static function get Instance():IWordCollection
		{
			return mInstance;
		}
		
		public var mCollection:Dictionary;
		
		public function get Collection():Dictionary
		{
			return mCollection;
		}
		
		public function WordCollection()
		{
			if (mInstance)
			{
				throw new Error("WordCollection is a singleton, and thus not intended for instantiation. Use WordCollection.Instance instead.");
			}
			
			mCollection = new Dictionary();
			
			AddWord(new Word(new <WordPiece>[new LetterWordPiece(LetterType.CONSONANT, "f"),
				new LetterWordPiece(LetterType.VOWEL, "a"), new LetterWordPiece(LetterType.CONSONANT, "n")]));
			AddWord(new Word(new <WordPiece>[new LetterWordPiece(LetterType.CONSONANT, "f"),
				new LetterWordPiece(LetterType.VOWEL, "u"), new LetterWordPiece(LetterType.CONSONANT, "n")]));
			AddWord(new Word(new <WordPiece>[new LetterWordPiece(LetterType.CONSONANT, "m"),
				new LetterWordPiece(LetterType.VOWEL, "a"), new LetterWordPiece(LetterType.CONSONANT, "d")]));
			AddWord(new Word(new <WordPiece>[new LetterWordPiece(LetterType.CONSONANT, "m"),
				new LetterWordPiece(LetterType.VOWEL, "a"), new LetterWordPiece(LetterType.CONSONANT, "t")]));
			AddWord(new Word(new <WordPiece>[new LetterWordPiece(LetterType.CONSONANT, "s"),
				new LetterWordPiece(LetterType.VOWEL, "a"), new LetterWordPiece(LetterType.CONSONANT, "d")]));
		}
		
		public function ContainWord(aWord:Word):Boolean
		{
			return mCollection[aWord.WordString];
		}
		
		public function AddWord(aWord:Word):void
		{
			if (!ContainWord(aWord))
			{
				mCollection[aWord.WordString] = aWord;
			}
		}
	}
}