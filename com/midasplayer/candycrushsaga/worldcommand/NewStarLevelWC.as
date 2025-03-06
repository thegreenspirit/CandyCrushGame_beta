package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import flash.events.*;
   
   public class NewStarLevelWC extends WorldCommand
   {
      private var newStarLevelData:StarLevelVO;
      
      private var getWorldCommandHandlerFn:Function;
      
      public function NewStarLevelWC(param1:StarLevelVO, param2:Function)
      {
         super();
         this.newStarLevelData = param1;
         this.getWorldCommandHandlerFn = param2;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeStarsAnimation(this.newStarLevelData,this.endCommand);
      }
      
      override public function destruct() : void
      {
         this.newStarLevelData = null;
         this.getWorldCommandHandlerFn = null;
      }
      
      private function endCommand() : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
   }
}

import flash.events.EventDispatcher;

