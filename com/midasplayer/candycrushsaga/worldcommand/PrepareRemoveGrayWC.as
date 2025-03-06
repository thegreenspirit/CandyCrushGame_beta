package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class PrepareRemoveGrayWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      private var episodeId:int;
      
      public function PrepareRemoveGrayWC(param1:int, param2:Function)
      {
         super();
         this.getWorldCommandHandlerFn = param2;
         this.episodeId = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.prepareRemoveGrayOverlay(this.episodeId);
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

