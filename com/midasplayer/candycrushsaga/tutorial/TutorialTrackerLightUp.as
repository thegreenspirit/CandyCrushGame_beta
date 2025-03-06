package com.midasplayer.candycrushsaga.tutorial
{
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import com.midasplayer.candycrushsaga.ccshared.event.GameCommEvent;
   import flash.events.Event;
   
   public class TutorialTrackerLightUp extends TutorialTracker
   {
      public function TutorialTrackerLightUp(param1:CCMain, param2:TutorialHandler)
      {
         super(param1,param2);
         _MAX_SWITCHES = 5;
      }
      
      override protected function setListeners() : void
      {
         _ccMain.getGame().addEventListener(GameCommEvent.SUCCESSFUL_SWITCH,this.onSwitch);
         _ccMain.getGame().addEventListener(GameCommEvent.FAILED_SWITCH,this.onSwitch);
         _ccMain.getGame().addEventListener(GameCommEvent.SUCCESFUL_LIGHTUP,this.onSuccessfulLightUp);
      }
      
      private function onSwitch(event:GameCommEvent) : void
      {
         var _loc_3:* = _switches + 1;
         _switches = _loc_3;
         if(_switches >= _MAX_SWITCHES)
         {
            _tutorialHandler.addTutorialPop(TutorialHandler.POP_ID_EXPLAIN_LIGHT_UP_1,null,null);
            dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
            _tutorialHandler.addTutorialPop(TutorialHandler.TRK_ID_EXPLAIN_LIGHT_UP,null,null);
         }
      }
      
      private function onSuccessfulLightUp(event:GameCommEvent) : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         _ccMain.getGame().removeEventListener(GameCommEvent.FAILED_SWITCH,this.onSwitch);
         _ccMain.getGame().removeEventListener(GameCommEvent.SUCCESSFUL_SWITCH,this.onSwitch);
         _ccMain.getGame().removeEventListener(GameCommEvent.SUCCESFUL_LIGHTUP,this.onSuccessfulLightUp);
      }
   }
}

import flash.events.EventDispatcher;

