package com.midasplayer.candycrushsaga.balance
{
   import balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.display.*;
   
   public class BoosterModule extends MovieClip
   {
      private var _boosterButtons:Array;
      
      private var _inventory:Inventory;
      
      public function BoosterModule(param1:Inventory, param2:String)
      {
         var _loc_9:int = 0;
         var _loc_10:CCBooster = null;
         var _loc_11:MovieClip = null;
         var _loc_4:int = 0;
         var _loc_5:int = 0;
         var _loc_8:uint = 0;
         super();
         this._inventory = param1;
         var _loc_3:* = this._inventory.getAvailableBoostersAmount(BalanceConstants.POWERUP_TRIGGER_CONTEXT_PREGAME);
         if(_loc_3 <= 3)
         {
            _loc_4 = 70;
            _loc_5 = 360;
            _loc_9 = 3;
         }
         else if(_loc_3 == 4)
         {
            _loc_4 = 25;
            _loc_5 = 360;
            _loc_9 = 4;
         }
         else
         {
            _loc_4 = 25;
            _loc_5 = 325;
            _loc_9 = 7;
         }
         this._boosterButtons = new Array();
         var _loc_6:* = BalanceConstants.POWERUP_TRIGGER_CONTEXT_PREGAME;
         var _loc_7:* = this._inventory.getCCBoosters(Inventory.FIND_POWERUP_CONTEXT,_loc_6,true);
         while(_loc_8 < _loc_9)
         {
            if(_loc_7.length > _loc_8)
            {
               _loc_10 = _loc_7[_loc_8];
               _loc_11 = new PopBoosterButton(_loc_6,param1,_loc_10,param2,null);
               _loc_11.setUpButton();
               this._boosterButtons.push(_loc_11);
            }
            else
            {
               _loc_11 = new BoosterButtonBGBig();
               _loc_11.gotoAndStop(BoosterButton.FL_BG_INACTIVE);
            }
            _loc_11.x = _loc_4;
            _loc_11.y = _loc_5;
            this.addChild(_loc_11);
            _loc_4 += 100;
            _loc_5 = _loc_8 > 2 ? 400 : _loc_5;
            if(_loc_8 == 3)
            {
               _loc_4 = 75;
            }
            _loc_8 += 1;
         }
      }
      
      public function collectSelectedBoosters() : void
      {
         var _loc_1:BoosterButton = null;
         for each(_loc_1 in this._boosterButtons)
         {
            _loc_1.collectSelectedPowerUps();
         }
      }
      
      public function getAvailableBoosterButtons() : Array
      {
         return this._boosterButtons;
      }
      
      public function destroy() : void
      {
         var _loc_1:BoosterButton = null;
         Console.println(" --- cleanup boostermodule");
         while(this._boosterButtons.length > 0)
         {
            _loc_1 = this._boosterButtons[0];
            _loc_1.destroy();
            this._boosterButtons.splice(0,1);
            _loc_1 = null;
         }
         this._boosterButtons = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

