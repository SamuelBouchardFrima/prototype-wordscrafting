package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	public class ComponentWordPiece extends WordPiece
	{
		private var mType:ComponentType;
		
		public function get Type():ComponentType
		{
			return mType;
		}
		
		public function ComponentWordPiece(aType:ComponentType, aPieceString:String)
		{
			super(aPieceString);
			
			mType = aType;
		}
	}
}