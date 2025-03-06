package com.flashdynamix.motion.plugins
{
   import flash.media.*;
   
   public class SoundTween extends AbstractTween
   {
      private var _current:SoundTransform;
      
      protected var _to:SoundTransform;
      
      protected var _from:SoundTransform;
      
      internal var updateObject:Object;
      
      public function SoundTween()
      {
         super();
         this._to = new SoundTransform();
         this._from = new SoundTransform();
      }
      
      override public function construct(... args) : void
      {
         super.construct();
         this._current = args[0];
         this.updateObject = args[1];
         this.apply();
      }
      
      override protected function set to(param1:Object) : void
      {
         this._to = param1 as SoundTransform;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1 as SoundTransform;
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
         return Boolean(this.updateObject) ? this.updateObject : this.current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is SoundTween && (this.current == param1.current || (param1 as SoundTween).updateObject != null && this.updateObject == (param1 as SoundTween).updateObject);
      }
      
      override public function toTarget(param1:Object) : void
      {
         var _loc_2:SoundTransform = null;
         if(param1 is SoundTransform)
         {
            _loc_2 = param1 as SoundTransform;
            add("volume",_loc_2.volume,false);
            add("pan",_loc_2.pan,false);
         }
         else
         {
            super.toTarget(param1);
         }
      }
      
      override public function fromTarget(param1:Object) : void
      {
         var _loc_2:SoundTransform = null;
         if(param1 is SoundTransform)
         {
            _loc_2 = param1 as SoundTransform;
            add("volume",_loc_2.volume,true);
            add("pan",_loc_2.pan,true);
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
            if(Boolean(this.updateObject))
            {
               this._current = this.updateObject.soundTransform;
               this._from = this.updateObject.soundTransform;
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
            if(_loc_3 == "volume")
            {
               this._current.volume = this._from.volume * _loc_2 + this._to.volume * param1;
            }
            else if(_loc_3 == "pan")
            {
               this._current.pan = this._from.pan * _loc_2 + this._to.pan * param1;
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
         if(this.updateObject == null)
         {
            return;
         }
         this.updateObject.soundTransform = this._current;
      }
      
      override public function dispose() : void
      {
         this._to = null;
         this._from = null;
         this._current = null;
         this.updateObject = null;
         super.dispose();
      }
   }
}

