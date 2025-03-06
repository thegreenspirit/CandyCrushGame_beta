package com.midasplayer.candycrushsaga.tutorial
{
   import com.midasplayer.candycrushsaga.main.ICCQueueElement;
   import flash.events.EventDispatcher;
   
   public class TutorialTracker extends EventDispatcher implements ICCQueueElement
   {
      protected var _MAX_SWITCHES:int = 5;
      
      protected var _switches:int;
      
      protected var _ccMain:CCMain;
      
      protected var _tutorialHandler:TutorialHandler;
      
      public function TutorialTracker(param1:CCMain, param2:TutorialHandler)
      {
         super();
         this._ccMain = param1;
         this._tutorialHandler = param2;
         this._switches = 0;
      }
      
      protected function setListeners() : void
      {
      }
      
      public function triggerCommand() : void
      {
         this.setListeners();
      }
      
      public function deactivate() : void
      {
      }
      
      public function destruct() : void
      {
      }
   }
}

import flash.events.EventDispatcher;

