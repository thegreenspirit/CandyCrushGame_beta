package com.flashdynamix.utils
{
   public class ObjectPool
   {
      public var minSize:int;
      
      public var size:int = 0;
      
      public var Create:Class;
      
      public var length:int = 0;
      
      private var list:Array;
      
      private var disposed:Boolean = false;
      
      public function ObjectPool(param1:Class, param2:int = 10)
      {
         var _loc_3:int = 0;
         super();
         this.list = [];
         this.Create = param1;
         this.minSize = param2;
         while(_loc_3 < param2)
         {
            this.add();
            _loc_3++;
         }
      }
      
      public function add() : void
      {
         var _loc_1:* = this.length + 1;
         this.list[_loc_1] = new this.Create();
      }
      
      public function checkOut() : *
      {
         var _loc_1:Object = null;
         var _loc_2:* = undefined;
         if(this.length == 0)
         {
            _loc_1 = this;
            _loc_2 = this.size + 1;
            _loc_1.size = _loc_2;
            return new this.Create();
         }
         return this.list[--this.length];
      }
      
      public function checkIn(param1:*) : void
      {
         var _loc_3:Object = this;
         _loc_3.length = this.length + 1;
         var _loc_2:* = this.length + 1;
         this.list[_loc_2] = param1;
      }
      
      public function empty() : void
      {
         var _loc_1:int = 0;
         _loc_1 = 0;
         this.list.length = 0;
         this.length = _loc_1;
         this.size = _loc_1;
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this.disposed = true;
         this.Create = null;
         this.list = null;
      }
   }
}

