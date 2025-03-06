package com.midasplayer.candycrushsaga.worldcommand
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class TransportToEpisodeWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      private var episodeId:int;
      
      public function TransportToEpisodeWC(param1:int, param2:Function)
      {
         super();
         this.episodeId = param1;
         Console.println("TransportToEpisodeWC Constructor");
         this.getWorldCommandHandlerFn = param2;
      }
      
      override public function triggerCommand() : void
      {
         MonsterDebugger.trace(this,"TransportToEpisodeWC triggerCommand");
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeTransportToEpisode(this.episodeId,this.endCommand);
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

