package com.midasplayer.candycrushsaga.ccshared.net
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   
   public class CCUrlLoader
   {
      private var _clbOnComplete:Function;
      
      private var _clbOnIOError:Function;
      
      private var _isDone:Boolean;
      
      private var _loaderInfo:LoaderInfo;
      
      private var _sourcePath:String;
      
      private var myLoader:Loader;
      
      public function CCUrlLoader()
      {
         super();
         this._isDone = false;
      }
      
      public function isDone() : Boolean
      {
         return this._isDone;
      }
      
      public function sourcePath() : String
      {
         return this._sourcePath;
      }
      
      public function content() : LoaderInfo
      {
         return this._loaderInfo;
      }
      
      public function getLoadedBytes() : int
      {
         if(Boolean(this._loaderInfo))
         {
            return this._loaderInfo.bytesLoaded;
         }
         return 0;
      }
      
      public function load(param1:String, param2:Function, param3:Function) : void
      {
         this._isDone = false;
         this._sourcePath = param1;
         this._clbOnComplete = param2;
         this._clbOnIOError = param3;
         var _loc_4:* = new URLLoader();
         _loc_4.dataFormat = URLLoaderDataFormat.BINARY;
         _loc_4.addEventListener(Event.COMPLETE,this._onBinaryLoadComplete);
         _loc_4.addEventListener(IOErrorEvent.IO_ERROR,this._onBinaryLoadError);
         _loc_4.load(new URLRequest(param1));
      }
      
      private function _onBinaryLoadComplete(event:Event) : void
      {
         var _loc_2:* = URLLoader(event.target);
         _loc_2.removeEventListener(Event.COMPLETE,this._onBinaryLoadComplete);
         _loc_2.removeEventListener(IOErrorEvent.IO_ERROR,this._onBinaryLoadError);
         this.myLoader = new Loader();
         this.myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this._onByteLoadComplete);
         this.myLoader.loadBytes(ByteArray(_loc_2.data),new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain)));
      }
      
      private function _onBinaryLoadError(event:IOErrorEvent) : void
      {
         var _loc_2:* = URLLoader(event.target);
         _loc_2.removeEventListener(Event.COMPLETE,this._onBinaryLoadComplete);
         _loc_2.removeEventListener(IOErrorEvent.IO_ERROR,this._onBinaryLoadError);
         this._clbOnIOError(event,this._sourcePath);
      }
      
      private function _onByteLoadComplete(event:Event) : void
      {
         this._loaderInfo = LoaderInfo(event.target);
         this._loaderInfo.removeEventListener(Event.COMPLETE,this._onByteLoadComplete);
         this.myLoader = null;
         this._isDone = true;
         this._clbOnComplete(event,this._sourcePath);
      }
   }
}

