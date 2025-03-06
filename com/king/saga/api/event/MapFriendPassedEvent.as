package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class MapFriendPassedEvent extends SagaEvent
   {
      public static const Type:String = "MAP_FRIEND_PASSED";
      
      private var _friendUserId:Number;
      
      public function MapFriendPassedEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._friendUserId = _loc_3.getAsIntNumber("friendUserId");
      }
      
      public function getFriendUserId() : Number
      {
         return this._friendUserId;
      }
   }
}

