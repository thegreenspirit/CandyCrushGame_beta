package com.midasplayer.candycrushsaga.main
{
   import com.midasplayer.console.Console;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class MainFactory extends EventDispatcher
   {
      public static const MAIN_LOADING_COMPLETE:String = "mainLoadingComplete";
      
      public static const MAIN_LOADING_PROGRESS:String = "mainLoadingProgress";
      
      public static const MAIN_BYTES:int = 130000;
      
      private var _loader:Loader;
      
      private var dLoader:URLLoader; // wut
      
      private var _ccMain:Object;
      
      public var mainBytes:int = 0;
      
      public var mainPercent:Number = 0;
      
      public function MainFactory()
      {
         super();
      }
      
      public function startLoadingLibrary(param1:String) : void
      {
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.mainLoaded);
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onMainProgress);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.load(new URLRequest(param1));
         dispatchEvent(new Event(MainFactory.MAIN_LOADING_PROGRESS));
      }
      
      private function onMainProgress(param1:ProgressEvent) : void
      {
         var _loc2_:* = param1.bytesTotal;
         if(_loc2_ == 0)
         {
            _loc2_ = MAIN_BYTES;
         }
         this.mainPercent = param1.bytesLoaded / _loc2_ * 100;
         this.mainBytes = param1.bytesLoaded;
         dispatchEvent(new Event(MainFactory.MAIN_LOADING_PROGRESS));
      }
      
      private function onComplete(param1:Event) : void
      {
         this._loader = new Loader();
         this._loader.loadBytes(param1.target.data);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.mainLoaded);
      }
      
      public function getCCMain() : *
      {
         this._ccMain = this._loader.content.root;
         return this._ccMain;
      }
      
      private function onError(param1:Event) : void
      {
         Console.println("Mainfactory " + param1.toString());
         this.removeListeners();
      }
      
      private function removeListeners() : void
      {
         if(this._loader)
         {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
      }
      
      private function mainLoaded(param1:Event) : void
      {
         this.removeListeners();
         dispatchEvent(new Event(MainFactory.MAIN_LOADING_COMPLETE));
      }
   }
}

