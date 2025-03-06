package
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.adobe.serialization.json.*;
   import com.demonsters.debugger.*;
   import com.king.saga.api.crafting.*;
   import com.king.saga.api.event.*;
   import com.king.saga.api.product.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.bug.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.api.*;
   import com.midasplayer.candycrushsaga.ccshared.event.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   import com.midasplayer.candycrushsaga.charms.*;
   import com.midasplayer.candycrushsaga.charms.api.*;
   import com.midasplayer.candycrushsaga.collaboration.*;
   import com.midasplayer.candycrushsaga.cutscene.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.AssetFactory;
   import com.midasplayer.candycrushsaga.main.CCQueueHandler;
   import com.midasplayer.candycrushsaga.main.GameEventHandler;
   import com.midasplayer.candycrushsaga.main.GameFactory;
   import com.midasplayer.candycrushsaga.main.LevelMiniatures;
   import com.midasplayer.candycrushsaga.main.UserPicLoader;
   import com.midasplayer.candycrushsaga.main.WorldFactory;
   import com.midasplayer.candycrushsaga.popup.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.candycrushsaga.topnav.*;
   import com.midasplayer.candycrushsaga.tutorial.*;
   import com.midasplayer.candycrushsaga.world.*;
   import com.midasplayer.console.*;
   import com.midasplayer.debug.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.geom.*;
   import flash.utils.*;
   import main.*;
   
   [SWF(width="755",height="650",frameRate="24",backgroundColor="#FFFFFF")]
   public class CCMain extends MovieClip implements IConsoleCommandProcessor, IBugDataInformer, IAssertHandler
   {
      private static var _instance:CCMain;
      
      public static var mcDisplayBase:MovieClip = new MovieClip();
      public static var mcDisplayPopup:MovieClip = new MovieClip();
      public static var mcDisplayTutorial:MovieClip = new MovieClip();
      public static var mcDisplayTopNav:MovieClip = new MovieClip();
      public static var mcDisplayTooltips:MovieClip = new MovieClip();
      
      private static var unhandledErrors:Array = [];
      
      private var dummy_1:IWorldCommandHandler;
      
      private var _ccModel:CCModel;
      
      private var _userPicLoader:UserPicLoader;
      
      private var _levelMiniatures:LevelMiniatures;
      
      private var _hourGlass:HourGlass;
      
      private var _ccQueueHandler:CCQueueHandler;
      
      private var _topNavMediator:TopNavMediator;
      
      private var _cutsceneHandler:CutsceneHandler;
      
      private var _gameFactory:GameFactory;
      
      private var _inventory:Inventory;
      
      private var _tutorialHandler:TutorialHandler;
      
      private var _toolTipHandler:TooltipHandler;
      
      public var _worldFactory:WorldFactory;
      
      private var _world:Object;
      
      private var _game:IGameComm;
      
      private var _loaderParams:Object;
      
      private var _swfUrls:Object;
      private var _swfUrlsFinal:Object = null;
      
      private var _imagesUrlMap:Object;
      
      private var _worldFileKey:String = "/swf/CCWorld.swf";
      private var _gameFileKey:String = "/swf/CandyCrushGame.swf";
      private var _gameModeAllFileKey:String = "/swf/assets/graphics_mode_all.swf";
      private var _gameModeClassicFileKey:String = "/swf/assets/graphics_mode_classic.swf";
      private var _gameModeClassicMovesFileKey:String = "/swf/assets/graphics_mode_classic_moves.swf";
      private var _gameModeLightupFileKey:String = "/swf/assets/graphics_mode_lightup.swf";
      private var _gameModeDropdownFileKey:String = "/swf/assets/graphics_mode_dropdown.swf";
      private var _girl_introduction:String = "/swf/assets/cutscenes/girl_introduction.swf";
      
      private var _isFan:Boolean = false;
      
      private var _preLoader:Object;
      private var _preloaderHidden:Boolean = false;
      
      private var _gameEventHandler:GameEventHandler;
      
      public var soundManager:CCSoundManager;
      public var musicManager:CCMusicManager;
      
      private var _failReason:String;
      
      private var videoAdTimer:Timer;
      
      private var _ccGameEndEvent:GameCommEvent;
      
      private var _bugReportForm:BugReportForm;
      private var _bugReportFormActivator:EastereggActivator;
      
      public function CCMain()
      {
         super();
         this._swfUrls = {"/swf/CCWorld.swf":"/swf/CCWorld.swf", "/swf/CandyCrushGame.swf":"/swf/CandyCrushGame.swf", "/swf/assets/graphics_mode_all.swf":"/swf/assets/graphics_mode_all.swf", "/swf/assets/graphics_mode_classic.swf":"/swf/assets/graphics_mode_classic.swf", "/swf/assets/graphics_mode_classic_moves.swf":"/swf/assets/graphics_mode_classic_moves.swf", "/swf/assets/graphics_mode_lightup.swf":"/swf/assets/graphics_mode_lightup.swf", "/swf/assets/graphics_mode_dropdown.swf":"/swf/assets/graphics_mode_dropdown.swf", "/swf/assets/cutscenes/girl_introduction.swf":"/swf/assets/cutscenes/girl_introduction.swf", "/swf/assets/cutscenes/girl_resolution.swf":"/swf/assets/cutscenes/girl_resolution.swf", "/swf/assets/cutscenes/robot_introduction.swf":"/swf/assets/cutscenes/robot_introduction.swf", "/swf/assets/cutscenes/robot_resolution.swf":"/swf/assets/cutscenes/robot_resolution.swf", "/swf/assets/cutscenes/bunny_resolution.swf":"/swf/assets/cutscenes/bunny_resolution.swf", "/swf/assets/cutscenes/bunny_introduction.swf":"/swf/assets/cutscenes/bunny_introduction.swf", "/swf/assets/cutscenes/unicorn_resolution.swf":"/swf/assets/cutscenes/unicorn_resolution.swf", "/swf/assets/cutscenes/unicorn_introduction.swf":"/swf/assets/cutscenes/unicorn_introduction.swf", "/swf/assets/cutscenes/space_resolution.swf":"/swf/assets/cutscenes/space_resolution.swf", "/swf/assets/cutscenes/space_introduction.swf":"/swf/assets/cutscenes/space_introduction.swf", "/swf/assets/cutscenes/yeti_resolution.swf":"/swf/assets/cutscenes/yeti_resolution.swf", "/swf/assets/cutscenes/yeti_introduction.swf":"/swf/assets/cutscenes/yeti_introduction.swf", "/swf/assets/cutscenes/dragon_introduction.swf":"/swf/assets/cutscenes/dragon_introduction.swf", "/swf/assets/cutscenes/dragon_resolution.swf":"/swf/assets/cutscenes/dragon_resolution.swf", "/swf/assets/cutscenes/troll_resolution.swf":"/swf/assets/cutscenes/troll_resolution.swf", "/swf/assets/cutscenes/troll_introduction.swf":"/swf/assets/cutscenes/troll_introduction.swf", "/swf/assets/cutscenes/sultan_introduction.swf":"/swf/assets/cutscenes/sultan_introduction.swf", "/swf/assets/cutscenes/sultan_resolution.swf":"/swf/assets/cutscenes/sultan_resolution.swf", "/swf/assets/WorldAssets.swf":"/swf/assets/WorldAssets.swf"};
         this._imagesUrlMap = null;
         MonsterDebugger.initialize(this);
         TrackingTrail.track("Main");
         if(Boolean(stage))
         {
            Debug.setAssertHandler(this);
            // this.parent is supposed to be stage, but 2018 CCMain says otherwise so idk...
            this.init(this.parent.loaderInfo.parameters);
            this.setupFeedback();
         }
         Console.registerProcessor("pop",this,"Trigger a popup manually.");
         Console.registerProcessor("tipster",this,"Watch levels and powerup recommendation values.");
         _instance = this;
      }
      
      public static function getInstance() : CCMain
      {
         return _instance;
      }
      
      public function get ccModel() : CCModel
      {
         return this._ccModel;
      }
      
      public function setLoaderParams(param1:Object) : void
      {
         var loaderParams:* = param1;
         this._loaderParams = loaderParams;
         
         // load swf urls
         var pt:* = new PrintTable(["url","key"],"Loaded swf urls.");
         var cleanedJson:String = null;
         var jsonDecoder:JSONDecoder = null;
         var jsonObject:Object = null;
         var json:String = this._loaderParams["swfUrls"];
         try
         {
            cleanedJson = json.replace(/#/g,"\"");
            jsonDecoder = new JSONDecoder(cleanedJson,false);
            jsonObject = jsonDecoder.getValue();
            this._swfUrlsFinal = jsonObject;
         }
         catch(e:Error)
         {
            Console.println("Error parsing swf urls: " + e);
         }
         
         // load images map
         cleanedJson = null;
         jsonDecoder = null;
         jsonObject = null;
         var imagesMapJson:Object = this._loaderParams["imagesMap"];
         try
         {
            cleanedJson = imagesMapJson.replace(/#/g,"\"");
            jsonDecoder = new JSONDecoder(cleanedJson,false);
            jsonObject = jsonDecoder.getValue();
            this._imagesUrlMap = jsonObject;
         }
         catch(e:Error)
         {
            Console.println("Error parsing images urls: " + e);
         }
         
         if(Boolean(this._loaderParams["fan"]))
         {
            this._isFan = this._loaderParams["fan"] == "true";
         }
      }
      
      public function setIsFan() : void
      {
         this._isFan = true;
      }
      
      public function getSwfUrl(param1:String) : String
      {
         Debug.assert(this._swfUrls[param1] != null,"Trying to use a swf url that doesn\'t exist: \"" + param1 + "\"");
         if(Boolean(this._swfUrlsFinal))
         {
            return this._swfUrlsFinal[this._swfUrls[param1]];
         }
         return this._swfUrls[param1];
      }
      
      public function init(flashvars:Object = null, preloader:Object = null) : void
      {
         this._preLoader = preloader;
         this.realStart(flashvars);
      }
      
      public function realStart(flashvars:Object) : void
      {
         this.setLoaderParams(flashvars);
         Console.println("Hello Charles! 7/6");
         TrackingTrail.track("Init");
         AssetFactory.setUrlDataFn(this.getSwfUrl);
         this._worldFactory = new WorldFactory(this);
         this._worldFactory.startLoadingWorldClass(this.getSwfUrl(this._worldFileKey));
         if(Boolean(this._preLoader))
         {
            this._preLoader.startingAssetLoad("worldClasses");
         }
         this.addEventListener(Event.ENTER_FRAME,this.checkWorldClassLoadingProgress);
         this._gameEventHandler = new GameEventHandler();
      }
      
      private function checkWorldClassLoadingProgress(event:Event) : void
      {
         var _loc_2:* = this._worldFactory.worldClassAvailable;
         if(_loc_2)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.checkWorldClassLoadingProgress);
            this.initAPI();
         }
         if(!this._preLoader)
         {
            return;
         }
         var _loc_3:* = 100 * this._worldFactory.bytesLoaded / this._worldFactory.bytesTotal;
         this._preLoader.updateBytesLoaded(CCConstants.WORLD_CLASS,this._worldFactory.bytesLoaded,this._worldFactory.bytesTotal);
      }
      
      private function initAPI() : void
      {
         this._ccModel = new CCModel(this,this._loaderParams);
         this._ccModel.addEventListener(CCModel.MISSION_ACCOMPLISHED,this.onMissionAccomplished);
         this._ccModel.addEventListener(CCModel.GAME_INIT,this.onGameInit);
      }
      
      private function onMissionAccomplished(event:ModelEvent) : void
      {
         var _loc_2:* = event.value as CCMissionData;
         this._ccQueueHandler.queueMissionAccomplishedPop(null,_loc_2);
      }
      
      private function onGameInit(event:Event) : void
      {
         var _loc_5:int = 0;
         var _loc_6:String = null;
         var _loc_2:* = this._ccModel.getCurrentUserTopEpisode();
         var _loc_3:* = this._ccModel.getCurrentUserTopLevel();
         TrackingTrail.track("onInit:" + _loc_2 + "|" + _loc_3);
         this._ccModel.removeEventListener(CCModel.GAME_INIT,this.onGameInit);
         this.addDisplayLayers();
         this.initiateDataMembers();
         var _loc_4:* = this._ccModel.getPlayerIsNew();
         if(this._ccModel.getPlayerIsNew())
         {
            _loc_5 = this._ccModel.getCurrentUser().getLives();
            if(_loc_5 <= 0)
            {
               this.queueNoMoreLivesPop();
               return;
            }
            _loc_6 = this._cutsceneHandler.getCutsceneStory(1);
            this._cutsceneHandler.addEventListener(CutsceneConstants.CUTSCENE_LOADED,this.onFirstCutsceneLoaded);
            this._cutsceneHandler.addEventListener(CutsceneConstants.CUTSCENE_PROGRESS,this.onCutsceneProgress);
            this._cutsceneHandler.loadCutscene(1,_loc_6,CutsceneConstants.CUTSCENE_TYPE_INTRODUCTION,false);
            if(Boolean(this._preLoader))
            {
               this._preLoader.setFirstTime(true);
            }
         }
         else
         {
            if(Boolean(this._preLoader))
            {
               this._preLoader.setFirstTime(false);
            }
            this._ccQueueHandler.queueCreateWorldWC(this.createWorld,this._worldFactory,WorldFactory.WORLD_ASSETS_READY_FOR_CREATION,this.getWorldCommandHandler);
         }
         this.startLoadingGame();
         if(!_loc_4)
         {
            if(CCModel.newEvents == false)
            {
               Console.println("CC Varning: set timeout and double check message, the response from Facebook is too slow.");
               setTimeout(this.doubleCheckMessages,3000);
            }
            else
            {
               this.handleGameInitMessages();
            }
         }
         this.createTopNav(this._isFan);
      }
      
      private function doubleCheckMessages() : void
      {
         this._ccModel.addEventListener(CCModel.RECEIVED_GET_MESSAGES,this.onDoubleCheckMessages);
         this._ccModel.getMessages();
      }
      
      private function onDoubleCheckMessages(event:Event) : void
      {
         this._ccModel.removeEventListener(CCModel.RECEIVED_GET_MESSAGES,this.onDoubleCheckMessages);
         this.handleGameInitMessages();
         this._topNavMediator.possibleLifeUpdate();
      }
      
      private function onCutsceneProgress(event:Event) : void
      {
         if(Boolean(this._preLoader))
         {
            this._preLoader.startingAssetLoad("cutsceneAsset");
         }
         if(Boolean(this._preLoader))
         {
            this._preLoader.updateBytesLoaded(CCConstants.CUTSCENE,this._cutsceneHandler.currentCutsceneBytesLoaded);
         }
      }
      
      private function onFirstCutsceneLoaded(event:Event) : void
      {
         this._cutsceneHandler.removeEventListener(CutsceneConstants.CUTSCENE_LOADED,this.onFirstCutsceneLoaded);
         this.startLoadingGame();
      }
      
      public function initiateVeryFirstGame() : void
      {
         this._ccQueueHandler.queuePlayCutscene(this._cutsceneHandler,mcDisplayBase,1,this._hourGlass,true);
         this._ccQueueHandler.queueWelcomePop(this.startVeryFirstGame,this.startVeryFirstGame,this._cutsceneHandler.addCutsceneSnapShot,this.hidePreloader);
      }
      
      private function addDisplayLayers() : void
      {
         this.addChild(mcDisplayBase);
         this.addChild(mcDisplayTopNav);
         this.addChild(mcDisplayPopup);
         this.addChild(mcDisplayTutorial);
         this.addChild(mcDisplayTooltips);
         mcDisplayBase.name = "_mcDisplayBase";
         mcDisplayTopNav.name = "_mcDisplayTopNav";
         mcDisplayPopup.name = "_mcDisplayPopup";
         mcDisplayTutorial.name = "_mcDisplayTutorial";
         mcDisplayTooltips.name = "_mcDisplayTooltips";
         mcDisplayTooltips.mouseEnabled = false;
         mcDisplayTooltips.mouseChildren = false;
      }
      
      private function initiateDataMembers() : void
      {
         this._userPicLoader = new UserPicLoader(this._ccModel.getUserProfiles());
         this._levelMiniatures = new LevelMiniatures(this._imagesUrlMap,this._ccModel.getNumberOfLevels);
         this._hourGlass = new HourGlass(this);
         this._ccQueueHandler = new CCQueueHandler(this);
         this._cutsceneHandler = new CutsceneHandler(mcDisplayBase,this.getSwfUrl);
         this._inventory = new Inventory(this._ccModel);
         this._tutorialHandler = new TutorialHandler(this._ccQueueHandler,this._ccModel,this);
         this._toolTipHandler = new TooltipHandler(mcDisplayTooltips,this.getTooltipClip);
         mcDisplayPopup.addChild(this._ccQueueHandler);
      }
      
      private function handleGameInitMessages() : void
      {
         Console.println("@ handleGameInitMessages() - CCMain.as");
         this.handleLifeGifts();
         this.handleEpisodeUnlocks();
         this.showNotificationCentral();
      }
      
      private function showNotificationCentral() : void
      {
         var _loc_2:Function = null;
         var _loc_1:* = this._ccModel.getAllHelpRequests();
         if(_loc_1.length > 0)
         {
            _loc_2 = this.getUserPicLoader().getBigUserPicById;
            this._ccQueueHandler.queueNotificationCentral(_loc_1,this._ccModel.getUserProfiles(),_loc_2,this._ccModel.sendAcceptLifeRequestTo,this._ccModel.sendAcceptUnlockRequestTo);
            this._ccModel.removeAllHelpRequests();
         }
      }
      
      private function handleEpisodeUnlocks() : void
      {
         var _loc_2:* = this._ccModel.getEpisodeUnlocked();
         var _loc_3:* = this.getUserPicLoader().getBigUserPicById;
         var _loc_6:* = this._ccModel.getLevelUnlockedData();
         if(_loc_2 > 1)
         {
            this._ccQueueHandler.queuePrepareRemoveGrayWC(_loc_2,this.getWorldCommandHandler);
            this._ccQueueHandler.queuePrepareTransportToEpisodeWC(_loc_2,this.getWorldCommandHandler);
            if(_loc_6 != null)
            {
               TrackingTrail.track("EpiUnl" + _loc_6.episodeId);
               this._ccQueueHandler.queuePrepareLevelUnlockedWC(_loc_6,this.getWorldCommandHandler);
               this._ccQueueHandler.queuePrepareMoveSelfPicWC(_loc_6,this.getWorldCommandHandler);
            }
         }
      }
      
      private function startLoadingGame() : void
      {
         TrackingTrail.track("LoadG");
         if(this._gameFactory != null)
         {
            return;
         }
         mcDisplayBase.y = CCConstants.TOPNAV_HEIGHT;
         if(Boolean(this._preLoader))
         {
            this._preLoader.startingAssetLoad("gameClasses");
         }
         this._gameFactory = new GameFactory(mcDisplayBase);
         this._gameFactory.addEventListener(GameFactory.LOADING_PROGRESS,this.onGameAssetsProgress);
         this._gameFactory.addEventListener(GameFactory.LOADING_COMPLETE,this.onGameAssetsComplete);
         this._gameFactory.startLoadingLibrary(this.getSwfUrl(this._gameFileKey));
         this._gameFactory.startLoadingLibrary(this.getSwfUrl(this._gameModeAllFileKey));
         this._gameFactory.startLoadingLibrary(this.getSwfUrl(this._gameModeClassicFileKey));
         this._gameFactory.startLoadingLibrary(this.getSwfUrl(this._gameModeClassicMovesFileKey));
         this._gameFactory.startLoadingLibrary(this.getSwfUrl(this._gameModeLightupFileKey));
         this._gameFactory.startLoadingLibrary(this.getSwfUrl(this._gameModeDropdownFileKey));
      }
      
      private function onGameAssetsComplete(event:Event) : void
      {
         TrackingTrail.track("GACmp");
         MonsterDebugger.trace(this,"game asset COMPLETE. percent=" + this._gameFactory.percentLoaded);
         this._gameFactory.removeEventListener(GameFactory.LOADING_PROGRESS,this.onGameAssetsProgress);
         this._gameFactory.removeEventListener(GameFactory.LOADING_COMPLETE,this.onGameAssetsComplete);
         var _loc_2:* = this._ccModel.getPlayerIsNew();
         if(_loc_2)
         {
            if(Boolean(this._preLoader))
            {
               this._preLoader.percent100hook(this.initiateVeryFirstGame);
            }
            else
            {
               this.initiateVeryFirstGame();
            }
         }
      }
      
      private function onGameAssetsProgress(event:Event) : void
      {
         if(Boolean(this._preLoader))
         {
            this._preLoader.startingAssetLoad("gameAssets");
         }
         if(Boolean(this._preLoader))
         {
            this._preLoader.updateBytesLoaded(CCConstants.GAME_CLASS,this._gameFactory.totalBytesLoaded);
         }
      }
      
      public function createWorld() : Boolean
      {
         if(Boolean(this._world))
         {
            return true;
         }
         TrackingTrail.track("CWorld");
         this._world = this._worldFactory.createWorld();
         mcDisplayBase.addChild(DisplayObject(this._world));
         this._world.addEventListener(WorldEvent.PLAY_LEVEL,this.initiatePlayLevel);
         this._world.addEventListener(WorldEvent.CLICK_COLLAB,this.showCollabPop);
         this._worldFactory.addEventListener(WorldFactory.WORLD_ASSETS_LOADING_COMPLETE,this.onAllWorldAssetsLoaded);
         this._worldFactory.addEventListener(WorldFactory.WORLD_ASSETS_PROGRESS,this.onWorldAssetsProgress);
         this._worldFactory.loadAssets();
         if(Boolean(this._preLoader))
         {
            this._preLoader.startingAssetLoad("worldAssets");
         }
         if(Boolean(this._topNavMediator))
         {
            this._topNavMediator.setGameMode(TopNavMediator.WORLD);
         }
         return false;
      }
      
      private function onWorldAssetsProgress(event:Event) : void
      {
         if(Boolean(this._preLoader))
         {
            this._preLoader.updateBytesLoaded(CCConstants.WORLD_ASSETS,this._worldFactory.assetBytes);
         }
      }
      
      public function onAllWorldAssetsLoaded(event:Event) : void
      {
         var _loc_4:Boolean = false;
         TrackingTrail.track("WAssetsLoaded");
         if(Boolean(this._preLoader))
         {
            this._preLoader.startingAssetLoad("worldAssetsComplete");
         }
         this._cutsceneHandler.removeCutsceneSnapShot();
         this._worldFactory.removeEventListener(WorldFactory.WORLD_ASSETS_LOADING_COMPLETE,this.onAllWorldAssetsLoaded);
         this._worldFactory.removeEventListener(WorldFactory.WORLD_ASSETS_PROGRESS,this.onWorldAssetsProgress);
         var _loc_2:* = this._ccModel.getCurrentUser().getUserId();
         this._world.setUserPicFactory(this._userPicLoader.getSmallUserPicById);
         this._world.setMiniaturePicFactory(this._levelMiniatures.getMiniature);
         var _loc_3:* = this._ccModel.getAllCollaborationHelpers();
         if(this._ccModel.getCurrentUserTopEpisode() == 1 && this._ccModel.getCurrentUserTopLevel() == 2)
         {
            _loc_4 = true;
         }
         var _loc_5:* = this._ccModel.getEpisodeUnlocked() != 0;
         this._world.start(_loc_2,this._ccModel.getUserUnivserse(),this._ccModel.getUniverseDescription(),this._ccModel.getUserProfiles(),_loc_3,this._ccModel.getGameModeName,this._gameEventHandler.lastPlayedEpisode,this._gameEventHandler.lastPlayedLevel,this._gameEventHandler.aLevelWasCompletedForTheFirstTime,_loc_4,_loc_5);
         this._world.setupCharms(this._ccModel,this._ccQueueHandler,this._inventory);
         this.musicManager.playMusicInLobby();
         if(!this._preloaderHidden)
         {
            this.hidePreloader();
         }
         this._inventory.correctMissedItemUnlocks();
         if(!this._gameFactory)
         {
            this.startLoadingGame();
         }
      }
      
      private function hidePreloader() : void
      {
         dispatchEvent(new Event(CCConstants.EVENT_HIDE_PRELOADER_SCREEN));
         this._preloaderHidden = true;
      }
      
      public function showCollabPop(event:WorldEvent = null, param2:int = 0) : void
      {
         var _loc_9:int = 0;
         var _loc_10:int = 0;
         if(event != null)
         {
            _loc_9 = event.episode_id;
            _loc_10 = event.level_id;
         }
         else
         {
            _loc_9 = param2;
            _loc_10 = 1;
         }
         var _loc_3:* = String(_loc_9 + ":" + _loc_10);
         var _loc_4:* = this._ccModel.getCollaborationHelpersByEpisode(_loc_9);
         var _loc_5:* = this.getUserPicLoader().getBigUserPicById;
         var _loc_7:int = 3;
         if(_loc_4 != null)
         {
            _loc_7 = 3 - _loc_4.length;
         }
         var _loc_8:* = this._ccModel.getCollaborationProductForOpenSlots(_loc_7);
         this._ccQueueHandler.queueCollaborationPanelPop(_loc_9,_loc_10,_loc_4,_loc_5,this.onAskForCollaborationHelp,this.onBuyCollaboration,_loc_3,_loc_8);
      }
      
      public function onBuyCollaboration(param1:int, param2:String) : void
      {
         TrackingTrail.track("BuyColl");
         this._ccModel.buyCollaborationProduct(param1,param2);
         this._ccModel.addEventListener(CCModel.COLLABORATION_PURCHASE_STATUS,this.onCollabPurchaseStatus);
      }
      
      private function onCollabPurchaseStatus(event:Event) : void
      {
         MonsterDebugger.trace(this,"onCollabPurchaseStatus");
         this._ccModel.removeEventListener(CCModel.COLLABORATION_PURCHASE_STATUS,this.onCollabPurchaseStatus);
         this._ccModel.addEventListener(CCModel.RECEIVED_GET_MESSAGES,this.onGetMessagesAfterCollabPurchase);
         this._ccModel.getMessages();
      }
      
      public function onGetMessagesAfterCollabPurchase(event:Event) : void
      {
         TrackingTrail.track("BuyCollGetMsg");
         this._ccModel.removeEventListener(CCModel.RECEIVED_GET_MESSAGES,this.onGetMessagesAfterCollabPurchase);
         this.handleEpisodeUnlocks();
      }
      
      public function onAskForCollaborationHelp(param1:String) : void
      {
         TrackingTrail.track("AskColl");
         this._ccModel.requestCollaborationHelp(param1);
      }
      
      public function onBuyLives() : void
      {
         TrackingTrail.track("BuyLives");
         this._ccModel.removeEventListener(CCModel.LIVES_UPDATED,this.onBoughtLives);
         this._ccModel.addEventListener(CCModel.LIVES_UPDATED,this.onBoughtLives);
         this._ccModel.buyFullLives();
      }
      
      private function onBoughtLives(event:ModelEvent) : void
      {
         var _loc_2:int = 0;
         TrackingTrail.track("BuyLivesEvt(" + event.value + ")");
         this._ccModel.removeEventListener(CCModel.LIVES_UPDATED,this.onBoughtLives);
         this._topNavMediator.possibleLifeUpdate();
         if(event.value == true)
         {
            _loc_2 = this._ccModel.getUserActiveEpisode();
            if(_loc_2 != 0)
            {
               this.initiatePlayLevel(null,false,true);
            }
         }
         else if(this._world == null)
         {
            this._ccQueueHandler.queueCreateWorldWC(this.createWorld,this._worldFactory,WorldFactory.WORLD_ASSETS_READY_FOR_CREATION,this.getWorldCommandHandler);
         }
      }
      
      public function onAskForLivesHelp() : void
      {
         TrackingTrail.track("AskLives");
         this._ccModel.askForLives();
      }
      
      private function updateActiveLevel(event:WorldEvent = null) : void
      {
         if(Boolean(event))
         {
            this._ccModel.setUserActiveEpisode(event.episode_id);
            this._ccModel.setUserActiveLevel(event.level_id);
         }
      }
      
      public function initiatePlayLevel(event:WorldEvent = null, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc_7:String = null;
         var _loc_8:Boolean = false;
         TrackingTrail.track("PlayL");
         var _loc_4:* = this._ccModel.getCurrentUser().getLives();
         if(!param3 && _loc_4 <= 0)
         {
            this.queueNoMoreLivesPop();
            return;
         }
         if(event != null)
         {
            this.updateActiveLevel(event);
         }
         var _loc_5:* = this._ccModel.getUserActiveEpisode();
         var _loc_6:* = this._ccModel.getUserActiveLevel();
         if(!param2)
         {
            _loc_7 = this._cutsceneHandler.getCutsceneStory(_loc_5);
            _loc_8 = this._ccModel.getLastLevelId(_loc_5) == _loc_6 ? true : false;
            if(_loc_8 == false)
            {
               this._cutsceneHandler.loadCutscene(_loc_5,_loc_7,CutsceneConstants.CUTSCENE_TYPE_INTRODUCTION,false);
            }
            else
            {
               this._cutsceneHandler.loadCutscene(_loc_5,_loc_7,CutsceneConstants.CUTSCENE_TYPE_RESOLUTION,true);
            }
         }
         this._ccQueueHandler.queueGameStartPop(this.cancelStartGame,this.startGame,_loc_5,_loc_6,this._inventory,this);
      }
      
      public function getTutorialHandler() : TutorialHandler
      {
         return this._tutorialHandler;
      }
      
      public function getTopNav() : TopNavMediator
      {
         Console.println("CCMain | getTopNav()");
         return this._topNavMediator;
      }
      
      private function startVeryFirstGame() : void
      {
         TrackingTrail.track("FirstGame");
         this._ccQueueHandler.queueRunGame(this.createAndRunGame,"createAndRun");
      }
      
      private function startGame() : void
      {
         var _loc_1:int = 0;
         var _loc_2:Boolean = false;
         TrackingTrail.track("StartG");
         this.musicManager.stopMusicInLobby();
         if(this._cutsceneHandler.getFactory() != null)
         {
            _loc_1 = this._ccModel.getUserActiveLevel();
            _loc_2 = this._ccModel.isShortCutsceneVersion(CutsceneConstants.CUTSCENE_TYPE_INTRODUCTION);
            this._ccQueueHandler.queuePlayCutscene(this._cutsceneHandler,mcDisplayBase,_loc_1,this._hourGlass,_loc_2);
         }
         this._ccQueueHandler.queueRunGame(this.createAndRunGame,"createAndRun");
      }
      
      public function showResolutionCutscene() : void
      {
         var _loc_3:int = 0;
         var _loc_4:Boolean = false;
         TrackingTrail.track("ShowCut");
         var _loc_1:* = this._ccModel.getUserActiveEpisode();
         var _loc_2:* = this._cutsceneHandler.getCutsceneStory(_loc_1);
         this._cutsceneHandler.loadCutscene(_loc_1,_loc_2,CutsceneConstants.CUTSCENE_TYPE_RESOLUTION,false);
         if(this._cutsceneHandler.getFactory() != null)
         {
            _loc_3 = this._ccModel.getUserActiveLevel();
            _loc_4 = this._ccModel.isShortCutsceneVersion(CutsceneConstants.CUTSCENE_TYPE_RESOLUTION);
            this._ccQueueHandler.queuePlayCutscene(this._cutsceneHandler,mcDisplayBase,_loc_3,this._hourGlass,_loc_4);
         }
      }
      
      private function cancelStartGame() : void
      {
         this._ccQueueHandler.queueCreateWorldWC(this.createWorld,this._worldFactory,WorldFactory.WORLD_ASSETS_READY_FOR_CREATION,this.getWorldCommandHandler);
      }
      
      private function createAndRunGame() : void
      {
         TrackingTrail.track("CreateRunG:" + this._ccModel.getUserActiveEpisode() + "|" + this._ccModel.getUserActiveLevel());
         this.musicManager.stopMusicInLobby();
         if(Boolean(this._gameFactory))
         {
            if(this._gameFactory.isDone())
            {
               this._topNavMediator.setGameMode(TopNavMediator.GAME);
               this._cutsceneHandler.addCutsceneSnapShot();
               this._ccModel.gameStart(this._ccModel.getUserActiveEpisode(),this._ccModel.getUserActiveLevel());
               this._cutsceneHandler.removeCutscene();
            }
            else
            {
               Console.println("Still loading game... Add timeglass...");
               this._hourGlass.setUp(this._gameFactory.isDone,this.createAndRunGame);
            }
         }
         else
         {
            Console.println("GameFactory does not exist");
         }
      }
      
      public function gameStart(param1:int, param2:int, param3:Number) : void
      {
         var _loc_7:CCBooster = null;
         var _loc_8:int = 0;
         var _loc_9:int = 0;
         var _loc_10:int = 0;
         var _loc_11:int = 0;
         var _loc_12:int = 0;
         var _loc_13:int = 0;
         var _loc_14:int = 0;
         var _loc_15:int = 0;
         TrackingTrail.track("GameSt");
         this.destroyWorld();
         this._game = this._gameFactory.getGame(this.getSwfUrl(this._gameFileKey));
         Debug.assert(CCConstants.MINIMUM_REQUIRED_GAME_ENGINE_VERSION <= this._game.getVersion(),"Trying to use an outdated version of the game.\nMinimum required game version: " + CCConstants.MINIMUM_REQUIRED_GAME_ENGINE_VERSION + ", current game version: " + this._game.getVersion());
         if(CCConstants.MINIMUM_REQUIRED_GAME_ENGINE_VERSION > this._game.getVersion())
         {
            return;
         }
         this._game.addEventListener(GameCommEvent.GAME_COMPLETED,this.onGameEnd);
         this._game.addEventListener(GameCommEvent.GAME_FAILED,this.onGameEnd);
         this._game.addEventListener(GameCommEvent.USER_QUIT,this.onGameEnd);
         this._game.addEventListener(GameCommEvent.GAME_PLAY_START,this.onGamePlayStart);
         this._game.addEventListener(GameCommEvent.GAME_PLAY_END,this.onGamePlayEnd);
         this._game.addEventListener(GameCommEvent.INGAME_BOOSTER_CONSUMED,this.onUnlockBoosterPanel);
         this._game.addEventListener(GameCommEvent.INGAME_BOOSTER_PREPARED,this.onLockBoosterPanel);
         this._game.addEventListener(GameCommEvent.SHOW_EXTRA_MOVES_REMINDER,this.onShowExtraMovesReminder);
         this._game.addEventListener(GameCommEvent.HIDE_EXTRA_MOVED_REMINDER,this.onHideExtraMovesReminder);
         this._game.addEventListener(GameCommEvent.CAP_EXTRA_MOVES_REMINDER,this.onCapExtraMovesReminder);
         var _loc_4:* = this._ccModel.getGameConf(param1,param2);
         this.overrideSeedValue(_loc_4);
         var _loc_5:* = this._inventory.getSelectedBoosters();
         var _loc_6:* = new Vector.<String>();
         for each(_loc_7 in _loc_5)
         {
            _loc_6.push(_loc_7.getType());
         }
         this._inventory.useBoostersInGame();
         this._game.start(_loc_4,this._gameFactory.getAllAssetApplicationDomains(),_loc_6);
         this._game.lockBoard(null);
         _loc_8 = 0;
         _loc_9 = 32;
         _loc_10 = 16;
         _loc_11 = 8;
         _loc_12 = 128;
         _loc_13 = 256;
         _loc_14 = 512;
         _loc_15 = 1024;
         if(_loc_4.getEpisodId() == 1 && _loc_4.getLevelId() == 4)
         {
            this._game.prespawnSpecialCandy(_loc_11,5,4);
            this._game.prespawnSpecialCandy(_loc_10,5,5);
         }
         else if(_loc_4.getEpisodId() == 1 && _loc_4.getLevelId() == 7)
         {
            this._game.prespawnSpecialCandy(_loc_10,5,4);
            this._game.prespawnSpecialCandy(_loc_10,5,5);
         }
         this.checkSoundState();
      }
      
      private function overrideSeedValue(param1:GameConf) : void
      {
         if(this._ccModel.getLevelStars(param1.getEpisodId(),param1.getLevelId()) > 0)
         {
            param1.setRandomSeed(0);
         }
      }
      
      public function getGame() : IGameComm
      {
         return this._game;
      }
      
      public function getTooltipClip() : MovieClip
      {
         return new TooltipClip();
      }
      
      public function checkSoundState(event:Event = null) : void
      {
         if(this._game == null)
         {
            return;
         }
         if(CCSoundManager.getInstance().isOn)
         {
            this._game.soundOn();
         }
         else
         {
            this._game.soundOff();
         }
         if(CCMusicManager.getInstance().isOn)
         {
            this._game.musicOn();
         }
         else
         {
            this._game.musicOff();
         }
      }
      
      private function onGameEnd(event:GameCommEvent) : void
      {
         var _loc_51:* = undefined;
         TrackingTrail.track("GameE");
         this._game.removeEventListener(GameCommEvent.GAME_COMPLETED,this.onGameEnd);
         this._game.removeEventListener(GameCommEvent.GAME_FAILED,this.onGameEnd);
         this._game.removeEventListener(GameCommEvent.USER_QUIT,this.onGameEnd);
         this._game.removeEventListener(GameCommEvent.GAME_PLAY_START,this.onGamePlayStart);
         this._game.removeEventListener(GameCommEvent.GAME_PLAY_END,this.onGamePlayEnd);
         this._game.removeEventListener(GameCommEvent.INGAME_BOOSTER_CONSUMED,this.onUnlockBoosterPanel);
         this._game.removeEventListener(GameCommEvent.INGAME_BOOSTER_PREPARED,this.onLockBoosterPanel);
         this._game.removeEventListener(GameCommEvent.SHOW_EXTRA_MOVES_REMINDER,this.onShowExtraMovesReminder);
         this._game.removeEventListener(GameCommEvent.HIDE_EXTRA_MOVED_REMINDER,this.onHideExtraMovesReminder);
         this._game.removeEventListener(GameCommEvent.CAP_EXTRA_MOVES_REMINDER,this.onCapExtraMovesReminder);
         this._ccGameEndEvent = event;
         this.shutDownGame();
         this._topNavMediator.removeBoosterPanel();
         this._ccQueueHandler.removeAllTutorialTrackers();
         var _loc_2:int = 666;
         switch(this._ccGameEndEvent.type())
         {
            case GameCommEvent.GAME_COMPLETED:
               _loc_2 = CCConstants.GAME_OVER_REASON_VICTORY;
               break;
            case GameCommEvent.GAME_FAILED:
               this._failReason = event.failReason();
               _loc_2 = CCConstants.calculateGameFailReasonCode(this._failReason);
               break;
            case GameCommEvent.USER_QUIT:
               _loc_2 = CCConstants.GAME_OVER_REASON_QUIT_BUTTON;
         }
         var _loc_3:* = this._ccModel.getUserActiveEpisode();
         var _loc_4:* = this._ccModel.getUserActiveLevel();
         this._ccModel.addEventListener(CCModel.GAME_END_RESPONSE_RECEIVED,this.gameEndResponse);
         this._ccModel.setGameEnd(_loc_3,_loc_4,event.score(),_loc_2,this._game.getFrameTrackingBuckets());
      }
      
      private function gameEndResponse(event:Event) : void
      {
         TrackingTrail.track("GameEResp");
         this._ccModel.removeEventListener(CCModel.GAME_END_RESPONSE_RECEIVED,this.gameEndResponse);
         this.showNotificationCentral();
         this._gameEventHandler.handleGameEndEvents(this,this._ccModel,this._ccQueueHandler,this._inventory,this._ccGameEndEvent);
         this._topNavMediator.possibleLifeUpdate();
      }
      
      private function shutDownGame() : void
      {
         TrackingTrail.track("GameSD");
         if(this._game != null)
         {
            this._game.shutDown();
         }
      }
      
      private function handleLifeGifts() : void
      {
         var _loc_1:GiftReceivedVO = null;
         var _loc_2:* = this._ccModel.getNextLifeGiftReceived();
         while(_loc_2)
         {
            _loc_1 = this._ccModel.getNextLifeGiftReceived();
            Console.println("CREATING LIFE POP");
            this._ccQueueHandler.queueLifeReceivedPop(null,this._ccModel.sendAcceptLifeRequestTo,_loc_1,this.getUserPicLoader().getBigUserPicById);
         }
      }
      
      private function createTopNav(param1:Boolean) : void
      {
         var _loc_2:* = new TopNavContent();
         mcDisplayTopNav.addChild(_loc_2);
         this.setupSounds();
         this._topNavMediator = new TopNavMediator(_loc_2,param1,this._ccModel,this.soundManager,this.musicManager,this);
         this._topNavMediator.setGameMode(TopNavMediator.WORLD);
      }
      
      private function setupSounds() : void
      {
         this.soundManager = CCSoundManager.getInstance();
         this.soundManager.addEventListener(CCSoundManager.SOUND_STATE_CHANGED,this.checkSoundState);
         SoundInterface.setCCSoundManager(CCSoundManager.getInstance);
         this.musicManager = CCMusicManager.getInstance();
         this.musicManager.addEventListener(CCSoundManager.SOUND_STATE_CHANGED,this.checkSoundState);
         SoundInterface.setCCMusicManager(CCMusicManager.getInstance);
      }
      
      public function getWorldCommandHandler() : IWorldCommandHandler
      {
         return this._world.getCommandHandler();
      }
      
      public function getUserPicLoader() : UserPicLoader
      {
         return this._userPicLoader;
      }
      
      public function getFailReason() : String
      {
         return this._failReason;
      }
      
      public function getInventory() : Inventory
      {
         return this._inventory;
      }
      
      public function getCurrentGameModeName() : String
      {
         var _loc_1:* = this._ccModel.getUserActiveEpisode();
         var _loc_2:* = this._ccModel.getUserActiveLevel();
         return this._ccModel.getGameModeName(_loc_1,_loc_2);
      }
      
      public function getTotalLevel(param1:int = 0, param2:int = 0) : int
      {
         if(param1 == 0 || param2 == 0)
         {
            param1 = this._ccModel.getUserActiveEpisode();
            param2 = this._ccModel.getUserActiveLevel();
         }
         return this._ccModel.getTotalLevel(param1,param2);
      }
      
      public function getCurrentUserId() : int
      {
         return this._ccModel.getCurrentUser().getUserId();
      }
      
      public function getStars(param1:int = 0, param2:int = 0) : int
      {
         if(param1 == 0 || param2 == 0)
         {
            param1 = this._ccModel.getUserActiveEpisode();
            param2 = this._ccModel.getUserActiveLevel();
         }
         return this._ccModel.getLevelStars(param1,param2);
      }
      
      public function getNextScoreTarget(param1:int = 0, param2:int = 0) : int
      {
         if(param1 == 0 || param2 == 0)
         {
            param1 = this._ccModel.getUserActiveEpisode();
            param2 = this._ccModel.getUserActiveLevel();
         }
         return this._ccModel.getNextScoreTarget(param1,param2);
      }
      
      public function getLowestScoreTarget(param1:int = 0, param2:int = 0) : int
      {
         if(param1 == 0 || param2 == 0)
         {
            param1 = this._ccModel.getUserActiveEpisode();
            param2 = this._ccModel.getUserActiveLevel();
         }
         return this._ccModel.getScoreTarget(param1,param2,1);
      }
      
      public function getBestScoreEver(param1:int = 0, param2:int = 0) : int
      {
         if(param1 == 0 || param2 == 0)
         {
            param1 = this._ccModel.getUserActiveEpisode();
            param2 = this._ccModel.getUserActiveLevel();
         }
         return this._ccModel.getBestScoreEver(param1,param2);
      }
      
      public function getHighScoreListData(param1:int = 0, param2:int = 0) : HighScoreListVO
      {
         return this._ccModel.getHighScoreListData();
      }
      
      public function getGameMode(param1:int = 0, param2:int = 0) : String
      {
         if(param1 == 0 || param2 == 0)
         {
            param1 = this._ccModel.getUserActiveEpisode();
            param2 = this._ccModel.getUserActiveLevel();
         }
         return this._ccModel.getGameModeName(param1,param2);
      }
      
      public function getGameConf(param1:int = 0, param2:int = 0) : GameConf
      {
         if(param1 == 0 || param2 == 0)
         {
            param1 = this._ccModel.getUserActiveEpisode();
            param2 = this._ccModel.getUserActiveLevel();
         }
         return this._ccModel.getGameConf(param1,param2);
      }
      
      public function onGameOverLossPopClosed(param1:Boolean = false) : void
      {
         this.destroyGame();
         if(param1)
         {
            this.initiatePlayLevel(null,param1);
         }
         else
         {
            this._ccQueueHandler.queueCreateWorldWC(this.createWorld,this._worldFactory,WorldFactory.WORLD_ASSETS_READY_FOR_CREATION,this.getWorldCommandHandler);
         }
      }
      
      private function onUnlockBoosterPanel(event:GameCommEvent) : void
      {
         this._topNavMediator.unlockBoosterPanel();
      }
      
      private function onLockBoosterPanel(event:GameCommEvent) : void
      {
         this._topNavMediator.lockBoosterPanel();
      }
      
      private function onShowExtraMovesReminder(event:GameCommEvent) : void
      {
         this._topNavMediator.showExtraMovesReminder();
      }
      
      private function onHideExtraMovesReminder(event:GameCommEvent) : void
      {
         this._topNavMediator.hideExtraMovesReminder();
      }
      
      private function onCapExtraMovesReminder(event:GameCommEvent) : void
      {
         this._topNavMediator.capExtraMovesReminder();
      }
      
      public function onGamePlayStart(event:GameCommEvent) : void
      {
         var _loc_6:CCBooster = null;
         var _loc_7:String = null;
         var _loc_8:Boolean = false;
         var _loc_9:Boolean = false;
         if(this._tutorialHandler.tutorialStation(1,1))
         {
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_SWITCHING_1,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_SWITCHING_2,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_SWITCHING_3,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_SWITCHING_4,null,null);
            this._tutorialHandler.addTutorialTracker(TutorialHandler.TRK_ID_EXPLAIN_SWITCHING_RANDOM);
         }
         else if(this._tutorialHandler.tutorialStation(1,2))
         {
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_STRIPED_1,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_STRIPED_2,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_STRIPED_3,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_STRIPED_4,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_SCORE_METER,null,null);
            this._tutorialHandler.addTutorialTracker(TutorialHandler.TRK_ID_SCORE_LIMIT);
         }
         else if(this._tutorialHandler.tutorialStation(1,3))
         {
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_MOVES_LEFT,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_WRAPPED_1,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_WRAPPED_2,null,null);
         }
         else if(this._tutorialHandler.tutorialStation(1,4))
         {
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_STRIPED_WRAPPED_1,null,null);
         }
         else if(this._tutorialHandler.tutorialStation(1,5))
         {
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_COLORBOMB_1,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_COLORBOMB_2,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_COLORBOMB_3,null,null);
         }
         else if(this._tutorialHandler.tutorialStation(1,6))
         {
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_LIGHT_UP_1,null,null);
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_LIGHT_UP_2,null,null);
            this._tutorialHandler.addTutorialTracker(TutorialHandler.TRK_ID_EXPLAIN_LIGHT_UP);
         }
         else if(this._tutorialHandler.tutorialStation(2,1))
         {
            this._tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_DROP_DOWN_1,null,null);
         }
         var _loc_2:* = this._inventory.getCCBoosters(Inventory.FIND_POWERUP_CONTEXT,BalanceConstants.POWERUP_TRIGGER_CONTEXT_INGAME,true);
         var _loc_3:* = this._ccModel.getUserActiveEpisode();
         var _loc_4:* = this._ccModel.getUserActiveLevel();
         var _loc_5:* = this._ccModel.getGameConf(_loc_3,_loc_4).gameModeName();
         for each(_loc_6 in _loc_2)
         {
            _loc_7 = TutorialHandler.POP_INTRODUCE_BOOSTER_PREFIX + _loc_6.getType();
            _loc_8 = _loc_6.acceptedInGameMode(_loc_5);
            _loc_9 = this._ccModel.getSeenBoosterTut(_loc_7);
            if(_loc_8 && !_loc_9)
            {
               this._tutorialHandler.addTutorialPop(_loc_7,null,null);
            }
         }
         if(this._ccQueueHandler.hasTutorialInQueue() == false)
         {
            this._game.unlockBoard();
         }
         this._topNavMediator.enableBoosterUsage();
      }
      
      public function getSeenBoosterTut(param1:String) : Boolean
      {
         return this._ccModel.getSeenBoosterTut(param1);
      }
      
      public function onGamePlayEnd(event:GameCommEvent) : void
      {
         this._topNavMediator.disableBoosterUsage();
      }
      
      public function setTutorialActive(param1:Boolean) : void
      {
         if(Boolean(this._game))
         {
            this._game.setTutorialActive(param1);
         }
      }
      
      public function getTutorialdisabled() : Boolean
      {
         if(Boolean(this._game))
         {
            return this._game.getTutorialDisabled();
         }
         return false;
      }
      
      public function setTutorialsDisabled(param1:Boolean) : void
      {
         if(Boolean(this._game))
         {
            this._game.setTutorialDisabled(param1);
         }
      }
      
      public function tutorialStation(param1:int, param2:int) : Boolean
      {
         if(this._tutorialHandler.tutorialStation(param1,param2))
         {
            return true;
         }
         return false;
      }
      
      public function addTutorialPop(param1:String, param2:Point, param3:Hint) : void
      {
         this._tutorialHandler.addTutorialPop(param1,param2,param3);
      }
      
      public function getTopEpisode() : int
      {
         return this._ccModel.getUserProfile(this._ccModel.getCurrentUser().getUserId()).getTopEpisode();
      }
      
      public function getTopLevel() : int
      {
         return this._ccModel.getUserProfile(this._ccModel.getCurrentUser().getUserId()).getTopLevel();
      }
      
      public function onGameOverVictoryPopClosed() : void
      {
         this.destroyGame();
      }
      
      public function onGameOverVictoryPopContinue(param1:int, param2:int, param3:int) : void
      {
         this._ccModel.shareCompletedLevel(param1,param2,param3);
         this.destroyGame();
      }
      
      public function setupAdTimer(param1:int = 3000) : void
      {
         if(this.videoAdTimer != null)
         {
            this.videoAdTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.popAdOnTimer);
            this.videoAdTimer.stop();
            this.videoAdTimer = null;
         }
         this.videoAdTimer = new Timer(param1,1);
         this.videoAdTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.popAdOnTimer);
         this.videoAdTimer.start();
      }
      
      private function popAdOnTimer(event:TimerEvent) : void
      {
         this.videoAdTimer.stop();
         this.videoAdTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.popAdOnTimer);
         this.videoAdTimer = null;
         this.checkVideoAdOffer();
      }
      
      private function checkVideoAdOffer() : void
      {
         var _loc_1:* = this._ccModel.getAdsEnabled();
         var _loc_2:* = this._ccModel.getCurrentUser().getLives();
         var _loc_3:* = LocalStorage.getCookie(CookieObjectVO.WATCH_VIDEO_AD,0);
         var _loc_4:* = _loc_2 <= 0;
         if(_loc_1 && _loc_4 && (_loc_3 == null || _loc_3.expired))
         {
            if(this._world == null)
            {
               this.displayVideoAdPop(this.closeVideoAd);
            }
            else
            {
               this.displayVideoAdPop();
            }
         }
         else if(this._world == null)
         {
            this.closeVideoAd();
         }
      }
      
      private function displayVideoAdPop(param1:Function = null) : void
      {
         this._ccQueueHandler.queueVideoAdsPop(this.launchVideoAd,null);
         if(param1 != null)
         {
         }
      }
      
      public function launchVideoAd() : void
      {
         TrackingTrail.track("VideoLaunch");
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("adVideoDone",this.adVideoDone);
            ExternalInterface.call("showAd");
         }
      }
      
      public function closeVideoAd() : void
      {
         this._ccQueueHandler.queueCreateWorldWC(this.createWorld,this._worldFactory,WorldFactory.WORLD_ASSETS_READY_FOR_CREATION,this.getWorldCommandHandler);
      }
      
      public function adVideoDone(param1:Boolean, param2:Number) : void
      {
         TrackingTrail.track("VideoDone");
         MonsterDebugger.trace(this,"adVideoDone status=" + param1 + ", timeToNextLife=" + param2);
         ExternalInterface.addCallback("adVideoDone",null);
         Console.println("adVideoDone status=" + param1 + ", timeToNextLife=" + param2);
         this.trySetVideoCookie(param2);
         this._topNavMediator.doPoll();
         if(this._world == null)
         {
            this.closeVideoAd();
         }
      }
      
      private function trySetVideoCookie(param1:Number) : void
      {
         var _loc_2:* = param1;
         LocalStorage.setCookie(CookieObjectVO.WATCH_VIDEO_AD,0,_loc_2,this.trySetVideoAdReply);
      }
      
      private function trySetVideoAdReply(param1:Boolean) : void
      {
      }
      
      public function destroyWorld() : void
      {
         this._toolTipHandler.removeTooltips(TooltipHandler.TYPE_WORLD);
         if(Boolean(this._world))
         {
            this._world.destruct();
            this._world.parent.removeChild(this._world);
            this._world.removeEventListener(WorldEvent.PLAY_LEVEL,this.initiatePlayLevel);
            this._world = null;
         }
      }
      
      public function destroyGame() : void
      {
         this._toolTipHandler.removeTooltips(TooltipHandler.TYPE_GAME);
         if(Boolean(this._game))
         {
            this._game.removeEventListener(GameCommEvent.SHUT_DOWN_COMPLETE,this.createWorld);
            this._game.removeEventListener(GameCommEvent.GAME_COMPLETED,this.onGameEnd);
            this._game.removeEventListener(GameCommEvent.GAME_FAILED,this.onGameEnd);
            this._game.removeEventListener(GameCommEvent.USER_QUIT,this.onGameEnd);
            this._game.destruct();
            this._game = null;
         }
      }
      
      public function queueBuyLivesPop() : void
      {
         var _loc_1:* = this._ccModel.getCurrentUser().getLives();
         if(_loc_1 > 0)
         {
            this._ccQueueHandler.queueBuyLivesPop(this._ccModel.getCurrentUser().getLives(),this.onBuyLives,this.onAskForLivesHelp,this._ccModel.getLifeProductFullLife().getCost().getAmount());
         }
         else
         {
            this.queueNoMoreLivesPop();
         }
      }
      
      public function queueSingleCharmPop(param1:CCCharm) : void
      {
         this._ccQueueHandler.queueSingleCharmPop(param1,this._ccModel.getCurrentUser(),null,this.openCharmsShopFeatured,this._inventory);
      }
      
      public function openCharmsShopFeatured(param1:CCCharm = null) : void
      {
         var _loc_2:* = this._ccModel.getCharmInventory();
         var _loc_3:* = this._ccModel.getCharmDailyOffer();
         this._ccQueueHandler.queueCharmsShop(_loc_2,_loc_3,param1,this._inventory);
      }
      
      public function resumeGame(event:Event) : void
      {
         Console.println("Resume Game");
         if(Boolean(this._game))
         {
            this._game.resumeGame();
         }
      }
      
      private function queueNoMoreLivesPop() : void
      {
         var _loc_1:* = this._ccModel.getCustomTimeToNextRegeneration();
         Console.println("queueNoMoreLivesPop " + _loc_1);
         this._ccQueueHandler.queueNoMoreLivesPop(this._ccModel.getCurrentUser().getLives(),this.onBuyLives,this.onAskForLivesHelp,this.onNoMoreLivesClosed,this._ccModel.getLifeProductFullLife().getCost().getAmount(),this.setupAdTimer,_loc_1);
      }
      
      private function queueInviteNumPop() : void
      {
         Console.println("queueInviteNumPop ");
         this._ccQueueHandler.queueInviteNumPop(this._ccModel.getCurrentUser().getInviteTotal(),this._ccModel.getCurrentUser().getInviteWard(),this);
      }
      
      private function queueInviteLevelPop() : void
      {
         Console.println("queueInviteLevelPop ");
         this._ccQueueHandler.queueInviteLevelPop(this._ccModel.getCurrentUserInvitedUsers(),this);
      }
      
      private function onNoMoreLivesClosed() : void
      {
         var _loc_4:CCMissionData = null;
         var _loc_5:Boolean = false;
         var _loc_2:* = Math.random() * 100;
         var _loc_3:* = this._ccModel.getCurrentUser().getLives() > 0;
         if(!_loc_3 && _loc_2 > 30)
         {
            _loc_4 = this._ccModel.missionsModel.getAnyAvailableMission();
            _loc_5 = _loc_4 != null;
            if(_loc_5)
            {
               this._ccQueueHandler.queueMissionPop(this.onMissionAccepted,_loc_4);
            }
         }
      }
      
      private function onMissionAccepted(param1:CCMissionData) : void
      {
         this._ccModel.acceptMission(param1);
      }
      
      public function queueItemUnlockedPop(param1:String, param2:String) : void
      {
         this._ccQueueHandler.queueItemUnlockedPop(null,param1,param2,this._ccModel,this.openCharmsShopFeatured_main,this._inventory);
      }
      
      public function openCharmsShopFeatured_main(param1:CCCharm = null) : void
      {
         var _loc_2:* = this._ccModel.getCharmInventory();
         var _loc_3:* = this._ccModel.getCharmDailyOffer();
         this._ccQueueHandler.queueCharmsShop(_loc_2,_loc_3,param1,this._inventory);
      }
      
      public function notifyConsoleActivation() : void
      {
         if(Boolean(this._game))
         {
            this._game.freeze();
         }
      }
      
      public function notifyConsoleDeactivation() : void
      {
         if(Boolean(this._game))
         {
            this._game.unFreeze();
         }
      }
      
      public function processCommand(param1:String, param2:Array) : void
      {
         var userComment:String = null;
         var episode:int = 0;
         var level:int = 0;
         var consoleActivated:Boolean = false;
         var fbvo:FriendBeatenVO = null;
         var fpvo:FriendPassedVO = null;
         var slvo:StarLevelVO = null;
         var grvo:GiftReceivedVO = null;
         var picLoaderFn:Function = null;
         var command:* = param1;
         var params:* = param2;
         switch(command)
         {
            case "bug":
               userComment = params.join(" ");
               if(userComment.length > 3)
               {
                  Console.println("Preparing bug report. Please wait.","bug_report",15517348);
                  consoleActivated = Console.isActivated();
                  if(consoleActivated)
                  {
                     Console.deactivate();
                  }
                  if(consoleActivated)
                  {
                     Console.activate();
                  }
               }
               else
               {
                  Console.println("Please provide a comment.","bug_report",15517348);
                  Console.println("Example: bug The fish is wicked.","bug_report",15517348);
               }
               break;
            case "pop":
               Console.deactivate();
               if(params.length > 0 && params[0] == "welcome")
               {
                  this._ccQueueHandler.queueWelcomePop(this.startVeryFirstGame,this.startVeryFirstGame,this._cutsceneHandler.addCutsceneSnapShot,this.hidePreloader);
               }
               else if(params.length > 0 && params[0] == "buy_life")
               {
                  this._ccQueueHandler.queueBuyLivesPop(this._ccModel.getCurrentUser().getLives(),this.onBuyLives,this.onAskForLivesHelp,this._ccModel.getLifeProductFullLife().getCost().getAmount());
               }
               else if(params.length > 0 && params[0] == "collab")
               {
                  this.showCollabPop(null,1);
               }
               else if(params.length > 0 && params[0] == "episode_complete")
               {
                  this._ccQueueHandler.queueEpisodeCompletedPop(null,this.episodeComplete,1);
               }
               else if(!(params.length > 0 && params[0] == "episode_unlocked"))
               {
                  if(params.length > 0 && params[0] == "friend_beaten")
                  {
                     fbvo = new FriendBeatenVO();
                     fbvo.currentUserId = LocalConstants.userId;
                     fbvo.episodeId = 1;
                     fbvo.levelId = 2;
                     fbvo.getBigUserPicById = function(param1:String, param2:int, param3:int):MovieClip
                     {
                        return _userPicLoader.getBigUserPicById(LocalConstants.userId);
                     };
                     fbvo.loadTopListByLevel = function(param1:int, param2:int, param3:FriendBeatenPop):void
                     {
                     };
                     this._ccQueueHandler.queueFriendBeatenPop(null,null,fbvo,null,null);
                  }
                  else if(params.length > 0 && params[0] == "friend_passed")
                  {
                     fpvo = new FriendPassedVO();
                     fpvo.currentUserId = LocalConstants.userId;
                     fpvo.episodeId = 1;
                     fpvo.levelId = 2;
                     fpvo.getBigUserPicById = function(param1:String, param2:int, param3:int):MovieClip
                     {
                        return _userPicLoader.getBigUserPicById(LocalConstants.userId);
                     };
                     this._ccQueueHandler.queueFriendPassedPop(null,null,fpvo,null);
                  }
                  else if(params.length > 0 && params[0] == "level_fail")
                  {
                     this._ccQueueHandler.queueGameOverLossPop(this.voidFunc,this.voidFunc,1,2,3,1500,"Classic",CCConstants.GAME_FAIL_REASON_LOW_SCORE,null);
                  }
                  else if(params.length > 0 && params[0] == "level_complete")
                  {
                     slvo = new StarLevelVO();
                     slvo.episodeId = 1;
                     slvo.levelId = 1;
                     this._ccQueueHandler.queueGameOverVictoryPop(this.voidFunc,this.voidFunc,slvo,1000,2,1,null,new Vector.<ItemAmount>(0),this);
                  }
                  else if(params.length > 0 && params[0] == "life_receive")
                  {
                     grvo = new GiftReceivedVO("life",LocalConstants.userId,"mange",99);
                     this._ccQueueHandler.queueLifeReceivedPop(this.voidFunc,this.voidFunc,grvo,function(param1:String, param2:int = 0, param3:int = 0):MovieClip
                     {
                        return _userPicLoader.getBigUserPicById(LocalConstants.userId);
                     });
                  }
                  else if(params.length > 0 && params[0] == "no_more_lives")
                  {
                     this.queueNoMoreLivesPop();
                  }
                  else if(params.length > 0 && params[0] == "collaboration_help_received")
                  {
                     this._ccQueueHandler.queueUnlockHelpReceivedPop(LocalConstants.userId,1,"mange",function(param1:String, param2:int = 0, param3:int = 0):MovieClip
                     {
                        return _userPicLoader.getBigUserPicById(LocalConstants.userId);
                     });
                  }
                  else if(params.length > 0 && params[0] == "video_ad")
                  {
                     this.displayVideoAdPop();
                  }
                  else if(params.length > 0 && params[0] == "notification_central")
                  {
                     picLoaderFn = this.getUserPicLoader().getBigUserPicById;
                     this._ccQueueHandler.queueNotificationCentral(new Vector.<SagaEvent>(0),this._ccModel.getUserProfiles(),picLoaderFn,this._ccModel.sendAcceptLifeRequestTo,this._ccModel.sendAcceptUnlockRequestTo);
                  }
                  else
                  {
                     Console.activate();
                     Console.println("Usage: pop [welcome|buy_life|collab|episode_complete|episode_unlocked|friend_beaten|friend_passed|\nlevel_fail|level_complete|life_receive|no_more_lives|collaboration_help_received|video_ad|notification_central]");
                  }
               }
               break;
            case "tipster":
               episode = params.length > 0 ? int(params[0]) : 0;
               level = params.length > 1 ? int(params[1]) : 0;
               this._gameEventHandler.powerUpTipster.traceValues(this._ccModel.getAllLevelInfoVO(),episode,level);
         }
      }
      
      private function voidFunc() : void
      {
      }
      
      private function _bugReportSuccess(param1:String) : void
      {
         Console.println("Bug report sent. Thank you very much! =)","bug_report",15517348);
      }
      
      private function _bugReportError(param1:String) : void
      {
         Console.println(param1);
         Console.println("Bug reporting is unavailable! =(","bug_report",15517348);
      }
      
      public function assert(param1:String) : void
      {
         var _loc_2:* = Debug.formatStackTrace(new Error().getStackTrace());
         Console.println("Assertion failed" + (Boolean(param1) ? ": " + param1 : "") + (_loc_2.length > 0 ? "\n" + _loc_2 : ""),"assert",16742263);
      }
      
      public function getBugData() : String
      {
         var _loc_1:String = "";
         var _loc_2:* = this._ccModel.getUserProfile(this._ccModel.getCurrentUser().getUserId());
         var _loc_3:* = new PrintTable(["user id","facebook id","name"]);
         _loc_3.addRow([_loc_2.getUserId(),_loc_2.getExternalUserId(),_loc_2.getFullName()]);
         return _loc_1 + _loc_3.toString();
      }
      
      public function queueErrorAlert(event:IOErrorEvent, param2:String, param3:Error = null) : void
      {
         var _loc_4:Object = null;
         TrackingTrail.track("[ERR:" + param2 + "]");
         if(Boolean(this._ccQueueHandler))
         {
            this._ccQueueHandler.queueErrorAlert(event,param2,param3);
         }
         else
         {
            _loc_4 = new Object();
            _loc_4.error = param3;
            _loc_4.message = param2;
            _loc_4.ioError = event;
            unhandledErrors.push(_loc_4);
         }
      }
      
      private function onBugReportFormActivated_1() : void
      {
         if(this._bugReportForm != null)
         {
            return;
         }
         this._bugReportForm = new BugReportForm("candycrush_bugs@king.com");
         this._bugReportForm.x = CCConstants.STAGE_WIDTH * 0.5;
         this._bugReportForm.y = CCConstants.STAGE_HEIGHT * 0.5;
         this.addChild(this._bugReportForm);
         this._bugReportForm.addEventListener(Event.CLOSE,this._onBugReportFormClosed_1);
      }
      
      public function onBugReportFormActivated_2() : void
      {
         if(this._bugReportForm != null)
         {
            return;
         }
         this._bugReportForm = new BugReportForm("candycrushfeedback@king.com");
         this._bugReportForm.x = CCConstants.STAGE_WIDTH * 0.5;
         this._bugReportForm.y = CCConstants.STAGE_HEIGHT * 0.5;
         this.addChild(this._bugReportForm);
         this._bugReportForm.addEventListener(Event.CLOSE,this._onBugReportFormClosed_2);
      }
      
      public function shareFriendBeaten(param1:String, param2:int, param3:String, param4:int, param5:int) : void
      {
         this._ccModel.shareFriendBeaten(param1,param2,param3,param4,param5);
      }
      
      public function shareFriendPassed(param1:String, param2:int) : void
      {
         this._ccModel.shareFriendPassed(param1,param2);
      }
      
      public function episodeComplete(param1:int) : void
      {
         this._ccModel.episodeComplete(param1);
      }
      
      public function capExtraMovesRemainder() : void
      {
         this._topNavMediator.capExtraMovesReminder();
      }
      
      private function _onBugReportFormClosed_1(event:Event = null) : void
      {
         if(this._bugReportForm == null)
         {
            return;
         }
         this._bugReportForm.removeEventListener(Event.CLOSE,this._onBugReportFormClosed_1);
         this._bugReportForm.destruct();
         this.removeChild(this._bugReportForm);
         this._bugReportForm = null;
      }
      
      private function _onBugReportFormClosed_2(event:Event = null) : void
      {
         if(this._bugReportForm == null)
         {
            return;
         }
         this._bugReportForm.removeEventListener(Event.CLOSE,this._onBugReportFormClosed_2);
         this._bugReportForm.destruct();
         this.removeChild(this._bugReportForm);
         this._bugReportForm = null;
      }
      
      private function setupFeedback() : void
      {
         Console.registerProcessor("bug",this,"Send a bug report.");
         this._bugReportFormActivator = new EastereggActivator("karies",this._onBugReportFormActivated,stage);
      }
      
      private function _onBugReportFormActivated() : void
      {
         this.onBugReportFormActivated_1();
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

