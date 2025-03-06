package com.king.saga.api.response
{
   import com.king.saga.api.crafting.ItemInfo;
   
   public class CraftResponse
   {
      private var _itemBalance:Vector.<ItemInfo>;
      
      public function CraftResponse(param1:Object)
      {
         var _loc3_:Object = null;
         this._itemBalance = new Vector.<ItemInfo>();
         super();
         var _loc2_:Array = param1 as Array;
         for each(_loc3_ in _loc2_)
         {
            this._itemBalance.push(new ItemInfo(_loc3_));
         }
      }
      
      public function getItemBalance() : Vector.<ItemInfo>
      {
         return this._itemBalance;
      }
   }
}

