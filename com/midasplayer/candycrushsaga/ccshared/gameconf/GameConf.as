package com.midasplayer.candycrushsaga.ccshared.gameconf
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.adobe.serialization.json.JSONEncoder;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class GameConf
   {
      public static const MODE_NAME_CLASSIC:String = "Classic";
      
      public static const MODE_NAME_CLASSIC_MOVES:String = "Classic moves";
      
      public static const MODE_NAME_LIGHT_UP:String = "Light up";
      
      public static const MODE_NAME_DROP_DOWN:String = "Drop down";
      
      public static const MODE_NAME_BALANCE:String = "Balance";
      
      public static const MODE_NAME_DROP_DOWN_SCORE:String = "Drop down score";
      
      public static const MODE_NAME_LIGHT_UP_SCORE:String = "Light up score";
      
      public static const MODE_NAME_ORDER:String = "Order";
      
      private var _protocolVersion:String;
      
      private var _gameModeName:String;
      
      private var _numberOfColors:int;
      
      private var _tileMap:Array;
      
      private var _scoreTargets:Array;
      
      private var _randomSeed:int;
      
      private var _portals:Array;
      
      private var _episodId:int;
      
      private var _levelId:int;
      
      private var _licoriceMax:int;
      
      private var _licoriceSpawn:int;
      
      private var _pepperCandyMax:int;
      
      private var _pepperCandySpawn:int;
      
      private var _pepperCandyExplosionTurns:int;
      
      private var _hasFrosting:Boolean = false;
      
      private var _hasLiqLock:Boolean = false;
      
      private var _hasChocolate:Boolean = false;
      
      private var _hasVisibleTeleporter:Boolean = false;
      
      private var _hasLiqSquare:Boolean = false;
      
      private var _hasPepperCandy:Boolean = false;
      
      protected var _levelInfoVO:LevelInfoVO;
      
      public function GameConf()
      {
         super();
         this._levelInfoVO = new LevelInfoVO();
         this.setProtocolVersion("0.1");
         this.setGameModeName("");
         this.setNumberOfColours(6);
         this.setTileMap([[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]);
         this.setScoreTargets([10000,20000,30000]);
         this.setRandomSeed(0);
         this.setPortals([]);
         this.setLicoriceSpawn(0);
         this.setLicoriceMax(0);
         this.setPepperCandySpawn(0);
         this.setPepperCandyMax(0);
         this.setPepperCandyExplosionTurns(0);
      }
      
      public function loadFromObject(param1:Object) : void
      {
         var _loc_2:* = new TypedKeyVal(param1);
         this.setProtocolVersion(_loc_2.getAsString("protocolVersion"));
         this.setGameModeName(_loc_2.getAsString("gameModeName"));
         this.setNumberOfColours(_loc_2.getAsInt("numberOfColours"));
         this.setTileMap(_loc_2.getAsArray("tileMap"));
         this.setScoreTargets(_loc_2.getAsArray("scoreTargets"));
         this.setRandomSeed(_loc_2.getAsInt("randomSeed"));
         this.setPortals(Boolean(_loc_2.has("portals")) ? _loc_2.getAsArray("portals") : []);
         this.setLicoriceSpawn(_loc_2.getAsIntDef("licoriceSpawn",0));
         this.setLicoriceMax(_loc_2.getAsIntDef("licoriceMax",0));
         this.setPepperCandySpawn(_loc_2.getAsIntDef("pepperCandySpawn",0));
         this.setPepperCandyMax(_loc_2.getAsIntDef("pepperCandyMax",0));
         this.setPepperCandyExplosionTurns(_loc_2.getAsIntDef("pepperCandyExplosionTurns",0));
      }
      
      public function getAsObject() : Object
      {
         return {
            "protocolVersion":this.protocolVersion(),
            "gameModeName":this.gameModeName(),
            "numberOfColours":this.numberOfColours(),
            "tileMap":this.tileMap(),
            "scoreTargets":this.scoreTargets(),
            "randomSeed":this.randomSeed(),
            "portals":this.portals(),
            "licoriceSpawn":this.getLicoriceSpawnRate(),
            "licoriceMax":this.getLicoriceMax(),
            "pepperCandySpawn":this.getPepperCandySpawnRate(),
            "pepperCandyMax":this.getPepperCandyMax(),
            "pepperCandyExplosionTurns":this.getPepperCandyExplosionTurns()
         };
      }
      
      public function getAsJsonString() : String
      {
         var _loc_1:* = new JSONEncoder(this.getAsObject());
         return _loc_1.getString();
      }
      
      public function loadFromJson(param1:String) : void
      {
         var decoder:JSONDecoder = null;
         var jsonStr:* = param1;
         try
         {
            decoder = new JSONDecoder(jsonStr,false);
            this.loadFromObject(decoder.getValue());
         }
         catch(e:Error)
         {
            Debug.assert(false,"Error when parsing gameconf json: " + e);
         }
      }
      
      public function protocolVersion() : String
      {
         return this._protocolVersion;
      }
      
      public function setProtocolVersion(param1:String) : void
      {
         this._protocolVersion = param1;
      }
      
      public function gameModeName() : String
      {
         return this._gameModeName;
      }
      
      public function setGameModeName(param1:String) : void
      {
         this._gameModeName = param1;
      }
      
      public function numberOfColours() : int
      {
         return this._numberOfColors;
      }
      
      public function setNumberOfColours(param1:int) : void
      {
         this._numberOfColors = param1;
      }
      
      public function tileMap() : Array
      {
         var _loc_3:Array = null;
         var _loc_4:int = 0;
         var _loc_2:int = 0;
         var _loc_1:* = new Array();
         while(_loc_2 < this._tileMap.length)
         {
            _loc_3 = new Array();
            _loc_1.push(_loc_3);
            _loc_4 = 0;
            while(_loc_4 < this._tileMap[_loc_2].length)
            {
               _loc_3.push(this._tileMap[_loc_2][_loc_4]);
               _loc_4++;
            }
            _loc_2++;
         }
         return _loc_1;
      }
      
      public function setTileMap(param1:Array) : void
      {
         var _loc_3:Array = null;
         var _loc_4:int = 0;
         var _loc_2:int = 0;
         this._tileMap = new Array();
         while(_loc_2 < param1.length)
         {
            _loc_3 = new Array();
            this._tileMap.push(_loc_3);
            _loc_4 = 0;
            while(_loc_4 < param1[_loc_2].length)
            {
               _loc_3.push(param1[_loc_2][_loc_4]);
               this.addLevelInfo(param1[_loc_2][_loc_4]);
               _loc_4++;
            }
            _loc_2++;
         }
      }
      
      private function addLevelInfo(param1:int) : void
      {
         if(Boolean(param1 & TileMapConstants.FROSTING))
         {
            this._levelInfoVO.hasFrosting = true;
         }
         else if(Boolean(param1 & TileMapConstants.FUDGE))
         {
            this._levelInfoVO.hasChocolate = true;
         }
         else if(Boolean(param1 & TileMapConstants.LICORICE_SQUARE))
         {
            this._levelInfoVO.hasLiqSquare = true;
         }
         else if(Boolean(param1 & TileMapConstants.LOCK_1))
         {
            this._levelInfoVO.hasLiqLock = true;
         }
      }
      
      public function scoreTargets() : Array
      {
         var _loc_2:int = 0;
         var _loc_1:* = new Array();
         while(_loc_2 < this._scoreTargets.length)
         {
            _loc_1.push(this._scoreTargets[_loc_2]);
            _loc_2++;
         }
         return _loc_1;
      }
      
      public function setScoreTargets(param1:Array) : void
      {
         var _loc_2:int = 0;
         this._scoreTargets = new Array();
         while(_loc_2 < param1.length)
         {
            this._scoreTargets.push(param1[_loc_2]);
            _loc_2++;
         }
      }
      
      public function randomSeed() : int
      {
         return this._randomSeed;
      }
      
      public function setRandomSeed(param1:int) : void
      {
         this._randomSeed = param1;
      }
      
      public function portals() : Array
      {
         var _loc_2:Array = null;
         var _loc_1:* = new Array();
         for each(_loc_2 in this._portals)
         {
            _loc_1.push([_loc_2[0],_loc_2[1]]);
         }
         return _loc_1;
      }
      
      public function setPortals(param1:Array) : void
      {
         var _loc_2:Array = null;
         this._portals = new Array();
         for each(_loc_2 in param1)
         {
            this._portals.push([_loc_2[0],_loc_2[1]]);
            if(this._portals[0][0].length >= 3)
            {
               this._levelInfoVO.hasVisibleTeleporter = true;
            }
         }
      }
      
      public function setEpisodId(param1:int) : void
      {
         this._episodId = param1;
         this._levelInfoVO.episodId = param1;
      }
      
      public function setLevelId(param1:int) : void
      {
         this._levelId = param1;
         this._levelInfoVO.levelId = param1;
      }
      
      public function getEpisodId() : int
      {
         return this._episodId;
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
      
      public function getLicoriceSpawnRate() : int
      {
         return this._licoriceSpawn;
      }
      
      public function getLicoriceMax() : int
      {
         return this._licoriceMax;
      }
      
      public function setLicoriceSpawn(param1:int) : void
      {
         this._licoriceSpawn = param1;
      }
      
      public function setLicoriceMax(param1:int) : void
      {
         this._licoriceMax = param1;
      }
      
      public function getGameInfoVI() : LevelInfoVO
      {
         return this._levelInfoVO;
      }
      
      public function getPepperCandySpawnRate() : int
      {
         return this._pepperCandySpawn;
      }
      
      public function getPepperCandyMax() : int
      {
         return this._pepperCandyMax;
      }
      
      public function getPepperCandyExplosionTurns() : int
      {
         return this._pepperCandyExplosionTurns;
      }
      
      public function setPepperCandySpawn(param1:int) : void
      {
         this._pepperCandySpawn = param1;
      }
      
      public function setPepperCandyMax(param1:int) : void
      {
         this._pepperCandyMax = param1;
      }
      
      public function setPepperCandyExplosionTurns(param1:int) : void
      {
         this._pepperCandyExplosionTurns = param1;
      }
   }
}

