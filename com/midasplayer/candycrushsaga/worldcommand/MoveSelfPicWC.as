package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class MoveSelfPicWC extends WorldCommand
   {
      public static const MOVE_SELF_PIC:String = "moveSelfPic";
      
      private var _commandType:String = "moveSelfPic";
      
      private var getWorldCommandHandlerFn:Function;
      
      private var episodeId:int;
      
      private var levelId:int;
      
      public function MoveSelfPicWC(param1:int, param2:int, param3:Function)
      {
         super();
         this.getWorldCommandHandlerFn = param3;
         this.episodeId = param1;
         this.levelId = param2;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         var _loc_2:* = _loc_1.getMapPointForSelfPic(this.episodeId,this.levelId);
         _loc_1.panToPosition(_loc_2,this.afterTweenCB);
      }
      
      private function afterTweenCB() : void
      {
         var _loc_1:* = this.getWorldCommandHandlerFn();
         _loc_1.executeMoveSelfPic(this.episodeId,this.levelId,this.endCommand);
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

