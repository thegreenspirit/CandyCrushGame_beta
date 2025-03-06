package com.king.saga.api.response
{
   import com.king.saga.api.toplist.*;
   
   public class LevelToplistsResponse
   {
      private var _toplists:Vector.<LevelToplist>;
      
      public function LevelToplistsResponse(param1:Object)
      {
         var _loc_3:Object = null;
         super();
         this._toplists = new Vector.<LevelToplist>();
         var _loc_2:* = param1 as Array;
         for each(_loc_3 in _loc_2)
         {
            this._toplists.push(new LevelToplist(_loc_3));
         }
      }
      
      public function getLevelToplists() : Vector.<LevelToplist>
      {
         return this._toplists;
      }
   }
}

