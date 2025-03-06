package com.midasplayer.candycrushsaga.worldcommand
{
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import com.midasplayer.candycrushsaga.main.CCQueueHandler;
   import com.midasplayer.candycrushsaga.main.WorldFactory;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class CreateWorldWC extends WorldCommand
   {
      private var _createWorldFunc:Function;
      
      private var _loadedCompleteStr:String;
      
      private var _worldFactory:IEventDispatcher;
      
      private var cCQueueHandler:CCQueueHandler;
      
      private var worldRefFn:Function;
      
      public function CreateWorldWC(param1:Function, param2:WorldFactory, param3:String, param4:Function, param5:CCQueueHandler)
      {
         super();
         this.worldRefFn = param4;
         this.cCQueueHandler = param5;
         this._createWorldFunc = param1;
         this._loadedCompleteStr = param3;
         this._worldFactory = param2;
      }
      
      override public function triggerCommand() : void
      {
         this._worldFactory.addEventListener(this._loadedCompleteStr,this.onLoadedComplete);
         var _loc_1:* = this._createWorldFunc();
         if(_loc_1)
         {
            this.onLoadedComplete();
         }
      }
      
      private function onLoadedComplete(event:Event = null) : void
      {
         this._worldFactory.removeEventListener(this._loadedCompleteStr,this.onLoadedComplete);
         this.cCQueueHandler.queueWorldInteractive(this.worldRefFn);
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function deactivate() : void
      {
         super.deactivate();
      }
      
      override public function destruct() : void
      {
      }
   }
}

import flash.events.EventDispatcher;

