package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import flash.events.*;
   
   public class PrepareLevelUnlockedWC extends WorldCommand
   {
      private var getWorldCommandHandler:Function;
      
      private var levelUnlockVO:LevelUnlockVO;
      
      public function PrepareLevelUnlockedWC(param1:LevelUnlockVO, param2:Function)
      {
         super();
         this.getWorldCommandHandler = param2;
         this.levelUnlockVO = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandler();
         _loc_1.prepareLevelUnlock(this.levelUnlockVO);
         this.endCommand();
      }
      
      override public function destruct() : void
      {
         this.getWorldCommandHandler = null;
         this.levelUnlockVO = null;
      }
      
      private function endCommand() : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
   }
}

import flash.events.EventDispatcher;

