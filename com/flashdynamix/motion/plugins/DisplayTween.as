package com.flashdynamix.motion.plugins
{
   import flash.display.*;
   
   public class DisplayTween extends AbstractTween
   {
      private var _current:DisplayObject;
      
      protected var _to:DisplayTweenObject;
      
      protected var _from:DisplayTweenObject;
      
      public function DisplayTween()
      {
         super();
         this._to = new DisplayTweenObject();
         this._from = new DisplayTweenObject();
      }
      
      override public function construct(... args) : void
      {
         super.construct();
         this._current = args[0];
      }
      
      override protected function set to(param1:Object) : void
      {
         this._to = param1 as DisplayTweenObject;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1 as DisplayTweenObject;
      }
      
      override protected function get from() : Object
      {
         return this._from;
      }
      
      override public function get current() : Object
      {
         return this._current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is DisplayTween && super.match(param1);
      }
      
      override public function update(param1:Number) : void
      {
         var _loc_3:String = null;
         var _loc_2:* = 1 - param1;
         if(!inited && _propCount > 0)
         {
            for(_loc_3 in propNames)
            {
               this._from[_loc_3] = this._current[_loc_3];
            }
            inited = true;
         }
         for(_loc_3 in propNames)
         {
            if(_loc_3 == "x")
            {
               this._current.x = this._from.x * _loc_2 + this._to.x * param1;
            }
            else if(_loc_3 == "y")
            {
               this._current.y = this._from.y * _loc_2 + this._to.y * param1;
            }
            else if(_loc_3 == "width")
            {
               this._current.width = this._from.width * _loc_2 + this._to.width * param1;
            }
            else if(_loc_3 == "height")
            {
               this._current.height = this._from.height * _loc_2 + this._to.height * param1;
            }
            else if(_loc_3 == "scaleX")
            {
               this._current.scaleX = this._from.scaleX * _loc_2 + this._to.scaleX * param1;
            }
            else if(_loc_3 == "scaleY")
            {
               this._current.scaleY = this._from.scaleY * _loc_2 + this._to.scaleY * param1;
            }
            else if(_loc_3 == "alpha")
            {
               this._current.alpha = this._from.alpha * _loc_2 + this._to.alpha * param1;
            }
            else if(_loc_3 == "rotation")
            {
               this._current.rotation = this._from.rotation * _loc_2 + this._to.rotation * param1;
            }
            else
            {
               this._current[_loc_3] = this._from[_loc_3] * _loc_2 + this._to[_loc_3] * param1;
            }
            if(timeline.snapToClosest)
            {
               this._current[_loc_3] = Math.round(this._current[_loc_3]);
            }
         }
      }
      
      override protected function translate(param1:String, param2:*) : Number
      {
         var _loc_3:* = this._current[param1];
         var _loc_4:* = super.translate(param1,param2);
         if(param1 == "rotation" && timeline.smartRotate)
         {
            _loc_4 = smartRotate(_loc_3,_loc_4);
         }
         return _loc_4;
      }
      
      override public function dispose() : void
      {
         this._to = null;
         this._from = null;
         this._current = null;
         super.dispose();
      }
   }
}

dynamic class DisplayTweenObject
{
   public var x:Number;
   
   public var y:Number;
   
   public var alpha:Number;
   
   public var width:Number;
   
   public var height:Number;
   
   public var scaleX:Number;
   
   public var scaleY:Number;
   
   public var rotation:Number;
   
   public function DisplayTweenObject()
   {
      super();
   }
}

