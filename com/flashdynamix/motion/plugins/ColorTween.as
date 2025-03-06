package com.flashdynamix.motion.plugins
{
   import flash.display.*;
   import flash.geom.*;
   
   public class ColorTween extends AbstractTween
   {
      private var _current:ColorTransform;
      
      protected var _to:ColorTransform;
      
      protected var _from:ColorTransform;
      
      internal var displayObject:DisplayObject;
      
      public function ColorTween()
      {
         super();
         this._to = new ColorTransform();
         this._from = new ColorTransform();
      }
      
      override public function construct(... args) : void
      {
         super.construct();
         this._current = args[0];
         this.displayObject = args[1];
         this.apply();
      }
      
      override protected function set to(param1:Object) : void
      {
         this._to = param1 as ColorTransform;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1 as ColorTransform;
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
         return Boolean(this.displayObject) ? this.displayObject : this.current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is ColorTween && (this.current == param1.current || (param1 as ColorTween).displayObject != null && this.displayObject == (param1 as ColorTween).displayObject);
      }
      
      override public function toTarget(param1:Object) : void
      {
         var _loc_2:ColorTransform = null;
         if(param1 is ColorTransform)
         {
            _loc_2 = param1 as ColorTransform;
            add("redOffset",_loc_2.redOffset,false);
            add("blueOffset",_loc_2.blueOffset,false);
            add("greenOffset",_loc_2.greenOffset,false);
            add("alphaOffset",_loc_2.alphaOffset,false);
            add("redMultiplier",_loc_2.redMultiplier,false);
            add("blueMultiplier",_loc_2.blueMultiplier,false);
            add("greenMultiplier",_loc_2.greenMultiplier,false);
            add("alphaMultiplier",_loc_2.alphaMultiplier,false);
         }
         else
         {
            super.toTarget(param1);
         }
      }
      
      override public function fromTarget(param1:Object) : void
      {
         var _loc_2:ColorTransform = null;
         if(param1 is ColorTransform)
         {
            _loc_2 = param1 as ColorTransform;
            add("redOffset",_loc_2.redOffset,true);
            add("blueOffset",_loc_2.blueOffset,true);
            add("greenOffset",_loc_2.greenOffset,true);
            add("alphaOffset",_loc_2.alphaOffset,true);
            add("redMultiplier",_loc_2.redMultiplier,true);
            add("blueMultiplier",_loc_2.blueMultiplier,true);
            add("greenMultiplier",_loc_2.greenMultiplier,true);
            add("alphaMultiplier",_loc_2.alphaMultiplier,true);
         }
         else
         {
            super.toTarget(param1);
         }
      }
      
      override public function update(param1:Number) : void
      {
         var _loc_3:String = null;
         var _loc_2:* = 1 - param1;
         if(!inited && _propCount > 0)
         {
            if(Boolean(this.displayObject))
            {
               this._current = this.displayObject.transform.colorTransform;
               this._from = this.displayObject.transform.colorTransform;
            }
            else
            {
               for(_loc_3 in propNames)
               {
                  this._from[_loc_3] = this._current[_loc_3];
               }
            }
            inited = true;
         }
         for(_loc_3 in propNames)
         {
            if(_loc_3 == "redOffset")
            {
               this._current.redOffset = this._from.redOffset * _loc_2 + this._to.redOffset * param1;
            }
            else if(_loc_3 == "redMultiplier")
            {
               this._current.redMultiplier = this._from.redMultiplier * _loc_2 + this._to.redMultiplier * param1;
            }
            else if(_loc_3 == "greenOffset")
            {
               this._current.greenOffset = this._from.greenOffset * _loc_2 + this._to.greenOffset * param1;
            }
            else if(_loc_3 == "greenMultiplier")
            {
               this._current.greenMultiplier = this._from.greenMultiplier * _loc_2 + this._to.greenMultiplier * param1;
            }
            else if(_loc_3 == "blueOffset")
            {
               this._current.blueOffset = this._from.blueOffset * _loc_2 + this._to.blueOffset * param1;
            }
            else if(_loc_3 == "blueMultiplier")
            {
               this._current.blueMultiplier = this._from.blueMultiplier * _loc_2 + this._to.blueMultiplier * param1;
            }
            else if(_loc_3 == "alphaOffset")
            {
               this._current.alphaOffset = this._from.alphaOffset * _loc_2 + this._to.alphaOffset * param1;
            }
            else if(_loc_3 == "alphaMultiplier")
            {
               this._current.alphaMultiplier = this._from.alphaMultiplier * _loc_2 + this._to.alphaMultiplier * param1;
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
         this.apply();
      }
      
      override public function apply() : void
      {
         if(this.displayObject == null)
         {
            return;
         }
         this.displayObject.transform.colorTransform = this._current;
      }
      
      override public function dispose() : void
      {
         this._to = null;
         this._from = null;
         this.displayObject = null;
         this._current = null;
         super.dispose();
      }
   }
}

