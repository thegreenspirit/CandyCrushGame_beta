package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.main.ICCQueueElement;
   import flash.events.EventDispatcher;
   
   public class WorldCommand extends EventDispatcher implements ICCQueueElement
   {
      public static const WORLD_COMMAND:String = "worldCommand";
      
      private var _commandType:String = "worldCommand";
      
      public function WorldCommand()
      {
         super();
      }
      
      public function triggerCommand() : void
      {
      }
      
      public function deactivate() : void
      {
      }
      
      public function destruct() : void
      {
      }
      
      public function executeOn(param1:Function) : void
      {
         param1();
      }
      
      public function get commandType() : String
      {
         return this._commandType;
      }
   }
}

import flash.events.EventDispatcher;

