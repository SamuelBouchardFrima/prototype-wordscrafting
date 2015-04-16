package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini.Mini;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini.MiniManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.IconUIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.MiniInteractionUI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.Word;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordCollection;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordPiece;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordValidator;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class CraftingUI extends MiniInteractionUI
	{
		private var mDictionaryButton:UIButton;
		private var mRadioButton:UIButton;
		private var mRadioSignal:Sprite;
		private var mUIWordPieceList:Vector.<UIWordPiece>;
		private var mUIWordPieceGroupList:Vector.<UIWordPieceGroup>;
		private var mDraggedUIWordPiece:UIWordPiece;
		private var mDraggedUIWordPieceGroup:UIWordPieceGroup;
		private var mEquipedUIWordPieceGroup:UIWordPieceGroup;
		private var mStartWord:Word;
		private var mRadioSignalTimer:Timer;
		private var mRadioSignalBlocker:Sprite;
		
		public function CraftingUI(aStartWord:Word = null)
		{
			mUIWordPieceList = new Vector.<UIWordPiece>();
			mUIWordPieceGroupList = new Vector.<UIWordPieceGroup>();
			mStartWord = aStartWord;
			
			super();
			
			var buttonSize:Point = new Point(50, 50);
			
			mDictionaryButton = new IconUIButton(buttonSize, Asset.DictionaryButtonBitmap);
			mDictionaryButton.x = 750;
			mDictionaryButton.y = 50;
			mDictionaryButton.addEventListener(MouseEvent.CLICK, OnClickDictionaryButton);
			addChild(mDictionaryButton);
			
			buttonSize = new Point(150, 150);
			
			mRadioButton = new IconUIButton(buttonSize, Asset.CraftingButtonBitmap, 0xFF0000);
			mRadioButton.x = 400;
			mRadioButton.y = 100;
			mRadioButton.addEventListener(MouseEvent.CLICK, OnClickRadioButton);
			addChild(mRadioButton);
			
			var signal:Bitmap = new Asset.RadioSignalBitmap();
			signal.width = 150;
			signal.height = 150;
			signal.x = signal.width * -0.5;
			signal.y = signal.height * -0.5;
			mRadioSignal = new Sprite();
			mRadioSignal.x = 400;
			mRadioSignal.y = 250;
			mRadioSignal.rotation = 180;
			mRadioSignal.addChild(signal);
			
			mRadioSignalTimer = new Timer(500, 1);
			mRadioSignalTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerCompleteRadioSignal);
			mRadioSignalBlocker = new Sprite();
			mRadioSignalBlocker.x = 400;
			mRadioSignalBlocker.y = 300;
			mRadioSignalBlocker.graphics.beginFill(0x000000, 0);
			mRadioSignalBlocker.graphics.drawRect(-400, -300, 800, 600);
			mRadioSignalBlocker.graphics.endFill();
			mRadioSignalBlocker.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownRadioSignalBlocker);
			
			if (mStartWord)
			{
				if (mStartWord.Valid)
				{
					SendRadioSignal();
				}
				else
				{
					mStartWord = null;
				}
			}
		}
		
		private function OnMouseDownRadioSignalBlocker(aEvent:MouseEvent):void
		{
			aEvent.stopPropagation();
		}
		
		private function SendRadioSignal():void
		{
			addChild(mRadioSignal);
			addChild(mRadioSignalBlocker);
			mRadioSignalTimer.start();
		}
		
		private function OnTimerCompleteRadioSignal(aEvent:TimerEvent):void
		{
			ReceiveRadioSignal();
		}
		
		private function ReceiveRadioSignal():void
		{
			removeChild(mRadioSignal);
			removeChild(mRadioSignalBlocker);
			mRadioSignalTimer.stop();
			
			var i:int, end:int;
			var piece:UIWordPiece;
			for (i = 0, end = MiniManager.Instance.MiniList.length; i < end; ++i)
			{
				piece = new UIWordPiece(MiniManager.Instance.MiniList[i].Produce(mStartWord));
				piece.x = mMiniList[i].x;
				piece.y = mMiniList[i].y - 50;
				piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
				addChild(piece);
				mUIWordPieceList.push(piece);
			}
			
			mStartWord = null;
		}
		
		override public function Dispose():void
		{
			mDictionaryButton.removeEventListener(MouseEvent.CLICK, OnClickDictionaryButton);
			mRadioSignalTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerCompleteRadioSignal);
			mRadioSignalTimer.stop();
			mRadioSignalBlocker.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownRadioSignalBlocker);
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			var i:int, end:int;
			for (i = 0, end = mUIWordPieceList.length; i < end; ++i)
			{
				mUIWordPieceList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
			}
			for (i = 0, end = mUIWordPieceGroupList.length; i < end; ++i)
			{
				mUIWordPieceGroupList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPieceGroup);
				mUIWordPieceGroupList[i].removeEventListener(UIWordPieceGroupEvent.RELEASE_PIECE, OnReleasePieceFromGroup);
				mUIWordPieceGroupList[i].removeEventListener(UIWordPieceGroupEvent.DRAG_PIECE, OnDragPieceFromGroup);
				mUIWordPieceGroupList[i].removeEventListener(UIWordPieceGroupEvent.SEND_TO_DICTIONARY, OnSendGroupToDictionary);
				mUIWordPieceGroupList[i].Dispose();
			}
			
			super.Dispose();
		}
		
		private function CreateWord(aPieceList:Vector.<UIWordPiece>):Word
		{
			var pieceList:Vector.<WordPiece> = new Vector.<WordPiece>();
			for (var i:int = 0, end:int = aPieceList.length; i < end; ++i)
			{
				pieceList.push(aPieceList[i].Piece);
			}
			return new Word(pieceList);
		}
		
		private function OnClickDictionaryButton(aEvent:MouseEvent):void
		{
			UIManager.Instance.CurrentUI = new UIType.DICTIONARY.UIClass();
		}
		
		private function OnClickRadioButton(aEvent:MouseEvent):void
		{
			if (!mEquipedUIWordPieceGroup)
			{
				return;
			}
			
			mStartWord = CreateWord(mEquipedUIWordPieceGroup.PieceList);
			if (mStartWord.Valid)
			{
				SendRadioSignal();
			}
			else
			{
				mStartWord = null;
			}
		}
		
		private function OnMouseDownUIWordPiece(aEvent:MouseEvent):void
		{
			mDraggedUIWordPiece = aEvent.currentTarget as UIWordPiece;
			mDraggedUIWordPiece.x = mouseX;
			mDraggedUIWordPiece.y = mouseY;
			addChild(mDraggedUIWordPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		private function OnMouseDownUIWordPieceGroup(aEvent:MouseEvent):void
		{
			mDraggedUIWordPieceGroup = aEvent.currentTarget as UIWordPieceGroup;
			if (mDraggedUIWordPieceGroup == mEquipedUIWordPieceGroup)
			{
				mEquipedUIWordPieceGroup = null;
				mRadioButton.Color = 0xFF0000;
			}
			mDraggedUIWordPieceGroup.x = mouseX;
			mDraggedUIWordPieceGroup.y = mouseY;
			addChild(mDraggedUIWordPieceGroup);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			if (mDraggedUIWordPiece)
			{
				mDraggedUIWordPiece.x = mouseX;
				mDraggedUIWordPiece.y = mouseY;
			}
			else if (mDraggedUIWordPieceGroup)
			{
				mDraggedUIWordPieceGroup.x = mouseX;
				mDraggedUIWordPieceGroup.y = mouseY;
			}
		}
		
		private function OnMouseUp(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			if (mDraggedUIWordPiece)
			{
				StopPieceDrag();
			}
			else if (mDraggedUIWordPieceGroup)
			{
				StopGroupDrag();
			}
		}
		
		private function StopPieceDrag():void 
		{
			var piece:UIWordPiece = mDraggedUIWordPiece;
			mDraggedUIWordPiece = null;
			
			var offset:Point = new Point(piece.width, piece.height);
			
			var i:int, endi:int, j:int, endj:int;
			var group:UIWordPieceGroup, otherPiece:UIWordPiece;
			
			for (i = 0, endi = mUIWordPieceGroupList.length; i < endi; ++i)
			{
				group = mUIWordPieceGroupList[i];
				for (j = 0, endj = group.PieceList.length; j < endj; ++j)
				{
					otherPiece = group.PieceList[j];
					if (piece.y >= otherPiece.y + group.y - offset.y && piece.y <= otherPiece.y + group.y + offset.y)
					{
						if (piece.x >= otherPiece.x + group.x && piece.x <= otherPiece.x + group.x + offset.x)
						{
							group.InsertPiece(piece, j + 1);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(piece), 1);
							return;
						}
						else if (piece.x <= otherPiece.x + group.x && piece.x >= otherPiece.x + group.x - offset.x)
						{
							group.InsertPiece(piece, j);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(piece), 1);
							return;
						}
					}
				}
			}
			
			for (i = 0, endi = mUIWordPieceList.length; i < endi; ++i)
			{
				otherPiece = mUIWordPieceList[i];
				if (otherPiece != piece)
				{
					if (piece.y >= otherPiece.y - offset.y && piece.y <= otherPiece.y + offset.y)
					{
						if (piece.x >= otherPiece.x && piece.x <= otherPiece.x + offset.x)
						{
							piece.x = otherPiece.x + piece.width;
							piece.y = otherPiece.y;
							piece.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
							otherPiece.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
							group = new UIWordPieceGroup(new <UIWordPiece>[otherPiece, piece]);
							group.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPieceGroup);
							group.addEventListener(UIWordPieceGroupEvent.RELEASE_PIECE, OnReleasePieceFromGroup);
							group.addEventListener(UIWordPieceGroupEvent.DRAG_PIECE, OnDragPieceFromGroup);
							group.addEventListener(UIWordPieceGroupEvent.SEND_TO_DICTIONARY, OnSendGroupToDictionary);
							mUIWordPieceGroupList.push(group);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(piece), 1);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(otherPiece), 1);
							addChild(group);
							return;
						}
						else if (piece.x <= otherPiece.x && piece.x >= otherPiece.x - offset.x)
						{
							piece.x = otherPiece.x - piece.width;
							piece.y = otherPiece.y;
							piece.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
							otherPiece.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
							group = new UIWordPieceGroup(new <UIWordPiece>[piece, otherPiece]);
							group.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPieceGroup);
							group.addEventListener(UIWordPieceGroupEvent.RELEASE_PIECE, OnReleasePieceFromGroup);
							group.addEventListener(UIWordPieceGroupEvent.DRAG_PIECE, OnDragPieceFromGroup);
							group.addEventListener(UIWordPieceGroupEvent.SEND_TO_DICTIONARY, OnSendGroupToDictionary);
							mUIWordPieceGroupList.push(group);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(piece), 1);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(otherPiece), 1);
							addChild(group);
							return;
						}
					}
				}
			}
		}
		
		private function StopGroupDrag():void 
		{
			var group:UIWordPieceGroup = mDraggedUIWordPieceGroup;
			mDraggedUIWordPieceGroup = null;
			
			var offset:Point = new Point(group.PieceList[0].width, group.PieceList[0].height);
			
			if (mEquipedUIWordPieceGroup)
			{
				return;
			}
			
			offset.x += mRadioButton.width;
			offset.y += mRadioButton.height;
			offset.x *= 0.5;
			offset.y *= 0.5;
			if (group.x >= mRadioButton.x - offset.x && group.x <= mRadioButton.x + offset.x &&
				group.y >= mRadioButton.y - offset.y && group.y <= mRadioButton.y + offset.y)
			{
				mEquipedUIWordPieceGroup = group;
				mRadioButton.Color = 0x00FF00;
			}
		}
		
		private function OnReleasePieceFromGroup(aEvent:UIWordPieceGroupEvent):void
		{
			var group:UIWordPieceGroup = aEvent.currentTarget as UIWordPieceGroup;
			var piece:UIWordPiece = aEvent.Piece;
			
			piece.x += group.x;
			piece.y += group.y;
			piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
			addChild(piece);
			mUIWordPieceList.push(piece);
			
			removeChild(group);
			group.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPieceGroup);
			group.removeEventListener(UIWordPieceGroupEvent.RELEASE_PIECE, OnReleasePieceFromGroup);
			group.removeEventListener(UIWordPieceGroupEvent.DRAG_PIECE, OnDragPieceFromGroup);
			group.removeEventListener(UIWordPieceGroupEvent.SEND_TO_DICTIONARY, OnSendGroupToDictionary);
			group.Dispose();
			mUIWordPieceGroupList.splice(mUIWordPieceGroupList.indexOf(group), 1);
			
			if (group == mEquipedUIWordPieceGroup)
			{
				mEquipedUIWordPieceGroup = null;
			}
			
			addChild(mDraggedUIWordPiece);
		}
		
		private function OnDragPieceFromGroup(aEvent:UIWordPieceGroupEvent):void
		{
			mDraggedUIWordPiece = aEvent.Piece;
			mDraggedUIWordPiece.x = mouseX;
			mDraggedUIWordPiece.y = mouseY;
			mDraggedUIWordPiece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
			addChild(mDraggedUIWordPiece);
			mUIWordPieceList.push(mDraggedUIWordPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		private function OnSendGroupToDictionary(aEvent:UIWordPieceGroupEvent):void
		{
			var word:Word = CreateWord((aEvent.currentTarget as UIWordPieceGroup).PieceList);
			if (!word.Valid)
			{
				return;
			}
			
			WordCollection.Instance.AddWord(word);
			UIManager.Instance.CurrentUI = new UIType.DICTIONARY.UIClass();
		}
	}
}