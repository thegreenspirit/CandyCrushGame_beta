package com.midasplayer.candycrushsaga.ccshared
{
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.tutorial.*;
   import com.midasplayer.util.*;
   
   public class CandyPropertiesHandler
   {
      private var _gameConfList:Vector.<GameConfigurationData>;
      
      private var _seenBoosterTutIds:Vector.<String>;
      
      private var _seenBoosterTutExtraMoves:Boolean = false;
      
      private var _seenBoosterTutCandyHammer:Boolean = false;
      
      public function CandyPropertiesHandler(param1:Object)
      {
         var _loc_2:Object = null;
         var _loc_3:TypedKeyVal = null;
         super();
         this._gameConfList = new Vector.<GameConfigurationData>();
         this._seenBoosterTutIds = new Vector.<String>();
         for each(_loc_2 in param1)
         {
            _loc_3 = new TypedKeyVal(_loc_2);
            this.handleTutorialProperties(_loc_3);
         }
      }
      
      private function handleTutorialProperties(param1:TypedKeyVal) : void
      {
         var _loc_3:String = null;
         var _loc_4:String = null;
         var _loc_5:Boolean = false;
         var _loc_2:* = BalanceConstants.ALL_BOOSTER_TYPES;
         for each(_loc_3 in _loc_2)
         {
            _loc_4 = TutorialHandler.POP_INTRODUCE_BOOSTER_PREFIX + _loc_3;
            if(param1.has(_loc_4))
            {
               _loc_5 = param1.getAsBool(_loc_4);
               if(_loc_5)
               {
                  this._seenBoosterTutIds.push(_loc_4);
               }
            }
         }
      }
      
      public function getSeenBoosterTut(param1:String) : Boolean
      {
         var _loc_2:String = null;
         for each(_loc_2 in this._seenBoosterTutIds)
         {
            if(_loc_2 == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setSeenBoosterTut(param1:String) : void
      {
         this._seenBoosterTutIds.push(param1);
      }
   }
}

