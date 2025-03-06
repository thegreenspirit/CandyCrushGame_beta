package com.king.saga.api.toplist
{
   import com.midasplayer.util.*;
   
   public class ToplistUser
   {
      private var _userId:Number;
      
      private var _value:Number;
      
      public function ToplistUser(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._userId = _loc_2.getAsIntNumber("userId");
         this._value = _loc_2.getAsIntNumber("value");
      }
      
      public function getUserId() : Number
      {
         return this._userId;
      }
      
      public function getValue() : Number
      {
         return this._value;
      }
   }
}

