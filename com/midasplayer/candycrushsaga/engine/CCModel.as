package com.midasplayer.candycrushsaga.engine
{
   import com.demonsters.debugger.*;
   import com.king.saga.api.*;
   import com.king.saga.api.crafting.ItemAmount;
   import com.king.saga.api.crafting.ItemInfo;
   import com.king.saga.api.event.*;
   import com.king.saga.api.listener.*;
   import com.king.saga.api.net.*;
   import com.king.saga.api.product.*;
   import com.king.saga.api.response.*;
   import com.king.saga.api.toplist.*;
   import com.king.saga.api.universe.*;
   import com.king.saga.api.universe.condition.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   import com.midasplayer.candycrushsaga.charms.*;
   import com.midasplayer.candycrushsaga.charms.api.*;
   import com.midasplayer.candycrushsaga.collaboration.*;
   import com.midasplayer.candycrushsaga.cutscene.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.debug.*;
   import com.midasplayer.text.I18n;
   import flash.events.*;
   import flash.external.*;
   import flash.net.SharedObject;
   
   public class CCModel extends EventDispatcher implements IGameInitListener, IGameEndListener, IApplicationErrorHandler, IGameStartListener, IGetMessagesListener, IBuyCollaborationProductListener, IBuyLifeProductListener, IGetBalanceListener, IGetRecipesListener, ICraftListener, IBuyAnyProductListener
   {
      private static var _gameModel:GameModel;
      
      public static var _userData:CCUserData;
      
      public static var newEvents:Boolean;
      
      public static const GAME_INIT:String = "gameInit";
      
      public static const GAME_END_RESPONSE_RECEIVED:String = "gameEndResponseReceived";
      
      public static const LIVES_UPDATED:String = "livesUpdated";
      
      public static const COLLABORATION_PURCHASE_STATUS:String = "collaborationPurchaseStatus";
      
      public static const RECEIVED_GET_MESSAGES:String = "receivedGetMessages";
      
      public static const MISSION_ACCOMPLISHED:String = "missionAccomplished";
      
      private var _ccMain:CCMain;
      
      private var _resources:Object;
      
      private var _localization:I18n;
      
      private var _currentUser:CurrentUser;
      
      private var _universeDescription:UniverseDescription;
      
      private var _userUniverse:UserUniverse;
      
      private var _userProfiles:UserProfiles;
      
      private var _lifeProducts:Vector.<LifeProduct>;
      
      private var _extraLifeProducts:Vector.<ExtraLifeProduct>;
      
      private var _itemProducts:Vector.<ItemProduct>;
      
      private var _inviteReward:Vector.<Award>;
      
      private var _levelReward:Vector.<Award>;
      
      private var _collaborationProducts:Vector.<CollaborationProduct>;
      
      private var _totalLevels:Array;
      
      private var _levelUnlockedEvent:LevelUnlockedEvent;
      
      private var _toplistFriendBeatenEvent:ToplistFriendBeatenEvent;
      
      private var _toplistFriendBeatenGoldEvent:ToplistFriendBeatenGoldEvent;
      
      private var _mapFriendPassedEvent:MapFriendPassedEvent;
      
      private var _mapFriendPassedGoldEvent:MapFriendPassedGoldEvent;
      
      private var _episodeCompletedEvent:EpisodeCompletedEvent;
      
      private var _gameCompletedEvent:GameCompletedEvent;
      
      private var _itemUnlockEvents:Vector.<ItemGoldRewardEvent>;
      
      private var _highScoreListData:HighScoreListVO;
      
      private var _friendBeatenData:FriendBeatenVO;
      
      private var _friendPassedData:FriendPassedVO;
      
      private var _lifeGiftsReceived:Vector.<GiftReceivedVO>;
      
      private var _helpAcceptedEvents:Array;
      
      private var _clbGetMessagesComplete:Function;
      
      private var _newStarLevelData:StarLevelVO;
      
      private var _sagaApi:ISagaApi;
      
      private var _socialApi:ISocialApi;
      
      private var _candyApi:CandyApi;
      
      private var _helpRequestList:Vector.<SagaEvent>;
      
      private var customTimeToNextRegeneration:int;
      
      private var _frameTrackingBuckets:Vector.<int>;
      
      private var _playerItems:Vector.<ItemInfo>;
      
      private var _getRecipesListener:IGetRecipesListener;
      
      private var _craftListener:ICraftListener;
      
      private var _getBalanceListener:IGetBalanceListener;
      
      private var _buyAnyProductListener:IBuyAnyProductListener;
      
      private var _adsEnabled:Boolean;
      
      private var _missionsModel:CCMissionsModel;
      
      private var inviteFriendNum:int = 0;
      
      private var sharedObj:SharedObject;
      
      public function CCModel(param1:CCMain, param2:Object)
      {
         super();
         this._ccMain = param1;
         this.setupAPI(param2);
      }
      
      public static function get gameModel() : GameModel
      {
         return _gameModel;
      }
      
      public static function getUserLevels(topEpisode:int, topLevel:*) : int
      {
         if(topEpisode <= 2)
         {
            return (topEpisode - 1) * 10 + topLevel;
         }
         return 20 + (topEpisode - 3) * 15 + topLevel;
      }
      
      public function get candyApi() : CandyApi
      {
         return this._candyApi;
      }
      
      public function setupAPI(param1:Object) : void
      {
         var _loc_2:* = new Object();
         _loc_2.userId = LocalConstants.userId;
         _loc_2.sessionKey = LocalConstants.sessionKey;
         _loc_2.platid = LocalConstants.platid;
         _loc_2.fan = LocalConstants.isFan;
         _loc_2.apiUrl = LocalConstants.apiUrl;
         _loc_2.candyApiUrl = LocalConstants.candyApiUrl;
         _loc_2.getGameConfigurationsMethod = LocalConstants.getGameConfigurationsMethod;
         _loc_2.getCandyPropertiesMethod = LocalConstants.getCandyPropertiesMethod;
         _loc_2.trackingUrl = LocalConstants.trackingUrl;
         _loc_2.platformUrl = LocalConstants.platformUrl;
         _loc_2.baseUrl = LocalConstants.baseUrl;
         if(Boolean(param1))
         {
            if(Boolean(param1.fan))
            {
               _loc_2.fan = param1.fan;
            }
            if(Boolean(param1.apiUrl))
            {
               _loc_2.apiUrl = param1.apiUrl;
            }
            if(Boolean(param1.sessionKey))
            {
               _loc_2.sessionKey = param1.sessionKey;
            }
            if(Boolean(param1.userId))
            {
               _loc_2.userId = param1.userId;
            }
            if(Boolean(param1.candyApiUrl))
            {
               _loc_2.candyApiUrl = param1.candyApiUrl;
            }
            if(Boolean(param1.trackingUrl))
            {
               _loc_2.trackingUrl = param1.trackingUrl;
            }
            if(Boolean(param1.platformUrl))
            {
               _loc_2.platformUrl = param1.platformUrl;
            }
            if(Boolean(param1.baseUrl))
            {
               _loc_2.baseUrl = param1.baseUrl;
            }
         }
         this._sagaApi = new SagaApi(_loc_2.apiUrl,_loc_2.sessionKey,this);
         this._socialApi = SocialApi.isAvailable() ? new SocialApi() : new DebugSocialApi();
         _gameModel = new GameModel(this._sagaApi,this._socialApi,CCConstants.GAME_RESULT_SALT);
         this._candyApi = new CandyApi(_loc_2,this.initiateGame,this.onNetError,this.onError,this);
         this._missionsModel = new CCMissionsModel(_loc_2.sessionKey,_loc_2.baseUrl);
      }
      
      private function initiateGame() : void
      {
         _gameModel.gameInit(this);
      }
      
      public function acceptMission(param1:CCMissionData) : void
      {
         this._missionsModel.acceptMission(param1);
      }
      
      private function _processMissionAccomplished() : void
      {
         var _loc_1:CCMissionData = null;
         if(this._missionsModel.hasAccomplishedMissionsReply)
         {
            if(this._missionsModel.accomplishedMissionsDataList.length > 0)
            {
               _loc_1 = this._missionsModel.accomplishedMissionsDataList[0];
               dispatchEvent(new ModelEvent(CCModel.MISSION_ACCOMPLISHED,_loc_1));
            }
         }
         else
         {
            this._missionsModel.addEventListener(CCMissionsModel.ACCOMPLISHED_MISSIONS_UPDATED,this.onAccomplishedMissionsData);
         }
      }
      
      private function onAccomplishedMissionsData(event:Event) : void
      {
         this._missionsModel.removeEventListener(CCMissionsModel.ACCOMPLISHED_MISSIONS_UPDATED,this.onAccomplishedMissionsData);
         this._processMissionAccomplished();
      }
      
      public function onGameInit(param1:GameInitResponse) : void
      {
         _userData = new CCUserData();
         this._newStarLevelData = new StarLevelVO();
         this._highScoreListData = new HighScoreListVO();
         this._friendBeatenData = new FriendBeatenVO();
         this._friendPassedData = new FriendPassedVO();
         this._currentUser = param1.getCurrentUser();
         this._userUniverse = param1.getUserUniverse();
         this._universeDescription = param1.getUniverseDescription();
         this._userProfiles = param1.getUserProfiles();
         this._lifeProducts = param1.getLifeProducts();
         this._levelReward = param1.levelReward;
         this._inviteReward = param1.inviteReward;
         this._extraLifeProducts = param1.getExtraLifeProducts();
         this._collaborationProducts = param1.getCollaborationProducts();
         this._playerItems = param1.getItemBalance();
         this._itemProducts = param1.getItemProducts();
         this._resources = param1.resources;
         this._totalLevels = this.getTotalLevels();
         this._localization = new I18n();
         I18n.init(param1.getResourceAsObject("candycrush.candycrush"));
         this.parseMessageEvents(param1.getEvents());
         dispatchEvent(new Event(CCModel.GAME_INIT));
         this._highScoreListData.currentUserId = this._currentUser.getUserId();
         this._highScoreListData.getUserProfile = this.getUserProfile;
         this._highScoreListData.loadTopListByLevel = this.loadTopListByLevel;
         this._highScoreListData.sendHighscoreLifeTo = this.sendHighscoreLifeTo;
         this._highScoreListData.getSmallUserPicById = this._ccMain.getUserPicLoader().getSmallUserPicById;
         this._highScoreListData.getBigUserPicById = this._ccMain.getUserPicLoader().getBigUserPicById;
         this._friendBeatenData.currentUserId = this._currentUser.getUserId();
         this._friendBeatenData.currentuserName = this.getUserProfile(this._friendBeatenData.currentUserId).getName();
         this._friendBeatenData.loadTopListByLevel = this.loadTopListByLevel;
         this._friendBeatenData.getBigUserPicById = this._ccMain.getUserPicLoader().getBigUserPicById;
         this._friendPassedData.currentUserId = this._currentUser.getUserId();
         this._friendPassedData.currentuserName = this.getUserProfile(this._friendBeatenData.currentUserId).getName();
         this._friendPassedData.getBigUserPicById = this._ccMain.getUserPicLoader().getBigUserPicById;
         this._candyApi.overrideScoreTargets(this.getLevelDescription);
         this._adsEnabled = param1.getAdsEnabled();
      }
      
      public function onNetError(event:IOErrorEvent, param2:String) : void
      {
         Console.println("OnNetError " + event.type + " " + event.text + " " + param2);
         this._ccMain.queueErrorAlert(event,param2);
      }
      
      public function onError(param1:Error, param2:String) : void
      {
         Console.println("OnNetError " + param1.message + " " + param1.name + " " + param2);
         this._ccMain.queueErrorAlert(null,param2,param1);
      }
      
      private function parseMessageEvents(param1:Vector.<SagaEvent>) : void
      {
         var _loc_2:SagaEvent = null;
         var _loc_3:LifeGiftEvent = null;
         var _loc_4:String = null;
         var _loc_6:UserProfile = null;
         var _loc_7:String = null;
         var _loc_8:UnlockHelpAcceptedEvent = null;
         var _loc_5:Number = NaN;
         newEvents = param1.length == 0 ? false : true;
         this._lifeGiftsReceived = new Vector.<GiftReceivedVO>();
         this._helpAcceptedEvents = [];
         this._helpRequestList = new Vector.<SagaEvent>();
         for each(_loc_2 in param1)
         {
            TrackingTrail.track("Evt:" + _loc_2.getType());
            switch(_loc_2.getType())
            {
               case LifeGiftEvent.Type:
                  Console.println("LIFE GIFT RECEIVED" + this._currentUser.getLives());
                  _loc_3 = _loc_2 as LifeGiftEvent;
                  _loc_4 = GiftReceivedVO.GIFT_TYPE_LIFE;
                  _loc_5 = _loc_3.getFromId();
                  _loc_6 = this.getUserProfile(_loc_5);
                  _loc_7 = _loc_6 != null ? _loc_6.getName() : "";
                  this._lifeGiftsReceived.push(new GiftReceivedVO(_loc_4,_loc_5,_loc_7,1));
                  break;
               case LevelUnlockedEvent.Type:
                  this._levelUnlockedEvent = _loc_2 as LevelUnlockedEvent;
                  break;
               case UnlockHelpAcceptedEvent.Type:
                  _loc_8 = _loc_2 as UnlockHelpAcceptedEvent;
                  this._helpAcceptedEvents.push(new UnlockGift(_loc_8.getFromId(),_loc_8.getEpisodeId()));
                  break;
               case LevelUnlockRequestEvent.Type:
               case LifeRequestEvent.Type:
                  this._helpRequestList.push(_loc_2);
                  break;
               case MapFriendPassedGoldEvent.Type:
               case ToplistFriendBeatenGoldEvent.Type:
                  break;
               default:
                  Debug.assert(false,"unhandled message event=" + _loc_2.getType() + ", data=" + _loc_2.getData());
                  break;
            }
         }
         this._processMissionAccomplished();
      }
      
      public function getAllHelpRequests() : Vector.<SagaEvent>
      {
         return this._helpRequestList;
      }
      
      public function removeAllHelpRequests() : void
      {
         var _loc_1:SagaEvent = null;
         for each(_loc_1 in this._helpRequestList)
         {
            _loc_1 = null;
         }
         this._helpRequestList.length = 0;
      }
      
      public function onGetMessages(param1:GetMessagesResponse) : void
      {
         this.parseMessageEvents(param1.getEvents());
         dispatchEvent(new Event(RECEIVED_GET_MESSAGES));
      }
      
      public function getCurrentUserActiveEpAndLevels() : int
      {
         var us:UserEpisode = null;
         var length:int = 0;
         for each(us in this._userUniverse.getUserEpisodes())
         {
            length += us.getUserLevels().length;
         }
         return length;
      }
      
      public function getCurrentUserInvitedUsers() : Array
      {
         var user:UserProfile = null;
         var temp:Array = new Array();
         for each(user in this._userProfiles.getAll())
         {
            if(user.getInvite() && user.getInvite() != "" && Number(user.getInvite()) == this._currentUser.getUserId())
            {
               temp.push(user);
            }
         }
         return temp;
      }
      
      public function poll(param1:IPollListener) : void
      {
         if(param1 == null)
         {
            param1 = this._ccMain.getTopNav();
         }
         _gameModel.poll(param1);
         Console.println("@ poll() - CCModel.as | currentUser lives: " + this._currentUser.getLives());
      }
      
      public function friendHasBeenBeaten() : Boolean
      {
         if(this._toplistFriendBeatenEvent != null)
         {
            return true;
         }
         return false;
      }
      
      public function getUnlockedItemEvent() : ItemGoldRewardEvent
      {
         return this._itemUnlockEvents.shift();
      }
      
      private function getTotalLevels() : Array
      {
         var _loc_4:EpisodeDescription = null;
         var _loc_5:Array = null;
         var _loc_6:int = 0;
         var _loc_7:uint = 0;
         var _loc_3:int = 0;
         var _loc_1:* = new Array();
         var _loc_2:* = this._universeDescription.getEpisodeDescriptions();
         for each(_loc_4 in _loc_2)
         {
            _loc_5 = new Array();
            _loc_6 = int(_loc_4.getLevelDescriptions().length);
            _loc_7 = 0;
            while(_loc_7 < _loc_6)
            {
               _loc_3++;
               _loc_5.push(_loc_3);
               _loc_7 += 1;
            }
            _loc_1.push(_loc_5);
         }
         return _loc_1;
      }
      
      public function getTotalLevel(param1:int, param2:int) : int
      {
         var _loc_5:Array = null;
         var _loc_3:* = param1 - 1;
         var _loc_4:* = param2 - 1;
         if(_loc_3 >= this._totalLevels.length)
         {
            return 0;
         }
         _loc_5 = this._totalLevels[_loc_3];
         if(_loc_3 >= _loc_5.length)
         {
            return 0;
         }
         return this._totalLevels[_loc_3][_loc_4];
      }
      
      public function gameStart(param1:int, param2:int) : void
      {
         _userData.setUserActivePosition(param1,param2);
         _gameModel.gameStart(param1,param2,this);
      }
      
      public function onGameStart(param1:GameStartResponse) : void
      {
         var _loc_2:* = _userData.activeEpisode;
         var _loc_3:* = _userData.activeLevel;
         var _loc_4:* = param1.getSeed();
         this._currentUser = param1.getCurrentUser();
         this._ccMain.gameStart(_userData.activeEpisode,_userData.activeLevel,_loc_4);
      }
      
      public function onGameStartError(param1:String) : void
      {
         Console.println("onGameStartError:",param1);
      }
      
      public function setGameEnd(param1:int, param2:int, param3:uint, param4:int, param5:Vector.<int>) : void
      {
         this._frameTrackingBuckets = param5;
         _gameModel.gameEndScore(param1,param2,param3,this,param4);
      }
      
      public function onGameEnd(param1:GameEndResponse) : void
      {
         var _loc_11:SagaEvent = null;
         var _loc_12:int = 0;
         var _loc_13:Object = null;
         Console.println("@ onGameEnd() - CCModel.as");
         var _loc_2:* = param1.getCurrentUser();
         var _loc_3:* = param1.getEpisodeId();
         var _loc_4:* = param1.getLevelId();
         var _loc_5:* = param1.getLevelToplist();
         var _loc_6:* = param1.getScore();
         var _loc_7:* = param1.getStars();
         var _loc_8:* = param1.isBestResult();
         var _loc_9:* = param1.isNewStarLevel();
         var _loc_10:* = param1.getEvents();
         this._levelUnlockedEvent = null;
         this._episodeCompletedEvent = null;
         this._toplistFriendBeatenEvent = null;
         this._toplistFriendBeatenGoldEvent = null;
         this._mapFriendPassedEvent = null;
         this._mapFriendPassedGoldEvent = null;
         this._itemUnlockEvents = new Vector.<ItemGoldRewardEvent>();
         this._gameCompletedEvent = null;
         this._newStarLevelData.episodeId = _loc_3;
         this._newStarLevelData.levelId = _loc_4;
         this._newStarLevelData.isBestResult = _loc_8;
         this._newStarLevelData.isNewStarLevel = _loc_9;
         this._newStarLevelData.score = _loc_6;
         this._newStarLevelData.stars = _loc_7;
         for each(_loc_11 in _loc_10)
         {
            Console.println("EVENT " + _loc_11.getType());
            if(_loc_11 is LevelUnlockedEvent)
            {
               this._levelUnlockedEvent = _loc_11 as LevelUnlockedEvent;
            }
            if(_loc_11 is EpisodeCompletedEvent)
            {
               this._episodeCompletedEvent = _loc_11 as EpisodeCompletedEvent;
            }
            if(_loc_11 is ToplistFriendBeatenEvent)
            {
               _loc_12 = ToplistFriendBeatenEvent(_loc_11).getFriendUserId();
               if(this._userProfiles.exists(_loc_12))
               {
                  this._toplistFriendBeatenEvent = _loc_11 as ToplistFriendBeatenEvent;
                  this._friendBeatenData.episodeId = _loc_3;
                  this._friendBeatenData.levelId = _loc_4;
                  this._friendBeatenData.friendUserId = _loc_12;
                  this._friendBeatenData.friendUserIdStr = this.getUserProfile(this._friendBeatenData.friendUserId).getExternalUserId();
                  this._friendBeatenData.friendName = this.getUserProfile(this._friendBeatenData.friendUserId).getName();
               }
            }
            if(_loc_11 is ToplistFriendBeatenGoldEvent)
            {
               this._toplistFriendBeatenGoldEvent = _loc_11 as ToplistFriendBeatenGoldEvent;
            }
            if(_loc_11 is MapFriendPassedEvent)
            {
               _loc_12 = MapFriendPassedEvent(_loc_11).getFriendUserId();
               if(this._userProfiles.exists(_loc_12))
               {
                  this._mapFriendPassedEvent = _loc_11 as MapFriendPassedEvent;
                  this._friendPassedData.friendName = this.getUserProfile(this._mapFriendPassedEvent.getFriendUserId()).getName();
                  this._friendPassedData.friendUserIdStr = this.getUserProfile(_loc_12).getExternalUserId();
                  this._friendPassedData.episodeId = _loc_3;
                  this._friendPassedData.levelId = _loc_4;
                  this._friendPassedData.friendUserId = this._mapFriendPassedEvent.getFriendUserId();
               }
            }
            if(_loc_11 is MapFriendPassedGoldEvent)
            {
               this._mapFriendPassedGoldEvent = _loc_11 as MapFriendPassedGoldEvent;
            }
            if(_loc_11 is ItemGoldRewardEvent)
            {
               this._itemUnlockEvents.push(_loc_11 as ItemGoldRewardEvent);
            }
            if(_loc_11 is GameCompletedEvent)
            {
               this._gameCompletedEvent = _loc_11 as GameCompletedEvent;
            }
         }
         _gameModel.reportFramerate(_loc_3,_loc_4,this._frameTrackingBuckets[0],this._frameTrackingBuckets[1],this._frameTrackingBuckets[2],this._frameTrackingBuckets[3],this._frameTrackingBuckets[4],this._frameTrackingBuckets[5],this._frameTrackingBuckets[6],this._frameTrackingBuckets[7],this._frameTrackingBuckets[8],this._frameTrackingBuckets[9]);
         if(this.levelCompletedForTheFirstTime(this._levelUnlockedEvent,this._episodeCompletedEvent))
         {
            if(ExternalInterface.available)
            {
               _loc_13 = this.getLevelCompletedStory(_loc_3,_loc_4,_loc_7,_loc_6);
               ExternalInterface.call("Saga.publishStory","complete",_loc_13);
               ExternalInterface.call("Saga.publishStory","complete",_loc_13);
            }
         }
         dispatchEvent(new Event(CCModel.GAME_END_RESPONSE_RECEIVED));
      }
      
      private function levelCompletedForTheFirstTime(event:LevelUnlockedEvent, param2:EpisodeCompletedEvent) : Boolean
      {
         if(Boolean(event) || Boolean(param2))
         {
            return true;
         }
         return false;
      }
      
      public function onGameEndError(param1:String) : void
      {
         Console.println("onGameEndError: " + param1);
      }
      
      public function sendHighscoreLifeTo(param1:Number) : void
      {
         var _loc_2:UserProfile = null;
         var _loc_3:String = null;
         var _loc_4:String = null;
         var _loc_5:String = null;
         if(this._userProfiles.exists(param1))
         {
            _loc_2 = this.getUserProfile(param1);
            _loc_3 = _loc_2.getExternalUserId();
            _loc_4 = I18n.getString("facebook_send_life_scorelist_title");
            _loc_5 = I18n.getString("facebook_send_life_scorelist_message");
            if(ExternalInterface.available)
            {
               _gameModel.openGiveLifeRequest(_loc_4,_loc_5,_loc_3);
            }
         }
      }
      
      public function sendAcceptLifeRequestTo(param1:Number) : void
      {
         var _loc_2:UserProfile = null;
         var _loc_3:String = null;
         var _loc_4:String = null;
         var _loc_5:String = null;
         Console.println("@ sendAcceptLifeRequestTo() : friendId: " + param1);
         if(this._userProfiles.exists(param1))
         {
            _loc_2 = this.getUserProfile(param1);
            _loc_3 = _loc_2.getExternalUserId();
            _loc_4 = I18n.getString("facebook_send_life_accepted_title");
            _loc_5 = I18n.getString("facebook_send_life_accepted_message");
            if(ExternalInterface.available)
            {
               _gameModel.openGiveLifeRequest(_loc_4,_loc_5,_loc_3);
            }
         }
      }
      
      public function sendAcceptUnlockRequestTo(param1:Number, param2:int, param3:int) : void
      {
         var _loc_4:UserProfile = null;
         var _loc_5:String = null;
         var _loc_6:String = null;
         var _loc_7:String = null;
         if(this._userProfiles.exists(param1))
         {
            _loc_4 = this.getUserProfile(param1);
            _loc_5 = _loc_4.getExternalUserId();
            _loc_6 = I18n.getString("facebook_send_help_accept_title");
            _loc_7 = I18n.getString("facebook_send_help_accept_message");
            if(ExternalInterface.available)
            {
               _gameModel.openAcceptLevelUnlockRequest(_loc_6,_loc_7,_loc_5,param2,param3);
            }
         }
      }
      
      public function loadTopListByLevel(param1:int, param2:int, param3:IToplistListener) : void
      {
         _gameModel.getLevelToplist(param1,param2,param3);
      }
      
      public function getExtraLifeProduct() : ExtraLifeProduct
      {
         if(this._extraLifeProducts.length > 0)
         {
            return this._extraLifeProducts[0];
         }
         return null;
      }
      
      public function getPlayerItems() : Vector.<ItemInfo>
      {
         return this._playerItems;
      }
      
      public function getItemProductByType(param1:String) : ItemProduct
      {
         var _loc_2:ItemProduct = null;
         for each(_loc_2 in this._itemProducts)
         {
            if(_loc_2.getType() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
      
      public function getItemBalance(param1:IGetBalanceListener) : void
      {
         this._getBalanceListener = param1;
         _gameModel.getBalance(this);
      }
      
      public function getRecipes(param1:IGetRecipesListener) : void
      {
         this._getRecipesListener = param1;
         _gameModel.getRecipes(this);
      }
      
      public function useItemsInGame(param1:ICraftListener, param2:Vector.<ItemAmount>, param3:int, param4:int) : void
      {
         this._craftListener = param1;
         _gameModel.useItemsInGame(this,param2,param3,param4);
      }
      
      public function handOutItemWinnings(param1:ICraftListener, param2:Vector.<ItemAmount>, param3:int, param4:int) : void
      {
         this._craftListener = param1;
         _gameModel.handOutItemWinnings(this,param2,param3,param4);
      }
      
      public function craft(param1:ICraftListener, param2:String) : void
      {
         this._craftListener = param1;
         _gameModel.craft(this,param2);
      }
      
      public function unlockItem(param1:ICraftListener, param2:String, param3:String) : void
      {
         this._craftListener = param1;
         _gameModel.unlockItem(this,param2);
         this._ccMain.queueItemUnlockedPop(param2,param3);
      }
      
      public function onGetBalance(param1:GetBalanceResponse) : void
      {
         this._playerItems = param1.getBalance();
         this._getBalanceListener.onGetBalance(param1);
      }
      
      public function onGetRecipes(param1:GetRecipesResponse) : void
      {
         this._getRecipesListener.onGetRecipes(param1);
      }
      
      public function onCraft(param1:CraftResponse) : void
      {
         this._playerItems = param1.getItemBalance();
         this._craftListener.onCraft(param1);
      }
      
      public function friendHasBeenPassed() : Boolean
      {
         if(this._mapFriendPassedEvent != null)
         {
            return true;
         }
         return false;
      }
      
      public function getUserActiveEpisode() : int
      {
         return _userData.activeEpisode;
      }
      
      public function getUserActiveLevel() : int
      {
         return _userData.activeLevel;
      }
      
      public function getUniverseDescription() : UniverseDescription
      {
         return this._universeDescription;
      }
      
      public function getUserUnivserse() : UserUniverse
      {
         return this._userUniverse;
      }
      
      public function getCurrentUser() : CurrentUser
      {
         return this._currentUser;
      }
      
      public function getUserProfiles() : UserProfiles
      {
         return this._userProfiles;
      }
      
      public function getLevelDescription(param1:int, param2:int) : LevelDescription
      {
         return this._universeDescription.getLevelDescription(param1,param2);
      }
      
      public function getNumberOfLevels(param1:int) : int
      {
         return this._universeDescription.getEpisodeDescription(param1).getLevelDescriptions().length;
      }
      
      public function getLevelIndex(param1:int, param2:int) : int
      {
         var _loc_3:int = 0;
         var _loc_4:int = 1;
         while(_loc_4 < param1)
         {
            _loc_3 += this.getNumberOfLevels(_loc_4);
            _loc_4++;
         }
         return _loc_3 + param2;
      }
      
      public function getUserProfile(param1:Number) : UserProfile
      {
         if(this._userProfiles.exists(param1))
         {
            return this.getUserProfiles().getUserProfile(param1);
         }
         return null;
      }
      
      public function getLevelStars(param1:int, param2:int) : int
      {
         return this._userUniverse.getUserLevel(param1,param2).getStars();
      }
      
      public function getBestScoreEver(param1:int, param2:int) : int
      {
         return this.getUserUnivserse().getUserLevel(param1,param2).getScore();
      }
      
      public function getAllCollaborationHelpers() : Array
      {
         var _loc_3:UserEpisode = null;
         var _loc_4:int = 0;
         var _loc_5:Vector.<Number> = null;
         var _loc_1:Array = [];
         var _loc_2:* = this._userUniverse.getUserEpisodes();
         for each(_loc_3 in _loc_2)
         {
            _loc_4 = _loc_3.getEpisodeId();
            _loc_5 = this.getCollaborationHelpersByEpisode(_loc_4);
            _loc_1[_loc_4] = _loc_5;
         }
         return _loc_1;
      }
      
      public function getCollaborationHelpersByEpisode(param1:int) : Vector.<Number>
      {
         var _loc_2:UserEpisode = null;
         var _loc_3:UserLevel = null;
         var _loc_4:FriendInviteData = null;
         var _loc_5:Vector.<Number> = null;
         if(this._userUniverse.hasUserEpisode(param1))
         {
            _loc_2 = this._userUniverse.getUserEpisode(param1);
            _loc_3 = _loc_2.getUserLevel(1);
            _loc_4 = _loc_3.getFriendInviteData();
            return _loc_4 != null ? _loc_4.getUserIds() : null;
         }
         return null;
      }
      
      public function getPlayerIsNew() : Boolean
      {
         if(this.getCurrentUserTopEpisode() == 1 && this.getCurrentUserTopLevel() == 1)
         {
            return true;
         }
         return false;
      }
      
      public function getCurrentUserTopEpisode() : int
      {
         var _loc_1:* = this._currentUser.getUserId();
         var _loc_2:* = this._userProfiles.getUserProfile(_loc_1);
         return _loc_2.getTopEpisode();
      }
      
      public function getCurrentUserTopLevel() : int
      {
         var _loc_1:* = this._currentUser.getUserId();
         var _loc_2:* = this._userProfiles.getUserProfile(_loc_1);
         return _loc_2.getTopLevel();
      }
      
      public function getNextScoreTarget(param1:int, param2:int) : int
      {
         var _loc_5:int = 0;
         var _loc_7:StarProgression = null;
         var _loc_3:* = this.getLevelStars(param1,param2);
         var _loc_4:* = this.getLevelDescription(param1,param2).getStarProgressions();
         var _loc_6:* = _loc_3 < 3 ? _loc_3 + 1 : _loc_3;
         for each(_loc_7 in _loc_4)
         {
            if(_loc_7.getNumberOfStars() == _loc_6)
            {
               _loc_5 = _loc_7.getPoints();
            }
         }
         return _loc_5;
      }
      
      public function getScoreTarget(param1:int, param2:int, param3:int) : int
      {
         var _loc_5:StarProgression = null;
         var _loc_4:* = this._universeDescription.getLevelDescription(param1,param2).getStarProgressions();
         for each(_loc_5 in _loc_4)
         {
            if(_loc_5.getNumberOfStars() == param3)
            {
               return _loc_5.getPoints();
            }
         }
         return -1;
      }
      
      public function getGameConf(param1:int, param2:int) : GameConf
      {
         return this._candyApi.getGameConf(param1,param2);
      }
      
      public function getLevelInfoVI(param1:int, param2:int) : LevelInfoVO
      {
         return this._candyApi.getGameConf(param1,param2).getGameInfoVI();
      }
      
      public function getAllLevelInfoVO() : Vector.<LevelInfoVO>
      {
         return this._candyApi.getAllLevelInfoVO();
      }
      
      public function getLevelUnlockedData() : LevelUnlockVO
      {
         if(this._levelUnlockedEvent == null)
         {
            return null;
         }
         var _loc_1:* = new LevelUnlockVO();
         _loc_1.episodeId = this._levelUnlockedEvent.getEpisodeId();
         _loc_1.levelId = this._levelUnlockedEvent.getLevelId();
         return _loc_1;
      }
      
      public function getEpisodeCompleted() : int
      {
         if(this._episodeCompletedEvent == null)
         {
            return 0;
         }
         return this._episodeCompletedEvent.getEpisodeId();
      }
      
      public function getNextLifeGiftReceived() : GiftReceivedVO
      {
         return this._lifeGiftsReceived.shift();
      }
      
      public function getNewStarLevelData() : StarLevelVO
      {
         return this._newStarLevelData;
      }
      
      public function getEpisodeUnlocked() : int
      {
         if(Boolean(this._levelUnlockedEvent))
         {
            if(this._levelUnlockedEvent.getLevelId() == 1)
            {
               return this._levelUnlockedEvent.getEpisodeId();
            }
         }
         return 0;
      }
      
      public function getNextUnlockHelp() : UnlockGift
      {
         if(this._helpAcceptedEvents != null)
         {
            return this._helpAcceptedEvents.shift() as UnlockGift;
         }
         return null;
      }
      
      public function getGameModeName(param1:int, param2:int) : String
      {
         return this._candyApi.getGameModeName(param1,param2);
      }
      
      public function isShortCutsceneVersion(param1:String) : Boolean
      {
         var _loc_2:* = this.getUserActiveLevel();
         var _loc_3:* = this.getUserActiveEpisode();
         if(_loc_2 == 1)
         {
            return false;
         }
         var _loc_4:* = this.getLastLevelId(_loc_3);
         if(_loc_2 == _loc_4 && param1 == CutsceneConstants.CUTSCENE_TYPE_RESOLUTION)
         {
            return false;
         }
         return true;
      }
      
      public function getLastLevelId(param1:int) : int
      {
         var _loc_2:* = this._universeDescription.getEpisodeDescription(param1);
         var _loc_3:* = _loc_2.getLevelDescriptions();
         return _loc_2.getLevelDescriptions().length;
      }
      
      public function getHighScoreListData() : HighScoreListVO
      {
         return this._highScoreListData;
      }
      
      public function getFriendBeatenData() : FriendBeatenVO
      {
         return this._friendBeatenData;
      }
      
      public function getFriendPassedData() : FriendPassedVO
      {
         return this._friendPassedData;
      }
      
      public function setUserActiveEpisode(param1:int) : void
      {
         _userData.activeEpisode = param1;
      }
      
      public function setUserActiveLevel(param1:int) : void
      {
         _userData.activeLevel = param1;
      }
      
      public function setSound(param1:Boolean) : void
      {
         _gameModel.setSound(param1);
      }
      
      public function setMusic(param1:Boolean) : void
      {
         _gameModel.setMusic(param1);
      }
      
      public function getInitialSoundFXSetting() : Boolean
      {
         return this._currentUser.getSoundFx();
      }
      
      public function getInitialMusicSetting() : Boolean
      {
         return this._currentUser.getSoundMusic();
      }
      
      public function openInviteDialog(param1:String, param2:String) : void
      {
         MonsterDebugger.trace(this,"openInviteDialog");
         _gameModel.openInviteDialog(param1,param2);
      }
      
      public function openLikeDialog(param1:Function) : void
      {
         MonsterDebugger.trace(this,"openLikeDialog");
         _gameModel.openLikeDialog(param1);
      }
      
      public function openRateDialog() : void
      {
         MonsterDebugger.trace(this,"openRateDialog");
         _gameModel.openRateDialog();
      }
      
      public function requestCollaborationHelp(param1:String) : void
      {
         MonsterDebugger.trace(this,"requestCollaborationHelp stationString=" + param1);
         var _loc_2:* = I18n.getString("facebook_request_collaboration_help_title");
         var _loc_3:* = I18n.getString("facebook_request_collaboration_help_message");
         _gameModel.getHelpLevelUnlock(_loc_2,_loc_3,this.toArr(param1)[0],this.toArr(param1)[1]);
      }
      
      private function toArr(param1:String) : Array
      {
         return param1.split(":");
      }
      
      public function buyAnyProduct(param1:int, param2:int, param3:IBuyAnyProductListener) : void
      {
         Console.println("@ buyAnyProduct() - CCModel.as | productId:" + param1 + " | category:" + param2 + " listener:" + param3);
         this._buyAnyProductListener = param3;
         _gameModel.buyAnyProduct(param1,param2,this);
      }
      
      public function buyCollaborationProduct(param1:int, param2:String) : void
      {
         _gameModel.buyLevelUnlockProduct(param1,this,this.toArr(param2)[0],this.toArr(param2)[1]);
      }
      
      public function onBuyCollaborationProduct(param1:String, param2:String, param3:int) : void
      {
         dispatchEvent(new Event(COLLABORATION_PURCHASE_STATUS));
      }
      
      public function getCollaborationProductForOpenSlots(param1:int) : CollaborationProduct
      {
         var _loc_3:CollaborationProduct = null;
         var _loc_2:int = 0;
         while(_loc_2 < this._collaborationProducts.length)
         {
            _loc_3 = CollaborationProduct(this._collaborationProducts[_loc_2]);
            if(_loc_3.getNoOfInvites() == param1)
            {
               return _loc_3;
            }
            _loc_2++;
         }
         return null;
      }
      
      public function buyFullLives() : void
      {
         _gameModel.buyLifeProduct(this.getLifeProductFullLife().getId(),this);
      }
      
      public function onBuyLifeProduct(param1:String, param2:String, param3:int) : void
      {
         MonsterDebugger.trace(this," onBuyLifeProduct status=" + param1);
         dispatchEvent(new ModelEvent(LIVES_UPDATED,param1 == "ok"));
      }
      
      public function getLifeProductFullLife() : LifeProduct
      {
         var _loc_2:LifeProduct = null;
         var _loc_1:LifeProduct = null;
         for each(_loc_2 in this._lifeProducts)
         {
            if(_loc_2.getName() == "full_life")
            {
               _loc_1 = _loc_2;
               break;
            }
         }
         return _loc_1;
      }
      
      public function askForLives() : void
      {
         MonsterDebugger.trace(this,"askForLives");
         var _loc_1:* = I18n.getString("facebook_request_life_help_title");
         var _loc_2:* = I18n.getString("facebook_request_life_help_message");
         _gameModel.openAskForLifeRequest(_loc_1,_loc_2);
      }
      
      public function getAdsEnabled() : Boolean
      {
         return this._adsEnabled;
      }
      
      public function getCustomTimeToNextRegeneration() : int
      {
         return this.customTimeToNextRegeneration;
      }
      
      public function getInviteFriendNum() : int
      {
         return this._currentUser.ivtotal;
      }
      
      public function getInviteFriendLevel() : int
      {
         return 0;
      }
      
      public function setCustomTimeToNextRegeneration(param1:int) : void
      {
         this.customTimeToNextRegeneration = param1;
      }
      
      public function onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         Console.println("@ onBuyAnyProduct() - CCModel.as");
         this._buyAnyProductListener.onBuyAnyProduct(param1,param2,param3,param4);
         this.getItemBalance(this._ccMain.getInventory());
      }
      
      public function getInventory() : Inventory
      {
         return this._ccMain.getInventory();
      }
      
      public function getMessages() : void
      {
         _gameModel.getMessages(this);
      }
      
      public function shareFriendBeaten(param1:String, param2:int, param3:String, param4:int, param5:int) : void
      {
         var _loc_6:* = param5 - param4;
         var _loc_7:* = I18n.getString("facebook_friend_beaten_share_name",param5,_loc_6);
         var _loc_8:* = I18n.getString("facebook_friend_beaten_share_promt",param2,param3);
         var _loc_9:* = I18n.getString("facebook_friend_beaten_share_description");
         if(ExternalInterface.available)
         {
            _gameModel.openShareGoldDialog(_loc_7,_loc_9,_loc_8,"share/FriendBeatenSmall.png",10,param1);
         }
      }
      
      public function shareFriendPassed(param1:String, param2:int) : void
      {
         var _loc_3:* = I18n.getString("facebook_friend_passed_share_name",param2);
         var _loc_4:* = I18n.getString("facebook_friend_passed_share_promt");
         var _loc_5:* = I18n.getString("facebook_friend_passed_share_description");
         if(ExternalInterface.available)
         {
            _gameModel.openShareGoldDialog(_loc_3,_loc_5,_loc_4,"share/FriendPassed.png",10,param1);
         }
      }
      
      public function episodeComplete(param1:int) : void
      {
         var _loc_2:* = I18n.getString("facebook_episode_complete_share_name",param1);
         var _loc_3:* = I18n.getString("facebook_episode_complete_share_promt",param1);
         var _loc_4:* = I18n.getString("facebook_episode_complete_share_description");
         var _loc_5:String = "share/90x90share_pic.jpg";
         switch(param1)
         {
            case 1:
               _loc_5 = "share/LevelComplete_CandyTownSmall.png";
               break;
            case 2:
               _loc_5 = "share/LevelComplete_CandyFactorySmall.png";
               break;
            case 3:
               _loc_5 = "share/LevelComplete_LemonadeLakeSmall.png";
               break;
            case 4:
               _loc_5 = "share/LevelComplete_ChocMountainSmall.png";
               break;
            case 5:
               _loc_5 = "share/LevelComplete_LollipopForestSmall.png";
               break;
            case 6:
               _loc_5 = "share/LevelComplete_BunnyHillsSmall.png";
               break;
            case 7:
               _loc_5 = "share/LevelComplete_TuggumitrollSmall.png";
               break;
            case 8:
               _loc_5 = "share/LevelComplete_SaltyCanyonSmall.png";
               break;
            default:
               _loc_5 = "share/90x90share_pic.jpg";
         }
         if(ExternalInterface.available)
         {
            _gameModel.openShareGoldDialog(_loc_2,_loc_4,_loc_3,_loc_5,10);
         }
      }
      
      public function shareCompletedLevel(param1:int, param2:int, param3:int) : void
      {
         var _loc_4:* = I18n.getString("popup_game_over_victory_name",param1,param2,param3);
         var _loc_5:* = I18n.getString("popup_game_over_victory_promt",param1,param2);
         var _loc_6:* = I18n.getString("popup_game_over_victory_description",param1,param2,param3);
         var _loc_7:String = "share/90x90share_pic.jpg";
         switch(param3)
         {
            case 1:
               _loc_7 = "share/90x90share_pic.jpg";
               break;
            case 2:
               _loc_7 = "share/TwoStarsSmall.png";
               break;
            case 3:
               _loc_7 = "share/ThreeStarsSmall.png";
               break;
            default:
               _loc_7 = "share/90x90share_pic.jpg";
         }
         if(ExternalInterface.available)
         {
            _gameModel.openShareGoldDialog(_loc_4,_loc_6,_loc_5,_loc_7,10);
         }
      }
      
      public function shareUnlockedBooster(param1:String, param2:String) : void
      {
         var _loc_3:* = I18n.getString("popup_unlocked_item_name",param1);
         var _loc_4:* = I18n.getString("popup_unlocked_item_promt",param1);
         var _loc_5:* = I18n.getString("popup_unlocked_item_description",param2);
      }
      
      public function setSeenBoosterTut(param1:String) : void
      {
         this._candyApi.setSeenBoosterTut(param1);
      }
      
      public function getSeenBoosterTut(param1:String) : Boolean
      {
         return this._candyApi.getSeenBoosterTut(param1);
      }
      
      public function getCharmInventory() : CharmInventory
      {
         return new CharmInventory(this);
      }
      
      public function getCharmDailyOffer() : DailyOfferCharmInventory
      {
         return DailyOfferCharmInventory.createEmpty(this);
      }
      
      private function getLevelCompletedStory(param1:int, param2:int, param3:int, param4:Number) : Object
      {
         var _loc_5:* = new Object();
         _loc_5.number = param1;
         var _loc_6:* = new Object();
         _loc_5.episode = _loc_5;
         _loc_6.number = this.getTotalLevel(param1,param2);
         var _loc_7:* = new Object();
         _loc_5.level = _loc_6;
         _loc_7.stars = param3;
         _loc_7.score = param4;
         return _loc_7;
      }
      
      public function get missionsModel() : CCMissionsModel
      {
         return this._missionsModel;
      }
      
      public function get levelReward() : Vector.<Award>
      {
         return this._levelReward;
      }
      
      public function get inviteReward() : Vector.<Award>
      {
         return this._inviteReward;
      }
   }
}

import flash.events.EventDispatcher;

