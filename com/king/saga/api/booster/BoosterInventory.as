package com.king.saga.api.booster
{
   import com.midasplayer.util.TypedKeyVal;
   
   public class BoosterInventory
   {
      private var _typed:TypedKeyVal;
      
      public function BoosterInventory(param1:Object)
      {
         super();
         this._typed = new TypedKeyVal(param1);
      }
      
      public function getCount(param1:String) : int
      {
         if(!this._typed.has(param1))
         {
            return 0;
         }
         return this._typed.getAsInt(param1);
      }
      
      public function copy(param1:BoosterInventory) : void
      {
         this._typed = param1._typed;
      }
   }
}

