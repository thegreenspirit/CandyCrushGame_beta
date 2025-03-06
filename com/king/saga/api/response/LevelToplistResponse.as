package com.king.saga.api.response
{
   import com.king.saga.api.toplist.*;
   import com.king.saga.api.user.*;
   
   public class LevelToplistResponse
   {
      private var _toplist:LevelToplist;
      
      private var _toplistProfiles:Vector.<ToplistProfile>;
      
      public function LevelToplistResponse(param1:LevelToplist, param2:UserProfiles)
      {
         var _loc_4:ToplistUser = null;
         super();
         this._toplistProfiles = new Vector.<ToplistProfile>();
         this._toplist = param1;
         var _loc_3:* = this._toplist.getToplistUsers();
         for each(_loc_4 in _loc_3)
         {
            if(param2.exists(_loc_4.getUserId()))
            {
               this._toplistProfiles.push(new ToplistProfile(_loc_4,param2.getUserProfile(_loc_4.getUserId())));
            }
         }
      }
      
      public function getLevelToplist() : LevelToplist
      {
         return this._toplist;
      }
      
      public function getLevelToplistProfiles() : Vector.<ToplistProfile>
      {
         return this._toplistProfiles;
      }
   }
}

