package com.king.saga.api.toplist
{
   import com.king.saga.api.user.UserProfile;
   import com.midasplayer.debug.Debug;
   
   public class ToplistProfile
   {
      private var _toplistUser:ToplistUser;
      
      private var _userProfile:UserProfile;
      
      public function ToplistProfile(param1:ToplistUser, param2:UserProfile)
      {
         super();
         Debug.assert(param1.getUserId() == param2.getUserId(),"Trying to create a toplist profile with different users.");
         this._toplistUser = param1;
         this._userProfile = param2;
      }
      
      public function getToplistUser() : ToplistUser
      {
         return this._toplistUser;
      }
      
      public function getUserProfile() : UserProfile
      {
         return this._userProfile;
      }
   }
}

