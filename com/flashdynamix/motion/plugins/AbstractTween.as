package com.flashdynamix.motion.plugins
{
   import com.flashdynamix.motion.*;
   
   public class AbstractTween
   {
      public var inited:Boolean = false;
      
      public var timeline:TweensyTimeline;
      
      internal var propNames:Object;
      
      protected var _propCount:int = 0;
      
      public function AbstractTween()
      {
         super();
         this.propNames = {};
      }
      
      public function construct(... args) : void
      {
         this.inited = false;
      }
      
      protected function set to(param1:Object) : void
      {
      }
      
      protected function get to() : Object
      {
         return null;
      }
      
      protected function set from(param1:Object) : void
      {
      }
      
      protected function get from() : Object
      {
         return null;
      }
      
      public function get current() : Object
      {
         return null;
      }
      
      public function get instance() : Object
      {
         return this.current;
      }
      
      protected function get properties() : Number
      {
         return this._propCount;
      }
      
      public function get hasAnimations() : Boolean
      {
         return this._propCount > 0;
      }
      
      public function add(param1:String, param2:*, param3:Boolean) : void
      {
         var _loc_4:* = undefined;
         var _loc_5:* = undefined;
         if(param3)
         {
            this.to[param1] = this.current[param1];
            this.current[param1] = this.translate(param1,param2);
         }
         else
         {
            this.to[param1] = this.translate(param1,param2);
         }
         if(!this.propNames[param1])
         {
            this.propNames[param1] = true;
            _loc_4 = this;
            _loc_5 = this._propCount + 1;
            _loc_4._propCount = _loc_5;
         }
      }
      
      public function remove(param1:String) : void
      {
         if(this.propNames[param1] == null)
         {
            return;
         }
         delete this.propNames[param1];
         var _loc_2:* = this;
         var _loc_3:* = this._propCount - 1;
         _loc_2._propCount = _loc_3;
      }
      
      public function has(param1:String) : Boolean
      {
         return this.propNames[param1] != null;
      }
      
      public function toTarget(param1:Object) : void
      {
         var _loc_2:String = null;
         for(_loc_2 in param1)
         {
            this.add(_loc_2,param1[_loc_2],false);
         }
      }
      
      public function fromTarget(param1:Object) : void
      {
         var _loc_2:String = null;
         for(_loc_2 in param1)
         {
            this.add(_loc_2,param1[_loc_2],true);
         }
      }
      
      public function updateTo(param1:Number, param2:Object) : void
      {
         var _loc_3:String = null;
         var _loc_4:Number = NaN;
         var _loc_5:Number = NaN;
         for(_loc_3 in param2)
         {
            if(this.has(_loc_3))
            {
               _loc_4 = Number(param2[_loc_3]);
               _loc_5 = (_loc_4 - this.current[_loc_3]) * (1 / (1 - param1));
               this.from[_loc_3] = _loc_4 - _loc_5;
               this.to[_loc_3] = _loc_4;
            }
         }
      }
      
      public function removeOverlap(param1:AbstractTween) : void
      {
         var _loc_2:String = null;
         if(this.match(param1))
         {
            for(_loc_2 in param1.propNames)
            {
               this.remove(_loc_2);
            }
         }
      }
      
      public function match(param1:AbstractTween) : Boolean
      {
         return param1.instance == this.instance;
      }
      
      public function stop(... args) : void
      {
         var _loc_3:int = 0;
         _loc_3 = 0;
         while(_loc_3 < args.length)
         {
            this.remove(args[_loc_3]);
            _loc_3++;
         }
      }
      
      public function stopAll() : void
      {
         var _loc_1:String = null;
         for(_loc_1 in this.propNames)
         {
            this.remove(_loc_1);
         }
      }
      
      public function update(param1:Number) : void
      {
      }
      
      public function swapToFrom() : void
      {
         var _loc_1:* = this.to;
         this.to = this.from;
         this.from = _loc_1;
      }
      
      public function apply() : void
      {
      }
      
      public function clear() : void
      {
         this.stopAll();
         this.timeline = null;
      }
      
      public function dispose() : void
      {
         this.propNames = null;
         this.timeline = null;
      }
      
      protected function translate(param1:String, param2:*) : Number
      {
         var _loc_5:Array = null;
         var _loc_4:Number = NaN;
         var _loc_6:Number = NaN;
         var _loc_7:Number = NaN;
         var _loc_3:* = this.current[param1];
         if(param2 is String)
         {
            _loc_5 = String(param2).split(",");
            if(_loc_5.length == 1)
            {
               _loc_4 = _loc_3 + parseFloat(param2);
            }
            else
            {
               _loc_6 = parseFloat(_loc_5[0]);
               _loc_7 = parseFloat(_loc_5[1]);
               _loc_4 = _loc_3 + _loc_6 + Math.random() * (_loc_7 - _loc_6);
            }
         }
         else
         {
            _loc_4 = param2;
         }
         return _loc_4;
      }
      
      protected function smartRotate(param1:Number, param2:Number) : Number
      {
         var _loc_4:* = 180 * 2;
         param1 = Math.abs(param1) > _loc_4 ? (param1 < 0 ? param1 % _loc_4 + _loc_4 : param1 % _loc_4) : param1;
         param2 = Math.abs(param2) > _loc_4 ? (param2 < 0 ? param2 % _loc_4 + _loc_4 : param2 % _loc_4) : param2;
         return param2 + (Math.abs(param2 - param1) < 180 ? 0 : (param2 - param1 > 0 ? -_loc_4 : _loc_4));
      }
   }
}

