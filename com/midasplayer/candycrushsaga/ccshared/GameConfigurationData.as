package com.midasplayer.candycrushsaga.ccshared
{
   import com.adobe.serialization.json.*;
   import com.king.saga.api.universe.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.util.*;
   
   public class GameConfigurationData
   {
      private var _gameConf:GameConf;
      
      private var _episodeId:int;
      
      private var _levelId:int;
      
      private var _totalLevel:int;
      
      public function GameConfigurationData(param1:Object, param2:CCModel)
      {
         var _loc_3:TypedKeyVal = null;
         super();
         _loc_3 = new TypedKeyVal(param1);
         this._episodeId = _loc_3.getAsInt("episode");
         this._levelId = _loc_3.getAsInt("level");
         this._totalLevel = _loc_3.getAsInt("totalLevel");
         var _loc_4:* = _loc_3.getAsString("gameData");
         var _loc_5:* = com.adobe.serialization.json.JSON.decode(_loc_4);
         var _loc_6:* = new GameConfFactory();
         this._gameConf = _loc_6.createFromObject(_loc_5);
         this._gameConf.setEpisodId(this._episodeId);
         this._gameConf.setLevelId(this._levelId);
      }
      
      private function overrideScoreTargetValues(param1:CCModel) : void
      {
         var _loc_2:* = new Array();
         var _loc_3:uint = 1;
         while(_loc_3 <= 3)
         {
            _loc_2.push(param1.getScoreTarget(this._episodeId,this._levelId,_loc_3));
            _loc_3 += 1;
         }
         this._gameConf.setScoreTargets(_loc_2);
      }
      
      public function overrideScoreTargets(param1:Function) : void
      {
         var _loc_4:StarProgression = null;
         var _loc_2:* = param1(this._episodeId,this._levelId).getStarProgressions();
         var _loc_3:* = new Array();
         for each(_loc_4 in _loc_2)
         {
            _loc_3.push(_loc_4.getPoints());
         }
         this._gameConf.setScoreTargets(_loc_3);
      }
      
      public function overrideRandomSeed(param1:int) : void
      {
         this._gameConf.setRandomSeed(param1);
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelid() : int
      {
         return this._levelId;
      }
      
      public function getGameConf() : GameConf
      {
         return this._gameConf;
      }
      
      public function getGameModeName() : String
      {
         return this._gameConf.gameModeName();
      }
   }
}

