package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class ExecuteRemoveGrayWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      private var episodeId:int;
      
      public function ExecuteRemoveGrayWC(param1:int, param2:Function)
      {
         super();
         this.getWorldCommandHandlerFn = param2;
         this.episodeId = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeRemoveGrayOverlay(this.episodeId);
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

