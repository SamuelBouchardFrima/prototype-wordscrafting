package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.CraftingReserve;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class UIReserve extends Sprite
	{
		private var mSlotList:Vector.<UIReserveSlot>;
		
		public function get SlotList():Vector.<UIReserveSlot>
		{
			return mSlotList;
		}
		
		public function UIReserve()
		{
			super();
			
			mSlotList = new Vector.<UIReserveSlot>();
			var slot:UIReserveSlot;
			for (var i:int = 0, end:int = CraftingReserve.Instance.ReserveList.length; i < end; ++i)
			{
				slot = new UIReserveSlot(i);
				slot.x = (125 * i) - 250;
				slot.y = 0;
				slot.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownSlot);
				addChild(slot);
				mSlotList.push(slot);
			}
		}
		
		public function Dispose():void
		{
			for (var i:int = 0, end:int = mSlotList.length; i < end; ++i)
			{
				mSlotList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownSlot);
			}
		}
		
		private function OnMouseDownSlot(aEvent:MouseEvent):void
		{
			var slot:UIReserveSlot = aEvent.currentTarget as UIReserveSlot;
			if (CraftingReserve.Instance.ReserveList[slot.Index])
			{
				dispatchEvent(new UIReserveEvent(UIReserveEvent.RESTORE_WORD_PIECE_GROUP, slot.Index));
			}
		}
	}
}