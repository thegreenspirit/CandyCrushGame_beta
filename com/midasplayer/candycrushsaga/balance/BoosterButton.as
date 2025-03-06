package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.listener.IBuyAnyProductListener;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   
   public class BoosterButton extends MovieClip implements IBuyAnyProductListener
   {
      internal static var _glowFilter:GlowFilter;
      
      public static var FL_BG_ACTIVE:String = "active";
      
      public static var FL_BG_INACTIVE:String = "inactive";
      
      public static var FL_SYMBOL_NORMAL:String = "normal";
      
      public static var FL_SYMBOL_ACTIVATED:String = "activated";
      
      public static var FL_SYMBOL_INACTIVE:String = "inactive";
      
      public static var FL_AMOUNT_INACTIVE:String = "inactive";
      
      public static var FL_AMOUNT_TOTAL:String = "total";
      
      public static var FL_AMOUNT_ADD:String = "add";
      
      public static var FL_AMOUNT_ACTIVATED:String = "activated";
      
      private var previousAmount:int = 0;
      
      protected var _boosterInfoBubble:BoosterInfoBubble;
      
      protected var _inventory:Inventory;
      
      protected var _ccPowerUp:CCPowerUp;
      
      protected var _mcButton:MovieClip;
      
      protected var _mcBG:MovieClip;
      
      protected var _mcSymbol:MovieClip;
      
      protected var _mcAmount:MovieClip;
      
      protected var _gameMode:String;
      
      protected var _context:String;
      
      protected var _isActivated:Boolean;
      
      protected var _containerOb:Object;
      
      public function BoosterButton(param1:String, param2:Inventory, param3:CCPowerUp, param4:String, param5:* = null)
      {
         super();
         this._context = param1;
         this._ccPowerUp = param3;
         this._inventory = param2;
         this._gameMode = param4;
         this._containerOb = param5;
         _glowFilter = new GlowFilter();
         _glowFilter.color = 16777215;
         _glowFilter.strength = 2.6;
         _glowFilter.blurX = 9;
         _glowFilter.blurY = 9;
         _glowFilter.inner = true;
         this._isActivated = false;
         if(this._ccPowerUp.acceptedInGameMode(param4))
         {
            if(this._ccPowerUp.getPopActivated() && this._inventory.getItemAmount(this._ccPowerUp.getType()) > 0)
            {
               this._isActivated = true;
            }
         }
         this.previousAmount = this._inventory.getItemAmount(this._ccPowerUp.getType());
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      public function setUpButton() : void
      {
         this.addChild(this._mcButton);
         if(this._ccPowerUp.acceptedInGameMode(this._gameMode) == true)
         {
            this._mcButton.buttonMode = true;
            this._mcButton.mouseChildren = false;
            this.setButtonState();
            this.setUpInfoBubble();
            this.setUpListeners();
         }
         else
         {
            this.gotoFrame(this._mcBG,true,BoosterButton.FL_BG_INACTIVE);
            this.gotoFrame(this._mcSymbol,true,BoosterButton.FL_SYMBOL_INACTIVE);
            this.gotoFrame(this._mcAmount,true,BoosterButton.FL_AMOUNT_INACTIVE);
         }
      }
      
      public function setButtonState() : void
      {
         var _loc_1:* = this._inventory.getItemAmount(this._ccPowerUp.getType());
         var _loc_2:* = this._ccPowerUp.getUnlocked();
         if(_loc_2 == false)
         {
            this.gotoFrame(this._mcBG,true,BoosterButton.FL_BG_INACTIVE);
            this.gotoFrame(this._mcSymbol,true,BoosterButton.FL_SYMBOL_INACTIVE);
            this.gotoFrame(this._mcAmount,true,BoosterButton.FL_AMOUNT_INACTIVE);
         }
         else
         {
            this.gotoFrame(this._mcBG,true,BoosterButton.FL_BG_ACTIVE);
            if(this._isActivated)
            {
               this.setToActivated();
            }
            else
            {
               this.gotoFrame(this._mcSymbol,true,BoosterButton.FL_SYMBOL_NORMAL);
               if(_loc_1 > 0)
               {
                  this.setToReadyToActivate();
               }
               else
               {
                  this.setToAdd();
               }
            }
         }
      }
      
      protected function setToActivated() : void
      {
         this.gotoFrame(this._mcSymbol,false,BoosterButton.FL_SYMBOL_ACTIVATED);
         this.gotoFrame(this._mcAmount,false,BoosterButton.FL_AMOUNT_ACTIVATED);
         this.typeAmount();
      }
      
      protected function setToAdd() : void
      {
         this.gotoFrame(this._mcSymbol,true,BoosterButton.FL_SYMBOL_NORMAL);
         this.gotoFrame(this._mcAmount,true,BoosterButton.FL_AMOUNT_ADD);
      }
      
      protected function setToReadyToActivate() : void
      {
         this.gotoFrame(this._mcSymbol,true,BoosterButton.FL_SYMBOL_NORMAL);
         this.gotoFrame(this._mcAmount,true,BoosterButton.FL_AMOUNT_TOTAL);
         this.typeAmount();
      }
      
      protected function setUpInfoBubble() : void
      {
         if(this._ccPowerUp is CCBooster)
         {
            this._boosterInfoBubble = new BoosterInfoBubble(this._context,this._inventory,CCBooster(this._ccPowerUp),this);
         }
      }
      
      protected function gotoFrame(param1:MovieClip, param2:Boolean, param3:String) : void
      {
         if(param1.currentFrameLabel != param3)
         {
            if(param2)
            {
               param1.gotoAndStop(param3);
            }
            else
            {
               param1.gotoAndPlay(param3);
            }
         }
      }
      
      protected function setUpListeners() : void
      {
         if(this._ccPowerUp.getUnlocked() == false)
         {
            return;
         }
         this.setUpButtonListeners();
      }
      
      protected function setUpButtonListeners() : void
      {
         this._mcButton.buttonMode = true;
         this._inventory.addEventListener(BalanceConstants.EVENT_INVENTORY_HAS_BEEN_UPDATED,this.inventoryHasBeenUpdated);
         this._mcButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._mcButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._mcButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      protected function removeButtonListeners() : void
      {
         this._mcButton.buttonMode = false;
         this._inventory.removeEventListener(BalanceConstants.EVENT_INVENTORY_HAS_BEEN_UPDATED,this.inventoryHasBeenUpdated);
         this._mcButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._mcButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._mcButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      protected function onMouseOver(event:MouseEvent) : void
      {
         this._mcSymbol.filters = [_glowFilter];
      }
      
      protected function onMouseOut(event:MouseEvent) : void
      {
         this._mcSymbol.filters = [];
      }
      
      protected function onMouseDown(event:MouseEvent) : void
      {
         SoundInterface.playSound(SoundInterface.CLICK);
         if(this._isActivated)
         {
            if(this is PopBoosterButton)
            {
               this.unselectBoosterButton();
            }
         }
         else if(this._mcAmount.currentFrameLabel == BoosterButton.FL_AMOUNT_ADD)
         {
            if(this._ccPowerUp is CCCharm)
            {
               BoosterPanel(this._containerOb).queueSingleCharmPop(CCCharm(this._ccPowerUp));
            }
            else
            {
               this._boosterInfoBubble.create();
            }
            if(this._containerOb is BoosterPanel)
            {
               this._containerOb.stopGame();
            }
         }
         else
         {
            this.selectBoosterButton();
         }
      }
      
      public function onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         this.selectBoosterButton();
      }
      
      public function resumeGame() : void
      {
         if(this._containerOb is BoosterPanel)
         {
            this._containerOb.resumeGame();
         }
      }
      
      public function selectBoosterButton() : void
      {
         this._isActivated = true;
         this.setToActivated();
      }
      
      public function unselectBoosterButton() : void
      {
         this._isActivated = false;
         this.setButtonState();
      }
      
      public function collectSelectedPowerUps() : void
      {
         if(this._isActivated)
         {
            this._inventory.addToSelectedBoosters(this._ccPowerUp);
         }
      }
      
      protected function inventoryHasBeenUpdated(event:Event) : void
      {
         if(Boolean(this._boosterInfoBubble))
         {
            this._boosterInfoBubble.remove();
         }
         this.setButtonState();
      }
      
      protected function typeAmount() : void
      {
         if(this._ccPowerUp is CCCharm)
         {
            return;
         }
         if(this._mcAmount.currentFrameLabel == BoosterButton.FL_AMOUNT_ADD || this._mcAmount.currentFrameLabel == BoosterButton.FL_AMOUNT_INACTIVE)
         {
            return;
         }
         var _loc_1:* = this._inventory.getItemAmount(this._ccPowerUp.getType());
         trace(this._ccPowerUp.getType(),_loc_1);
         this._mcAmount.tAmount.text = _loc_1.toString();
         this._mcAmount.tAmount.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
         this._mcAmount.tAmount.embedFonts = false;
         if(_loc_1 > this.previousAmount)
         {
            SoundInterface.playSound(SoundInterface.BOOSTER_CREATED);
         }
         this.previousAmount = _loc_1;
      }
      
      public function getMovieClip() : MovieClip
      {
         return this._mcButton;
      }
      
      public function getBoosterId() : String
      {
         return this._ccPowerUp.getType();
      }
      
      public function getCCPowerUp() : CCPowerUp
      {
         return this._ccPowerUp;
      }
      
      public function acceptedInGameMode(param1:String) : Boolean
      {
         return this._ccPowerUp.acceptedInGameMode(param1);
      }
      
      public function removeBoosterInfoBubble() : void
      {
         if(this._boosterInfoBubble != null)
         {
            this._boosterInfoBubble.remove();
            if(this._boosterInfoBubble.parent != null)
            {
               this._boosterInfoBubble.parent.removeChild(this._boosterInfoBubble);
            }
            this._boosterInfoBubble = null;
         }
      }
      
      public function destroy() : void
      {
         this._ccPowerUp.setPopActivated(this._isActivated,this._gameMode);
         this._inventory.removeEventListener(BalanceConstants.EVENT_INVENTORY_HAS_BEEN_UPDATED,this.inventoryHasBeenUpdated);
         this._mcButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._mcButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._mcButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         if(this._mcButton.parent != null)
         {
            this._mcButton.parent.removeChild(this._mcButton);
         }
         this._mcButton = null;
         if(Boolean(_glowFilter))
         {
            _glowFilter = null;
         }
         this.removeBoosterInfoBubble();
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

