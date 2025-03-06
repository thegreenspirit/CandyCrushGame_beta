package com.king.saga.api.net
{
   import com.king.platform.util.*;
   import com.king.saga.api.crafting.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.net.*;
   import flash.events.*;
   import flash.net.*;
   
   public class SagaApi implements ISagaApi
   {
      private var _apiUrl:String;
      
      private var _sessionKey:String;
      
      private var _platid:int;
      
      private var _errorHandler:IApplicationErrorHandler;
      
      public function SagaApi(param1:String, param2:String, param3:IApplicationErrorHandler)
      {
         this._platid = LocalConstants.platid;
         super();
         this._apiUrl = param1;
         this._sessionKey = param2;
         this._errorHandler = param3;
         if(this._apiUrl.length > 0 && this._apiUrl.substring(this._apiUrl.length - 1,1) != "/")
         {
            this._apiUrl += "/";
         }
      }
      
      public function gameInit(param1:Function) : void
      {
         this._call("gameInit",param1,null);
      }
      
      public function sagaInit(param1:Function, param2:Boolean) : void
      {
         this._call("sagaInit",param1,null,param2);
      }
      
      public function gameStart(param1:Function, param2:int, param3:int) : void
      {
         this._call("gameStart",param1,null,param2,param3);
      }
      
      public function gameEnd(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:Number, param7:int, param8:String) : void
      {
         this._gameEnd(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function reportFramerate(param1:int, param2:int, param3:Number, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int) : void
      {
         this._call("reportFramerate",null,null,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
      }
      
      public function poll(param1:Function) : void
      {
         this._call("poll",param1,null);
      }
      
      public function getMessages(param1:Function) : void
      {
         this._call("getMessages",param1,null);
      }
      
      public function peekMessages(param1:Function) : void
      {
         this._call("peekMessages",param1,null);
      }
      
      public function removeMessages(param1:Function, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc_5:Number = NaN;
         var _loc_4:* = new Array();
         for each(_loc_5 in param2)
         {
            _loc_4.push(_loc_5);
         }
         this._call("removeMessages",param1,null,KJSON.stringify(_loc_4),param3);
      }
      
      public function removeLife(param1:Function) : void
      {
         this._call("removeLife",param1,null);
      }
      
      public function getLevelToplist(param1:Function, param2:int, param3:int) : void
      {
         this._call("getLevelToplist",param1,null,param2,param3);
      }
      
      public function buyBooster(param1:Function, param2:String) : void
      {
         this._call("buyBooster",param1,null,param2);
      }
      
      public function getRecipes(param1:Function) : void
      {
         this._call("getRecipes",param1,null);
      }
      
      public function craft(param1:Function, param2:String) : void
      {
         this._call("craft",param1,null,param2);
      }
      
      public function getBalance(param1:Function) : void
      {
         this._call("getBalance",param1,null);
      }
      
      public function useItemsInGame(param1:Function, param2:Vector.<ItemAmount>, param3:int, param4:int) : void
      {
         var _loc_6:ItemAmount = null;
         var _loc_5:* = new Array();
         for each(_loc_6 in param2)
         {
            _loc_5.push(_loc_6.toObject());
         }
         this._call("useItemsInGame",param1,null,KJSON.stringify(_loc_5),param3,param4);
      }
      
      public function handOutItemWinnings(param1:Function, param2:Vector.<ItemAmount>, param3:int, param4:int, param5:String) : void
      {
         var _loc_7:ItemAmount = null;
         var _loc_6:* = new Array();
         for each(_loc_7 in param2)
         {
            _loc_6.push(_loc_7.toObject());
         }
         this._call("handOutItemWinnings",param1,null,KJSON.stringify(_loc_6),param3,param4,param5);
      }
      
      public function unlockItem(param1:Function, param2:String, param3:String) : void
      {
         this._call("unlockItem",param1,null,param2,param3);
      }
      
      public function activateItem(param1:Function, param2:String, param3:String) : void
      {
         this._call("activateItem",param1,null,param2,param3);
      }
      
      public function deactivateItem(param1:Function, param2:String, param3:String) : void
      {
         this._call("deactivateItem",param1,null,param2,param3);
      }
      
      public function getLevelToplists(param1:Function) : void
      {
         this._call("getLevelToplists",param1,null);
      }
      
      public function setMusic(param1:Boolean) : void
      {
         this._call("setSoundMusic",null,null,param1);
      }
      
      public function setSound(param1:Boolean) : void
      {
         this._call("setSoundFx",null,null,param1);
      }
      
      private function _gameEnd(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:Number, param7:int, param8:String) : void
      {
         var _loc_9:Object = null;
         _loc_9 = new Object();
         _loc_9.episodeId = param2;
         _loc_9.levelId = param3;
         _loc_9.score = param4;
         _loc_9.seed = param6;
         _loc_9.timeLeftPercent = param7;
         _loc_9.reason = param5;
         _loc_9.cs = param8;
         var _loc_10:* = KJSON.stringify(_loc_9);
         this._call("gameEnd",param1,null,_loc_10);
      }
      
      private function _call(param1:String, param2:Function, param3:Object, ... args) : void
      {
         var _loc_7:String = null;
         var _loc_8:IntermediateComplete = null;
         var _loc_6:int = 0;
         var arg:* = new URLVariables();
         arg._session = this._sessionKey;
         arg.platid = this._platid;
         while(_loc_6 < args.length)
         {
            arg["arg" + _loc_6] = args[_loc_6];
            _loc_6++;
         }
         _loc_7 = this._apiUrl + param1;
         _loc_8 = new IntermediateComplete(param2,param3,_loc_7,args.toString());
         var _loc_9:* = new ApiCall(_loc_7,arg,this._onComplete,this._onIOError,3,_loc_8);
         _loc_9.call();
      }
      
      private function _onComplete(param1:String, param2:Object) : void
      {
         var ic:IntermediateComplete = null;
         var response:String = param1;
         var callbackObject:* = param2;
         ic = callbackObject as IntermediateComplete;
         try
         {
            if(ic.callback != null)
            {
               response = response.replace(/\'/,"/\'");
               ic.callback(KJSON.parse(response),ic.callbackObject);
            }
         }
         catch(err:Error)
         {
            _errorHandler.onError(err,"Something went wrong after a saga api call: " + ic.url + " with params: " + ic.params);
         }
      }
      
      private function _onIOError(event:IOErrorEvent, param2:Object) : void
      {
         this._errorHandler.onNetError(event,"A saga api call went wrong.");
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

