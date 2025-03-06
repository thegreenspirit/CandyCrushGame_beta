package com.midasplayer.candycrushsaga.tutorial
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.world.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import flash.geom.*;
   import tutorial.*;
   
   public class TutorialHandler
   {
      public static const POP_ID_WORLD_INTRODUCTION:String = "idWorldIntroduction";
      
      public static const POP_ID_EXPLAIN_SWITCHING_1:String = "idExplainSwitching1";
      public static const POP_ID_EXPLAIN_SWITCHING_2:String = "idExplainSwitching2";
      public static const POP_ID_EXPLAIN_SWITCHING_3:String = "idExplainSwitching3";
      public static const POP_ID_EXPLAIN_SWITCHING_4:String = "idExplainSwitching4";
      
      public static const POP_ID_EXPLAIN_SWITCHING_RANDOM:String = "idExplainSwitchingRandom";
      public static const TRK_ID_EXPLAIN_SWITCHING_RANDOM:String = "TRKidExplainSwitchingRandom";
      
      public static const POP_ID_EXPLAIN_LIGHT_UP_1:String = "idExplainLightUp1";
      public static const POP_ID_EXPLAIN_LIGHT_UP_2:String = "idExplainLightUp2";
      public static const TRK_ID_EXPLAIN_LIGHT_UP:String = "TRKidExplainLightUp";
      
      public static const POP_ID_MOVES_LEFT:String = "idMovesLeft";
      
      public static const POP_ID_SCORE_METER:String = "idScoreMeter";
      
      public static const POP_ID_STRIPED_1:String = "idStriped1";
      public static const POP_ID_STRIPED_2:String = "idStriped2";
      public static const POP_ID_STRIPED_3:String = "idStriped3";
      public static const POP_ID_STRIPED_4:String = "idStriped4";
      
      public static const TRK_ID_SCORE_LIMIT:String = "idScoreLimit";
      public static const POP_ID_SCORE_LIMIT_REACHED:String = "idScoreLimitReached";
      
      public static const POP_ID_WRAPPED_1:String = "idWrapped1";
      public static const POP_ID_WRAPPED_2:String = "idWrapped2";
      
      public static const POP_ID_STRIPED_WRAPPED_1:String = "idStripedWrapped1";
      
      public static const POP_ID_COLORBOMB_1:String = "idColorBomb1";
      public static const POP_ID_COLORBOMB_2:String = "idColorBomb2";
      public static const POP_ID_COLORBOMB_3:String = "idColorBomb3";
      
      public static const POP_ID_DROP_DOWN_1:String = "idDropDown1";
      
      public static const POP_INTRODUCE_BOOSTER_EXTRA_MOVES:String = "introduceBoosterCandyExtraMoves";
      public static const POP_INTRODUCE_BOOSTER_HAMMER:String = "introduceBoosterCandyHammer";
      public static const POP_INTRODUCE_BOOSTER_COLORBOMB:String = "introduceBoosterCandyColorBomb";
      public static const POP_INTRODUCE_BOOSTER_FISH:String = "introduceBoosterCandySwedishFish";
      public static const POP_INTRODUCE_BOOSTER_COCONUT_WHEEL:String = "introduceBoosterCandyCoconutLiquorice";
      public static const POP_INTRODUCE_BOOSTER_PREFIX:String = "introduceBooster";
      
      private var _ccQueueHandler:CCQueueHandler;
      
      private var _ccModel:CCModel;
      
      private var _ccMain:CCMain;
      
      private var _tutorialPops:Vector.<TutorialPop>;
      
      public function TutorialHandler(param1:CCQueueHandler, param2:CCModel, param3:CCMain)
      {
         super();
         this._ccQueueHandler = param1;
         this._ccModel = param2;
         this._ccMain = param3;
      }
      
      public function addTutorialPop(param1:String, param2:Point, param3:Hint, param4:Boolean = true) : Boolean
      {
         var _loc_5:* = this.getTutorialPop(param1,param2,param3);
         if(this.getTutorialPop(param1,param2,param3) == null)
         {
            return false;
         }
         if(param4)
         {
            this._ccQueueHandler.queueTutorialPop(_loc_5);
         }
         else
         {
            _loc_5.addEventListener(CCConstants.DEACTIVATE_QUEUE_ELEMENT,this.removeUnQueuedElement);
            _loc_5.addEventListener(CCConstants.SKIP_TUTORIALS,this.removeUnQueuedElement);
            _loc_5.triggerCommand();
         }
         return true;
      }
      
      public function addTutorialTracker(param1:String) : void
      {
         var _loc_2:* = this.getTutorialTracker(param1);
         this._ccQueueHandler.queueTutorialTracker(_loc_2);
      }
      
      public function tutorialStation(param1:int, param2:int) : Boolean
      {
         var _loc_3:* = this._ccModel.getUserProfile(this._ccModel.getCurrentUser().getUserId()).getTopEpisode();
         var _loc_4:* = this._ccModel.getUserProfile(this._ccModel.getCurrentUser().getUserId()).getTopLevel();
         var _loc_5:* = this._ccModel.getUserActiveEpisode();
         var _loc_6:* = this._ccModel.getUserActiveLevel();
         if(_loc_3 == param1 && _loc_5 == param1 && _loc_4 == param2 && _loc_6 == param2)
         {
            return true;
         }
         return false;
      }
      
      public function getTutorialPop(param1:String, param2:Point, param3:Hint) : TutorialPop
      {
         var _loc_4:String = null;
         var _loc_5:TutorialManModVO = null;
         var _loc_7:Function = null;
         var _loc_8:Hint = null;
         var _loc_9:Vector.<Point> = null;
         var _loc_10:int = 0;
         var _loc_6:* = "tutorial_" + param1;
         switch(param1)
         {
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_RANDOM:
               _loc_8 = this._ccMain.getGame().getNextHint();
               _loc_9 = _loc_8.coordsInvolved;
               _loc_10 = this._ccMain.getNextScoreTarget();
               param2 = _loc_8.mainCoord;
               param2.y += 80;
               _loc_4 = _loc_8.getDirectionString();
               return new TutorialPopSwitch(param2,I18n.getString("tutorial_explainSwitching_" + _loc_4),null,null,_loc_4,_loc_9,this._ccMain,false);
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_1:
               _loc_4 = Hint.DIRECTION_LEFT;
               param2 = new Point(240,510);
               _loc_5 = new TutorialManModVO();
               _loc_5.headModY = -230;
               _loc_5.armModRotation = -25;
               _loc_5.bubbleModX = -45;
               _loc_5.bubbleModY = -245;
               return new TutorialPopSwitch(param2,I18n.getString("tutorial_explainSwitching_" + _loc_4),new CandySwitch1(),_loc_5,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_2:
               _loc_4 = Hint.DIRECTION_DOWN;
               param2 = new Point(245,264);
               _loc_5 = new TutorialManModVO();
               _loc_5.bubbleModX = 45;
               _loc_5.bubbleModY = 100;
               return new TutorialPopSwitch(param2,I18n.getString("tutorial_explainSwitching_" + _loc_4),new CandySwitch2(),_loc_5,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_3:
               _loc_4 = Hint.DIRECTION_LEFT;
               param2 = new Point(370,285);
               _loc_5 = new TutorialManModVO();
               _loc_5.bubbleModX = 20;
               _loc_5.bubbleModY = 130;
               _loc_5.headModY = 20;
               return new TutorialPopSwitch(param2,I18n.getString("tutorial_explainSwitching_" + _loc_4),new CandySwitch3(),_loc_5,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_4:
               param2 = new Point(200,400);
               return new TutorialPopInfo(param2,I18n.getString("tutorial_explainSwitching_try_yourself"),null,null,0,null,false);
            case TutorialHandler.POP_ID_WORLD_INTRODUCTION:
               param2 = new Point(373,500);
               _loc_7 = this.startEpisode1Level2;
               _loc_5 = new TutorialManModVO();
               _loc_5.headModY = -150;
               _loc_5.armModX = 30;
               _loc_5.armModY = 0;
               _loc_5.armModRotation = -10;
               _loc_5.bubbleModX = -20;
               _loc_5.bubbleModY = -165;
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,_loc_5,1,_loc_7);
            case TutorialHandler.POP_ID_STRIPED_1:
               _loc_4 = Hint.DIRECTION_DOWN;
               param2 = new Point(401,355);
               _loc_5 = new TutorialManModVO();
               _loc_5.headModY = -150 - 100;
               _loc_5.armModX = 50 + 55;
               _loc_5.armModY = -320 - 100 - 100 + 60;
               _loc_5.armModRotation = 30;
               _loc_5.bubbleModX = -5;
               _loc_5.bubbleModY = -155 - 100 - 20;
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,_loc_5,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_STRIPED_2:
               param2 = new Point(424,351);
               _loc_5 = new TutorialManModVO();
               _loc_5.headModY = -150 - 50;
               _loc_5.headModX -= 10;
               _loc_5.armModX = -10;
               _loc_5.armModY = -130 - 50;
               _loc_5.armModRotation = 12;
               _loc_5.bubbleModX = -5;
               _loc_5.bubbleModY = -230;
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,_loc_5,0.7);
            case TutorialHandler.POP_ID_STRIPED_3:
               _loc_4 = Hint.DIRECTION_UP;
               param2 = new Point(519,383);
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,null,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_SCORE_METER:
               param2 = new Point(48,140);
               _loc_10 = this._ccMain.getNextScoreTarget(1,2);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6,_loc_10),null,null,0.5);
            case TutorialHandler.POP_ID_SCORE_LIMIT_REACHED:
               param2 = new Point(53,172);
               _loc_10 = this._ccMain.getNextScoreTarget(1,2);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6,_loc_10),null,null,1.2,null,true);
            case TutorialHandler.POP_ID_MOVES_LEFT:
               param2 = new Point(53,95);
               _loc_10 = this._ccMain.getNextScoreTarget(1,3);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6,_loc_10),null,null,0.45,null,true);
            case TutorialHandler.POP_ID_WRAPPED_1:
               _loc_4 = Hint.DIRECTION_UP;
               param2 = new Point(473,467);
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,null,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_WRAPPED_2:
               _loc_4 = Hint.DIRECTION_DOWN;
               param2 = new Point(387,354);
               _loc_5 = new TutorialManModVO();
               _loc_5.bubbleModX = 30;
               _loc_5.bubbleModY = -100;
               _loc_5.armModRotation = 8;
               _loc_5.armModX = 30;
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,_loc_5,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_STRIPED_WRAPPED_1:
               _loc_4 = Hint.DIRECTION_DOWN;
               param2 = new Point(428,387);
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,null,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_COLORBOMB_1:
               _loc_4 = Hint.DIRECTION_LEFT;
               param2 = new Point(438,465);
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,null,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_COLORBOMB_2:
               _loc_4 = Hint.DIRECTION_LEFT;
               param2 = new Point(378,469);
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,null,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_COLORBOMB_3:
               param2 = new Point(180,400);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),new CandySwitch5(),null,0,null,false);
            case TutorialHandler.POP_ID_EXPLAIN_LIGHT_UP_1:
               param2 = new Point(424,255);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),new CandySwitch4(),null,2.5);
            case TutorialHandler.POP_ID_EXPLAIN_LIGHT_UP_2:
               _loc_4 = Hint.DIRECTION_UP;
               param2 = new Point(378,240);
               return new TutorialPopSwitch(param2,I18n.getString(_loc_6),null,null,_loc_4,this.getHints(param1),this._ccMain,true);
            case TutorialHandler.POP_ID_DROP_DOWN_1:
               param2 = new Point(180,400);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,null,0,null,false);
            case TutorialHandler.POP_INTRODUCE_BOOSTER_EXTRA_MOVES:
               this.setTutorialHasBeenSeen(param1);
               param2 = new Point(629,25);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,null,0.5);
            case TutorialHandler.POP_INTRODUCE_BOOSTER_HAMMER:
               this.setTutorialHasBeenSeen(param1);
               param2 = new Point(684,25);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,null,0.5);
            case TutorialHandler.POP_INTRODUCE_BOOSTER_COLORBOMB:
               this.setTutorialHasBeenSeen(param1);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,null,0.8);
            case TutorialHandler.POP_INTRODUCE_BOOSTER_FISH:
               this.setTutorialHasBeenSeen(param1);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,null,0.8);
            case TutorialHandler.POP_INTRODUCE_BOOSTER_COCONUT_WHEEL:
               this.setTutorialHasBeenSeen(param1);
               return new TutorialPopInfo(param2,I18n.getString(_loc_6),null,null,0.8);
            default:
               return null;
         }
      }
      
      private function setTutorialHasBeenSeen(param1:String) : void
      {
         this._ccModel.setSeenBoosterTut(param1);
      }
      
      private function getTutorialTracker(param1:String) : TutorialTracker
      {
         var _loc_2:* = "tutorial_" + param1 + "_";
         switch(param1)
         {
            case TutorialHandler.TRK_ID_EXPLAIN_LIGHT_UP:
               return new TutorialTrackerLightUp(this._ccMain,this);
            case TutorialHandler.TRK_ID_EXPLAIN_SWITCHING_RANDOM:
               return new TutorialTrackerSwitch(this._ccMain,this);
            case TutorialHandler.TRK_ID_SCORE_LIMIT:
               return new TutorialTrackerScoreLimit(this._ccMain,this);
            default:
               return null;
         }
      }
      
      private function getHints(param1:String) : Vector.<Point>
      {
         var _loc_2:* = new Vector.<Point>();
         switch(param1)
         {
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_1:
               _loc_2.push(new Point(1,6));
               _loc_2.push(new Point(0,6));
               _loc_2.push(new Point(0,5));
               _loc_2.push(new Point(0,4));
               break;
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_2:
               _loc_2.push(new Point(1,3));
               _loc_2.push(new Point(1,4));
               _loc_2.push(new Point(0,4));
               _loc_2.push(new Point(2,4));
               break;
            case TutorialHandler.POP_ID_EXPLAIN_SWITCHING_3:
               _loc_2.push(new Point(3,3));
               _loc_2.push(new Point(2,3));
               _loc_2.push(new Point(2,4));
               _loc_2.push(new Point(2,5));
               break;
            case TutorialHandler.POP_ID_STRIPED_1:
               _loc_2.push(new Point(4,3));
               _loc_2.push(new Point(4,4));
               _loc_2.push(new Point(3,4));
               _loc_2.push(new Point(5,4));
               _loc_2.push(new Point(6,4));
               break;
            case TutorialHandler.POP_ID_STRIPED_3:
               _loc_2.push(new Point(6,5));
               _loc_2.push(new Point(6,4));
               _loc_2.push(new Point(4,4));
               _loc_2.push(new Point(5,4));
               break;
            case TutorialHandler.POP_ID_WRAPPED_1:
               _loc_2.push(new Point(5,6));
               _loc_2.push(new Point(5,5));
               _loc_2.push(new Point(4,5));
               _loc_2.push(new Point(6,5));
               _loc_2.push(new Point(5,4));
               _loc_2.push(new Point(5,3));
               break;
            case TutorialHandler.POP_ID_WRAPPED_2:
               _loc_2.push(new Point(4,6));
               _loc_2.push(new Point(5,6));
               _loc_2.push(new Point(5,5));
               _loc_2.push(new Point(5,7));
               break;
            case TutorialHandler.POP_ID_STRIPED_WRAPPED_1:
               _loc_2.push(new Point(5,4));
               _loc_2.push(new Point(5,5));
               break;
            case TutorialHandler.POP_ID_COLORBOMB_1:
               _loc_2.push(new Point(6,6));
               _loc_2.push(new Point(5,6));
               _loc_2.push(new Point(5,4));
               _loc_2.push(new Point(5,5));
               _loc_2.push(new Point(5,7));
               _loc_2.push(new Point(5,8));
               break;
            case TutorialHandler.POP_ID_COLORBOMB_2:
               _loc_2.push(new Point(5,8));
               _loc_2.push(new Point(5,7));
               break;
            case TutorialHandler.POP_ID_EXPLAIN_LIGHT_UP_2:
               _loc_2.push(new Point(3,2));
               _loc_2.push(new Point(3,1));
               _loc_2.push(new Point(4,1));
               _loc_2.push(new Point(5,1));
         }
         return _loc_2;
      }
      
      private function removeUnQueuedElement(event:Event) : void
      {
         var _loc_2:* = event.currentTarget as TutorialPop;
         _loc_2.deactivate();
         _loc_2.removeEventListener(CCConstants.DEACTIVATE_QUEUE_ELEMENT,this.removeUnQueuedElement);
         _loc_2.addEventListener(CCConstants.SKIP_TUTORIALS,this.removeUnQueuedElement);
         _loc_2.destruct();
         _loc_2 = null;
      }
      
      private function startEpisode1Level2() : void
      {
         var _loc_1:* = new WorldEvent(WorldEvent.PLAY_LEVEL);
         _loc_1.episode_id = 1;
         _loc_1.level_id = 2;
         this._ccMain.initiatePlayLevel(_loc_1);
      }
   }
}

