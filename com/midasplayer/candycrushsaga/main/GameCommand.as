package com.midasplayer.candycrushsaga.main
{
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class GameCommand extends MovieClip implements ICCQueueElement
   {
      private var _clbExitFunc:Function;
      
      private var _command:String;
      
      public function GameCommand(param1:Function, param2:String)
      {
         super();
         this._clbExitFunc = param1;
         this._command = param2;
      }
      
      public function triggerCommand() : void
      {
         if(this._clbExitFunc != null)
         {
            this._clbExitFunc();
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      public function deactivate() : void
      {
      }
      
      public function destruct() : void
      {
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

