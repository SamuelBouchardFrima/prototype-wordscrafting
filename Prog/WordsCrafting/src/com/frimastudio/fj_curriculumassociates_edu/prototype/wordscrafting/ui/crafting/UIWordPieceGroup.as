package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordPiece;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class UIWordPieceGroup extends Sprite
	{
		private var mGroupBackground:Sprite;
		private var mPieceList:Vector.<UIWordPiece>;
		
		public function get PieceList():Vector.<UIWordPiece>
		{
			return mPieceList;
		}
		
		private function get Valid():Boolean
		{
			var pieceList:Vector.<WordPiece> = new Vector.<WordPiece>();
			for (var i:int = 0, end:int = mPieceList.length; i < end; ++i)
			{
				pieceList.push(mPieceList[i].Piece);
			}
			return new Word(pieceList).Valid;
		}
		
		public function UIWordPieceGroup(aPieceList:Vector.<UIWordPiece>)
		{
			super();
			
			mGroupBackground = new Sprite();
			addChild(mGroupBackground);
			
			mPieceList = aPieceList;
			
			x = mPieceList[0].x;
			y = mPieceList[0].y;
			
			for (var i:int = 0, end:int = mPieceList.length; i < end; ++i)
			{
				mPieceList[i].x -= x;
				mPieceList[i].y -= y;
				mPieceList[i].addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
				addChild(mPieceList[i]);
			}
			
			DrawGroupBackground();
		}
		
		public function Dispose():void
		{
			for (var i:int = 0, end:int = mPieceList.length; i < end; ++i)
			{
				mPieceList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
			}
		}
		
		public function InsertPiece(aPiece:UIWordPiece, aIndex:int):void
		{
			if (aIndex > mPieceList.length)
			{
				throw new Error("Index " + aIndex + " outside of range " + mPieceList.length);
			}
			
			var firstLocation:Number = mPieceList[0].x;
			aPiece.y = mPieceList[0].y;
			
			mPieceList.splice(aIndex, 0, aPiece);
			aPiece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
			addChild(aPiece);
			
			for (var i:int = aIndex, end:int = mPieceList.length; i < end; ++i)
			{
				mPieceList[i].x = (i * aPiece.width) + firstLocation;
			}
			
			DrawGroupBackground();
		}
		
		private function DrawGroupBackground():void 
		{
			mGroupBackground.graphics.clear();
			mGroupBackground.graphics.beginFill(0xEEEEEE, 0.5);
			mGroupBackground.graphics.lineStyle(3, (Valid ? 0x00FF00 : 0xFF0000));
			mGroupBackground.graphics.moveTo(mPieceList[0].x - (mPieceList[0].width / 2) - 10,
				mPieceList[0].y - (mPieceList[0].height / 2) - 10);
			mGroupBackground.graphics.lineTo(mPieceList[mPieceList.length - 1].x + (mPieceList[0].width / 2) + 10,
				mPieceList[0].y - (mPieceList[0].height / 2) - 10);
			mGroupBackground.graphics.lineTo(mPieceList[mPieceList.length - 1].x + (mPieceList[0].width / 2) + 10,
				mPieceList[0].y + (mPieceList[0].height / 2) + 10);
			mGroupBackground.graphics.lineTo(mPieceList[0].x - (mPieceList[0].width / 2) - 10,
				mPieceList[0].y + (mPieceList[0].height / 2) + 10);
			mGroupBackground.graphics.lineTo(mPieceList[0].x - (mPieceList[0].width / 2) - 10,
				mPieceList[0].y - (mPieceList[0].height / 2) - 10);
			mGroupBackground.graphics.endFill();
		}
		
		private function OnMouseDownUIWordPiece(aEvent:MouseEvent):void
		{
			aEvent.stopPropagation();
			
			var piece:UIWordPiece = aEvent.currentTarget as UIWordPiece;
			piece.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
			
			var firstLocation:Number = 0;
			var index:int = mPieceList.indexOf(piece);
			mPieceList.splice(index, 1);
			for (var i:int = index, end:int = mPieceList.length; i < end; ++i)
			{
				mPieceList[i].x = (i * piece.width) + firstLocation;
			}
			
			dispatchEvent(new UIWordPieceGroupEvent(UIWordPieceGroupEvent.DRAG_PIECE, piece));
			
			if (mPieceList.length == 1)
			{
				removeChild(mPieceList[0]);
				dispatchEvent(new UIWordPieceGroupEvent(UIWordPieceGroupEvent.RELEASE_PIECE, mPieceList[0]));
			}
			else
			{
				DrawGroupBackground();
			}
		}
	}
}