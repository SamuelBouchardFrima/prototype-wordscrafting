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
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class CraftingUI extends MiniInteractionUI
	{
		private var mDictionaryButton:UIButton;
		private var mRadioButton:UIButton;
		private var mUIWordPieceList:Vector.<UIWordPiece>;
		private var mUIWordPieceGroupList:Vector.<UIWordPieceGroup>;
		private var mDraggedUIWordPiece:UIWordPiece;
		private var mDraggedUIWordPieceGroup:UIWordPieceGroup;
		private var mEquipedUIWordPiece:UIWordPiece;
		private var mEquipedUIWordPieceGroup:UIWordPieceGroup;
		private var mStartWord:Word;
		
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
			
			for (var i:int = 0, end:int = mUIWordPieceList.length; i < end; ++i)
			{
				mUIWordPieceList[i].x = mMiniList[i].x;
				mUIWordPieceList[i].y = mMiniList[i].y - 50;
				mUIWordPieceList[i].addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
				addChild(mUIWordPieceList[i]);
			}
		}
		
		override public function Dispose():void
		{
			mDictionaryButton.removeEventListener(MouseEvent.CLICK, OnClickDictionaryButton);
			
			super.Dispose();
		}
		
		override protected function CreateMiniSprite(aMini:Mini):Sprite
		{
			mUIWordPieceList.push(new UIWordPiece(aMini.Produce(mStartWord)));
			return super.CreateMiniSprite(aMini);
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
			var word:Word;
			if (mEquipedUIWordPiece)
			{
				word = CreateWord(new <UIWordPiece>[mEquipedUIWordPiece]);
				mEquipedUIWordPiece = null;
			}
			else if (mEquipedUIWordPieceGroup)
			{
				word = CreateWord(mEquipedUIWordPieceGroup.PieceList);
				mEquipedUIWordPieceGroup = null;
			}
			else
			{
				return;
			}
			
			if (!word.Valid)
			{
				trace("Invalid word " + word);
				return;
			}
			trace("Valid word " + word.WordString);
			
			var i:int, end:int;
			for (i = 0, end = mUIWordPieceList.length; i < end; ++i)
			{
				removeChild(mUIWordPieceList[i]);
				mUIWordPieceList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
			}
			mUIWordPieceList.splice(0, mUIWordPieceList.length);
			
			for (i = 0, end = mUIWordPieceGroupList.length; i < end; ++i)
			{
				removeChild(mUIWordPieceGroupList[i]);
				mUIWordPieceGroupList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPieceGroup);
				mUIWordPieceGroupList[i].removeEventListener(UIWordPieceGroupEvent.RELEASE_PIECE, OnReleasePieceFromGroup);
				mUIWordPieceGroupList[i].removeEventListener(UIWordPieceGroupEvent.DRAG_PIECE, OnDragPieceFromGroup);
				mUIWordPieceGroupList[i].Dispose();
			}
			mUIWordPieceGroupList.splice(0, mUIWordPieceGroupList.length);
			
			var piece:UIWordPiece;
			for (i = 0, end = MiniManager.Instance.MiniList.length; i < end; ++i)
			{
				piece = new UIWordPiece(MiniManager.Instance.MiniList[i].Produce(word));
				piece.x = mMiniList[i].x;
				piece.y = mMiniList[i].y - 50;
				piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownUIWordPiece);
				addChild(piece);
				mUIWordPieceList.push(piece);
			}
			
			mRadioButton.Color = 0xFF0000;
		}
		
		private function OnMouseDownUIWordPiece(aEvent:MouseEvent):void
		{
			mDraggedUIWordPiece = aEvent.currentTarget as UIWordPiece;
			if (mDraggedUIWordPiece == mEquipedUIWordPiece)
			{
				mEquipedUIWordPiece = null;
				mRadioButton.Color = 0xFF0000;
			}
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
							mUIWordPieceGroupList.push(group);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(piece), 1);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(otherPiece), 1);
							addChild(group);
							if (otherPiece == mEquipedUIWordPiece)
							{
								mEquipedUIWordPiece = null;
								mEquipedUIWordPieceGroup = group;
							}
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
							mUIWordPieceGroupList.push(group);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(piece), 1);
							mUIWordPieceList.splice(mUIWordPieceList.indexOf(otherPiece), 1);
							addChild(group);
							if (otherPiece == mEquipedUIWordPiece)
							{
								mEquipedUIWordPiece = null;
								mEquipedUIWordPieceGroup = group;
							}
							return;
						}
					}
				}
			}
			
			if (piece.x >= mDictionaryButton.x - offset.x && piece.x <= mDictionaryButton.x + offset.x &&
				piece.y >= mDictionaryButton.y - offset.y && piece.y <= mDictionaryButton.y + offset.y)
			{
				var word:Word = CreateWord(new <UIWordPiece>[piece]);
				if (!word.Valid)
				{
					trace("Invalid word " + word.WordString);
					return;
				}
				trace("Valid word " + word.WordString);
				
				WordCollection.Instance.AddWord(word);
				UIManager.Instance.CurrentUI = new UIType.DICTIONARY.UIClass();
				return;
			}
			
			if (mEquipedUIWordPiece || mEquipedUIWordPieceGroup)
			{
				return;
			}
			
			offset.x += mRadioButton.width;
			offset.y += mRadioButton.height;
			offset.x *= 0.5;
			offset.y *= 0.5;
			if (piece.x >= mRadioButton.x - offset.x && piece.x <= mRadioButton.x + offset.x &&
				piece.y >= mRadioButton.y - offset.y && piece.y <= mRadioButton.y + offset.y)
			{
				mEquipedUIWordPiece = piece;
				mRadioButton.Color = 0x00FF00;
			}
		}
		
		private function StopGroupDrag():void 
		{
			var group:UIWordPieceGroup = mDraggedUIWordPieceGroup;
			mDraggedUIWordPieceGroup = null;
			
			var offset:Point = new Point(group.PieceList[0].width, group.PieceList[0].height);
			
			if (group.x >= mDictionaryButton.x - offset.x && group.x <= mDictionaryButton.x + offset.x &&
				group.y >= mDictionaryButton.y - offset.y && group.y <= mDictionaryButton.y + offset.y)
			{
				var word:Word = CreateWord(group.PieceList);
				if (!word.Valid)
				{
					trace("Invalid word " + word.WordString);
					return;
				}
				trace("Valid word " + word.WordString);
				
				WordCollection.Instance.AddWord(word);
				UIManager.Instance.CurrentUI = new UIType.DICTIONARY.UIClass();
				return;
			}
			
			if (mEquipedUIWordPiece || mEquipedUIWordPieceGroup)
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
			group.Dispose();
			mUIWordPieceGroupList.splice(mUIWordPieceGroupList.indexOf(group), 1);
			
			if (group == mEquipedUIWordPieceGroup)
			{
				mEquipedUIWordPieceGroup = null;
				mEquipedUIWordPiece = piece;
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
	}
}