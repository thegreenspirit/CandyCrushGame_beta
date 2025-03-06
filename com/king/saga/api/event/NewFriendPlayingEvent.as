package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class NewFriendPlayingEvent extends SagaEvent
   {
      public static const Type:String = "NEW_FRIEND_PLAYING";
      
      private var _friendUserId:Number;
      
      private var _friendExternalId:String;
      
      private var _friendPicUrl:String;
      
      private var _friendName:String;
      
      public function NewFriendPlayingEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._friendUserId = _loc_3.getAsIntNumber("friendUserId");
         this._friendExternalId = _loc_3.getAsString("friendExternalId");
         this._friendPicUrl = _loc_3.getAsString("friendPicSquareUrl");
         this._friendName = _loc_3.getAsString("friendName");
      }
      
      public function getFriendUserId() : Number
      {
         return this._friendUserId;
      }
      
      public function getFriendExternalId() : String
      {
         return this._friendExternalId;
      }
      
      public function getFriendPicUrl() : String
      {
         return this._friendPicUrl;
      }
      
      public function getFriendName() : String
      {
         return this._friendName;
      }
   }
}

