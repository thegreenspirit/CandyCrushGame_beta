package com.midasplayer.candycrushsaga.cutscene
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.net.*;
   
   public class CutsceneFactory extends EventDispatcher
   {
      public static const CUTSCENE_LOAD_COMPLETED:String = "cutsceneLoadCompleted";
      
      public static const CUTSCENE_PROGRESS:String = "cutsceneProgress";
      
      private var _loader:Loader;
      
      private var _fileName:String;
      
      private var _container:MovieClip;
      
      private var _swf:MovieClip;
      
      private var _cutsceneAvailable:Boolean;
      
      private var _cutsceneSnapShot:MovieClip;
      
      private var _name:String;
      
      private var _getAssetUrl:Function;
      
      private var _type:String;
      
      private var _followUp:Boolean;
      
      private var pathTracker:PathTracker;
      
      private var myPath:String;
      
      public function CutsceneFactory(param1:String, param2:String, param3:Function, param4:Boolean, param5:PathTracker)
      {
         super();
         this.pathTracker = param5;
         this._type = param2;
         this._name = param1 + "_" + this._type;
         this._fileName = this._name;
         Console.println("| cutscene filename: " + this._fileName);
         this._cutsceneAvailable = false;
         this._getAssetUrl = param3;
         this._followUp = param4;
         this.startLoadingLibrary();
      }
      
      public function getType() : String
      {
         return this._type;
      }
      
      public function getFollowUp() : Boolean
      {
         return this._followUp;
      }
      
      private function startLoadingLibrary() : void
      {
         if(ExternalInterface.available)
         {
            this.myPath = this._getAssetUrl("/swf/assets/cutscenes/" + this._fileName + ".swf");
         }
         else
         {
            this.myPath = "assets/cutscenes/" + this._fileName + ".swf";
         }
         this.pathTracker.addedPaths.push(this.myPath);
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.load(new URLRequest(this.myPath));
      }
      
      private function onComplete(event:Event) : void
      {
         this.pathTracker.completedPaths.push(this.myPath);
         this._swf = event.currentTarget.content.getChildAt(0) as MovieClip;
         this._swf.gotoAndStop(1);
         this._cutsceneAvailable = true;
         dispatchEvent(new Event(CutsceneFactory.CUTSCENE_LOAD_COMPLETED));
      }
      
      public function stopAllAnimations(param1:MovieClip) : void
      {
         var _loc_3:MovieClip = null;
         var _loc_2:uint = 0;
         param1.stop();
         while(_loc_2 < param1.numChildren)
         {
            _loc_3 = param1.getChildAt(_loc_2) as MovieClip;
            if(Boolean(_loc_3))
            {
               _loc_3.stop();
               if(_loc_3.numChildren > 0)
               {
                  this.stopAllAnimations(_loc_3);
               }
            }
            _loc_2 += 1;
         }
      }
      
      private function onError(event:Event) : void
      {
         this.pathTracker.failedPaths.push(this.myPath);
         Console.println("ERROR e=" + event.toString());
         this.destruct();
      }
      
      public function getCutsceneAvailable() : Boolean
      {
         return this._cutsceneAvailable;
      }
      
      public function getCutscene() : MovieClip
      {
         return this._swf;
      }
      
      public function setCutsceneSnapShot(param1:MovieClip) : void
      {
         this._cutsceneSnapShot = param1;
      }
      
      public function getCutsceneSnapShot() : MovieClip
      {
         return this._cutsceneSnapShot;
      }
      
      public function getCutsceneName() : String
      {
         return this._name;
      }
      
      public function destruct() : void
      {
         this.pathTracker = null;
         if(Boolean(this._loader))
         {
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._loader = null;
         }
      }
      
      public function getBytesLoaded() : int
      {
         return this._loader.contentLoaderInfo.bytesLoaded;
      }
      
      private function onProgress(event:ProgressEvent) : void
      {
         dispatchEvent(new Event(CutsceneFactory.CUTSCENE_PROGRESS));
      }
   }
}

import flash.events.EventDispatcher;

