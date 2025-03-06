package com.king.saga.api.response
{
   import com.king.saga.api.toplist.*;
   import com.midasplayer.debug.*;
   import flash.utils.*;
   
   public class LevelToplistResponses
   {
      private var _levelToplists:Dictionary;
      
      public function LevelToplistResponses()
      {
         super();
         this._levelToplists = new Dictionary();
      }
      
      public function insert(param1:LevelToplistResponse) : void
      {
         Debug.assert(param1 != null,"Trying to insert a null level toplist response.");
         var _loc_2:* = param1.getLevelToplist();
         this._levelToplists[this._getUid(_loc_2.getEpisodeId(),_loc_2.getLevelId())] = param1;
      }
      
      public function exists(param1:int, param2:int) : Boolean
      {
         return this._get(param1,param2) != null;
      }
      
      public function getLevelToplist(param1:int, param2:int) : LevelToplistResponse
      {
         var _loc_3:* = this._get(param1,param2);
         Debug.assert(_loc_3 != null,"Trying to get a non existing level top list response with episode id: " + param1 + " levelid: " + param2);
         return _loc_3;
      }
      
      private function _get(param1:int, param2:int) : LevelToplistResponse
      {
         return this._levelToplists[this._getUid(param1,param2)];
      }
      
      private function _getUid(param1:int, param2:int) : String
      {
         return param1 + "_" + param2;
      }
   }
}

