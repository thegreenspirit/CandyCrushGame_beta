package com.flashdynamix.utils
{
   import flash.utils.*;
   
   public class MultiTypeObjectPool
   {
      public var pools:Dictionary;
      
      private var disposed:Boolean = false;
      
      public function MultiTypeObjectPool(... args)
      {
         var _loc_3:int = 0;
         super();
         this.pools = new Dictionary(true);
         while(_loc_3 < args.length)
         {
            this.add(args[_loc_3]);
            _loc_3++;
         }
      }
      
      public function add(param1:Class) : void
      {
         this.pools[param1] = new ObjectPool(param1);
      }
      
      public function checkOut(param1:Class) : *
      {
         return ObjectPool(this.pools[param1]).checkOut();
      }
      
      public function checkIn(param1:Object) : void
      {
         ObjectPool(this.pools[param1.constructor]).checkIn(param1);
      }
      
      public function empty() : void
      {
         var _loc_1:ObjectPool = null;
         for each(_loc_1 in this.pools)
         {
            _loc_1.empty();
         }
      }
      
      public function dispose() : void
      {
         var _loc_1:ObjectPool = null;
         if(this.disposed)
         {
            return;
         }
         this.disposed = true;
         for each(_loc_1 in this.pools)
         {
            _loc_1.dispose();
            delete this.pools[_loc_1];
         }
         this.pools = null;
      }
   }
}

