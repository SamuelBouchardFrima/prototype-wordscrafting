package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	public class CraftingReserve implements ICraftingReserve
	{
		private static var mInstance:CraftingReserve = new CraftingReserve();
		
		public static function get Instance():ICraftingReserve
		{
			return mInstance;
		}
		
		private var mReserveList:Vector.<WordPiece>;
		
		public function get ReserveList():Vector.<WordPiece>
		{
			return mReserveList;
		}
		
		public function CraftingReserve()
		{
			if (mInstance)
			{
				throw new Error("CraftingReserve is a singleton not intended for instantiation. Use CraftingReserve.Instance instead.");
			}
			
			mReserveList = new Vector.<WordPiece>(10);
		}
	}
}