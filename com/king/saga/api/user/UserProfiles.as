package com.king.saga.api.user
{
   import com.midasplayer.debug.*;
   
   public class UserProfiles
   {
      private var _userProfiles:Vector.<UserProfile>;
      
      public function UserProfiles()
      {
         super();
         this._userProfiles = new Vector.<UserProfile>();
      }
      
      public function add(param1:UserProfile) : void
      {
         Debug.assert(!this.exists(param1.getUserId()),"Trying to add a user profile that already has been added.");
         this._userProfiles.push(param1);
      }
      
      public function getAll() : Vector.<UserProfile>
      {
         return this._userProfiles;
      }
      
      public function exists(param1:Number) : Boolean
      {
         return this._getUserProfile(param1) != null;
      }
      
      public function getUserProfile(param1:Number) : UserProfile
      {
         var _loc_2:* = this._getUserProfile(param1);
         Debug.assert(_loc_2 != null,"Trying to get a non existing user with id: " + param1);
         return _loc_2;
      }
      
      private function _getUserProfile(param1:Number) : UserProfile
      {
         var _loc_2:UserProfile = null;
         for each(_loc_2 in this._userProfiles)
         {
            if(_loc_2.getUserId() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
   }
}

