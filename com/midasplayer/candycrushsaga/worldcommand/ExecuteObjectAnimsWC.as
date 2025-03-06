package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class ExecuteObjectAnimsWC extends WorldCommand
   {
      private var getWorldCommandHandlerFn:Function;
      
      public function ExecuteObjectAnimsWC(param1:Function)
      {
         super();
         this.getWorldCommandHandlerFn = param1;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         var _loc_2:* = _loc_1.getMapPointForFirstObjectAnim();
         if(_loc_2 != null)
         {
            _loc_1.panToPosition(_loc_2,this.afterTweenCB);
         }
         else
         {
            this.endCommand();
         }
      }
      
      private function afterTweenCB() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeObjectAnims(this.endCommand);
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

