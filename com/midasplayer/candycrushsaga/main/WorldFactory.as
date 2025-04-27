package com.midasplayer.candycrushsaga.main
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.main.CCMain;
   import com.midasplayer.candycrushsaga.tutorial.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   
   public class WorldFactory extends EventDispatcher
   {
      public static const WORLD_LOADING_COMPLETE:String = "worldLoadingComplete";
      
      public static const WORLD_ASSETS_LOADING_COMPLETE:String = "worldAssetsLoadingComplete";
      
      public static const WORLD_ASSETS_READY_FOR_CREATION:String = "worldAssetsReadyForCreation";
      
      public static const WORLD_ASSETS_PROGRESS:String = "worldAssetsProgress";
      
      public var pathTracker:PathTracker;
      
      private var _ccMain:CCMain;
      
      private var _loader:Loader;
      
      private var worldAssetFactory:AssetFactory;
      
      private var worldAssetsArr:Array;
      
      private var currentWorld:Object;
      
      private var worldAssetsCompleted:Boolean = false;
      
      private var filePaths:Array;
      
      private var onlyPath:String;
      
      public var assetBytes:int;
      
      public var assetPercent:Number;
      
      public var worldClassAvailable:Boolean = false;
      
      public var bytesTotal:int = 0;
      
      public var bytesLoaded:int = 0;
      
      public function WorldFactory(param1:CCMain)
      {
         super();
         this.worldAssetsArr = [];
         this._ccMain = param1;
      }
      
      public function startLoadingWorldClass(param1:String) : void
      {
         this.trackPaths(param1);
         this.onlyPath = param1;
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onWorldClassComplete);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onWorldClassError);
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onWorldClassProgress);
         this._loader.load(new URLRequest(param1));
      }
      
      private function trackPaths(param1:String) : void
      {
         this.pathTracker = new PathTracker("WorldFactory");
         this.pathTracker.addedPaths.push(param1);
      }
      
      public function createWorld() : *
      {
         var _loc_1:* = this._loader.contentLoaderInfo.applicationDomain.getDefinition("com.midasplayer.candycrushsaga.world.World") as Class;
         this.currentWorld = new _loc_1();
         return this.currentWorld;
      }
      
      public function getSkinAsset(param1:String, param2:String) : MovieClip
      {
         var _loc_3:* = AssetFactory.getFactory(param2);
         var _loc_4:* = _loc_3.retrieveAsset(param2 + "." + param1);
         return _loc_3.retrieveAsset(param2 + "." + param1);
      }
      
      public function loadAssets() : void
      {
         this.startLoadingWorldAssets();
      }
      
      private function startLoadingWorldAssets() : void
      {
         this.worldAssetFactory = AssetFactory.getFactory(AssetFactory.WORLD_COMMON);
         if(this.worldAssetFactory.progressStatus == AssetFactory.STATUS_COMPLETE)
         {
            this.worldAssetComplete();
         }
         else
         {
            this.worldAssetFactory.addEventListener(AssetFactory.ASSET_STATUS_UPDATED,this.onWorldAssetUpdate);
            dispatchEvent(new Event(WorldFactory.WORLD_ASSETS_PROGRESS));
         }
      }
      
      private function onWorldAssetUpdate(event:Event) : void
      {
         this.assetPercent = AssetFactory(event.target).percentLoaded();
         this.assetBytes = AssetFactory(event.target).bytesLoaded;
         dispatchEvent(new Event(WorldFactory.WORLD_ASSETS_PROGRESS));
         if(AssetFactory(event.target).progressStatus == AssetFactory.STATUS_COMPLETE)
         {
            this.worldAssetFactory.removeEventListener(AssetFactory.ASSET_STATUS_UPDATED,this.onWorldAssetUpdate);
            this.worldAssetComplete();
         }
      }
      
      private function worldAssetComplete() : void
      {
         this.worldAssetsCompleted = true;
         if(this.checkAllCustomAssetsLoaded() && this.worldAssetsCompleted)
         {
            this.allAssetsLoaded();
         }
      }
      
      private function checkAllCustomAssetsLoaded() : Boolean
      {
         var _loc_2:AssetFactory = null;
         var _loc_1:Boolean = true;
         for each(_loc_2 in this.worldAssetsArr)
         {
            if(_loc_2.progressStatus != AssetFactory.STATUS_COMPLETE)
            {
               _loc_1 = false;
               break;
            }
         }
         return _loc_1;
      }
      
      private function onWorldClassProgress(event:ProgressEvent) : void
      {
         var _loc_2:* = LoaderInfo(event.target);
         this.bytesTotal = _loc_2.bytesTotal;
         if(this.bytesTotal == 0)
         {
            this.bytesTotal = 93 * 1000;
         }
         this.bytesLoaded = _loc_2.bytesLoaded;
      }
      
      private function onWorldClassError(event:Event) : void
      {
         this.removeListeners();
      }
      
      private function onWorldClassComplete(event:Event) : void
      {
         this.pathTracker.completedPaths.push(this.onlyPath);
         this.removeListeners();
         this.worldClassAvailable = true;
         dispatchEvent(new Event(WORLD_LOADING_COMPLETE));
      }
      
      private function destruct() : void
      {
         this.removeListeners();
      }
      
      private function removeListeners() : void
      {
         if(Boolean(this._loader))
         {
            this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onWorldClassProgress);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onWorldClassComplete);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onWorldClassError);
         }
      }
      
      private function allAssetsLoaded() : void
      {
         this.currentWorld.setSkinFunction(this.getSkinAsset);
         dispatchEvent(new Event(WorldFactory.WORLD_ASSETS_LOADING_COMPLETE));
         dispatchEvent(new Event(WorldFactory.WORLD_ASSETS_READY_FOR_CREATION));
         if(this._ccMain.getTopEpisode() == 1 && this._ccMain.getTopLevel() == 2)
         {
            this._ccMain.addTutorialPop(TutorialHandler.POP_ID_WORLD_INTRODUCTION,null,null);
         }
      }
   }
}

import flash.events.EventDispatcher;

