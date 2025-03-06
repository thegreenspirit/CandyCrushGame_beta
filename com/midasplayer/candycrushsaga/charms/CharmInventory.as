package com.midasplayer.candycrushsaga.charms
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.debug.*;
   
   public class CharmInventory
   {
      private var _charms:Vector.<Charm>;
      
      private var _minRemaining:int;
      
      private var cCModel:CCModel;
      
      private var _charmOfWealthAmount:Number;
      
      public function CharmInventory(param1:CCModel)
      {
         super();
         this._charms = new Vector.<Charm>();
         this.cCModel = param1;
      }
      
      public function getCharm(param1:String) : CCCharm
      {
         var _loc_2:* = this._getCharm(param1);
         Debug.assert(_loc_2 != null,"Trying to get an unexisting charm: " + param1);
         return _loc_2;
      }
      
      private function _getCharm(param1:String) : CCCharm
      {
         var _loc_2:CCCharm = null;
         for each(_loc_2 in this._charms)
         {
            MonsterDebugger.trace(this,"charm=" + _loc_2);
            if(_loc_2.getType() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
      
      public function getCharmFromId(param1:int) : CCCharm
      {
         return this._getCharmFromId(param1);
      }
      
      public function getMinutesRemaining() : int
      {
         return this._minRemaining;
      }
      
      public function getCharmOfWealthAmount() : Number
      {
         return this._charmOfWealthAmount;
      }
      
      private function _getCharmFromId(param1:int) : CCCharm
      {
         var _loc_2:CCCharm = null;
         for each(_loc_2 in this._charms)
         {
            if(_loc_2.getProductId() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
   }
}

