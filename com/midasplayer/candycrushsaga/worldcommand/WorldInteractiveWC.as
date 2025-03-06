package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class WorldInteractiveWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      public function WorldInteractiveWC(param1:Function)
      {
         super();
         this.getWorldCommandHandlerFn = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeMakeInteractive();
         this.endCommand();
      }
      
      override public function destruct() : void
      {
         this.getWorldCommandHandlerFn = null;
      }
      
      private function endCommand() : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
   }
}

import flash.events.EventDispatcher;

