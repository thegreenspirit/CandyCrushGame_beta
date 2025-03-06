package com.king.saga.api.booster
{
   import com.midasplayer.debug.*;
   
   public class Boosters
   {
      private var _boosters:Vector.<Booster>;
      
      public function Boosters()
      {
         super();
         this._boosters = new Vector.<Booster>();
      }
      
      public function add(param1:Booster) : void
      {
         this._boosters.push(param1);
      }
      
      public function isAvailable(param1:String) : Boolean
      {
         return this._getBooster(param1) != null;
      }
      
      public function getBooster(param1:String) : Booster
      {
         var _loc_2:* = this._getBooster(param1);
         Debug.assert(_loc_2 != null,"Trying to get a non existing booster: " + param1);
         return _loc_2;
      }
      
      public function getAll() : Vector.<Booster>
      {
         return this._boosters;
      }
      
      private function _getBooster(param1:String) : Booster
      {
         var _loc_2:Booster = null;
         for each(_loc_2 in this._boosters)
         {
            if(_loc_2.getId() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
   }
}

