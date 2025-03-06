package com.midasplayer.candycrushsaga.worldcommand
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class SetActiveStationWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      private var episodeId:int;
      
      private var levelId:int;
      
      public function SetActiveStationWC(param1:int, param2:int, param3:Function)
      {
         super();
         MonsterDebugger.trace(this,"new SetActiveStationWC");
         this.getWorldCommandHandlerFn = param3;
         this.episodeId = param1;
         this.levelId = param2;
      }
      
      override public function triggerCommand() : void
      {
         MonsterDebugger.trace(this,"trigger :: SetActiveStationWC ");
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeSetActiveStation(this.episodeId,this.levelId);
         this.endCommand();
      }
      
      override public function destruct() : void
      {
         this.getWorldCommandHandlerFn = null;
      }
      
      private function endCommand() : void
      {
         MonsterDebugger.trace(this,"SetActiveStationWC endCommand");
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
   }
}

import flash.events.EventDispatcher;

