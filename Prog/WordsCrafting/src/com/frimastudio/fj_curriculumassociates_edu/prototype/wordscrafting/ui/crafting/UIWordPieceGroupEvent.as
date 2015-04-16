package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting
{
	import flash.events.Event;
	
	public class UIWordPieceGroupEvent extends Event
	{
		public static var RELEASE_PIECE:String = "UIWordPieceGroupEvent::RELEASE_PIECE";
		public static var DRAG_PIECE:String = "UIWordPieceGroupEvent::DRAG_PIECE";
		public static var SEND_TO_DICTIONARY:String = "UIWordPieceGroupEvent::SEND_TO_DICTIONARY";
		
		public var Piece:UIWordPiece;
		
		public function UIWordPieceGroupEvent(type:String, aPiece:UIWordPiece = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{ 
			super(type, bubbles, cancelable);
			
			Piece = aPiece;
		}
		
		public override function clone():Event
		{
			return new UIWordPieceGroupEvent(type, Piece, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("UIWordPieceGroupEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}