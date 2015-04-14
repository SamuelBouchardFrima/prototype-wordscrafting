package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.util.Random;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.ComponentType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.LetterType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.SyllableType;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class MiniManager extends EventDispatcher implements IMiniManager
	{
		private static var mInstance:MiniManager = new MiniManager();
		
		public static function get Instance():IMiniManager
		{
			return mInstance;
		}
		
		private var mMiniList:Vector.<Mini>;
		
		public function get MiniList():Vector.<Mini>
		{
			return mMiniList;
		}
		
		public function MiniManager(aTarget:IEventDispatcher = null)
		{
			super(aTarget);
			
			if (mInstance)
			{
				throw new Error("MiniManager is a singleton, and thus not intended for instantiation. Use MiniManager.Instance instead.");
			}
			
			mMiniList = new Vector.<Mini>();
			for (var i:int = 0, end:int = 5; i < end; ++i)
			{
				mMiniList.push(CreateRandomMini());
			}
		}
		
		private function CreateRandomMini():Mini
		{
			return new LetterMini(Random.FromList(LetterType.LIST));
			
			//switch (Random.RangeInt(0, 2))
			//{
				//case 0:
					//return new LetterMini(Random.FromList(LetterType.LIST));
				//case 1:
					//return new SyllableMini(Random.FromList(SyllableType.LIST));
				//case 2:
					//return new ComponentMini(Random.FromList(ComponentType.LIST));
				//default:
					//throw new Error("Error in Random.RangeInt(aMin, aMax). Value returned outside of the expected range.");
					//return null;
			//}
		}
	}
}