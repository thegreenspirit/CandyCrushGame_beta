package com.midasplayer.candycrushsaga.topnav
{
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TopNavBtnMediator extends EventDispatcher
   {
      private var _gfx:MovieClip;
      
      private var NORMAL:String = "normal";
      
      private var NORMAL_OFF:String = "alternateNormal";
      
      private var DOWN:String = "down";
      
      private var DOWN_OFF:String = "alternateDown";
      
      private var OVER:String = "over";
      
      private var OVER_OFF:String = "alternateOver";
      
      public var hasTwoStates:Boolean = false;
      
      private var ORG_Y:int;
      
      private var HIDDEN_Y:int = -30;
      
      private var _isOn:Boolean = true;
      
      private var text:String;
      
      private var foreverHidden:Boolean = false;
      
      public function TopNavBtnMediator(param1:MovieClip, param2:String = null, param3:Boolean = false)
      {
         super();
         this.ORG_Y = param1.y;
         this.text = param2;
         this.hasTwoStates = param3;
         this._gfx = param1;
         this._gfx.mouseChildren = false;
         this._gfx.buttonMode = true;
         this.addListeners();
         if(Boolean(param2))
         {
            this.setText();
         }
         this.setTintMode(false);
         this._gfx.gotoAndStop(this.currentNormal());
      }
      
      public function clearListeners() : void
      {
         this._gfx.removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this._gfx.removeEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         this._gfx.removeEventListener(MouseEvent.MOUSE_UP,this.overHandler);
         this._gfx.removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this._gfx.removeEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      public function setText(param1:String = null) : void
      {
         if(param1 != null)
         {
            this.text = param1;
         }
         if(Boolean(this._gfx.normalLabel))
         {
            this._gfx.normalLabel.embedFonts = false;
            this._gfx.normalLabel.text = this.text;
         }
         if(Boolean(this._gfx.normalLabel))
         {
            TextUtil.scaleToFit(this._gfx.normalLabel);
         }
      }
      
      public function show() : void
      {
         if(!this.foreverHidden)
         {
            TweenLite.to(this._gfx,1,{"y":this.ORG_Y});
         }
      }
      
      public function hide() : void
      {
         TweenLite.to(this._gfx,1,{"y":this.HIDDEN_Y});
      }
      
      public function hideForever() : void
      {
         this.hide();
         this.foreverHidden = true;
      }
      
      private function addListeners() : void
      {
         this._gfx.addEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this._gfx.addEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         this._gfx.addEventListener(MouseEvent.MOUSE_UP,this.overHandler);
         this._gfx.addEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this._gfx.addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      private function currentNormal() : String
      {
         return this.isOn ? this.NORMAL : this.NORMAL_OFF;
      }
      
      private function currentDown() : String
      {
         return this.isOn ? this.DOWN : this.DOWN_OFF;
      }
      
      private function currentOver() : String
      {
         return this.isOn ? this.OVER : this.OVER_OFF;
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         this._gfx.gotoAndStop(this.currentNormal());
         this.setTintMode(false);
      }
      
      private function overHandler(event:MouseEvent) : void
      {
         this._gfx.gotoAndStop(this.currentOver());
         this.setTintMode(false);
      }
      
      private function downHandler(event:MouseEvent) : void
      {
         this._gfx.gotoAndStop(this.currentDown());
         this.setTintMode(true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         CCSoundManager.getInstance().playSound(SoundInterface.CLICK);
         if(this.hasTwoStates)
         {
            this.isOn = !this.isOn;
         }
         this._gfx.gotoAndStop(this.currentNormal());
         this.setTintMode(false);
         dispatchEvent(event.clone());
      }
      
      private function setTintMode(param1:Boolean) : void
      {
         var _loc_2:* = this._gfx.tintLabel != null;
         if(_loc_2)
         {
            if(Boolean(this._gfx.normalLabel))
            {
               this._gfx.normalLabel.visible = !param1;
            }
            if(Boolean(this._gfx.tintLabel))
            {
               this._gfx.tintLabel.visible = param1;
            }
         }
         this.setText();
      }
      
      public function get isOn() : Boolean
      {
         return this._isOn;
      }
      
      public function set isOn(param1:Boolean) : void
      {
         this._isOn = param1;
         this._gfx.gotoAndStop(this.currentNormal());
      }
   }
}

import flash.events.EventDispatcher;

