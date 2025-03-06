package com.midasplayer.candycrushsaga.main
{
   import com.king.saga.api.crafting.ItemAmount;
   import com.king.saga.api.event.SagaEvent;
   import com.king.saga.api.product.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import com.midasplayer.candycrushsaga.ccshared.Console;
   import com.midasplayer.candycrushsaga.ccshared.HourGlass;
   import com.midasplayer.candycrushsaga.charms.*;
   import com.midasplayer.candycrushsaga.charms.api.*;
   import com.midasplayer.candycrushsaga.cutscene.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.popup.*;
   import com.midasplayer.candycrushsaga.popup.notificationcentral.*;
   import com.midasplayer.candycrushsaga.tutorial.*;
   import com.midasplayer.candycrushsaga.worldcommand.*;
   import flash.display.*;
   import flash.events.*;
   
   public class CCQueueHandler extends MovieClip
   {
      private var _ccQueue:Array;
      
      private var _ccMain:CCMain;
      
      private var errorQueue:Array;
      
      public function CCQueueHandler(param1:CCMain)
      {
         super();
         this._ccMain = param1;
         this._ccQueue = new Array();
      }
      
      public function queue(param1:*) : void
      {
         if(!this._ccQueue)
         {
            this._ccQueue = new Array();
         }
         this._ccQueue.push(param1);
         param1.addEventListener(CCConstants.DEACTIVATE_QUEUE_ELEMENT,this.deactivateQueueElement);
         param1.addEventListener(CCConstants.ADD_POPUP,this.addPopupAsChild);
         param1.addEventListener(CCConstants.LOCK_GAME_BOARD,this.lockGameBoard);
         param1.addEventListener(CCConstants.UNLOCK_GAME_BOARD,this.unLockGameBoard);
         param1.addEventListener(CCConstants.SKIP_TUTORIALS,this.skipTutorials);
         if(this._ccQueue.length == 1)
         {
            this.triggerQueueElement(this._ccQueue[0]);
         }
      }
      
      private function addPopupAsChild(event:Event) : void
      {
         var _loc_2:* = event.target as MovieClip;
         addChild(_loc_2);
      }
      
      private function lockGameBoard(event:Event) : void
      {
         if(this._ccMain.getGame() != null)
         {
            this._ccMain.getGame().lockBoard(null);
         }
      }
      
      private function unLockGameBoard(event:Event) : void
      {
         if(this._ccMain.getGame() != null)
         {
            this._ccMain.getGame().unlockBoard();
         }
      }
      
      public function preTriggerQueueElements() : void
      {
      }
      
      public function triggerQueueElement(param1:*) : void
      {
         if(param1)
         {
            param1.triggerCommand();
            if(param1 is TutorialPop)
            {
               this._ccMain.setTutorialActive(true);
            }
         }
      }
      
      public function deactivateQueueElement(event:Event) : void
      {
         var _loc_2:uint = 0;
         var _loc_3:* = undefined;
         while(_loc_2 < this._ccQueue.length)
         {
            if(this._ccQueue[_loc_2] == event.currentTarget)
            {
               _loc_3 = this._ccQueue[_loc_2];
               this.destructElement(_loc_3,_loc_2);
               break;
            }
            _loc_2 += 1;
         }
         if(this.noMoreTutorialElements())
         {
            this._ccMain.setTutorialActive(false);
         }
         if(this._ccQueue.length > 0)
         {
            this.triggerQueueElement(this._ccQueue[0]);
         }
      }
      
      private function noMoreTutorialElements() : Boolean
      {
         var _loc_1:* = undefined;
         for each(_loc_1 in this._ccQueue)
         {
            if(_loc_1 is TutorialPop)
            {
               return false;
            }
         }
         return true;
      }
      
      private function skipTutorials(event:Event) : void
      {
         var _loc_2:uint = 0;
         var _loc_3:* = undefined;
         while(_loc_2 < this._ccQueue.length)
         {
            _loc_3 = this._ccQueue[_loc_2];
            if(_loc_3 is TutorialPop)
            {
               this.destructElement(_loc_3,_loc_2);
               _loc_2 -= 1;
            }
            _loc_2 += 1;
         }
         this._ccMain.setTutorialActive(false);
         this._ccMain.setTutorialsDisabled(true);
         if(this._ccQueue.length > 0)
         {
            this.triggerQueueElement(this._ccQueue[0]);
         }
      }
      
      private function destructElement(param1:*, param2:int) : void
      {
         param1.deactivate();
         if(param1 is Popup)
         {
            if(Boolean(param1.parent))
            {
               param1.parent.removeChild(param1);
            }
         }
         param1.removeEventListener(CCConstants.DEACTIVATE_QUEUE_ELEMENT,this.deactivateQueueElement);
         param1.removeEventListener(CCConstants.LOCK_GAME_BOARD,this.lockGameBoard);
         param1.removeEventListener(CCConstants.UNLOCK_GAME_BOARD,this.unLockGameBoard);
         param1.removeEventListener(CCConstants.ADD_POPUP,this.addPopupAsChild);
         param1.removeEventListener(CCConstants.SKIP_TUTORIALS,this.skipTutorials);
         param1.destruct();
         this._ccQueue.splice(param2,1);
         param1 = null;
      }
      
      private function destructUnqueuedElement(event:Event) : void
      {
         var _loc_4:MovieClip = null;
         var _loc_5:ErrorAlertPop = null;
         var _loc_3:int = 0;
         var _loc_2:* = Popup(event.target);
         _loc_2.deactivate();
         if(Boolean(_loc_2.parent))
         {
            _loc_2.parent.removeChild(_loc_2);
         }
         _loc_2.destruct();
         _loc_2.removeEventListener(CCConstants.DEACTIVATE_QUEUE_ELEMENT,this.destructUnqueuedElement);
         while(_loc_3 < this.errorQueue.length)
         {
            _loc_4 = this.errorQueue[_loc_3];
            if(_loc_4 == event.target)
            {
               this.errorQueue.splice(_loc_3,1);
               break;
            }
            _loc_3++;
         }
         if(this.errorQueue.length >= 1)
         {
            _loc_5 = this.errorQueue.shift();
            addChild(_loc_5);
            _loc_5.triggerCommand();
         }
      }
      
      public function hasTutorialInQueue() : Boolean
      {
         var _loc_1:* = undefined;
         for each(_loc_1 in this._ccQueue)
         {
            if(_loc_1 is TutorialPop)
            {
               return true;
            }
         }
         return false;
      }
      
      public function queueWelcomePop(param1:Function, param2:Function, param3:Function, param4:Function) : void
      {
         this.queue(new WelcomePop(param1,param2,param3,param4));
      }
      
      public function queueMissionPop(param1:Function, param2:CCMissionData) : void
      {
         this.queue(new MissionPop(param1,param2));
      }
      
      public function queueMissionAccomplishedPop(param1:Function, param2:CCMissionData) : void
      {
         this.queue(new MissionAccomplishedPop(param1,param2));
      }
      
      public function queueGameStartPop(param1:Function, param2:Function, param3:int, param4:int, param5:Inventory, param6:CCMain) : void
      {
         this.queue(new GameStartPop(param1,param2,param3,param4,param5,param6));
      }
      
      public function queueGameOverLossPop(param1:Function, param2:Function, param3:int, param4:int, param5:int, param6:int, param7:String, param8:String, param9:HighScoreListVO) : void
      {
         this.queue(new GameOverLossPop(param1,param2,param3,param4,param5,param6,param7,param8,param9));
      }
      
      public function queueGameOverVictoryPop(param1:Function, param2:Function, param3:Object, param4:int, param5:int, param6:int, param7:HighScoreListVO, param8:Vector.<ItemAmount>, param9:CCMain) : void
      {
         this.queue(new GameOverVictoryPop(param1,param2,param3,param4,param5,param6,param7,param8,param9));
      }
      
      public function queueFriendBeatenPop(param1:Function, param2:Function, param3:FriendBeatenVO, param4:HighScoreListVO, param5:CCMain) : void
      {
         this.queue(new FriendBeatenPop(param1,param2,param3,param4,param5));
      }
      
      public function queueFriendPassedPop(param1:Function, param2:Function, param3:FriendPassedVO, param4:CCMain) : void
      {
         this.queue(new FriendPassedPop(param1,param2,param3,param4));
      }
      
      public function queueLifeReceivedPop(param1:Function, param2:Function, param3:GiftReceivedVO, param4:Function) : void
      {
         this.queue(new LifeReceivedPop(param1,param2,param3,param4));
      }
      
      public function queueBuyLivesPop(param1:int, param2:Function, param3:Function, param4:int) : void
      {
         this.queue(new BuyLifePop(param1,param2,param3,param4));
      }
      
      public function queueVideoAdsPop(param1:Function, param2:Function) : void
      {
         this.queue(new VideoAdPop(param1,param2));
      }
      
      public function queueNoMoreLivesPop(param1:int, param2:Function, param3:Function, param4:Function, param5:int, param6:Function, param7:int) : void
      {
         this.queue(new NoMoreLivesPop(param1,param2,param3,param4,param5,param6,param7));
      }
      
      public function queueInviteNumPop(param1:int, param2:Array, param3:CCMain) : void
      {
         this.queue(new InviteFriendNumsPop(param1,param2,param3));
      }
      
      public function queueInviteLevelPop(param1:Array, param2:CCMain) : void
      {
         this.queue(new InviteFriendLevelPop(param1,param2));
      }
      
      public function queueEpisodeCompletedPop(param1:Function, param2:Function, param3:int) : void
      {
         this.queue(new EpisodeCompletedPop(param2,param2,param3));
      }
      
      public function queueSagaCompletePop() : void
      {
         this.queue(new SagaCompletedPop());
      }
      
      public function queueItemUnlockedPop(param1:Function, param2:String, param3:String, param4:CCModel, param5:Function, param6:Inventory) : void
      {
         var _loc_7:CCCharm = null;
         var _loc_8:CurrentUser = null;
         if(param3 == BalanceConstants.CATEGORY_CHARM)
         {
            _loc_7 = param4.getInventory().getCCCharmByType(param2);
            _loc_8 = param4.getCurrentUser();
            this.queueCharmUnlockedPop(_loc_7,_loc_8,null,param5,param6);
         }
         else
         {
            if(param3 != BalanceConstants.CATEGORY_BOOSTER)
            {
               throw new Error("No such item category handled=" + param3);
            }
            this.queue(new ItemUnlockedPop(param1,param2,param3));
         }
      }
      
      public function queuePowerUpTipsterPop(param1:Function, param2:Function, param3:CCPowerUp) : void
      {
         this.queue(new PowerUpTipsterPop(param1,param2,param3));
      }
      
      public function queueRunGame(param1:Function, param2:String) : void
      {
         this.queue(new GameCommand(param1,param2));
      }
      
      public function queuePlayCutscene(param1:CutsceneHandler, param2:MovieClip, param3:int, param4:HourGlass, param5:Boolean) : void
      {
         this.queue(new Cutscene(param1,param2,param3,param4,param5));
      }
      
      public function queueTutorialPop(param1:TutorialPop) : void
      {
         if(this._ccMain.getGame() != null)
         {
            if(this._ccMain.getTutorialdisabled() == true)
            {
               return;
            }
         }
         this.queue(param1);
      }
      
      public function queueTutorialTracker(param1:TutorialTracker) : void
      {
         if(this._ccMain.getGame() != null)
         {
            if(this._ccMain.getTutorialdisabled() == true)
            {
               return;
            }
         }
         this.queue(param1);
      }
      
      public function removeAllTutorialTrackers() : void
      {
         var _loc_1:uint = 0;
         var _loc_2:* = undefined;
         this._ccMain.setTutorialsDisabled(true);
         while(_loc_1 < this._ccQueue.length)
         {
            _loc_2 = this._ccQueue[_loc_1];
            if(_loc_2 is TutorialTracker)
            {
               _loc_2.destruct();
               this._ccQueue.splice(_loc_1,1);
               _loc_2 = null;
            }
            _loc_1 += 1;
         }
      }
      
      public function queueCreateWorldWC(param1:Function, param2:WorldFactory, param3:String, param4:Function) : void
      {
         this.queue(new CreateWorldWC(param1,param2,param3,param4,this));
      }
      
      public function queueNewStarLevelWC(param1:StarLevelVO, param2:Function) : void
      {
         this.queue(new NewStarLevelWC(param1,param2));
      }
      
      public function queuePrepareTransportToEpisodeWC(param1:int, param2:Function) : void
      {
         this.queue(new PrepareTransportToEpisodeWC(param1,param2));
      }
      
      public function queueTransportToEpisodeWC(param1:int, param2:Function) : void
      {
         this.queue(new TransportToEpisodeWC(param1,param2));
      }
      
      public function queuePrepareRemoveGrayWC(param1:int, param2:Function) : void
      {
         this.queue(new PrepareRemoveGrayWC(param1,param2));
      }
      
      public function queueRemoveGrayWC(param1:int, param2:Function) : void
      {
         this.queue(new ExecuteRemoveGrayWC(param1,param2));
      }
      
      public function queueLevelUnlockedWC(param1:LevelUnlockVO, param2:Function) : void
      {
         this.queue(new LevelUnlockedWC(param1,param2));
      }
      
      public function queueMoveSelfPic(param1:int, param2:int, param3:Function) : void
      {
         this.queue(new MoveSelfPicWC(param1,param2,param3));
      }
      
      public function queuePrepareLevelUnlockedWC(param1:LevelUnlockVO, param2:Function) : void
      {
         this.queue(new PrepareLevelUnlockedWC(param1,param2));
      }
      
      public function queuePrepareMoveSelfPicWC(param1:LevelUnlockVO, param2:Function) : void
      {
         this.queue(new PrepareMoveSelfPicWC(param1.episodeId,param1.levelId,param2));
      }
      
      public function queuePrepareTransportIntro(param1:int, param2:Function) : void
      {
         this.queue(new PrepareTransportIntroWC(param1,param2));
      }
      
      public function queueTransportIntro(param1:int, param2:Function) : void
      {
         this.queue(new ExecuteTransportIntroWC(param1,param2));
      }
      
      public function queuePrepareCollaborationIntro(param1:int, param2:Function) : void
      {
         this.queue(new PrepareCollaborationIntroWC(param1,param2));
      }
      
      public function queueCollaborationIntro(param1:int, param2:Function) : void
      {
         this.queue(new ExecuteCollaborationIntroWC(param1,param2));
      }
      
      public function queueUnlockHelpReceivedPop(param1:Number, param2:int, param3:String, param4:Function) : void
      {
         this.queue(new UnlockHelpReceivedPop(param1,param2,param3,param4));
      }
      
      public function queueCollaborationPanelPop(param1:int, param2:int, param3:Vector.<Number>, param4:Function, param5:Function, param6:Function, param7:String, param8:CollaborationProduct) : void
      {
         this.queue(new CollaborationPanelPop(param1,param2,param3,param4,param5,param6,param7,param8));
      }
      
      public function queuePrepareStarLevelWC(param1:StarLevelVO, param2:Function) : void
      {
         this.queue(new PrepareStarAnimWC(param1,param2));
      }
      
      public function queueExecuteObjectAnimsWC(param1:Function) : void
      {
         this.queue(new ExecuteObjectAnimsWC(param1));
      }
      
      public function queueNotificationCentral(param1:Vector.<SagaEvent>, param2:UserProfiles, param3:Function, param4:Function, param5:Function) : void
      {
         this.queue(new NotificationsPopup(param1,param2,param3,param4,param5));
      }
      
      public function queueWorldInteractive(param1:Function) : void
      {
         this.queue(new WorldInteractiveWC(param1));
      }
      
      public function queueWorldDisableInteraction(param1:Function) : void
      {
         this.queue(new WorldDisabledWC(param1));
      }
      
      public function queueErrorAlert(event:IOErrorEvent, param2:String, param3:Error) : void
      {
         if(this.errorQueue == null)
         {
            this.errorQueue = [];
         }
         var _loc_4:* = new ErrorAlertPop(event,param2,param3);
         this.errorQueue.push(_loc_4);
         if(this.errorQueue.length == 1)
         {
            addChild(_loc_4);
            _loc_4.triggerCommand();
         }
         _loc_4.addEventListener(CCConstants.DEACTIVATE_QUEUE_ELEMENT,this.destructUnqueuedElement);
      }
      
      public function queuePrepareMoveToTicket(param1:int, param2:int, param3:Function) : void
      {
         this.queue(new PrepareMoveSelfPicWC(param1,param2,param3));
      }
      
      public function queueMoveToTicket(param1:int, param2:int, param3:Function) : void
      {
         this.queue(new MoveSelfPicWC(param1,param2,param3));
      }
      
      public function queueSetActiveStation(param1:LevelUnlockVO, param2:Function) : void
      {
         this.queue(new SetActiveStationWC(param1.episodeId,param1.levelId,param2));
      }
      
      public function queueCharmsShop(param1:*, param2:*, param3:CCCharm = null, param4:Inventory = null) : void
      {
         var _loc_5:* = new ShopPopup(null,new SHOP_POPUP(),param3,param4);
         _loc_5.init(param1 as CharmInventory,param2 as DailyOfferCharmInventory);
         this.queue(_loc_5);
      }
      
      public function queueSingleCharmPop(param1:CCCharm, param2:CurrentUser, param3:Function, param4:Function, param5:Inventory) : void
      {
         Console.println("CCQueueHandler.as | queueSingleCharmPop() ");
         var _loc_6:* = new CharmUnlockedPop(param3,param4,new PERMANENT_BOOSTER_POPUP(),param5);
         _loc_6.init(param1,param2,CharmUnlockedPop.INFO);
         this.queue(_loc_6);
         Console.println(_loc_6 + " " + CCConstants.SKIP_TUTORIALS + " " + CCConstants.RESUME_GAME + " " + this._ccMain + " " + this._ccMain.resumeGame);
         _loc_6.addEventListener("resumeGame",this._ccMain.resumeGame);
      }
      
      public function queueCharmUnlockedPop(param1:CCCharm, param2:CurrentUser, param3:Function, param4:Function, param5:Inventory) : void
      {
         var _loc_6:* = new CharmUnlockedPop(param3,param4,new PERMANENT_BOOSTER_POPUP(),param5);
         _loc_6.init(param1,param2,CharmUnlockedPop.UNLOCKED);
         this.queue(_loc_6);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

