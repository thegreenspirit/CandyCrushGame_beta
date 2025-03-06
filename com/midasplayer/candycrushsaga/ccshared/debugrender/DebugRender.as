package com.midasplayer.candycrushsaga.ccshared.debugrender
{
   public const DebugRender:_DebugRender = new _DebugRender();
}

import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.Event;

class _DebugRender
{
   public static const TTL_ONE_TICK:Number = 0.0333333333333333;
   
   public static const COLOR_DEFAULT:uint = 16777215;
   
   private var _canvas:MovieClip;
   
   private var _shapes:Vector.<com.midasplayer.candycrushsaga.ccshared.debugrender.DebugShape>;
   
   private var _color:uint;
   
   private var _alpha:Number;
   
   public function _DebugRender()
   {
      super();
   }
   
   public function init(param1:Stage) : void
   {
      if(this._isInitiated())
      {
         return;
      }
      this._canvas = new MovieClip();
      this._shapes = new Vector.<com.midasplayer.candycrushsaga.ccshared.debugrender.DebugShape>();
      this.setColor(0,1);
      param1.addChild(this._canvas);
      this._canvas.addEventListener(Event.ENTER_FRAME,this._onEnterFrame);
   }
   
   public function setColor(param1:uint, param2:Number = 1) : void
   {
      this._color = param1;
      this._alpha = param2;
   }
   
   public function drawDot(param1:int, param2:int, param3:Number = 0.0333333333333333) : void
   {
      if(!this._isInitiated())
      {
         return;
      }
      this._shapes.push(new DebugPoint(param1,param2,param3,this._color,this._alpha));
   }
   
   public function drawCircle(param1:int, param2:int, param3:Number, param4:Number = 0.0333333333333333) : void
   {
      if(!this._isInitiated())
      {
         return;
      }
      this._shapes.push(new DebugCircle(param1,param2,param3,param4,this._color,this._alpha));
   }
   
   public function drawLine(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:Number = 0.0333333333333333) : void
   {
      if(!this._isInitiated())
      {
         return;
      }
      this._shapes.push(new DebugLine(param1,param2,param3,param4,param5,param6,this._color,this._alpha));
   }
   
   private function _isInitiated() : Boolean
   {
      return this._canvas != null;
   }
   
   private function _onEnterFrame(param1:Event) : void
   {
      var _loc4_:com.midasplayer.candycrushsaga.ccshared.debugrender.DebugShape = null;
      if(this._canvas.parent != null)
      {
         this._canvas.parent.setChildIndex(this._canvas,this._canvas.parent.numChildren - 1);
      }
      var _loc2_:Graphics = this._canvas.graphics;
      _loc2_.clear();
      var _loc3_:int = 0;
      while(_loc3_ < this._shapes.length)
      {
         _loc4_ = this._shapes[_loc3_];
         _loc4_.render(_loc2_);
         _loc4_.update(0.1);
         if(_loc4_.isDone())
         {
            this._shapes.splice(_loc3_,1);
            _loc3_--;
         }
         _loc3_++;
      }
   }
}
