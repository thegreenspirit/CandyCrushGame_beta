package com.king.saga.api
{
   import com.adobe.crypto.*;
   import com.king.saga.api.crafting.*;
   import com.king.saga.api.event.*;
   import com.king.saga.api.listener.*;
   import com.king.saga.api.net.*;
   import com.king.saga.api.response.*;
   import com.king.saga.api.toplist.*;
   import com.king.saga.api.universe.*;
   import com.king.saga.api.universe.condition.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.debug.*;
   import com.midasplayer.text.I18n;
   import com.midasplayer.util.TypedKeyVal;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class GameModel
   {
      private static const _NotInitialized:String = "NotInitialized";
      
      private static const _WaitingForGameInit:String = "WaitingForGameInit";
      
      private static const _Idle:String = "Idle";
      
      private var _gameInit:GameInitResponse;
      
      private var _sagaApi:ISagaApi;
      
      private var _socialApi:ISocialApi;
      
      private var _secretForHash:String;
      
      private var _state:String = "NotInitialized";
      
      private var _gameInitListener:IGameInitListener;
      
      private var _gameStartListener:IGameStartListener;
      
      private var _gameEndListener:IGameEndListener;
      
      private var _toplistListener:IToplistListener;
      
      private var _buyBoosterListener:IBuyBoosterListener;
      
      private var _pollListener:IPollListener;
      
      private var _removeLifeListener:IRemoveLifeListener;
      
      private var _buyLifeProductListener:IBuyLifeProductListener;
      
      private var _buyCollaborationProductListener:IBuyCollaborationProductListener;
      
      private var _buyGoldProductListener:IBuyGoldProductListener;
      
      private var _buyAnyProductListener:IBuyAnyProductListener;
      
      private var _buyAnyProductToListener:IBuyAnyProductToListener;
      
      private var _buyIngameListener:IBuyIngameListener;
      
      private var _getMessagesListener:IGetMessagesListener;
      
      private var _getRecipesListener:IGetRecipesListener;
      
      private var _craftListener:ICraftListener;
      
      private var _getBalanceListener:IGetBalanceListener;
      
      private var _seed:Number;
      
      private var _cachedToplistResponses:LevelToplistResponses;
      
      private var _eventFactory:IEventFactory;
      
      private var _buyRecipeTopupProductListener:IBuyRecipeTopupListener;
      
      public function GameModel(param1:ISagaApi, param2:ISocialApi, param3:String, param4:IEventFactory = null)
      {
         super();
         this._cachedToplistResponses = new LevelToplistResponses();
         this._sagaApi = param1;
         this._socialApi = param2;
         this._secretForHash = param3;
         this._eventFactory = param4;
      }
      
      public static function createDefaultEventFactory() : IEventFactory
      {
         return new EventFactory();
      }
      
      public function get socialApi() : ISocialApi
      {
         return this._socialApi;
      }
      
      public function gameInit(param1:IGameInitListener) : void
      {
         Debug.assert(param1 != null,"You must specify a game init listener.");
         this._gameInitListener = param1;
         this._state = _WaitingForGameInit;
         this._sagaApi.gameInit(this._onGameInit);
      }
      
      public function sagaInit(param1:IGameInitListener, param2:Boolean) : void
      {
         Debug.assert(param1 != null,"You must specify a game init listener.");
         this._gameInitListener = param1;
         this._state = _WaitingForGameInit;
         this._sagaApi.sagaInit(this._onGameInit,param2);
      }
      
      public function gameStart(param1:int, param2:int, param3:IGameStartListener) : void
      {
         Debug.assert(param3 != null,"You must specify a game start listener.");
         this._gameStartListener = param3;
         this._verifyIdle();
         this._sagaApi.gameStart(this._onGameStart,param1,param2);
      }
      
      public function gameEndScore(param1:int, param2:int, param3:int, param4:IGameEndListener, param5:int) : void
      {
         this.gameEndTimeLeft(param1,param2,param3,-1,param4,param5);
      }
      
      public function gameEndTimeLeft(param1:int, param2:int, param3:int, param4:int, param5:IGameEndListener, param6:int) : void
      {
         var _loc_7:Number = NaN;
         Debug.assert(param5 != null,"You must specify a game end listener.");
         this._gameEndListener = param5;
         this._verifyIdle();
         _loc_7 = this._gameInit.getCurrentUser().getUserId();
         var _loc_8:* = MD5.hash(param1 + ":" + param2 + ":" + param3 + ":" + param4 + ":" + _loc_7 + ":" + this._seed + ":" + this._secretForHash);
         this._sagaApi.gameEnd(this._onGameEnd,param1,param2,param3,param6,this._seed,param4,_loc_8.substr(0,6));
      }
      
      public function reportFramerate(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int) : void
      {
         this._verifyIdle();
         this._sagaApi.reportFramerate(param1,param2,this._seed,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function poll(param1:IPollListener) : void
      {
         Debug.assert(param1 != null,"You must specify a poll listener.");
         this._pollListener = param1;
         this._verifyIdle();
         this._sagaApi.poll(this._onPoll);
      }
      
      public function getMessages(param1:IGetMessagesListener) : void
      {
         Debug.assert(param1 != null,"You must specify a get messages listener.");
         this._getMessagesListener = param1;
         this._verifyIdle();
         this._sagaApi.getMessages(this._onGetMessages);
      }
      
      public function removeLife(param1:IRemoveLifeListener) : void
      {
         Debug.assert(param1 != null,"You must specify a remove life listener.");
         this._removeLifeListener = param1;
         this._verifyIdle();
         this._sagaApi.removeLife(this._onRemoveLife);
      }
      
      public function getLevelToplist(param1:int, param2:int, param3:IToplistListener) : void
      {
         Debug.assert(param3 != null,"You must specify a toplist listener.");
         this._toplistListener = param3;
         this._verifyIdle();
         if(this._cachedToplistResponses.exists(param1,param2))
         {
            param3.onGetToplist(this._cachedToplistResponses.getLevelToplist(param1,param2).getLevelToplistProfiles());
         }
         else
         {
            this._sagaApi.getLevelToplist(this._onGetLevelToplist,param1,param2);
         }
      }
      
      public function buyBooster(param1:String, param2:IBuyBoosterListener) : void
      {
         Debug.assert(param2 != null,"You must specify a buy booster listener.");
         this._buyBoosterListener = param2;
         this._verifyIdle();
         this._sagaApi.buyBooster(this._onBuyBooster,param1);
      }
      
      public function getRecipes(param1:IGetRecipesListener) : void
      {
         Debug.assert(param1 != null,"You must specify a recipes listener.");
         this._getRecipesListener = param1;
         this._verifyIdle();
         this._sagaApi.getRecipes(this._onGetRecipes);
      }
      
      public function craft(param1:ICraftListener, param2:String) : void
      {
         Debug.assert(param1 != null,"You must specify a craft listener.");
         this._craftListener = param1;
         this._verifyIdle();
         this._sagaApi.craft(this._onCraft,param2);
      }
      
      public function getBalance(param1:IGetBalanceListener) : void
      {
         Debug.assert(param1 != null,"You must specify a get balance listener.");
         this._getBalanceListener = param1;
         this._verifyIdle();
         this._sagaApi.getBalance(this._onGetBalance);
      }
      
      public function useItemsInGame(param1:ICraftListener, param2:Vector.<ItemAmount>, param3:int, param4:int) : void
      {
         Debug.assert(param1 != null,"You must specify a craft listener.");
         this._craftListener = param1;
         this._verifyIdle();
         this._sagaApi.useItemsInGame(this._onCraft,param2,param3,param4);
      }
      
      public function handOutItemWinnings(param1:ICraftListener, param2:Vector.<ItemAmount>, param3:int, param4:int) : void
      {
         Debug.assert(param1 != null,"You must specify a craft listener.");
         this._craftListener = param1;
         this._verifyIdle();
         this._sagaApi.handOutItemWinnings(this._onCraft,param2,param3,param4,"hash");
      }
      
      public function unlockItem(param1:ICraftListener, param2:String) : void
      {
         Debug.assert(param1 != null,"You must specify a craft listener.");
         this._craftListener = param1;
         this._verifyIdle();
         this._sagaApi.unlockItem(this._onCraft,param2,"hash");
      }
      
      public function activateItem(param1:ICraftListener, param2:String) : void
      {
         Debug.assert(param1 != null,"You must specify a craft listener.");
         this._craftListener = param1;
         this._verifyIdle();
         this._sagaApi.activateItem(this._onCraft,param2,"hash");
      }
      
      public function deactivateItem(param1:ICraftListener, param2:String) : void
      {
         Debug.assert(param1 != null,"You must specify a craft listener.");
         this._craftListener = param1;
         this._verifyIdle();
         this._sagaApi.deactivateItem(this._onCraft,param2,"hash");
      }
      
      public function getLevelToplists(param1:IToplistListener) : void
      {
         Debug.assert(param1 != null,"You must specify a toplist listener.");
         this._toplistListener = param1;
         this._verifyIdle();
         this._sagaApi.getLevelToplists(this._onGetLevelToplists);
      }
      
      public function setSound(param1:Boolean) : void
      {
         this._sagaApi.setSound(param1);
      }
      
      public function setMusic(param1:Boolean) : void
      {
         this._sagaApi.setMusic(param1);
      }
      
      public function buyGoldProduct(param1:int, param2:IBuyGoldProductListener) : void
      {
         Debug.assert(param2 != null,"You must specify a buy gold product listener.");
         this._buyGoldProductListener = param2;
         this._verifyIdle();
         this._socialApi.buyGoldProduct(this._onBuyGoldProduct,param1);
      }
      
      public function buyLifeProduct(param1:int, param2:IBuyLifeProductListener) : void
      {
         Debug.assert(param2 != null,"You must specify a buy life product listener.");
         this._buyLifeProductListener = param2;
         this._verifyIdle();
         this._socialApi.buyLifeProduct(this._onBuyLifeProduct,param1);
      }
      
      public function buyIngameProduct(param1:int, param2:IBuyIngameListener) : void
      {
         Debug.assert(param2 != null,"You must specify an ingame product listener.");
         this._buyIngameListener = param2;
         this._verifyIdle();
         this._socialApi.buyIngameProduct(this._onBuyIngameProduct,param1);
      }
      
      public function buyLevelUnlockProduct(param1:int, param2:IBuyCollaborationProductListener, param3:int, param4:int) : void
      {
         Debug.assert(param2 != null,"You must specify a buy level product listener.");
         this._buyCollaborationProductListener = param2;
         this._verifyIdle();
         this._socialApi.buyLevelUnlockProduct(this._onBuyLevelUnlockProduct,param1,param3,param4);
      }
      
      public function buyAnyProduct(param1:int, param2:int, param3:IBuyAnyProductListener) : void
      {
         Debug.assert(param3 != null,"You must specify an any product listener.");
         this._buyAnyProductListener = param3;
         this._verifyIdle();
         this._socialApi.buyAnyProduct(this._onBuyAnyProduct,param2,param1);
      }
      
      public function buyAnyProductTo(param1:int, param2:int, param3:Number, param4:IBuyAnyProductToListener) : void
      {
         Debug.assert(param4 != null,"You must specify an any product listener (buyAnyProductTo).");
         this._buyAnyProductToListener = param4;
         this._verifyIdle();
         this._socialApi.buyAnyProductTo(this._onBuyAnyProductTo,param2,param1,param3);
      }
      
      public function buyRecipeTopupProduct(param1:Vector.<ItemAmount>, param2:String, param3:IBuyRecipeTopupListener) : void
      {
         Debug.assert(param3 != null,"You must specify a buy life product listener.");
         this._buyRecipeTopupProductListener = param3;
         this._verifyIdle();
         this._socialApi.buyRecipeTopupProduct(this._onBuyRecipeTopup,param1,param2);
      }
      
      public function openShareGoldDialog(param1:String, param2:String, param3:String, param4:String, param5:int, param6:String = null) : void
      {
         this._socialApi.openShareGoldDialog(param1,param2,param3,param4,param5,param6);
      }
      
      public function openShareItemDialog(param1:String, param2:String, param3:String, param4:String, param5:ItemAmount, param6:String = null) : void
      {
         Debug.assert(param5 != null,"You must specitfy an ItemAmount.");
         this._socialApi.openShareItemDialog(param1,param2,param3,param4,param5,param6);
      }
      
      public function openAskForItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String = null, param5:String = "") : void
      {
         Debug.assert(param3 != null,"You must specify an ItemAmount.");
         this._socialApi.openAskForItemRequest(param1,param2,param3,param4,param5);
      }
      
      public function openGiveItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String, param5:String = "") : void
      {
         Debug.assert(param3 != null,"You must specify an ItemAmount.");
         Debug.assert(param4 != null,"You must specify a receiving user.");
         this._socialApi.openGiveItemRequest(param1,param2,param3,param4,param5);
      }
      
      public function performOpenGraphAction(param1:String, param2:String, param3:int) : void
      {
         this._socialApi.performOpenGraphAction(param1,param2,param3);
      }
      
      public function notificationToMany(param1:String, param2:String, param3:Vector.<String>) : void
      {
         this._socialApi.notificationToMany(param1,param2,param3);
      }
      
      public function sendMapFriendPassedToMany(param1:String, param2:String, param3:Vector.<String>) : void
      {
         this._socialApi.sendMapFriendPassedToMany(param1,param2,param3);
      }
      
      public function sendToplistFriendBeatenToMany(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:int) : void
      {
         this._socialApi.sendToplistFriendBeatenToMany(param1,param2,param3,param4,param5,param6);
      }
      
      public function openLikeDialog(param1:Function = null) : void
      {
         this._socialApi.openLikeDialog(param1);
      }
      
      public function openRateDialog() : void
      {
         this._socialApi.openRateDialog();
      }
      
      public function openInviteDialog(param1:String, param2:String, param3:Function = null, param4:String = "") : void
      {
         this._socialApi.openInviteDialog(param1,param2,param3,param4);
      }
      
      public function openGiveGoldRequest(param1:String, param2:String, param3:String, param4:String = "") : void
      {
         this._socialApi.openGiveGoldRequest(param1,param2,param3,param4);
      }
      
      public function openGiveLifeRequest(param1:String, param2:String, param3:String, param4:String = "") : void
      {
         this._socialApi.openGiveLifeRequest(param1,param2,param3,param4);
      }
      
      public function openAskForLifeRequest(param1:String, param2:String, param3:String = null, param4:String = "") : void
      {
         this._socialApi.openAskForLifeRequest(param1,param2,param3,param4);
      }
      
      public function openGiveLifeToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void
      {
         this._socialApi.openGiveLifeToManyRequest(param1,param2,param3,param4);
      }
      
      public function openGiveGoldToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void
      {
         this._socialApi.openGiveGoldToManyRequest(param1,param2,param3,param4);
      }
      
      public function openGiveHelpToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:String = "") : void
      {
         this._socialApi.openGiveHelpToManyRequest(param1,param2,param3,param4,param5,param6);
      }
      
      public function openAcceptLevelUnlockRequest(param1:String, param2:String, param3:String, param4:int, param5:int, param6:String = "") : void
      {
         this._socialApi.openAcceptLevelUnlockRequest(param1,param2,param3,param4,param5,param6);
      }
      
      public function notifyProductGiftToUser(param1:String, param2:String, param3:int, param4:int, param5:String, param6:String = "") : void
      {
         this._socialApi.notifyProductGiftToUser(param1,param2,param3,param4,param5,param6);
      }
      
      public function getHelpLevelUnlock(param1:String, param2:String, param3:int, param4:int, param5:String = "") : void
      {
         this._socialApi.openInviteCollaborationFriendsDialog(param1,param2,param3,param4,param5);
      }
      
      public function shareLevelComplete(param1:int, param2:int, param3:int) : void
      {
         this._socialApi.shareLevelComplete(param1,param2,param3);
      }
      
      public function earnFunds(param1:IEarnFundsListener) : void
      {
         Debug.assert(param1 != null,"EarnFundsListener is null");
         this._socialApi.earnFunds(param1);
      }
      
      public function depositFunds(param1:IDepositFundsListener) : void
      {
         Debug.assert(param1 != null,"DepositFundsListener is null");
         this._socialApi.depositFunds(param1);
      }
      
      public function hasEarnFunds(param1:IEarnFundsListener) : void
      {
         Debug.assert(param1 != null,"EarnFundsListener is null");
         this._socialApi.hasEarnFunds(param1);
      }
      
      public function hasDepositFunds(param1:IDepositFundsListener) : void
      {
         Debug.assert(param1 != null,"DepositFundsListener is null");
         this._socialApi.hasDepositFunds(param1);
      }
      
      public function getDoesLike(param1:Function) : void
      {
         this._socialApi.getDoesLike(param1);
      }
      
      public function reload() : void
      {
         this._socialApi.reload();
      }
      
      private function _onGameInit(param1:Object, param2:Object) : void
      {
         Debug.assert(this._state == _WaitingForGameInit,"Expected waiting for game init state but it is: " + this._state);
         Debug.assert(this._gameInit == null,"Game init is already set.");
         this._state = _Idle;
         this._gameInit = new GameInitResponse(param1,this._eventFactory);
         this._processEvents(this._gameInit.getEvents());
         this._gameInitListener.onGameInit(this._gameInit);
      }
      
      private function _onGameStart(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         var _loc_3:* = new GameStartResponse(param1);
         this._seed = _loc_3.getSeed();
         this._gameStartListener.onGameStart(_loc_3);
      }
      
      private function _onGameEnd(param1:Object, param2:Object) : void
      {
         var _loc_3:GameEndResponse = null;
         var _loc_4:UserUniverse = null;
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         this._verifyIdle();
         _loc_3 = new GameEndResponse(param1,true,this._eventFactory);
         _loc_4 = this._gameInit.getUserUniverse();
         _loc_5 = _loc_3.getEpisodeId();
         _loc_6 = _loc_3.getLevelId();
         var _loc_7:* = _loc_4.getUserLevel(_loc_5,_loc_6);
         if(_loc_3.isBestResult())
         {
            _loc_7.setScore(_loc_3.getScore());
         }
         if(_loc_3.isNewStarLevel())
         {
            _loc_7.setStars(_loc_3.getStars());
         }
         this._gameInit.getCurrentUser().copy(_loc_3.getCurrentUser());
         this._processEvents(_loc_3.getEvents());
         this._cachedToplistResponses.insert(new LevelToplistResponse(_loc_3.getLevelToplist(),this._gameInit.getUserProfiles()));
         this._gameEndListener.onGameEnd(_loc_3);
      }
      
      private function _onBuyBooster(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         var _loc_3:* = new BuyBoosterResponse(param1);
         this._gameInit.getCurrentUser().copy(_loc_3.getCurrentUser());
         this._buyBoosterListener.onBuyBooster(_loc_3);
      }
      
      private function _onGetLevelToplist(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         var _loc_3:* = new LevelToplistResponse(new LevelToplist(param1),this._gameInit.getUserProfiles());
         this._cachedToplistResponses.insert(_loc_3);
         this._toplistListener.onGetToplist(_loc_3.getLevelToplistProfiles());
      }
      
      private function _onGetLevelToplists(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         var _loc_3:* = new LevelToplistsResponse(param1);
         this._toplistListener.onGetLevelToplists(_loc_3.getLevelToplists());
      }
      
      private function _onGetMessages(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         var _loc_3:* = new GetMessagesResponse(param1,true,this._eventFactory);
         this._gameInit.getCurrentUser().copy(_loc_3.getCurrentUser());
         this._processEvents(_loc_3.getEvents());
         this._getMessagesListener.onGetMessages(_loc_3);
      }
      
      private function _onRemoveLife(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         var _loc_3:* = new RemoveLifeResponse(param1);
         this._gameInit.getCurrentUser().copy(_loc_3.getCurrentUser());
         this._removeLifeListener.onRemoveLife(_loc_3);
      }
      
      private function _onPoll(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         var _loc_3:* = new PollResponse(param1);
         this._gameInit.getCurrentUser().copy(_loc_3.getCurrentUser());
         this._pollListener.onPoll(_loc_3);
      }
      
      private function _onGetRecipes(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         this._getRecipesListener.onGetRecipes(new GetRecipesResponse(param1));
      }
      
      private function _onCraft(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         this._craftListener.onCraft(new CraftResponse(param1));
      }
      
      private function _onGetBalance(param1:Object, param2:Object) : void
      {
         this._verifyIdle();
         this._getBalanceListener.onGetBalance(new GetBalanceResponse(param1));
      }
      
      private function _processEvents(param1:Vector.<SagaEvent>) : void
      {
         var _loc_5:SagaEvent = null;
         var _loc_6:LevelUnlockedEvent = null;
         var _loc_7:int = 0;
         var _loc_8:int = 0;
         var _loc_9:UserProfile = null;
         var _loc_10:UnlockHelpAcceptedEvent = null;
         var _loc_11:int = 0;
         var _loc_12:int = 0;
         var _loc_13:int = 0;
         var _loc_14:UserLevel = null;
         var _loc_15:FriendInviteData = null;
         var _loc_16:int = 0;
         var _loc_2:* = this._gameInit.getCurrentUser();
         var _loc_3:* = this._gameInit.getUserUniverse();
         var _loc_4:* = this._gameInit.getUserProfiles();
         for each(_loc_5 in param1)
         {
            if(_loc_5 is LevelUnlockedEvent)
            {
               _loc_6 = _loc_5 as LevelUnlockedEvent;
               _loc_7 = _loc_6.getEpisodeId();
               _loc_8 = _loc_6.getLevelId();
               if(!_loc_3.hasUserLevel(_loc_7,_loc_8))
               {
                  _loc_3.addUserLevel(_loc_7,_loc_8);
               }
               _loc_3.getUserLevel(_loc_7,_loc_8).setUnlockedByEvent(true);
               _loc_9 = _loc_4.getUserProfile(_loc_2.getUserId());
               if(_loc_6.getEpisodeId() < 1001)
               {
                  _loc_9.setTopEpisode(_loc_6.getEpisodeId());
                  _loc_9.setTopLevel(_loc_6.getLevelId());
               }
            }
            else if(_loc_5 is UnlockHelpAcceptedEvent)
            {
               _loc_10 = _loc_5 as UnlockHelpAcceptedEvent;
               _loc_11 = _loc_10.getFromId();
               _loc_12 = _loc_10.getEpisodeId();
               _loc_13 = _loc_10.getLevelId();
               if(!_loc_3.hasUserLevel(_loc_12,_loc_13))
               {
                  _loc_3.addUserLevel(_loc_12,_loc_13);
               }
               Debug.assert(_loc_3.hasUserLevel(_loc_12,_loc_13),"Trying to access a level that does not exist! UnlockHelpAcceptedEvent, episde:" + _loc_12 + " level:" + _loc_13);
               _loc_14 = _loc_3.getUserLevel(_loc_12,_loc_13);
               _loc_15 = _loc_14.getFriendInviteData();
               if(_loc_15 != null)
               {
                  if(!_loc_15.hasUser(_loc_11))
                  {
                     _loc_15.addUserId(_loc_11);
                  }
               }
               else
               {
                  _loc_15 = FriendInviteData.create(false,false);
                  _loc_15.addUserId(_loc_11);
                  _loc_14.setFriendInviteData(_loc_15);
               }
               _loc_16 = this._gameInit.getUniverseDescription().getLevelDescription(_loc_12,_loc_13).getRequiredFriendInvites();
               if(_loc_15.getUserIds().length >= _loc_16)
               {
                  _loc_15.setIsCompleted();
               }
            }
         }
      }
      
      private function _onBuyLevelUnlockProduct(param1:String, param2:String, param3:int) : void
      {
         this._verifyIdle();
         this._buyCollaborationProductListener.onBuyCollaborationProduct(param1,param2,param3);
      }
      
      private function _onBuyLifeProduct(param1:String, param2:String, param3:int) : void
      {
         this._verifyIdle();
         this._buyLifeProductListener.onBuyLifeProduct(param1,param2,param3);
      }
      
      private function _onBuyGoldProduct(param1:String, param2:String, param3:int) : void
      {
         this._verifyIdle();
         this._buyGoldProductListener.onBuyGoldProduct(param1,param2,param3);
      }
      
      private function _onBuyRecipeTopup(param1:String, param2:String, param3:String) : void
      {
         this._verifyIdle();
         var _loc_4:* = new Vector.<ItemAmount>();
         this._buyRecipeTopupProductListener.onBuyRecipeTopup(param1,param2,param3);
      }
      
      private function _onBuyIngameProduct(param1:String, param2:String, param3:int) : void
      {
         this._verifyIdle();
         this._buyIngameListener.onBuyIngame(param1,param2,param3);
      }
      
      private function _onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         this._verifyIdle();
         this._buyAnyProductListener.onBuyAnyProduct(param1,param2,param3,param4);
      }
      
      private function _onBuyAnyProductTo(param1:String, param2:String, param3:int, param4:int, param5:Number) : void
      {
         this._verifyIdle();
         this._buyAnyProductToListener.onBuyAnyProductTo(param1,param2,param3,param4,param5);
      }
      
      private function _verifyIdle() : void
      {
         Debug.assert(this._state == _Idle,"Expecting idle state but is state id: " + this._state);
         Debug.assert(this._gameInit != null,"Calling game start, but has not recieved game init yet.");
      }
   }
}

