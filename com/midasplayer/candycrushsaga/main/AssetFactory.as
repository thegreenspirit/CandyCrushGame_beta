package com.midasplayer.candycrushsaga.main
{
   import com.demonsters.debugger.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.net.*;
   import flash.system.*;
   
   public class AssetFactory extends EventDispatcher
   {
      private static var getSwfUrlFn:Function;
      
      public static const ASSET_LOADED:String = "assetLoaded";
      
      public static const PARIS:String = "paris";
      
      public static const WORLD_COMMON:String = "worldCommon";
      
      public static const STATUS_INIT:String = "init";
      
      public static const STATUS_LOADING:String = "loading";
      
      public static const STATUS_COMPLETE:String = "complete";
      
      public static const STATUS_ERROR:String = "error";
      
      public static const ASSET_STATUS_UPDATED:String = "assetStatusUpdated";
      
      public static const COLOGNE:String = "cologne";
      
      public static const DEFAULT:String = "default";
      
      public static const WORLD_COMMON_BYTES:int = 1032870;
      
      private static var factoriesArr:Array = [];
      
      private var _loader:Loader;
      
      private var _totalBytes:int;
      
      public var bytesLoaded:int;
      
      private var _progressStatus:String;
      
      public var packageName:String;
      
      public function AssetFactory(param1:String)
      {
         super();
         MonsterDebugger.trace(this,"[new AssetFactory]");
         this.packageName = param1;
         factoriesArr.push(this);
         this.setStatus(STATUS_INIT);
         this.startLoadingAsset(this.getPathFromPackage(param1));
      }
      
      public static function getFactory(param1:String) : AssetFactory
      {
         return findFactoryForPackage(param1);
      }
      
      public static function setUrlDataFn(param1:Function) : void
      {
         getSwfUrlFn = param1;
      }
      
      private static function findFactoryForPackage(param1:String) : AssetFactory
      {
         var _loc_2:AssetFactory = null;
         for each(_loc_2 in factoriesArr)
         {
            if(param1 == _loc_2.packageName)
            {
               return _loc_2;
            }
         }
         return new AssetFactory(param1);
      }
      
      private function getPathFromPackage(param1:String) : String
      {
         switch(param1)
         {
            case WORLD_COMMON:
               if(ExternalInterface.available)
               {
                  return getSwfUrlFn("/swf/assets/WorldAssets.swf");
               }
               return "assets/WorldAssets.swf";
               break;
            default:
               return null;
         }
      }
      
      private function startLoadingAsset(param1:String) : void
      {
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         var _loc_2:* = ApplicationDomain.currentDomain;
         var _loc_3:* = SecurityDomain.currentDomain;
         var _loc_4:* = new LoaderContext();
         this._loader.load(new URLRequest(param1),_loc_4);
      }
      
      private function onProgress(event:ProgressEvent) : void
      {
         var _loc_2:* = LoaderInfo(event.target);
         this._totalBytes = _loc_2.bytesTotal;
         this.bytesLoaded = _loc_2.bytesLoaded;
         this.setStatus(STATUS_LOADING);
      }
      
      private function onComplete(event:Event) : void
      {
         this.setStatus(STATUS_COMPLETE);
         this.removeListeners();
      }
      
      public function retrieveAsset(param1:String) : MovieClip
      {
         var _loc_2:* = this._loader.contentLoaderInfo.applicationDomain.getDefinition(param1) as Class;
         return new _loc_2() as MovieClip;
      }
      
      public function percentLoaded() : Number
      {
         return 100 * this.bytesLoaded / this.totalBytes;
      }
      
      private function onError(event:Event) : void
      {
         this.removeListeners();
         this.setStatus(STATUS_ERROR);
      }
      
      private function destruct() : void
      {
         this.removeListeners();
      }
      
      private function removeListeners() : void
      {
         if(Boolean(this._loader))
         {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
      }
      
      private function setStatus(param1:String) : void
      {
         this._progressStatus = param1;
         dispatchEvent(new Event(ASSET_STATUS_UPDATED));
      }
      
      public function get progressStatus() : String
      {
         return this._progressStatus;
      }
      
      public function get totalBytes() : int
      {
         if(this._totalBytes != 0)
         {
            return this._totalBytes;
         }
         if(this.packageName == WORLD_COMMON)
         {
            return WORLD_COMMON_BYTES;
         }
         return 0;
      }
   }
}

import flash.events.EventDispatcher;

