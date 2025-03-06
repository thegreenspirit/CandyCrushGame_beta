package com.midasplayer.candycrushsaga.engine
{
   import com.adobe.serialization.json.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   import flash.events.*;
   import flash.net.*;
   
   public class CandyApi
   {
      private var _candyApiUrl:String;
      
      private var _apiUrl:String;
      
      private var _gameConfMethod:String;
      
      private var _candyPropertiesMethod:String;
      
      private var _sessionKey:String;
      
      private var _platid:int;
      
      private var _ccModel:CCModel;
      
      private var _gameConfApiLoader:URLLoader;
      
      public var _gameConfLoadRetries:int = 0;
      
      private var _candyPropApiLoader:URLLoader;
      
      public var _candyPropLoadRetries:int = 0;
      
      private var _gameConfHandler:GameConfHandler;
      
      private var _candyPropertiesHandler:CandyPropertiesHandler;
      
      private var _initiateGame:Function;
      
      private var _onNetError:Function;
      
      private var _onError:Function;
      
      public function CandyApi(param1:Object, param2:Function, param3:Function, param4:Function, param5:CCModel)
      {
         super();
         this._sessionKey = param1.sessionKey;
         this._platid = param1.platid;
         this._candyApiUrl = param1.candyApiUrl;
         this._apiUrl = param1.apiUrl;
         this._gameConfMethod = param1.getGameConfigurationsMethod;
         this._candyPropertiesMethod = param1.getCandyPropertiesMethod + "?_session=" + this._sessionKey;
         this._initiateGame = param2;
         this._onNetError = param3;
         this._onError = param4;
         this._ccModel = param5;
         this.loadGameConf();
      }
      
      private function loadGameConf() : void
      {
         var _loc_1:* = new URLRequest(this._candyApiUrl + this._gameConfMethod);
         _loc_1.method = URLRequestMethod.GET;
         Console.println("@ loadGameConf()" + this._candyApiUrl + this._gameConfMethod);
         this._gameConfApiLoader = new URLLoader();
         this._gameConfApiLoader.addEventListener(Event.COMPLETE,this.onGameConfDataComplete);
         this._gameConfApiLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onGameConfDataError);
         this._gameConfApiLoader.load(_loc_1);
      }
      
      private function onGameConfDataComplete(event:Event) : void
      {
         this._gameConfApiLoader.removeEventListener(Event.COMPLETE,this.onGameConfDataComplete);
         this._gameConfApiLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onGameConfDataError);
         var _loc_2:* = com.adobe.serialization.json.JSON.decode(event.target.data);
         this._gameConfHandler = new GameConfHandler(_loc_2,this._ccModel);
         this._gameConfApiLoader = null;
         this.loadCandyPropData();
      }
      
      private function onGameConfDataError(event:IOErrorEvent) : void
      {
         var _loc_3:* = undefined;
         var _loc_4:* = undefined;
         this._gameConfApiLoader.removeEventListener(Event.COMPLETE,this.onGameConfDataComplete);
         this._gameConfApiLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onGameConfDataError);
         if(this._gameConfLoadRetries < 3)
         {
            _loc_3 = this;
            _loc_4 = this._gameConfLoadRetries + 1;
            _loc_3._gameConfLoadRetries = _loc_4;
            Console.println("Retrying GameConf data loading retry num=" + this._gameConfLoadRetries);
            this.loadGameConf();
            return;
         }
         var _loc_2:* = "GameConf could not be loaded: type=" + event.type + ", text=" + event.text;
         Console.println(_loc_2);
         this._gameConfApiLoader = null;
      }
      
      private function loadCandyPropData() : void
      {
         var _loc_1:* = new URLRequest(this._candyApiUrl + this._candyPropertiesMethod);
         _loc_1.method = URLRequestMethod.GET;
         Console.println("@ loadCandyPropData() | candyApiUrl:" + this._candyApiUrl + " | candyPropertiesMethod:" + this._candyPropertiesMethod);
         this._candyPropApiLoader = new URLLoader();
         this._candyPropApiLoader.addEventListener(Event.COMPLETE,this.onCandyPropDataComplete);
         this._candyPropApiLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onCandyPropDataError);
         this._candyPropApiLoader.load(_loc_1);
      }
      
      private function onCandyPropDataComplete(event:Event) : void
      {
         this._candyPropApiLoader.removeEventListener(Event.COMPLETE,this.onCandyPropDataComplete);
         this._candyPropApiLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onCandyPropDataError);
         var _loc_2:* = com.adobe.serialization.json.JSON.decode(event.target.data);
         this._candyPropertiesHandler = new CandyPropertiesHandler(_loc_2);
         this._candyPropApiLoader = null;
         this._initiateGame();
      }
      
      private function onCandyPropDataError(event:IOErrorEvent) : void
      {
         var _loc_3:* = undefined;
         var _loc_4:* = undefined;
         this._candyPropApiLoader.removeEventListener(Event.COMPLETE,this.onCandyPropDataComplete);
         this._candyPropApiLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onCandyPropDataError);
         if(this._candyPropLoadRetries < 3)
         {
            _loc_3 = this;
            _loc_4 = this._candyPropLoadRetries + 1;
            _loc_3._candyPropLoadRetries = _loc_4;
            Console.println("Retrying Candyproperties data loading retry num=" + this._candyPropLoadRetries);
            this.loadCandyPropData();
            return;
         }
         var _loc_2:* = "Candyproperties could not be loaded: type=" + event.type + ", text=" + event.text;
         Console.println(_loc_2);
         Console.println("Make sure your session key is up to date.");
         this._candyPropApiLoader = null;
      }
      
      public function overrideScoreTargets(param1:Function) : void
      {
         this._gameConfHandler.overrideScoreTargets(param1);
      }
      
      public function getGameConf(param1:int, param2:int) : GameConf
      {
         return this._gameConfHandler.getGameConf(param1,param2);
      }
      
      public function getAllLevelInfoVO() : Vector.<LevelInfoVO>
      {
         return this._gameConfHandler.getAllLevelInfoVO();
      }
      
      public function getGameModeName(param1:int, param2:int) : String
      {
         return this._gameConfHandler.getGameModeName(param1,param2);
      }
      
      public function setSeenBoosterTut(param1:String) : void
      {
         this._candyPropertiesHandler.setSeenBoosterTut(param1);
         this.call("setCandyProperty",null,null,param1,"true");
      }
      
      public function getSeenBoosterTut(param1:String) : Boolean
      {
         return this._candyPropertiesHandler.getSeenBoosterTut(param1);
      }
      
      public function activateCharmByName(param1:String) : void
      {
         this.call(param1,this.charmOfExtraLifeHasBeenActivated,null);
      }
      
      public function getGiftInviteNum(num:int) : void
      {
         var arg:URLVariables = new URLVariables();
         arg._session = this._sessionKey;
         arg.num = num;
         new CandyApiCall(this._apiUrl + "/invreward",arg,this._onComplete,this._onIOError,3,null).call();
      }
      
      public function getGiftInviteLevel(externalUserId:String, level:int) : void
      {
         var arg:URLVariables = new URLVariables();
         arg._session = this._sessionKey;
         arg.level = level;
         arg.fid = externalUserId;
         new CandyApiCall(this._apiUrl + "/invlevel",arg,this._onComplete,this._onIOError,3,null).call();
      }
      
      public function charmOfExtraLifeHasBeenActivated(param1:Object, param2:Object) : void
      {
         var _loc_3:* = param1;
         if(_loc_3)
         {
            param2.charmOfExtraLifeHasBeenActivated();
            Console.println("Charm of Extra Life has been enabled");
         }
         else
         {
            Console.println("Charm of Extra Life could not be enabled");
         }
      }
      
      private function call(param1:String, param2:Function, param3:Object, ... args) : void
      {
         var _loc_7:String = null;
         var _loc_8:IntermediateComplete = null;
         var _loc_6:int = 0;
         var arg:URLVariables = new URLVariables();
         arg._session = this._sessionKey;
         arg.platid = this._platid;
         while(_loc_6 < args.length)
         {
            arg["arg" + _loc_6] = args[_loc_6];
            _loc_6++;
         }
         _loc_7 = this._candyApiUrl + param1;
         _loc_8 = new IntermediateComplete(param2,param3,_loc_7,arg.toString());
         var _loc_9:* = new CandyApiCall(_loc_7,arg,this._onComplete,this._onIOError,3,_loc_8);
         _loc_9.call();
      }
      
      private function _onComplete(param1:String, param2:Object) : void
      {
         var ic:IntermediateComplete = null;
         var response:* = param1;
         var callbackObject:* = param2;
         ic = callbackObject as IntermediateComplete;
         if(!ic)
         {
            return;
         }
         try
         {
            if(ic.callback != null)
            {
               ic.callback(com.adobe.serialization.json.JSON.decode(response),ic.callbackObject);
            }
         }
         catch(err:Error)
         {
            _onError(err,"Something went wrong after a candy api call: " + ic.url + " with params: " + ic.params);
         }
      }
      
      private function _onIOError(event:IOErrorEvent, param2:Object) : void
      {
         this._onNetError(event,"A candyapi call went wrong.");
      }
   }
}

class IntermediateComplete
{
   public var callback:Function;
   
   public var callbackObject:Object;
   
   public var url:String;
   
   public var params:String;
   
   public function IntermediateComplete(param1:Function, param2:Object, param3:String, param4:String)
   {
      super();
      this.callback = param1;
      this.callbackObject = param2;
      this.url = param3;
      this.params = param4;
   }
}

