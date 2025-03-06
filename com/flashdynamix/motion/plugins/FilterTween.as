package com.flashdynamix.motion.plugins
{
   import flash.display.*;
   import flash.filters.*;
   import flash.utils.*;
   
   public class FilterTween extends AbstractTween
   {
      internal static var filters:Dictionary = new Dictionary(true);
      
      private var _current:Object;
      
      protected var _to:Object;
      
      protected var _from:Object;
      
      protected var _filter:BitmapFilter;
      
      internal var displayObject:DisplayObject;
      
      protected var filterList:Array;
      
      public function FilterTween()
      {
         super();
         this._to = {};
         this._from = {};
      }
      
      override public function construct(... args) : void
      {
         super.construct();
         this._filter = args[0];
         this.displayObject = args[1];
         if(this._filter is ColorMatrixFilter)
         {
            this._current = ColorMatrixFilter(this._filter).matrix;
         }
         else
         {
            this._current = this._filter;
         }
         this.filterList = filters[this.displayObject];
         if(this.filterList == null || this.filterList.length != this.displayObject.filters.length)
         {
            args = this.displayObject.filters;
            filters[this.displayObject] = args;
            this.filterList = args;
         }
         if(this.filterList.indexOf(this._filter) == -1)
         {
            this.filterList.push(this._filter);
         }
         this.apply();
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
         return Boolean(this.displayObject) ? this.displayObject : this.current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is FilterTween && (this.current == param1.current || (param1 as FilterTween).displayObject != null && this.displayObject == (param1 as FilterTween).displayObject);
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
            this._current[_loc_3] = this._from[_loc_3] * _loc_2 + this._to[_loc_3] * param1;
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
         if(this._filter is ColorMatrixFilter)
         {
            ColorMatrixFilter(this._filter).matrix = this._current as Array;
         }
         this.displayObject.filters = this.filterList;
      }
      
      override public function dispose() : void
      {
         this._filter = null;
         this._current = null;
         this.displayObject = null;
         this.filterList = null;
         super.dispose();
      }
   }
}

