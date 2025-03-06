package com.midasplayer.candycrushsaga.balance
{
   import balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class PopBoosterButton extends BoosterButton
   {
      public function PopBoosterButton(param1:String, param2:Inventory, param3:CCBooster, param4:String, param5:BoosterModule)
      {
         super(param1,param2,param3,param4,param5);
         _mcButton = new PopBoosterButtonClip();
         _mcButton.iSymbolContainer.gotoAndStop(_ccPowerUp.getType());
         _mcSymbol = _mcButton.iSymbolContainer.iSymbol;
         _mcBG = _mcButton.iBG;
         _mcAmount = _mcButton.iAmount;
      }
      
      override protected function onMouseDown(event:MouseEvent) : void
      {
         var _loc_2:* = _ccPowerUp.getType();
         if(!_isActivated)
         {
            if(_mcAmount.currentFrameLabel == BoosterButton.FL_AMOUNT_ADD)
            {
            }
         }
         super.onMouseDown(event);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

