package com.midasplayer.candycrushsaga.tutorial
{
   import com.midasplayer.candycrushsaga.main.CCMain;
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import com.midasplayer.candycrushsaga.ccshared.event.GameCommEvent;
   import flash.events.Event;
   
   public class TutorialTrackerScoreLimit extends TutorialTracker
   {
      public function TutorialTrackerScoreLimit(param1:CCMain, param2:TutorialHandler)
      {
         super(param1,param2);
      }
      
      override protected function setListeners() : void
      {
         _ccMain.getGame().addEventListener(GameCommEvent.SCORE_TARGET_REACHED,this.onScoreTargetReached);
      }
      
      private function onScoreTargetReached(event:GameCommEvent) : void
      {
         _tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_SCORE_LIMIT_REACHED,null,null);
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         _ccMain.getGame().removeEventListener(GameCommEvent.SCORE_TARGET_REACHED,this.onScoreTargetReached);
      }
   }
}

import flash.events.EventDispatcher;

