package com.midasplayer.candycrushsaga.balance
{
   import balance.*;
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   import flash.display.*;
   import flash.events.*;
   
   public class ExtraMovesReminderContainer extends MovieClip
   {
      private var _clip:MovieClip;
      
      private var _shown:Boolean;
      
      private var _boosterCost:String;
      
      private var _remainderOffset:int;
      
      private var _capped:Boolean;
      
      public function ExtraMovesReminderContainer(param1:String, param2:String, param3:String)
      {
         super();
         if(param3 == GameConf.MODE_NAME_DROP_DOWN)
         {
            this._remainderOffset = 200;
         }
         else
         {
            this._remainderOffset = 0;
         }
         this.x = -100;
         this.y = 175 + this._remainderOffset;
         this.buttonMode = true;
         this.mouseEnabled = true;
         this.mouseChildren = true;
         this._clip = new ExtraMovesReminder();
         this._capped = false;
         this.addChild(this._clip);
         this._clip.gotoAndStop("bouncing");
         this._boosterCost = param2;
         this._clip.titeltextfield.label.text = param1;
         this._clip.fbBuyButton.label.text = param2;
         this._clip.mouseEnabled = true;
         this._clip.buttonMode = true;
         this._clip.titeltextfield.buttonMode = true;
         this._clip.titeltextfield.mouseEnabled = true;
         this._clip.titeltextfield.mouseChildren = false;
         this._clip.fbBuyButton.addEventListener(MouseEvent.MOUSE_OVER,this.mouse_over_function);
         this._clip.fbBuyButton.addEventListener(MouseEvent.MOUSE_DOWN,this.mouse_down_function);
         this._clip.fbBuyButton.addEventListener(MouseEvent.MOUSE_OUT,this.mouse_out_function);
         this._clip.fbBuyButton.stop();
      }
      
      public function show() : void
      {
         if(!this._capped)
         {
            this._clip.gotoAndStop("bouncing");
            this._clip.bounceanimation.play();
            TweenLite.to(this,1,{
               "x":0,
               "y":250 + this._remainderOffset
            });
            this._shown = true;
         }
      }
      
      public function hide() : void
      {
         this._clip.gotoAndStop("bouncing");
         this._clip.bounceanimation.stop();
         TweenLite.to(this,1,{
            "x":-100,
            "y":250 + this._remainderOffset
         });
         this._shown = false;
      }
      
      public function isShown() : Boolean
      {
         return this._shown;
      }
      
      public function setCap(param1:Boolean) : void
      {
         this._capped = param1;
      }
      
      private function mouse_over_function(event:MouseEvent) : void
      {
         this._clip.fbBuyButton.gotoAndStop("hovered");
         this._clip.fbBuyButton.label.text = this._boosterCost;
      }
      
      private function mouse_down_function(event:MouseEvent) : void
      {
         this._clip.fbBuyButton.gotoAndStop("pressed");
         this._clip.fbBuyButton.label.text = this._boosterCost;
      }
      
      private function mouse_out_function(event:MouseEvent) : void
      {
         this._clip.fbBuyButton.gotoAndStop("normal");
         this._clip.fbBuyButton.label.text = this._boosterCost;
      }
      
      private function remove() : void
      {
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

