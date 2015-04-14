package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.SyllableType;
	
	public class SyllableMini extends Mini
	{
		private var mType:SyllableType;
		
		public function get Type():SyllableType
		{
			return mType;
		}
		
		public function SyllableMini(aType:SyllableType)
		{
			super();
			
			mType = aType;
			
			mSpriteSize = 60;
			switch (mType)
			{
				case SyllableType.TWO_LETTERS:
					mSpriteColor = 0xFF0000;
					break;
				case SyllableType.THREE_LETTERS:
					mSpriteColor = 0x00FF00;
					break;
				case SyllableType.FOUR_LETTERS:
					mSpriteColor = 0x0000FF;
					break;
				case SyllableType.RHYME:
					mSpriteColor = 0xFFFF00;
					break;
				default:
					throw new Error("SyllableType " + mType.Description + " is not handled.");
					return;
			}
		}
	}
}