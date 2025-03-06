package com.flashdynamix.motion.plugins
{
   import flash.display.*;
   import flash.geom.*;
   
   public class MatrixTween extends AbstractTween
   {
      private var _current:Matrix;
      
      protected var _to:Matrix;
      
      protected var _from:Matrix;
      
      internal var displayObject:DisplayObject;
      
      public function MatrixTween()
      {
         super();
         this._to = new Matrix();
         this._from = new Matrix();
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
         this._to = param1 as Matrix;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1 as Matrix;
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
         return param1 is MatrixTween && (this.current == param1.current || (param1 as MatrixTween).displayObject != null && this.displayObject == (param1 as MatrixTween).displayObject);
      }
      
      override public function toTarget(param1:Object) : void
      {
         var _loc_2:Matrix = null;
         if(param1 is Matrix)
         {
            _loc_2 = param1 as Matrix;
            add("tx",_loc_2.tx,false);
            add("ty",_loc_2.ty,false);
            add("a",_loc_2.a,false);
            add("b",_loc_2.b,false);
            add("c",_loc_2.c,false);
            add("d",_loc_2.d,false);
         }
         else
         {
            super.toTarget(param1);
         }
      }
      
      override public function fromTarget(param1:Object) : void
      {
         var _loc_2:Matrix = null;
         if(param1 is Matrix)
         {
            _loc_2 = param1 as Matrix;
            add("tx",_loc_2.tx,true);
            add("ty",_loc_2.ty,true);
            add("a",_loc_2.a,true);
            add("b",_loc_2.b,true);
            add("c",_loc_2.c,true);
            add("d",_loc_2.d,true);
         }
         else
         {
            super.fromTarget(param1);
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
               this._current = this.displayObject.transform.matrix;
               this._from = this.displayObject.transform.matrix;
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
            if(_loc_3 == "tx")
            {
               this._current.tx = this._from.tx * _loc_2 + this._to.tx * param1;
            }
            else if(_loc_3 == "ty")
            {
               this._current.ty = this._from.ty * _loc_2 + this._to.ty * param1;
            }
            else if(_loc_3 == "a")
            {
               this._current.a = this._from.a * _loc_2 + this._to.a * param1;
            }
            else if(_loc_3 == "b")
            {
               this._current.b = this._from.b * _loc_2 + this._to.b * param1;
            }
            else if(_loc_3 == "c")
            {
               this._current.c = this._from.c * _loc_2 + this._to.c * param1;
            }
            else if(_loc_3 == "d")
            {
               this._current.d = this._from.d * _loc_2 + this._to.d * param1;
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
         this.displayObject.transform.matrix = this._current;
      }
      
      override public function dispose() : void
      {
         this._to = null;
         this._from = null;
         this._current = null;
         this.displayObject = null;
         super.dispose();
      }
   }
}

