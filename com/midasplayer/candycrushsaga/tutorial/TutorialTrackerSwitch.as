package com.midasplayer.candycrushsaga.tutorial
{
   import com.midasplayer.candycrushsaga.main.CCMain;
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import com.midasplayer.candycrushsaga.ccshared.event.GameCommEvent;
   import flash.events.Event;
   
   public class TutorialTrackerSwitch extends TutorialTracker
   {
      public function TutorialTrackerSwitch(param1:CCMain, param2:TutorialHandler)
      {
         super(param1,param2);
         _MAX_SWITCHES = 3;
      }
      
      override protected function setListeners() : void
      {
         _ccMain.getGame().addEventListener(GameCommEvent.SUCCESSFUL_SWITCH,this.userKnowsHowToSwitch);
         _ccMain.getGame().addEventListener(GameCommEvent.FAILED_SWITCH,this.onFailedSwitch);
      }
      
      private function onFailedSwitch(event:GameCommEvent) : void
      {
         var _loc_3:* = _switches + 1;
         _switches = _loc_3;
         if(_switches >= _MAX_SWITCHES)
         {
            _tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_SWITCHING_RANDOM,null,null);
            dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
            _tutorialHandler.addTutorialTracker(TutorialHandler.TRK_ID_EXPLAIN_SWITCHING_RANDOM);
         }
      }
      
      private function userKnowsHowToSwitch(event:GameCommEvent) : void
      {
         _switches = 0;
      }
      
      override public function destruct() : void
      {
         super.destruct();
         _ccMain.getGame().removeEventListener(GameCommEvent.FAILED_SWITCH,this.onFailedSwitch);
         _ccMain.getGame().removeEventListener(GameCommEvent.SUCCESSFUL_SWITCH,this.userKnowsHowToSwitch);
      }
   }
}

import flash.events.EventDispatcher;

