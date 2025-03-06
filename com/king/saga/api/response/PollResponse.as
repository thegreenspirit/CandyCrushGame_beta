package com.king.saga.api.response
{
   import com.king.saga.api.user.CurrentUser;
   import com.midasplayer.util.TypedKeyVal;
   
   public class PollResponse
   {
      private var _currentUser:CurrentUser;
      
      public function PollResponse(param1:Object)
      {
         super();
         var _loc2_:TypedKeyVal = new TypedKeyVal(param1);
         this._currentUser = new CurrentUser(_loc2_.getAsObject("currentUser"));
      }
      
      public function getCurrentUser() : CurrentUser
      {
         return this._currentUser;
      }
   }
}

