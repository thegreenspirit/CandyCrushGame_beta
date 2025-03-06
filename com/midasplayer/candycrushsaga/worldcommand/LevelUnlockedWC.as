package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import flash.events.*;
   
   public class LevelUnlockedWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      private var levelUnlockVO:LevelUnlockVO;
      
      public function LevelUnlockedWC(param1:LevelUnlockVO, param2:Function)
      {
         super();
         this.getWorldCommandHandlerFn = param2;
         this.levelUnlockVO = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         this.afterTweenCB();
      }
      
      private function afterTweenCB() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeLevelUnlock(this.levelUnlockVO,this.endCommand);
      }
      
      override public function destruct() : void
      {
         this.getWorldCommandHandlerFn = null;
         this.levelUnlockVO = null;
      }
      
      private function endCommand() : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
   }
}

import flash.events.EventDispatcher;

