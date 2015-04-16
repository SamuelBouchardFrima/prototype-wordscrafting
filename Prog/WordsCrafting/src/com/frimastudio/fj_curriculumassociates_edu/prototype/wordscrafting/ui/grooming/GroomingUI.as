package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.grooming
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.Food;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.grooming.FoodType;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.mini.MiniManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.IconUIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.MiniInteractionUI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UI;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class GroomingUI extends MiniInteractionUI
	{
		private var mPizzaButton:UIButton;
		private var mCoffeeButton:UIButton;
		private var mCupcakeButton:UIButton;
		private var mDraggedFood:UIFood;
		
		public function GroomingUI()
		{
			super();
			
			var buttonSize:Point = new Point(100, 100);
			
			mPizzaButton = new IconUIButton(buttonSize, Asset.PizzaButtonBitmap);
			mPizzaButton.x = 200;
			mPizzaButton.y = 200;
			addChild(mPizzaButton);
			mPizzaButton.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownPizzaButton);
			
			mCoffeeButton = new IconUIButton(buttonSize, Asset.CoffeeButtonBitmap);
			mCoffeeButton.x = 400;
			mCoffeeButton.y = 200;
			addChild(mCoffeeButton);
			mCoffeeButton.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownCoffeeButton);
			
			mCupcakeButton = new IconUIButton(buttonSize, Asset.CupcakeButtonBitmap);
			mCupcakeButton.x = 600;
			mCupcakeButton.y = 200;
			addChild(mCupcakeButton);
			mCupcakeButton.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownCupcakeButton);
		}
		
		override public function Dispose():void
		{
			mPizzaButton.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownPizzaButton);
			mCoffeeButton.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownCoffeeButton);
			mCupcakeButton.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownCupcakeButton);
			
			if (mDraggedFood)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			}
			
			super.Dispose();
		}
		
		private function CreateFood(aType:FoodType):void 
		{
			mDraggedFood = new UIFood(aType);
			mDraggedFood.x = mouseX;
			mDraggedFood.y = mouseY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			addChild(mDraggedFood);
		}
		
		private function OnMouseDownPizzaButton(aEvent:MouseEvent):void
		{
			CreateFood(FoodType.PIZZA);
		}
		
		private function OnMouseDownCoffeeButton(aEvent:MouseEvent):void
		{
			CreateFood(FoodType.COFFEE);
		}
		
		private function OnMouseDownCupcakeButton(aEvent:MouseEvent):void
		{
			CreateFood(FoodType.CUPCAKE);
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			mDraggedFood.x = mouseX;
			mDraggedFood.y = mouseY;
		}
		
		private function OnMouseUp(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			var offset:Point = new Point(mDraggedFood.width, mDraggedFood.height);
			var miniSprite:Sprite;
			for (var i:int = 0, end:int = mMiniList.length; i < end; ++i)
			{
				if (mMiniList[i].x >= mDraggedFood.x - offset.x && mMiniList[i].x <= mDraggedFood.x + offset.x &&
					mMiniList[i].y >= mDraggedFood.y - offset.y && mMiniList[i].y <= mDraggedFood.y + offset.y)
				{
					MiniManager.Instance.MiniList[i].Eat(new Food(mDraggedFood.Type));
					miniSprite = CreateMiniSprite(MiniManager.Instance.MiniList[i]);
					miniSprite.x = mMiniList[i].x;
					miniSprite.y = mMiniList[i].y;
					removeChild(mMiniList[i]);
					addChild(miniSprite);
					mMiniList[i] = miniSprite;
					break;
				}
			}
			
			removeChild(mDraggedFood);
			mDraggedFood = null;
		}
	}
}