package com.midasplayer.candycrushsaga.balance
{
   import balance.*;
   import com.greensock.*;
   import com.king.saga.api.crafting.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class BoosterInfoBubble extends MovieClip
   {
      private static var _gradientFilter:GradientBevelFilter;
      
      private static var _dropFilter:DropShadowFilter;
      
      private static const IN_BUTTON_QUIT:String = "iQuitButton";
      
      private static const IN_BUTTON_PURCHASE:String = "iPurchaseButton";
      
      private static const IN_BUTTON_CREATE:String = "iCreateButton";
      
      private var _clip:MovieClip;
      
      private var _ingredients:Array;
      
      private var _displayBase:MovieClip;
      
      private var _inventory:Inventory;
      
      private var _ccBooster:CCBooster;
      
      private var _boosterButton:BoosterButton;
      
      private var _boosterType:String;
      
      private var _mcButton:MovieClip;
      
      private var _context:String;
      
      private var _title:String;
      
      private var _description:String;
      
      private var _recipeTitle:String;
      
      private var _createButtonText:String;
      
      private var _purchaseButtonText:String;
      
      private var _purchaseAmount:String;
      
      private var _darkLayer:MovieClip;
      
      private var CRAFTING_ENABLED:Boolean;
      
      private var _mcAutoRegenSquare:MovieClip;
      
      public function BoosterInfoBubble(param1:String, param2:Inventory, param3:CCBooster, param4:BoosterButton)
      {
         super();
         this._displayBase = CCMain.mcDisplayPopup;
         this._ccBooster = param3;
         this._context = param1;
         this._inventory = param2;
         this._boosterType = param3.getType();
         this._mcButton = param4.getMovieClip();
         this._boosterButton = param4;
         this._title = I18n.getString("booster_name_" + this._boosterType);
         this._description = I18n.getString("booster_description_" + this._boosterType);
         this._recipeTitle = I18n.getString("booster_info_bubble_recipe_title");
         this._purchaseButtonText = I18n.getString("booster_info_bubble_button_purchase");
         this._purchaseAmount = I18n.getString("popup_item_unlocked_purchase_amount_" + this._boosterType);
         _gradientFilter = new GradientBevelFilter();
         _gradientFilter.blurX = 6;
         _gradientFilter.blurY = 6;
         _gradientFilter.strength = 1;
         _gradientFilter.angle = 270;
         _gradientFilter.distance = 5;
         _gradientFilter.type = "inner";
         _gradientFilter.colors = [16764159,16771327,16777215,13519280,8921947];
         _gradientFilter.alphas = [1,0.45,0,0.35,1];
         _gradientFilter.ratios = [0,60,130,190,255];
         _dropFilter = new DropShadowFilter();
         _dropFilter.blurX = 5;
         _dropFilter.blurY = 5;
         _dropFilter.strength = 0.66;
         _dropFilter.angle = 89;
         _dropFilter.distance = 3;
         _dropFilter.color = 0;
         _dropFilter.alpha = 0.8;
         this.CRAFTING_ENABLED = this._ccBooster.getCraftable();
      }
      
      public function create() : void
      {
         var _loc_7:Point = null;
         var _loc_8:Point = null;
         if(this._clip != null)
         {
            return;
         }
         this._clip = new BoosterInfoContainerClip();
         this._displayBase.addChild(this._clip);
         this._darkLayer = DarkLayer.addDarkLayer(this._clip);
         this._darkLayer.addEventListener(MouseEvent.CLICK,this.onClick);
         var _loc_1:* = this._clip.iSquare;
         var _loc_2:* = this._clip.iPurchaseButton;
         var _loc_3:* = this._clip.iBlobBG;
         var _loc_4:* = this._clip.iPoint;
         var _loc_5:* = this._clip.iQuitButton;
         if(this._context == BalanceConstants.POWERUP_TRIGGER_CONTEXT_INGAME)
         {
            _loc_4.gotoAndStop(2);
         }
         this._clip.tTitle.text = this._title;
         this._clip.iSymbol.gotoAndStop(this._ccBooster.getType());
         this._clip.iCreditSign.tValue.text = this._ccBooster.getCost();
         this._clip.tAmount.text = "x " + this._purchaseAmount;
         this._clip.tDesc.text = this._description;
         this._clip.tDesc.autoSize = TextFieldAutoSize.LEFT;
         var _loc_6:* = this._clip.iPurchaseButton;
         this._clip.iPurchaseButton.gotoAndStop("normal");
         this._clip.tCommand.text = this._purchaseButtonText;
         TextUtil.scaleToFit(this._clip.tCommand);
         TextUtil.scaleToFit(this._clip.tAmount);
         TextUtil.scaleToFit(this._clip.iCreditSign.tValue);
         TextUtil.scaleToFit(this._clip.tTitle);
         TextUtil.scaleToFit(this._clip.tDesc);
         this._clip.tCommand.mouseEnabled = false;
         this._clip.tCommand.autoSize = TextFieldAutoSize.CENTER;
         this._clip.tCommand.x = this._clip.width / 2 - this._clip.tCommand.width / 2;
         _loc_6.iBG.iLeft.x = 0;
         _loc_6.iBG.iCenter.x = _loc_6.iBG.iLeft.width;
         _loc_6.iBG.iCenter.width = this._clip.tCommand.width;
         _loc_6.iBG.iRight.x = _loc_6.iBG.iCenter.x + _loc_6.iBG.iCenter.width;
         _loc_6.y = this._clip.tDesc.y + this._clip.tDesc.height + 10;
         this._clip.tCommand.y = this._clip.iPurchaseButton.y + 2;
         _loc_6.x = (this._clip.iBlobBG.width - _loc_6.iBG.width) / 2;
         if(this._ccBooster.getAutoGenerating())
         {
            this._mcAutoRegenSquare = new AutoRegenSquare();
            this._mcAutoRegenSquare.tDesc.text = I18n.getString("booster_info_bubble_autoRegen_desc_" + this._boosterType);
            TextUtil.scaleToFit(this._mcAutoRegenSquare.tDesc);
            this._clip.addChild(this._mcAutoRegenSquare);
            this._mcAutoRegenSquare.y = _loc_6.y + _loc_6.height + 15;
            this._mcAutoRegenSquare.x = (this._clip.iBlobBG.width - this._mcAutoRegenSquare.width) / 2;
            this._clip.iBlobBG.height = this._mcAutoRegenSquare.y + this._mcAutoRegenSquare.height + 25;
         }
         else
         {
            this._clip.iBlobBG.height = _loc_6.y + _loc_6.height + 25;
         }
         this.setupButton(_loc_5);
         this.setupButton(_loc_2);
         if(this._context == BalanceConstants.POWERUP_TRIGGER_CONTEXT_PREGAME)
         {
            this._clip.x = 65;
            _loc_7 = this._mcButton.parent.localToGlobal(new Point(this._mcButton.x,this._mcButton.y));
            this._clip.y = _loc_7.y - this._clip.iBlobBG.height - 15;
            _loc_8 = _loc_4.parent.globalToLocal(_loc_7);
            _loc_4.x = _loc_8.x + 17;
            _loc_4.y = _loc_3.height - 10;
         }
         else if(this._context == BalanceConstants.POWERUP_TRIGGER_CONTEXT_INGAME)
         {
            this._clip.x = 300;
            this._clip.y = 60;
            _loc_7 = this._mcButton.parent.localToGlobal(new Point(this._mcButton.x,this._mcButton.y));
            _loc_8 = _loc_4.parent.globalToLocal(_loc_7);
            _loc_4.x = _loc_8.x + 7;
            _loc_4.y = -25;
         }
         this._clip.filters = [_gradientFilter,_dropFilter];
         this._clip.alpha = 0;
         TweenLite.to(this._clip,0.3,{"alpha":1});
         _loc_5.parent.addChild(_loc_5);
         _loc_5.buttonMode = true;
      }
      
      private function setUpIngredients() : Boolean
      {
         var _loc_5:ItemAmount = null;
         var _loc_6:MovieClip = null;
         var _loc_7:IngredientVO = null;
         var _loc_8:Boolean = false;
         this._ingredients = new Array();
         var _loc_1:* = this._inventory.getRecipe(this._boosterType);
         var _loc_2:* = _loc_1.getInputTypeIds();
         var _loc_4:Boolean = true;
         for each(_loc_5 in _loc_2)
         {
            _loc_6 = new IngredientContainer();
            _loc_7 = new IngredientVO(_loc_6,_loc_5);
            _loc_8 = this.setStockStatus(_loc_7);
            if(_loc_8 == false)
            {
               _loc_4 = false;
            }
            this.setAmountText(_loc_7);
            this._clip.addChild(_loc_7.mc);
            _loc_7.mc.x = 28;
            _loc_7.mc.y = 110 + this._ingredients.length * 35;
            this._ingredients.push(_loc_7);
         }
         return _loc_4;
      }
      
      private function setStockStatus(param1:IngredientVO) : Boolean
      {
         var _loc_2:* = param1.item.getType().toString();
         var _loc_3:* = param1.item.getAmount();
         var _loc_4:* = this._inventory.getItemAmount(param1.item.getType());
         if(this._inventory.getItemAmount(param1.item.getType()) >= _loc_3)
         {
            param1.mc.iIngredientTextContainer.gotoAndStop("enough");
            return true;
         }
         param1.mc.iIngredientTextContainer.gotoAndStop("notEnough");
         return false;
      }
      
      private function setAmountText(param1:IngredientVO) : void
      {
         var _loc_2:* = param1.item.getAmount();
         var _loc_3:* = this._inventory.getItemAmount(param1.item.getType());
         var _loc_4:* = _loc_3.toString() + " / " + _loc_2.toString();
         param1.mc.iIngredientTextContainer.tAmount.text = _loc_4;
         TextUtil.scaleToFit(param1.mc.iIngredientTextContainer.tAmount);
      }
      
      private function setupButton(param1:MovieClip) : void
      {
         param1.buttonMode = true;
         param1.mouseChildren = false;
         param1.addEventListener(MouseEvent.CLICK,this.onClick);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      public function onClick(event:MouseEvent) : void
      {
         var _loc_2:Boolean = false;
         switch(event.currentTarget.name)
         {
            case BoosterInfoBubble.IN_BUTTON_QUIT:
               event.currentTarget.gotoAndStop("pressed");
               this.remove();
               break;
            case BoosterInfoBubble.IN_BUTTON_PURCHASE:
               _loc_2 = false;
               this._inventory.buyPowerUp(this._ccBooster,this._boosterButton,_loc_2);
               this.removePurchaseListeners();
               break;
            default:
               this.remove();
         }
      }
      
      private function onMouseDown(event:MouseEvent) : void
      {
         if(event.target == this._clip.iPurchaseButton)
         {
            this._clip.tCommand.y = this._clip.iPurchaseButton.y + 2;
            event.currentTarget.gotoAndStop("pressed");
            SoundInterface.playSound(SoundInterface.CLICK_WRAPPED);
         }
         if(event.target == this._clip.iQuitButton)
         {
            SoundInterface.playSound(SoundInterface.CLICK);
         }
      }
      
      public function onMouseOver(event:MouseEvent) : void
      {
         event.currentTarget.gotoAndStop("hovered");
         if(event.target == this._clip.iPurchaseButton)
         {
            this._clip.tCommand.y = this._clip.iPurchaseButton.y - 2;
         }
      }
      
      public function onMouseOut(event:MouseEvent) : void
      {
         if(event.target == this._clip.iPurchaseButton)
         {
            this._clip.tCommand.y = this._clip.iPurchaseButton.y;
         }
         event.currentTarget.gotoAndStop("normal");
      }
      
      public function remove() : void
      {
         if(this._clip != null)
         {
            TweenLite.to(this._clip,0.3,{
               "alpha":0,
               "onComplete":this.destroy
            });
            DarkLayer.removeDarkLayer(this._clip);
            if(this._clip.alpha == 1)
            {
               this._boosterButton.resumeGame();
            }
         }
      }
      
      private function removePurchaseListeners() : void
      {
         var _loc_1:* = this._clip.iPurchaseButton;
         _loc_1.removeEventListener(MouseEvent.CLICK,this.onClick);
         _loc_1.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         _loc_1.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         _loc_1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      public function destroy() : void
      {
         var _loc_1:IngredientVO = null;
         var _loc_2:MovieClip = null;
         if(this._clip == null)
         {
            return;
         }
         Console.println(" --- clean up booster info bubble");
         for each(_loc_1 in this._ingredients)
         {
            _loc_1.mc.parent.removeChild(_loc_1.mc);
            _loc_1.mc = null;
            _loc_1 = null;
         }
         this._ingredients = null;
         this.removePurchaseListeners();
         _loc_2 = this._clip.iQuitButton;
         _loc_2.removeEventListener(MouseEvent.CLICK,this.onClick);
         _loc_2.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         _loc_2.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._darkLayer.removeEventListener(MouseEvent.CLICK,this.onClick);
         if(Boolean(this._mcAutoRegenSquare))
         {
            this._mcAutoRegenSquare.parent.removeChild(this._mcAutoRegenSquare);
            this._mcAutoRegenSquare = null;
         }
         this._clip.filters = [];
         this._clip.parent.removeChild(this._clip);
         this._clip = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

