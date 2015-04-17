package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.util.MathUtil;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class UIScrollbox extends Sprite
	{
		protected var mWindow:Sprite;
		protected var mElementContainer:Sprite;
		protected var mElementList:Vector.<UIScrollElement>;
		protected var mElementSize:Point;
		protected var mScrolling:Boolean;
		protected var mMouseYDelta:Number;
		
		public function UIScrollbox(aSize:Point)
		{
			super();
			
			var halfSize:Point = aSize.clone();
			halfSize.normalize(aSize.length * 0.5);
			
			graphics.lineStyle(2);
			graphics.moveTo(-(halfSize.x), -(halfSize.y));
			graphics.lineTo(halfSize.x, -(halfSize.y));
			graphics.lineTo(halfSize.x, halfSize.y);
			graphics.lineTo(-(halfSize.x), halfSize.y);
			graphics.lineTo(-(halfSize.x), -(halfSize.y));
			
			mWindow = new Sprite();
			mWindow.scrollRect = new Rectangle(0, 0, aSize.x, aSize.y);
			mWindow.x = -halfSize.x;
			mWindow.y = -halfSize.y;
			addChild(mWindow);
			
			mElementContainer = new Sprite();
			mElementContainer.x = 0;
			mElementContainer.y = 0;
			mElementContainer.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownElementContainer);
			mWindow.addChild(mElementContainer);
			
			mElementList = new Vector.<UIScrollElement>();
			
			mElementSize = new Point(aSize.x, 30);
		}
		
		public function Dispose():void
		{
			mElementContainer.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownElementContainer);
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			for (var i:int = 0, end:int = mElementList.length; i < end; ++i)
			{
				mElementList[i].Dispose();
			}
		}
		
		protected function AddElement(aElement:UIScrollElement):void
		{
			aElement.x = 0;
			aElement.y = (mElementList.length * mElementSize.y) + (mElementSize.y * 0.5);
			mElementContainer.addChild(aElement);
			mElementList.push(aElement);
		}
		
		private function OnMouseDownElementContainer(aEvent:MouseEvent):void
		{
			mScrolling = false;
			mMouseYDelta = mouseY;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			if (mElementContainer.height <= 400)
			{
				return;
			}
			
			mScrolling = true;
			
			mElementContainer.y += mouseY - mMouseYDelta;
			mElementContainer.y = MathUtil.MinMax(mElementContainer.y, 396 - mElementContainer.height, 0);
			
			mMouseYDelta = mouseY;
		}
		
		private function OnMouseUp(aEvent:MouseEvent):void
		{
			if (!mScrolling)
			{
				return;
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
	}
}