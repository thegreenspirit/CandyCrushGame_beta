package com.king.saga.api.universe
{
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class UserUniverse
   {
      private var _userEpisodes:Vector.<UserEpisode>;
      
      public function UserUniverse(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         super();
         this._userEpisodes = new Vector.<UserEpisode>();
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.getAsArray("episodes");
         for each(_loc_4 in _loc_3)
         {
            this._userEpisodes.push(new UserEpisode(_loc_4));
         }
      }
      
      public function getUserEpisodes() : Vector.<UserEpisode>
      {
         return this._userEpisodes;
      }
      
      public function getUserEpisode(param1:int) : UserEpisode
      {
         var _loc_2:* = this._getUserEpisode(param1);
         Debug.assert(_loc_2 != null,"Could not find user episode with id: " + param1);
         return _loc_2;
      }
      
      public function getUserLevel(param1:int, param2:int) : UserLevel
      {
         var _loc_3:* = this.getUserEpisode(param1);
         var _loc_4:* = _loc_3.getUserLevel(param2);
         return _loc_3.getUserLevel(param2);
      }
      
      public function addUserLevel(param1:int, param2:int) : void
      {
         var _loc_4:Object = null;
         if(!this.hasUserEpisode(param1))
         {
            _loc_4 = new Object();
            _loc_4.id = param1;
            _loc_4.levels = new Array();
            this._userEpisodes.push(new UserEpisode(_loc_4));
         }
         var _loc_3:* = this.getUserEpisode(param1);
         _loc_3.addUserLevel(param2);
      }
      
      public function hasUserEpisode(param1:int) : Boolean
      {
         return this._getUserEpisode(param1) != null;
      }
      
      public function hasUserLevel(param1:int, param2:int) : Boolean
      {
         return this.hasUserEpisode(param1) && this.getUserEpisode(param1).hasUserLevel(param2);
      }
      
      public function countTotalStars() : int
      {
         var _loc_2:UserEpisode = null;
         var _loc_1:int = 0;
         for each(_loc_2 in this._userEpisodes)
         {
            _loc_1 += _loc_2.countTotalStars();
         }
         return _loc_1;
      }
      
      private function _getUserEpisode(param1:int) : UserEpisode
      {
         var _loc_2:UserEpisode = null;
         for each(_loc_2 in this._userEpisodes)
         {
            if(_loc_2.getEpisodeId() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
   }
}

