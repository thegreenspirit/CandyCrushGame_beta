package com.midasplayer.candycrushsaga.popup.notificationcentral
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import flash.display.*;
   import flash.events.*;
   
   public class Slider extends MovieClip
   {
      private static const _KNOBSTEP:String = "knob_step";
      
      private static const _BARJUMP:String = "bar_jump";
      
      private var _mouseOffset:Number;
      
      private var _mask:MovieClip;
      
      private var _contentHolder:MovieClip;
      
      private var _contX:Number;
      
      private var _contY:Number;
      
      private var _arrow1:MovieClip;
      
      private var _arrow2:MovieClip;
      
      private var _sliderBg:MovieClip;
      
      private var _sliderKnob:MovieClip;
      
      private var _content:MovieClip;
      
      private var _knobStep:Number;
      
      private var _tweenSec:Number;
      
      private var _knobMin:Number;
      
      private var _knobMax:Number;
      
      private var _mouseReleased:Boolean;
      
      public function Slider(param1:MovieClip, param2:MovieClip, param3:Number, param4:Number, param5:MovieClip, param6:MovieClip, param7:MovieClip, param8:MovieClip, param9:Number = 64, param10:Number = 0.2, param11:Number = 120)
      {
         var contentHolder:*;
         var mask:*;
         var contX:*;
         var contY:*;
         var sliderBg:*;
         var sliderKnob:*;
         var arrowup:*;
         var arrowdown:*;
         var knobStep:*;
         var tweenSec:*;
         var mouseOffset:*;
         super();
         contentHolder = param1;
         mask = param2;
         contX = param3;
         contY = param4;
         sliderBg = param5;
         sliderKnob = param6;
         arrowup = param7;
         arrowdown = param8;
         knobStep = param9;
         tweenSec = param10;
         mouseOffset = param11;
         this._mouseOffset = mouseOffset;
         this._contentHolder = contentHolder;
         this._mask = mask;
         this._contX = contX;
         this._contY = contY;
         this._knobStep = knobStep;
         this._tweenSec = tweenSec;
         this._sliderBg = sliderBg;
         this._sliderKnob = sliderKnob;
         this._arrow1 = arrowup;
         this._arrow2 = arrowdown;
         this._mouseReleased = true;
         this._sliderBg.addEventListener(MouseEvent.CLICK,this.barJump);
         this._arrow1.alpha = 0;
         this._arrow2.alpha = 0;
         this._arrow1.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void
         {
            stepUp(event,_KNOBSTEP);
         });
         this._arrow2.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void
         {
            stepDown(event,_KNOBSTEP);
         });
         this._sliderKnob.addEventListener(MouseEvent.MOUSE_DOWN,this.addEnterFrameListener);
         this._sliderKnob.addEventListener(MouseEvent.MOUSE_OVER,this._onMouseOver);
         this._sliderKnob.addEventListener(MouseEvent.MOUSE_OUT,this._onMouseOut);
         this._contentHolder.parent.addEventListener(MouseEvent.MOUSE_UP,this.setMouseReleased);
         this.visibleElements(false);
      }
      
      private function _onMouseOut(event:MouseEvent) : void
      {
         if(this._mouseReleased)
         {
            event.currentTarget.gotoAndStop(1);
         }
      }
      
      private function _onMouseOver(event:MouseEvent) : void
      {
         if(this._mouseReleased)
         {
            event.currentTarget.gotoAndStop(2);
         }
      }
      
      private function visibleElements(param1:Boolean) : void
      {
         this._sliderBg.visible = param1;
         this._sliderKnob.visible = param1;
         this._arrow1.visible = param1;
         this._arrow2.visible = param1;
      }
      
      public function adjust(param1:MovieClip) : void
      {
         this._content = param1;
         if(this._content.height <= this._mask.height)
         {
            this.visible = false;
            this.visibleElements(false);
         }
         else
         {
            this.visible = true;
            this.positionSliderKnob();
            this.visibleElements(true);
         }
      }
      
      private function positionSliderKnob() : void
      {
         var _loc_1:Number = NaN;
         this._knobMin = this._arrow1.y + 10;
         this._knobMax = this._arrow2.y - 10 - this._sliderKnob.height;
         _loc_1 = (this._mask.y - this._content.y) / (this._content.height - this._mask.height);
         this._sliderKnob.y = this._knobMin + _loc_1 * (this._knobMax - this._knobMin);
      }
      
      private function stepUp(event:Event, param2:String) : void
      {
         var _loc_3:* = param2 == _KNOBSTEP ? this._knobStep : this._sliderKnob.y - mouseY + this._mouseOffset;
         var _loc_4:* = Math.max(this._knobMin,this._sliderKnob.y - _loc_3);
         var _loc_5:* = this.calcContentDest(_loc_4);
         this.tweenKnob(_loc_4);
         this.tweenContent(_loc_5);
      }
      
      private function stepDown(event:Event, param2:String) : void
      {
         var _loc_3:* = param2 == _KNOBSTEP ? this._knobStep : mouseY - this._sliderKnob.y - this._mouseOffset;
         var _loc_4:* = Math.min(this._knobMax,this._sliderKnob.y + _loc_3);
         var _loc_5:* = this.calcContentDest(_loc_4);
         this.tweenKnob(_loc_4);
         this.tweenContent(_loc_5);
      }
      
      private function barJump(event:MouseEvent) : void
      {
         if(mouseY < this._sliderKnob.y)
         {
            this.stepUp(null,_BARJUMP);
         }
         else
         {
            this.stepDown(null,_BARJUMP);
         }
      }
      
      private function calcContentDest(param1:Number) : Number
      {
         var _loc_2:Number = NaN;
         var _loc_3:Number = NaN;
         var _loc_4:Number = NaN;
         _loc_3 = (param1 - this._knobMin) / (this._knobMax - this._knobMin);
         _loc_4 = this._content.height - this._mask.height;
         return this._mask.y - _loc_3 * _loc_4;
      }
      
      private function tweenContent(param1:Number) : void
      {
         TweenLite.to(this._content,this._tweenSec,{
            "y":param1,
            "ease":Linear.easeOut,
            "useFrames":false
         });
      }
      
      private function tweenKnob(param1:Number) : void
      {
         TweenLite.to(this._sliderKnob,this._tweenSec,{
            "y":param1,
            "ease":Linear.easeOut,
            "useFrames":false
         });
      }
      
      private function addEnterFrameListener(event:MouseEvent) : void
      {
         event.currentTarget.gotoAndStop(3);
         this._mouseReleased = false;
         addEventListener(Event.ENTER_FRAME,this.dragObjects);
      }
      
      private function dragObjects(event:Event) : void
      {
         var _loc_2:Number = NaN;
         if(!this._mouseReleased)
         {
            this._sliderKnob.y = Math.min(Math.max(mouseY - this._mouseOffset,this._knobMin),this._knobMax);
         }
         _loc_2 = this.calcContentDest(this._sliderKnob.y);
         this._content.y += (_loc_2 - this._content.y) / 3;
         if(this._mouseReleased && this._content.y > _loc_2 - 1 && this._content.y < _loc_2 + 1)
         {
            event.currentTarget.gotoAndStop(1);
            removeEventListener(Event.ENTER_FRAME,this.dragObjects);
         }
      }
      
      private function setMouseReleased(event:Event) : void
      {
         this._sliderKnob.gotoAndStop(1);
         this._mouseReleased = true;
      }
      
      public function cleanUp() : void
      {
         var tmp:Object = null;
         this._arrow1.removeEventListener(MouseEvent.CLICK,function(event:MouseEvent):void
         {
            stepUp(event,_KNOBSTEP);
         });
         this._arrow2.removeEventListener(MouseEvent.CLICK,function(event:MouseEvent):void
         {
            stepDown(event,_KNOBSTEP);
         });
         this._sliderBg.removeEventListener(MouseEvent.CLICK,this.barJump);
         this._contentHolder.removeEventListener(MouseEvent.MOUSE_UP,this.setMouseReleased);
         if(this._sliderKnob.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            this._sliderKnob.removeEventListener(MouseEvent.MOUSE_DOWN,this.addEnterFrameListener);
         }
         if(this._sliderKnob.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this._sliderKnob.removeEventListener(MouseEvent.MOUSE_OVER,this._onMouseOver);
         }
         if(this._sliderKnob.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this._sliderKnob.removeEventListener(MouseEvent.MOUSE_OUT,this._onMouseOut);
         }
         if(this.hasEventListener(Event.ENTER_FRAME))
         {
            this.removeEventListener(Event.ENTER_FRAME,this.dragObjects);
         }
         while(this.numChildren > 0)
         {
            tmp = getChildAt(0);
            removeChildAt(0);
         }
         TweenLite.killTweensOf(this._sliderKnob);
         TweenLite.killTweensOf(this._content);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

