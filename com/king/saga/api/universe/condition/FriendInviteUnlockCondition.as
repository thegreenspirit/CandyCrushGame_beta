package com.king.saga.api.universe.condition
{
   import com.midasplayer.util.*;
   
   public class FriendInviteUnlockCondition extends UnlockCondition
   {
      public static const Type:String = "FriendInviteUnlockCondition";
      
      private var _numOfFriendsRequired:int;
      
      private var _isBuyable:Boolean;
      
      public function FriendInviteUnlockCondition(param1:Object)
      {
         super(Type);
         var _loc_2:* = new TypedKeyVal(param1);
         this._numOfFriendsRequired = _loc_2.getAsInt("numOfFriendsRequired");
         this._isBuyable = _loc_2.getAsBool("isBuyable");
      }
      
      public function getNumOfFriendsRequired() : int
      {
         return this._numOfFriendsRequired;
      }
      
      public function isBuyable() : Boolean
      {
         return this._isBuyable;
      }
      
      public function toString() : String
      {
         return "[LevelCompletedUnlockVO numFriends=" + this._numOfFriendsRequired + " isBuyable=" + this._isBuyable + "]";
      }
   }
}

