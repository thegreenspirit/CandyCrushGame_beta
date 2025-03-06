package com.king.saga.api.response
{
   import com.king.saga.api.user.*;
   import com.midasplayer.util.*;
   
   public class BuyBoosterResponse
   {
      private var _currentUser:CurrentUser;
      
      public function BuyBoosterResponse(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._currentUser = new CurrentUser(_loc_2.getAsObject("currentUser"));
      }
      
      public function getCurrentUser() : CurrentUser
      {
         return this._currentUser;
      }
   }
}

