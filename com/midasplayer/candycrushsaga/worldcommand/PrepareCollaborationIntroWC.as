package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class PrepareCollaborationIntroWC extends WorldCommand
   {
      private var getWorldCommandHandler:Function;
      
      private var episodeId:int;
      
      public function PrepareCollaborationIntroWC(param1:int, param2:Function)
      {
         super();
         this.getWorldCommandHandler = param2;
         this.episodeId = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandler();
         _loc_1.prepareCollaborationIntro(this.episodeId);
         this.endCommand();
      }
      
      override public function destruct() : void
      {
         this.getWorldCommandHandler = null;
      }
      
      private function endCommand() : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
   }
}

import flash.events.EventDispatcher;

