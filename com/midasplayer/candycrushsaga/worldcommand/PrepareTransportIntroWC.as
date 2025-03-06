package com.midasplayer.candycrushsaga.worldcommand
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class PrepareTransportIntroWC extends WorldCommand
   {
      private var getWorldCommandHandler:Function;
      
      private var episodeId:int;
      
      public function PrepareTransportIntroWC(param1:int, param2:Function)
      {
         super();
         MonsterDebugger.trace(this,"new PrepareTransportIntroWC ");
         this.getWorldCommandHandler = param2;
         this.episodeId = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandler();
         _loc_1.prepareTransportIntro(this.episodeId);
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

