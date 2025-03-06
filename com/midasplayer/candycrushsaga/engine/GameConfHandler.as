package com.midasplayer.candycrushsaga.engine
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   import com.midasplayer.debug.*;
   
   public class GameConfHandler
   {
      private var _gameConfList:Vector.<GameConfigurationData>;
      
      private var _ccModel:CCModel;
      
      public function GameConfHandler(param1:Object, param2:CCModel)
      {
         var _loc_3:Object = null;
         super();
         this._gameConfList = new Vector.<GameConfigurationData>();
         this._ccModel = param2;
         MonsterDebugger.initialize(this);
         MonsterDebugger.trace(this,"GameConfHandler");
         for each(_loc_3 in param1)
         {
            this._gameConfList.push(new GameConfigurationData(_loc_3,param2));
         }
      }
      
      public function overrideScoreTargets(param1:Function) : void
      {
         var _loc_2:GameConfigurationData = null;
         for each(_loc_2 in this._gameConfList)
         {
            _loc_2.overrideScoreTargets(param1);
         }
      }
      
      public function getGameConf(param1:int, param2:int) : GameConf
      {
         var _loc_3:GameConfigurationData = null;
         for each(_loc_3 in this._gameConfList)
         {
            if(_loc_3.getEpisodeId() == param1 && _loc_3.getLevelid() == param2)
            {
               return _loc_3.getGameConf();
            }
         }
         Debug.assert(false,"Error: could not find requestet GameConf for " + param1 + ":" + param2);
         return null;
      }
      
      public function getAllLevelInfoVO() : Vector.<LevelInfoVO>
      {
         var _loc_2:GameConfigurationData = null;
         var _loc_1:* = new Vector.<LevelInfoVO>();
         for each(_loc_2 in this._gameConfList)
         {
            _loc_1.push(_loc_2.getGameConf().getGameInfoVI());
         }
         return _loc_1;
      }
      
      public function getGameModeName(param1:int, param2:int) : String
      {
         var _loc_3:GameConfigurationData = null;
         for each(_loc_3 in this._gameConfList)
         {
            if(_loc_3.getEpisodeId() == param1 && _loc_3.getLevelid() == param2)
            {
               return _loc_3.getGameModeName();
            }
         }
         return "";
      }
   }
}

