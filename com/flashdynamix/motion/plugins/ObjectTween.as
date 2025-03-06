package com.flashdynamix.motion.plugins
{
   public class ObjectTween extends AbstractTween
   {
      private var _current:Object;
      
      protected var _to:Object;
      
      protected var _from:Object;
      
      public function ObjectTween()
      {
         super();
         this._to = {};
         this._from = {};
      }
      
      override public function construct(... args) : void
      {
         super.construct();
         this._current = args[0];
      }
      
      override protected function set to(param1:Object) : void
      {
         this._to = param1;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1;
      }
      
      override protected function get from() : Object
      {
         return this._from;
      }
      
      override public function get current() : Object
      {
         return this._current;
      }
      
      override public function get instance() : Object
      {
         return this._current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is ObjectTween && super.match(param1);
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
            this._current[_loc_3] = this.from[_loc_3] * _loc_2 + this.to[_loc_3] * param1;
            if(timeline.snapToClosest)
            {
               this._current[_loc_3] = Math.round(this._current[_loc_3]);
            }
         }
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

