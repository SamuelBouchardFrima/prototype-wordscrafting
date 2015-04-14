package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	public class SyllableWordPiece extends WordPiece
	{
		private var mType:SyllableType;
		
		public function get Type():SyllableType
		{
			return mType;
		}
		
		public function SyllableWordPiece(aType:SyllableType, aPieceString:String)
		{
			super(aPieceString);
			
			mType = aType;
		}
	}
}