package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   
   public class PrepareMoveSelfPicWC extends WorldCommand
   {
      public static const PREPARE_MOVE_SELF_PIC:String = "prepareMoveSelfPic";
      
      private var getWorldCommandHandlerFn:Function;
      
      private var episodeId:int;
      
      private var levelId:int;
      
      public function PrepareMoveSelfPicWC(param1:int, param2:int, param3:Function)
      {
         super();
         this.getWorldCommandHandlerFn = param3;
         this.episodeId = param1;
         this.levelId = param2;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.prepareMoveSelfPic(this.episodeId,this.levelId);
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
      
      override public function get commandType() : String
      {
         return PREPARE_MOVE_SELF_PIC;
      }
   }
}

import flash.events.EventDispatcher;

