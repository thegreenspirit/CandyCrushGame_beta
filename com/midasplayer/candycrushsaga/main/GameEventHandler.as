package com.midasplayer.candycrushsaga.main
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.event.*;
   import com.midasplayer.candycrushsaga.main.CCMain;
   import com.midasplayer.candycrushsaga.engine.*;
   
   public class GameEventHandler
   {
      public var lastPlayedLevel:int;
      
      public var lastPlayedEpisode:int;
      
      public var aLevelWasCompletedForTheFirstTime:Boolean;
      
      public var powerUpTipster:PowerUpTipster;
      
      public function GameEventHandler()
      {
         super();
         this.powerUpTipster = new PowerUpTipster();
      }
      
      public function handleGameEndEvents(param1:CCMain, param2:CCModel, param3:CCQueueHandler, param4:Inventory, param5:GameCommEvent) : void
      {
         var _loc_14:int = 0;
         var _loc_15:String = null;
         var _loc_16:int = 0;
         var _loc_17:int = 0;
         var _loc_18:CCPowerUp = null;
         var _loc_19:LevelUnlockVO = null;
         var _loc_20:Boolean = false;
         var _loc_21:Boolean = false;
         var _loc_22:Boolean = false;
         var _loc_23:FriendBeatenVO = null;
         var _loc_24:int = 0;
         var _loc_25:int = 0;
         var _loc_26:int = 0;
         var _loc_27:FriendPassedVO = null;
         var _loc_6:* = param2.getUserActiveEpisode();
         var _loc_7:* = param2.getUserActiveLevel();
         var _loc_8:* = param5.drops();
         if(param5.drops().length > 0)
         {
            param2.handOutItemWinnings(param4,_loc_8,_loc_6,_loc_7);
         }
         var _loc_9:* = param2.getNewStarLevelData();
         this.lastPlayedLevel = _loc_9.levelId;
         this.lastPlayedEpisode = _loc_9.episodeId;
         var _loc_10:* = param2.getBestScoreEver(_loc_9.episodeId,_loc_9.levelId);
         var _loc_11:* = param2.getCurrentUser().getUserId();
         var _loc_12:* = param2.getHighScoreListData();
         var _loc_13:* = param2.getEpisodeCompleted();
         if(_loc_9.stars == 0)
         {
            _loc_14 = param2.getTotalLevel(_loc_6,_loc_7);
            _loc_15 = param2.getGameModeName(_loc_6,_loc_7);
            _loc_16 = param2.getNextScoreTarget(_loc_6,_loc_7);
            _loc_17 = param2.getScoreTarget(_loc_6,_loc_7,1);
            param3.queueGameOverLossPop(param1.onGameOverLossPopClosed,param1.onGameOverLossPopClosed,_loc_6,_loc_7,_loc_14,_loc_17,_loc_15,param1.getFailReason(),_loc_12);
            _loc_18 = this.powerUpTipster.pickPowerUpToRecommend(param2.getUserActiveEpisode(),param2.getUserActiveLevel(),param4,param2.getLevelInfoVI,param2.getCurrentUser().getLives());
            if(Boolean(_loc_18))
            {
               param3.queuePowerUpTipsterPop(null,param4.buyPowerUp,_loc_18);
            }
         }
         else
         {
            _loc_19 = param2.getLevelUnlockedData();
            this.aLevelWasCompletedForTheFirstTime = _loc_13 > 0 || _loc_19 != null;
            _loc_20 = _loc_13 == CCConstants.LAST_EPISODE;
            _loc_21 = _loc_13 != 0 && _loc_19 == null && !_loc_20;
            param3.queueGameOverVictoryPop(param1.onGameOverVictoryPopClosed,param1.onGameOverVictoryPopContinue,_loc_9,_loc_10,_loc_6,_loc_7,_loc_12,_loc_8,param1);
            MonsterDebugger.trace(this,"[[handleGameEndEvents]]");
            param3.queueCreateWorldWC(param1.createWorld,param1._worldFactory,WorldFactory.WORLD_ASSETS_READY_FOR_CREATION,param1.getWorldCommandHandler);
            param3.queueWorldDisableInteraction(param1.getWorldCommandHandler);
            if(_loc_21)
            {
               param3.queuePrepareMoveToTicket(_loc_13,_loc_7 + 1,param1.getWorldCommandHandler);
               param3.queuePrepareTransportIntro(_loc_13,param1.getWorldCommandHandler);
               param3.queuePrepareCollaborationIntro(_loc_13,param1.getWorldCommandHandler);
            }
            if(_loc_13 != 0)
            {
               param1.showResolutionCutscene();
            }
            _loc_22 = false;
            if(_loc_19 != null)
            {
               param3.queuePrepareLevelUnlockedWC(_loc_19,param1.getWorldCommandHandler);
               param3.queuePrepareMoveSelfPicWC(_loc_19,param1.getWorldCommandHandler);
               param4.tryUnlockItem(_loc_19.episodeId,_loc_19.levelId);
            }
            if(_loc_9.isNewStarLevel == true)
            {
               param3.queuePrepareStarLevelWC(_loc_9,param1.getWorldCommandHandler);
            }
            if(param2.friendHasBeenBeaten())
            {
               _loc_23 = param2.getFriendBeatenData();
               param3.queueFriendBeatenPop(null,param1.shareFriendBeaten,_loc_23,_loc_12,param1);
            }
            if(_loc_9.isNewStarLevel == true)
            {
               param3.queueNewStarLevelWC(_loc_9,param1.getWorldCommandHandler);
            }
            if(_loc_13 != 0)
            {
               if(_loc_13 == CCConstants.LAST_EPISODE)
               {
                  param3.queueSagaCompletePop();
               }
               else
               {
                  param3.queueEpisodeCompletedPop(null,param1.episodeComplete,_loc_13);
               }
            }
            if(this.aLevelWasCompletedForTheFirstTime)
            {
               param3.queueExecuteObjectAnimsWC(param1.getWorldCommandHandler);
            }
            if(_loc_19 != null)
            {
               _loc_24 = _loc_19.episodeId;
               _loc_25 = _loc_19.levelId;
               param3.queueMoveSelfPic(_loc_24,_loc_25,param1.getWorldCommandHandler);
               param3.queueLevelUnlockedWC(_loc_19,param1.getWorldCommandHandler);
            }
            if(_loc_21)
            {
               param3.queueMoveToTicket(_loc_13,_loc_7 + 1,param1.getWorldCommandHandler);
               param3.queueCollaborationIntro(_loc_13,param1.getWorldCommandHandler);
               param3.queueTransportIntro(_loc_13,param1.getWorldCommandHandler);
               _loc_26 = _loc_13 + 1;
               param1.showCollabPop(null,_loc_26);
            }
            if(param2.friendHasBeenPassed())
            {
               _loc_27 = param2.getFriendPassedData();
               param3.queueFriendPassedPop(null,param1.shareFriendPassed,_loc_27,param1);
            }
            param3.queueWorldInteractive(param1.getWorldCommandHandler);
         }
      }
   }
}

