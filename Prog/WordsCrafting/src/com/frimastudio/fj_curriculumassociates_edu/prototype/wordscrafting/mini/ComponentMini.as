package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.ComponentType;
	
	public class ComponentMini extends Mini
	{
		private var mType:ComponentType;
		
		public function get Type():ComponentType
		{
			return mType;
		}
		
		public function ComponentMini(aType:ComponentType)
		{
			super();
			
			mType = aType;
			
			mSpriteSize = 40;
			switch (mType)
			{
				case ComponentType.ROOT:
					mSpriteColor = 0xFFFF00;
					break;
				case ComponentType.PREFFIX:
					mSpriteColor = 0xFF0000;
					break;
				case ComponentType.SUFFIX:
					mSpriteColor = 0x00FF00;
					break;
				case ComponentType.OTHER_AFFIX:
					mSpriteColor = 0x0000FF;
					break;
				default:
					throw new Error("ComponentType " + mType.Description + " is not handled.");
					return;
			}
		}
	}
}