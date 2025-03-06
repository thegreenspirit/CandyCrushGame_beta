package com.king.saga.api.universe.condition
{
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class FriendInviteData extends UnlockData
   {
      public static const Type:String = "FriendInviteData";
      
      private var _userIds:Vector.<Number>;
      
      private var _isBought:Boolean;
      
      private var _isCompleted:Boolean;
      
      public function FriendInviteData(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Number = NaN;
         this._userIds = new Vector.<Number>();
         super(Type);
         _loc_2 = new TypedKeyVal(param1);
         this._isBought = _loc_2.getAsBool("isBought");
         this._isCompleted = _loc_2.getAsBool("isCompleted");
         var _loc_3:* = _loc_2.getAsArray("userIds");
         for each(_loc_4 in _loc_3)
         {
            this._userIds.push(_loc_4);
         }
      }
      
      public static function create(param1:Boolean, param2:Boolean) : FriendInviteData
      {
         var _loc_3:* = new Object();
         _loc_3.isBought = param1;
         _loc_3.isCompleted = param2;
         _loc_3.userIds = new Array();
         return new FriendInviteData(_loc_3);
      }
      
      public function getUserIds() : Vector.<Number>
      {
         return this._userIds;
      }
      
      public function isBought() : Boolean
      {
         return this._isBought;
      }
      
      public function isCompleted() : Boolean
      {
         return this._isCompleted;
      }
      
      public function addUserId(param1:Number) : void
      {
         Debug.assert(this._userIds.indexOf(param1) == -1,"User already exists!");
         this._userIds.push(param1);
      }
      
      public function setIsCompleted() : void
      {
         this._isCompleted = true;
      }
      
      public function hasUser(param1:Number) : Boolean
      {
         var _loc_2:Number = NaN;
         for each(_loc_2 in this._userIds)
         {
            if(param1 == _loc_2)
            {
               return true;
            }
         }
         return false;
      }
   }
}

