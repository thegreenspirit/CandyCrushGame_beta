package com.midasplayer.candycrushsaga.main
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.api.*;
   import com.midasplayer.candycrushsaga.ccshared.net.*;
   import com.midasplayer.debug.*;
   import flash.display.*;
   import flash.events.*;
   import flash.system.*;
   import flash.utils.*;
   
   public class GameFactory extends EventDispatcher
   {
      public static const LOADING_PROGRESS:String = "loadingProgress";
      
      public static const LOADING_COMPLETE:String = "loadingComplete";
      
      private var _loaders:Vector.<CCUrlLoader>;
      
      private var container:MovieClip;
      
      private var totalBytesAllGameAssets:int = 1740000;
      
      private var totalBytesGameClass:int = 3470000;
      
      private var _loadingTimer:Timer;
      
      private var path:String;
      
      private var pathTracker:PathTracker;
      
      public var totalBytesLoaded:int;
      
      public var percentLoaded:Number;
      
      public function GameFactory(param1:MovieClip)
      {
         super();
         this.pathTracker = new PathTracker("GameFactory");
         this.container = param1;
         this._loaders = new Vector.<CCUrlLoader>();
      }
      
      public function startLoadingLibrary(param1:String) : void
      {
         this.pathTracker.addedPaths.push(param1);
         this.path = param1;
         var _loc_2:* = new CCUrlLoader();
         _loc_2.load(param1,this.onComplete,this.onError);
         this._loaders.push(_loc_2);
         if(!this._loadingTimer)
         {
            this._loadingTimer = new Timer(100);
            this._loadingTimer.addEventListener(TimerEvent.TIMER,this.onLoadingProgressCheck);
            this._loadingTimer.start();
         }
      }
      
      private function onLoadingProgressCheck(event:TimerEvent) : void
      {
         var _loc_2:CCUrlLoader = null;
         this.totalBytesLoaded = 0;
         for each(_loc_2 in this._loaders)
         {
            this.totalBytesLoaded += _loc_2.getLoadedBytes();
         }
         this.percentLoaded = 100 * this.totalBytesLoaded / (this.totalBytesAllGameAssets + this.totalBytesGameClass);
         if(this.isDone())
         {
            this._loadingTimer.stop();
            this._loadingTimer.removeEventListener(TimerEvent.TIMER,this.onLoadingProgressCheck);
            this._loadingTimer = null;
            dispatchEvent(new Event(GameFactory.LOADING_PROGRESS));
            dispatchEvent(new Event(GameFactory.LOADING_COMPLETE));
         }
         else
         {
            dispatchEvent(new Event(GameFactory.LOADING_PROGRESS));
         }
      }
      
      public function isDone() : Boolean
      {
         var _loc_2:CCUrlLoader = null;
         var _loc_1:Boolean = true;
         for each(_loc_2 in this._loaders)
         {
            if(!_loc_2.isDone())
            {
               _loc_1 = false;
            }
         }
         return _loc_1;
      }
      
      public function getGame(param1:String) : IGameComm
      {
         var _loc_2:IGameComm = null;
         var _loc_5:Class = null;
         var _loc_3:* = this.getAsset(param1);
         if(Boolean(_loc_3.applicationDomain.hasDefinition("com.midasplayer.candycrushsaga.game.CandyCrushGame")))
         {
            _loc_5 = _loc_3.applicationDomain.getDefinition("com.midasplayer.candycrushsaga.game.CandyCrushGame") as Class;
            _loc_2 = new _loc_5(this.container);
         }
         Debug.assert(_loc_2 != null,"Trying to get CandyCrushGame before it exist.");
         return _loc_2;
      }
      
      public function getAsset(param1:String) : LoaderInfo
      {
         var _loc_2:CCUrlLoader = null;
         for each(_loc_2 in this._loaders)
         {
            if(_loc_2.isDone() && _loc_2.sourcePath() == param1)
            {
               return _loc_2.content();
            }
         }
         Debug.assert(false,"Trying to get non existing asset \"" + param1 + "\".");
         return null;
      }
      
      public function getAllAssetApplicationDomains() : Vector.<ApplicationDomain>
      {
         var _loc_2:CCUrlLoader = null;
         var _loc_1:* = new Vector.<ApplicationDomain>();
         for each(_loc_2 in this._loaders)
         {
            if(_loc_2.isDone())
            {
               _loc_1.push(_loc_2.content().applicationDomain);
            }
         }
         return _loc_1;
      }
      
      private function onComplete(event:Event, param2:String = "") : void
      {
         if(param2 != "")
         {
            this.pathTracker.completedPaths.push(param2);
         }
      }
      
      private function onError(event:Event, param2:String = "") : void
      {
         if(param2 != "")
         {
            this.pathTracker.failedPaths.push(param2);
         }
         Debug.assert(false,"ERROR e=" + event.toString());
      }
      
      private function destruct() : void
      {
      }
   }
}

import flash.events.EventDispatcher;

