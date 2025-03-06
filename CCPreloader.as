package
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.king.platform.client.ClientHealthTracking;
   import com.king.platform.rpc.RemoteRpcService;
   import com.king.platform.rpc.SessionKeyProvider;
   import com.king.saga.api.net.IApplicationErrorHandler;
   import com.king.saga.api.tracking.GuiTracker;
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import com.midasplayer.candycrushsaga.ccshared.CCDebug;
   import com.midasplayer.candycrushsaga.ccshared.Console;
   import com.midasplayer.candycrushsaga.ccshared.DummyConsole;
   import com.midasplayer.candycrushsaga.ccshared.IFunnelTracker;
   import com.midasplayer.candycrushsaga.ccshared.LoaderParams;
   import com.midasplayer.candycrushsaga.ccshared.RemoteAssert;
   import com.midasplayer.candycrushsaga.ccshared.assetloader.ILoadingStatus;
   import com.midasplayer.candycrushsaga.ccshared.debugrender.DebugRender;
   import com.midasplayer.candycrushsaga.ccshared.tracking.TrackingConstants;
   import com.midasplayer.candycrushsaga.ccshared.utils.CCTimeouter;
   import com.midasplayer.candycrushsaga.ccshared.utils.CCTimeouterFactory;
   import com.midasplayer.candycrushsaga.ccshared.utils.CandyCrushGameConsole;
   import com.midasplayer.candycrushsaga.ccshared.utils.typeddictionaries.DictionaryStringString;
   import com.midasplayer.candycrushsaga.main.IConsoleActivationListener;
   import com.midasplayer.debug.Debug;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   public class CCPreloader extends MovieClip implements IApplicationErrorHandler, ILoadingStatus, IFunnelTracker
   {
      private static const _SPLASH_FRAME_RATE:Number = 30;
      
      private static const _SPLASH_QUOTA_BEFORE_GAME_LOAD:Number = 0.7;
      
      private var _splash:MovieClip;
      
      private var _splashFramesPerStageFrame:Number;
      
      private var _stageFrames:Number = 0;
      
      private var _ccMain:MovieClip;
      
      private var _mainLoader:Loader;
      
      private var _mainLoaderTimeouter:CCTimeouter;
      
      private var _mainLoadedBytes:int = 0;
      
      private var _mainTotalBytes:int = 0;
      
      private var _totalBytes:int = 0;
      
      private var _loadedBytes:int = 0;
      
      private var _currentPercentLoaded:int = 0;
      
      private var _preLoaderBG:MovieClip;
      
      private var _loaderParams:Object;
      
      private var _mainTotalBytesHaveBeenReported:Boolean = false;
      
      private var _show100callback:Function;
      
      private var _percent100timer:Timer;
      
      private var _isInited:Boolean;
      
      private var _guiTracker:GuiTracker;
      
      private var _mainFileUrl:String;
      
      private var _lastHttpStatus:int;
      
      private var _tries:int;
      
      private var _remoteAssert:RemoteAssert;
      
      public function CCPreloader()
      {
         super();
         if(stage)
         {
            this._onStage();
         }
         else
         {
            this.addEventListener(Event.ADDED_TO_STAGE,this._onStage);
         }
      }
      
      public static function decode(param1:String) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeShort(param1.charCodeAt(_loc3_));
            _loc3_++;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function encode(param1:ByteArray) : String
      {
         var _loc2_:uint = param1.position;
         var _loc3_:Array = new Array();
         param1.position = 0;
         while(param1.position < param1.length - 1)
         {
            _loc3_.push(param1.readShort());
         }
         if(param1.position != param1.length)
         {
            _loc3_.push(param1.readByte() << 8);
         }
         param1.position = _loc2_;
         return String.fromCharCode.apply(null,_loc3_);
      }
      
      private function _onStage(param1:Event = null) : void
      {
         this._loaderParams = this.root.loaderInfo.parameters;
         CCTimeouterFactory.useLoaderTimeoutSeconds(60 * 2);
         this._trackFlashLoaded();
         this._setupStage();
         if(param1 != null)
         {
            this.removeEventListener(Event.ADDED_TO_STAGE,this._onStage);
         }
         this._showSplash();
      }
      
      private function _trackFlashLoaded() : void
      {
         this._guiTracker = new GuiTracker(this._loaderParams.trackingUrl,this._loaderParams.sessionKey,this);
         this.customFunnel(TrackingConstants.FLASH_LOADED);
      }
      
      public function customFunnel(param1:String) : void
      {
         this._guiTracker.CustomFunnel(this._loaderParams.fName,param1,this._loaderParams.fId);
      }
      
      private function _setupStage() : void
      {
         stage.showDefaultContextMenu = false;
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         stage.align = StageAlign.TOP_LEFT;
      }
      
      private function _showSplash() : void
      {
         this._splash = new GA_splash();
         this._splash.stop();
         parent.addChild(this._splash);
         this._splashFramesPerStageFrame = _SPLASH_FRAME_RATE / stage.frameRate;
         addEventListener(Event.ENTER_FRAME,this._splashAnimator);
      }
      
      private function _splashAnimator(param1:Event) : void
      {
         this._stageFrames += 1;
         var _loc2_:int = this._stageFrames * this._splashFramesPerStageFrame;
         this._splash.gotoAndStop(_loc2_);
         if(!this._isInited && _loc2_ > this._splash.totalFrames * _SPLASH_QUOTA_BEFORE_GAME_LOAD)
         {
            this._isInited = true;
            this._init();
         }
         if(_loc2_ === this._splash.totalFrames)
         {
            this._removeSplash();
         }
      }
      
      private function _removeSplash() : void
      {
         removeEventListener(Event.ENTER_FRAME,this._splashAnimator);
         parent.removeChild(this._splash);
      }
      
      private function _setUpPreloaderGFX() : void
      {
         this._preLoaderBG = new PreLoaderBG();
         this.addChildAt(this._preLoaderBG,0);
         this._preLoaderBG.animBar.progressMask.scaleX = 0;
      }
      
      public function startingAssetLoad(param1:String) : void
      {
         // i assume this was some sort of tracking stuff so eh
      }
      
      public function setFirstTime(param1:Boolean) : void
      {
         // uhh idk
      }
      
      private function _println(param1:String) : void
      {
         Console.println("Preloader: " + param1,"Preloader",16777215);
      }
      
      private function _getPreText(param1:String) : String
      {
         var key:String = param1;
         var texts:Object = this._loaderParams.texts;
         var cleanedJson:String = null;
         var jsonDecoder:JSONDecoder = null;
         var jsonObject:Object = null;
         var valueByKey:String = key;
         if(texts)
         {
            try
            {
               cleanedJson = texts.replace(/#/g,"\"");
               jsonDecoder = new JSONDecoder(cleanedJson,false);
               jsonObject = jsonDecoder.getValue();
               valueByKey = jsonObject[key];
            }
            catch(e:Error)
            {
               Debug.assert(false,e.message);
            }
         }
         return valueByKey;
      }
      
      private function _startLoadingMain() : void
      {
         this._mainLoader = new Loader();
         this._mainLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.clientHealthLoggingUncaughtErrorEventListener("_mainLoader.uncaughtErrorEvents",this._remoteAssert));
         this._mainLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this._initiateCCMain);
         this._mainLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this._onMainError);
         this._mainLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this._onMainProgress);
         this._mainLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         this._mainLoader.load(new URLRequest(this._mainFileUrl));
         this._mainLoaderTimeouter = CCTimeouterFactory.getInstance().newLoaderTimeouter();
         this._mainLoaderTimeouter.start(this._onMainTimeout);
      }
      
      private function onHttpStatus(param1:HTTPStatusEvent) : void
      {
         this._lastHttpStatus = param1.status;
         if(this._lastHttpStatus != 200)
         {
            Console.println("MainLoader httpStatus: " + param1.status);
         }
      }
      
      private function _onMainProgress(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this._mainLoaderTimeouter.extendTimeout();
         if(!this._mainTotalBytesHaveBeenReported)
         {
            _loc4_ = int(param1.target.bytesTotal);
            if(_loc4_ == 0)
            {
               _loc4_ = CCConstants.MAIN_TOTAL_BYTES;
            }
            _loc5_ = _loc4_ - CCConstants.MAIN_TOTAL_BYTES;
            this.correctTotalBytes(_loc5_);
            this._mainTotalBytes = _loc4_;
            this._mainTotalBytesHaveBeenReported = true;
         }
         var _loc2_:int = int(param1.target.bytesLoaded);
         var _loc3_:int = _loc2_ - this._mainLoadedBytes;
         this.updateBytesLoaded(null, _loc3_);
         this._mainLoadedBytes = _loc2_;
      }
      
      private function retry() : Boolean
      {
         if(--this._tries > 0 && this._lastHttpStatus != 404)
         {
            Console.println("Retrying LoadingMain in 1 sec");
            setTimeout(this._startLoadingMain,CCConstants.NET_LOADING_RETRY_DELAY);
            return true;
         }
         return false;
      }
      
      private function _onMainTimeout() : void
      {
         if(this._mainLoader != null)
         {
            this._onMainError(new Event("timeout"));
         }
      }
      
      private function _onMainError(param1:Event) : void
      {
         this.removeLoaderListeners();
         this._mainLoader.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.clientHealthLoggingUncaughtErrorEventListener("_mainLoader.uncaughtErrorEvents",this._remoteAssert));
         if(this.retry())
         {
            return;
         }
         Debug.assert(false,"ERROR e:" + param1.toString() + " CCPreloader.as _onMainError | path: " + this._mainFileUrl + " | httpStatus: " + this._lastHttpStatus + " | finalUrl: " + this._mainLoader.contentLoaderInfo.url + " | bytesLoaded: " + this._mainLoader.contentLoaderInfo.bytesLoaded + "/" + this._mainLoader.contentLoaderInfo.bytesTotal);
      }
      
      private function removeLoaderListeners() : void
      {
         this._mainLoaderTimeouter.stop();
         this._mainLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this._initiateCCMain);
         this._mainLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this._onMainError);
         this._mainLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this._onMainProgress);
         this._mainLoader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
      }
      
      private function _initiateCCMain(param1:Event) : void
      {
         this._println("loading done ... initiate CCMain");
         this.removeLoaderListeners();
         this._ccMain = this._mainLoader.content.root as MovieClip;
         this._mainLoader = null;
         this.addChildAt(this._ccMain,0);
         this._ccMain.init(this._loaderParams,this);
         this._ccMain.addEventListener(CCConstants.EVENT_HIDE_PRELOADER_SCREEN,this._cleanUp);
      }
      
      public function setTotalBytesForNewPlayer() : void
      {
         this._totalBytes = CCConstants.TOTAL_BYTES_NEW_PLAYER;
         if(this._mainTotalBytes != 0)
         {
            this._totalBytes -= CCConstants.MAIN_TOTAL_BYTES;
            this._totalBytes += this._mainTotalBytes;
         }
      }
      
      private function _updateLoadingInfo(param1:Event) : void
      {
         if(!this._preLoaderBG)
         {
            return;
         }
         this._updatePercentsLoaded();
         this._updateProgressVisually();
      }
      
      private function _updatePercentsLoaded() : void
      {
         var _loc1_:int = int(this._totalBytes / 1000) * 1000;
         var _loc2_:Number = this._loadedBytes / _loc1_ * 100;
         if(_loc2_ > this._currentPercentLoaded)
         {
            this._currentPercentLoaded = _loc2_;
         }
      }
      
      public function correctTotalBytes(param1:int) : void
      {
         this._totalBytes += param1;
      }
      
      public function updateBytesLoaded(param1:String, param2:int, param3:int = 0) : void
      {
         this._loadedBytes += param2;
         this._totalBytes += param3;
      }
      
      private function _updateProgressVisually() : void
      {
         this._updateLoadingText();
         var _loc1_:int = Math.min(int(this._currentPercentLoaded),100);
         if(this._preLoaderBG != null)
         {
            this._preLoaderBG.tPercent.text = _loc1_ + " %";
            this._preLoaderBG.animBar.progressMask.scaleX = _loc1_ / 100;
         }
      }
      
      private function _updateLoadingText() : void
      {
         var _loc1_:String = null;
         if(this._currentPercentLoaded >= 100)
         {
            _loc1_ = this._getPreText("preloader_loading_complete_header");
         }
         else if(this._currentPercentLoaded > 83)
         {
            _loc1_ = this._getPreText("preloader_loading_part6_message");
         }
         else if(this._currentPercentLoaded > 66)
         {
            _loc1_ = this._getPreText("preloader_loading_part5_message");
         }
         else if(this._currentPercentLoaded > 50)
         {
            _loc1_ = this._getPreText("preloader_loading_part4_message");
         }
         else if(this._currentPercentLoaded > 33)
         {
            _loc1_ = this._getPreText("preloader_loading_part3_message");
         }
         else if(this._currentPercentLoaded > 16)
         {
            _loc1_ = this._getPreText("preloader_loading_part2_message");
         }
         else
         {
            _loc1_ = this._getPreText("preloader_loading_part1_message");
         }
         if(this._preLoaderBG.loadingProgress.text == _loc1_)
         {
            return;
         }
         this._preLoaderBG.loadingProgress.text = _loc1_;
         this._println(_loc1_);
      }
      
      public function percent100hook(param1:Function) : void
      {
         this._show100callback = param1;
         this._percent100timer = new Timer(500,1);
         this._percent100timer.addEventListener(TimerEvent.TIMER_COMPLETE,this._timerComplete);
         this._percent100timer.start();
      }
      
      private function _timerComplete(param1:TimerEvent) : void
      {
         this._percent100timer.stop();
         this._percent100timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this._timerComplete);
         this._percent100timer = null;
         this._show100callback();
      }
      
      private function _onConsoleToggle(param1:Boolean) : void
      {
         /*var _loc2_:IConsoleActivationListener = IConsoleActivationListener(this._ccMain);
         if(_loc2_)
         {
            if(param1)
            {
               _loc2_.onConsoleActivation();
            }
            else
            {
               _loc2_.onConsoleDeactivation();
            }
         }*/
      }
      
      private function _cleanUp(param1:Event) : void
      {
         this._ccMain.removeEventListener(CCConstants.EVENT_HIDE_PRELOADER_SCREEN,this._cleanUp);
         this.removeEventListener(Event.ENTER_FRAME,this._updateLoadingInfo);
         this.customFunnel(TrackingConstants.APP_LOADED);
         this._preLoaderBG.parent.removeChild(this._preLoaderBG);
         this._preLoaderBG = null;
      }
      
      private function _init() : void
      {
         var debugMode:Boolean;
         var clientHealthTracking:ClientHealthTracking;
         var sessionKeyProvider:SessionKeyProvider = null;
         var remoteRpcService:RemoteRpcService = null;
         
         var valueByKey:String = null;
         var mainFileKey:String = null;
         var cleanedJson:String = null;
         var jsonDecoder:JSONDecoder = null;
         var jsonObject:Object = null;
         
         this._tries = CCConstants.NET_LOADING_TRIES;
         this._totalBytes = CCConstants.TOTAL_BYTES_DEFAULT;
         debugMode = CCDebug.isDebugMode(this._loaderParams.debugMode,this._loaderParams.apiUrl);
         if(debugMode && Console is DummyConsole)
         {
            Console = new CandyCrushGameConsole(stage,CCConstants.STAGE_WIDTH,CCConstants.STAGE_HEIGHT,true,this._onConsoleToggle);
         }
         DebugRender.init(stage);
         sessionKeyProvider = new SessionKeyProvider(this._loaderParams.sessionKey);
         remoteRpcService = new RemoteRpcService(this._loaderParams.platformUrl,sessionKeyProvider);
         clientHealthTracking = new ClientHealthTracking(remoteRpcService);
         this._remoteAssert = new RemoteAssert(clientHealthTracking);
         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.clientHealthLoggingUncaughtErrorEventListener("PreLoaderMain.loaderInfo.uncaughtErrorEvents",this._remoteAssert));
         Debug.setAssertHandler(this._remoteAssert);
         this._mainFileUrl = "CCMain.swf";
         if(this._loaderParams.swfUrls)
         {
            mainFileKey = "/swf/CCMain.swf";
            valueByKey = null;
            try
            {
               cleanedJson = this._loaderParams.swfUrls.replace(/#/g,"\"");
               jsonDecoder = new JSONDecoder(cleanedJson,false);
               jsonObject = jsonDecoder.getValue();
               valueByKey = jsonObject[mainFileKey];
            }
            catch(e:Error)
            {
               Debug.assert(valueByKey != null,"Trying to use a swf url that doesn\'t exist: \"" + mainFileKey + "\"");
            }
            this._mainFileUrl = valueByKey;
         }
         this.addEventListener(Event.ENTER_FRAME,this._updateLoadingInfo);
         this._setUpPreloaderGFX();
         this._startLoadingMain();
      }
      
      private function clientHealthLoggingUncaughtErrorEventListener(param1:String, param2:RemoteAssert) : Function
      {
         var eventSourceName:String = param1;
         var remoteAssert:RemoteAssert = param2;
         if(!this._loaderParams.logUncaughtClientErrors)
         {
            return function(param1:UncaughtErrorEvent):void
            {
            };
         }
         return function(param1:UncaughtErrorEvent):void
         {
            var _loc2_:* = undefined;
            if(param1.error is Error)
            {
               _loc2_ = param1.error.getStackTrace();
               if(_loc2_ == null)
               {
                  _loc2_ = "no stacktrace: " + param1.error.toString();
               }
            }
            else if(param1.error is ErrorEvent)
            {
               _loc2_ = param1.error.text;
            }
            else
            {
               _loc2_ = param1.error.toString();
            }
            remoteAssert.assert(eventSourceName + " " + _loc2_ + "\n ---");
            param1.stopPropagation();
         };
      }
      
      public function onNetError(param1:IOErrorEvent, param2:String) : void
      {
         Debug.assert(false,param2);
      }
      
      public function onError(param1:Error, param2:String) : void
      {
      }
   }
}

