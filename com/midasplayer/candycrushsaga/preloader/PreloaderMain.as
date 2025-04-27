package com.midasplayer.candycrushsaga.preloader
{
   import com.adobe.serialization.json.*;
   import com.king.platform.client.*;
   import com.king.platform.rpc.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.game.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.console.*;
   import com.midasplayer.debug.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.system.*;
   import flash.utils.*;
   
   public class PreloaderMain extends MovieClip implements IAssertHandler
   {
      private var _mainFactory:MainFactory;
      
      private var _ccMain:Object;
      
      private var _preLoaderBG:MovieClip;
      
      private var _loaderParams:Object;
      
      private var languageMap:Object;
      
      private var gameAssetBytes_tot:int = 6200000;
      
      private var worldClassBytes_tot:int = 106000;
      
      private var worldAssetBytes_tot:int = 1030000;
      
      private var mainBytes_tot:int = 5000000;
      
      private var cutsceneAssetBytes_tot:int = 296000;
      
      private var gameAssetBytes_done:int = 0;
      
      private var worldClassBytes_done:int = 0;
      
      private var worldAssetBytes_done:int = 0;
      
      private var mainBytes_done:int = 0;
      
      private var cutsceneAssetBytes_done:int = 0;
      
      private var isFirst:Boolean = true;
      
      private var show100callback:Function;
      
      private var percent100timer:Timer;
      
      private var _reportedAsserts:int = 0;
      
      public function PreloaderMain()
      {
         super();
         if(!stage)
         {
            this.addEventListener(Event.ADDED_TO_STAGE,this.onStage);
         }
         else
         {
            this.init();
         }
      }
      
      private function onStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onStage);
         this.init();
      }
      
      private function init() : void
      {
         this.setUpPreloaderGFX();
         this.realInit();
      }
      
      private function realInit() : void
      {
         var jsonDecoder:JSONDecoder = null;
         var swfUrls:Object = null;
         var mainFileKey:String = null;
         var bugReportUrl:String = null;
         var mainFileUrl:String = null;
         this._loaderParams = this.root.loaderInfo.parameters;
         new GameConsole(stage,CCConstants.STAGE_WIDTH,CCConstants.STAGE_HEIGHT,this._loaderParams.apiUrl == null || String(this._loaderParams.apiUrl).search("dev.midasplayer.") > -1 || String(this._loaderParams.apiUrl).search("candycrushqa.midasplayer.com") > -1,this._onConsoleToggle);
         if(this._loaderParams["texts"])
         {
            this.setupPreLanguage(new JSONDecoder(this._loaderParams["texts"].replace(/#/g,"\""),false));
         }
         Debug.setAssertHandler(this);
         if(this._loaderParams.apiUrl != null && String(this._loaderParams.apiUrl).search("candycrush.king.com") > -1)
         {
         }
         stage.showDefaultContextMenu = false;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         if(this._loaderParams["episode"] != null && this._loaderParams["level"] != null)
         {
            if(this._loaderParams["episode"] == 1 && this._loaderParams["level"] == 1)
            {
               this.setFirstTime(true);
            }
            else
            {
               this.setFirstTime(false);
            }
         }
         if(this._loaderParams["swfUrls"])
         {
            try
            {
               jsonDecoder = new JSONDecoder(this._loaderParams["swfUrls"].replace(/#/g,"\""),false);
               swfUrls = jsonDecoder.getValue();
            }
            catch(e:Error)
            {
               Console.println("Error parsing swf urls: " + e);
            }
            mainFileKey = "/swf/CCMain.swf";
            Debug.assert(swfUrls[mainFileKey] == null,"Trying to use a swf url that doesn\'t exist: \"" + swfUrls[mainFileKey] + "\"");
            if(swfUrls[mainFileKey])
            {
               mainFileUrl = swfUrls[mainFileKey];
            }
            else
            {
               mainFileUrl = swfUrls[mainFileKey];
            }
         }
         else
         {
            mainFileUrl = "CCMain.swf";
         }
         this.startLoadingMain(mainFileUrl);
      }
      
      private function setupPreLanguage(param1:JSONDecoder) : void
      {
         this.languageMap = param1.getValue();
      }
      
      private function getPreText(param1:String) : String
      {
         if(this.languageMap)
         {
            return this.languageMap[param1];
         }
         return param1;
      }
      
      private function setUpPreloaderGFX() : void
      {
         this._preLoaderBG = new PreLoaderBG();
         this.addChild(this._preLoaderBG);
      }
      
      private function startLoadingMain(param1:String) : void
      {
         this._preLoaderBG.loadingProgress.text = this.getPreText("preloader_loading_part1_message");
         this._preLoaderBG.loadingHeader.text = this.getPreText("preloader_loading_header");
         this._mainFactory = new MainFactory();
         this._mainFactory.addEventListener(MainFactory.MAIN_LOADING_PROGRESS,this.mainProgress);
         this._mainFactory.addEventListener(MainFactory.MAIN_LOADING_COMPLETE,this.initiateCCMain);
         this._mainFactory.startLoadingLibrary(param1);
         TextUtil.scaleToFit(this._preLoaderBG.loadingProgress);
         TextUtil.scaleToFit(this._preLoaderBG.loadingHeader);
      }
      
      private function mainProgress(param1:Event) : void
      {
         this.updateBytesLoaded(CCConstants.MAIN_CLASS,this._mainFactory.mainBytes);
      }
      
      private function initiateCCMain(param1:Event) : void
      {
         this._preLoaderBG.loadingProgress.text = this.getPreText("preloader_loading_part2_message");
         TextUtil.scaleToFit(this._preLoaderBG.loadingProgress);
         this._ccMain = this._mainFactory.getCCMain();
         this.addChild(this._ccMain as DisplayObject);
         this._ccMain.init(this);
         this._ccMain.addEventListener(CCConstants.EVENT_HIDE_PRELOADER_SCREEN,this.cleanUp);
      }
      
      public function startingAssetLoad(param1:String) : void
      {
         if(!this._preLoaderBG)
         {
            return;
         }
         switch(param1)
         {
            // TODO: figure out the order of loading
            case "gameAssets":
               this._preLoaderBG.loadingProgress.text = this.getPreText("preloader_loading_part6_message");
               break;
            case "worldClasses":
               this._preLoaderBG.loadingProgress.text = this.getPreText("preloader_loading_part3_message");
               break;
            case "worldAssets":
               this._preLoaderBG.loadingProgress.text = this.getPreText("preloader_loading_part4_message");
               break;
            case "worldAssetsComplete":
               this._preLoaderBG.loadingProgress.text = this.getPreText("preloader_loading_part5_message");
               break;
            case "cutsceneAsset":
               this._preLoaderBG.loadingProgress.text = ""; // is this displayed in the preloader? 
               break;
            case "complete":
               this._preLoaderBG.loadingProgress.text = this.getPreText("preloader_loading_complete_header");
         }
         TextUtil.scaleToFit(this._preLoaderBG.loadingProgress);
      }
      
      public function setFirstTime(param1:Boolean) : void
      {
         this.isFirst = param1;
      }
      
      public function updateBytesLoaded(param1:String, param2:int, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         switch(param1)
         {
            case CCConstants.MAIN_CLASS:
               this.mainBytes_done = param2;
               break;
            case CCConstants.GAME_CLASS:
               this.gameAssetBytes_done = param2;
               break;
            case CCConstants.WORLD_CLASS:
               this.worldClassBytes_done = param2;
               break;
            case CCConstants.WORLD_ASSETS:
               this.worldAssetBytes_done = param2;
               break;
            case CCConstants.CUTSCENE:
               this.cutsceneAssetBytes_done = param2;
         }
         if(this.isFirst)
         {
            _loc4_ = this.mainBytes_tot + this.gameAssetBytes_tot + this.cutsceneAssetBytes_tot;
            _loc5_ = this.mainBytes_done + this.gameAssetBytes_done + this.cutsceneAssetBytes_done;
         }
         else
         {
            _loc4_ = this.mainBytes_tot + this.worldAssetBytes_tot + this.worldClassBytes_tot;
            _loc5_ = this.mainBytes_done + this.worldAssetBytes_done + this.worldClassBytes_done;
         }
         var _loc6_:* = "] [game=" + this.gameAssetBytes_done + "/" + this.gameAssetBytes_tot;
         var _loc7_:* = "] [cutsc.=" + this.cutsceneAssetBytes_done + "/" + this.cutsceneAssetBytes_tot;
         var _loc8_:* = "] [main=" + this.mainBytes_done + "/" + this.mainBytes_tot;
         var _loc9_:* = "] [worldC=" + this.worldClassBytes_done + "/" + this.worldClassBytes_tot;
         var _loc10_:* = "] [worldAss=" + this.worldAssetBytes_done + "/" + this.worldAssetBytes_tot;
         var _loc11_:* = 100 * _loc5_ / _loc4_;
         this.drawPercent(_loc11_);
      }
      
      private function drawPercent(param1:Number) : void
      {
         param1 *= 0.7;
         param1 += 32;
         param1 = Math.min(param1,100);
         if(!this._preLoaderBG)
         {
            return;
         }
         var _loc2_:* = int(param1);
         var _loc3_:* = _loc2_.toString();
         this._preLoaderBG.tPercent.text = _loc2_ + " %";
         this._preLoaderBG.animBar.progressMask.scaleX = param1 / 100;
         TextUtil.scaleToFit(this._preLoaderBG.tPercent);
      }
      
      public function percent100hook(param1:Function) : void
      {
         this.show100callback = param1;
         this.startingAssetLoad("complete");
         this.percent100timer = new Timer(500,1);
         this.percent100timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerComplete);
         this.percent100timer.start();
      }
      
      private function timerComplete(param1:TimerEvent) : void
      {
         this.percent100timer.stop();
         this.percent100timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.timerComplete);
         this.percent100timer = null;
         this.show100callback();
      }
      
      public function updatePercent(param1:Number) : void
      {
      }
      
      private function cleanUp(param1:Event) : void
      {
         this._preLoaderBG.parent.removeChild(this._preLoaderBG);
         this._preLoaderBG = null;
      }
      
      private function _onConsoleToggle(param1:Boolean) : void
      {
         if(this._ccMain)
         {
            if(param1)
            {
               this._ccMain.notifyConsoleActivation();
            }
            else
            {
               this._ccMain.notifyConsoleDeactivation();
            }
         }
      }
      
      public function assert(param1:String) : void
      {
         var _loc_3:*;
         var trail:String = null;
         var systemInfo:String = null;
         var devMsg:String = null;
         var rpcService:RpcService = null;
         var clientHealthTracking:ClientHealthTracking = null;
         var stackTrace:String = null;
         var message:* = param1;
         if(Capabilities.isDebugger)
         {
            stackTrace = Debug.formatStackTrace(new Error().getStackTrace());
            Console.println("Assertion failed" + (!!message ? ": " + message : "") + (stackTrace.length > 0 ? "\n" + stackTrace : ""),"assert",16742263);
         }
         _loc_3 = this;
         _loc_3._reportedAsserts = this._reportedAsserts + 1;
         if(this._loaderParams.platformUrl != null && this._reportedAsserts++ < 5)
         {
            trail = TrackingTrail.getTrail();
            systemInfo = "OS:" + Capabilities.os + " FP:" + Capabilities.version;
            devMsg = "(" + Constants.VERSION + ") " + systemInfo + "\n" + (message != null ? message : "") + "\n" + stackTrace + "\n" + trail;
            rpcService = new RemoteRpcService(this._loaderParams.platformUrl,this._loaderParams.sessionKey);
            clientHealthTracking = new ClientHealthTracking(rpcService);
            clientHealthTracking.clientException2(1,devMsg,function():void
            {
            },function():void
            {
            });
         }
      }
   }
}

