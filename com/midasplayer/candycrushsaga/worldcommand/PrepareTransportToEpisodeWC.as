package com.midasplayer.candycrushsaga.worldcommand
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class PrepareTransportToEpisodeWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      private var episodeId:int;
      
      public function PrepareTransportToEpisodeWC(param1:int, param2:Function)
      {
         super();
         this.episodeId = param1;
         Console.println("PrepareTransportToEpisodeWC Constructor");
         this.getWorldCommandHandlerFn = param2;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         MonsterDebugger.trace(this,"PrepareTransportToEpisodeWC triggerCommand commandHandler=" + _loc_1);
         _loc_1.prepareTransportToEpisode(this.episodeId);
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

