package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import flash.events.*;
   
   public class PrepareStarAnimWC extends WorldCommand
   {
      private var getWorldCommandHandler:Function;
      
      private var newStarLevelData:StarLevelVO;
      
      public function PrepareStarAnimWC(param1:StarLevelVO, param2:Function)
      {
         super();
         this.getWorldCommandHandler = param2;
         this.newStarLevelData = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandler();
         _loc_1.prepareStarAnim(this.newStarLevelData);
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

