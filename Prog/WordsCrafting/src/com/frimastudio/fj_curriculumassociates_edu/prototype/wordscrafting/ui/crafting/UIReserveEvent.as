package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting
{
	import flash.events.Event;
	
	public class UIReserveEvent extends Event
	{
		public static const RESTORE_WORD_PIECE_GROUP:String = "UIReserveEvent::RESTORE_WORD_PIECE_GROUP";
		
		public var SlotIndex:int;
		
		public function UIReserveEvent(type:String, aSlotIndex:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			SlotIndex = aSlotIndex;
		}
		
		public override function clone():Event
		{
			return new UIReserveEvent(type, SlotIndex, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("UIReserveEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}