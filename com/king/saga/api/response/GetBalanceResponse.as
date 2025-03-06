package com.king.saga.api.response
{
   import com.king.saga.api.crafting.*;
   
   public class GetBalanceResponse
   {
      private var _balance:Vector.<ItemInfo>;
      
      public function GetBalanceResponse(param1:Object)
      {
         var _loc_3:Object = null;
         super();
         this._balance = new Vector.<ItemInfo>();
         var _loc_2:* = param1 as Array;
         for each(_loc_3 in _loc_2)
         {
            this._balance.push(new ItemInfo(_loc_3));
         }
      }
      
      public function getBalance() : Vector.<ItemInfo>
      {
         return this._balance;
      }
   }
}

