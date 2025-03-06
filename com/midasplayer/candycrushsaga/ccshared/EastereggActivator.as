package com.midasplayer.candycrushsaga.ccshared
{
   import flash.events.*;
   
   public class EastereggActivator
   {
      private var _activationCommand:String;
      
      private var _activationCallback:Function;
      
      private var _keyboardEventDispatcher:EventDispatcher;
      
      private var _keyHistory:Vector.<String>;
      
      public function EastereggActivator(param1:String, param2:Function, param3:EventDispatcher)
      {
         var _loc_4:int = 0;
         super();
         this._activationCommand = param1;
         this._activationCallback = param2;
         this._keyboardEventDispatcher = param3;
         this._keyHistory = new Vector.<String>();
         while(_loc_4 < param1.length)
         {
            this._keyHistory.push("");
            _loc_4++;
         }
         this._keyboardEventDispatcher.addEventListener(KeyboardEvent.KEY_DOWN,this._onKeyDown);
      }
      
      public function destroy() : void
      {
         this._keyboardEventDispatcher.removeEventListener(KeyboardEvent.KEY_DOWN,this._onKeyDown);
      }
      
      private function _onKeyDown(event:KeyboardEvent) : void
      {
         this._keyHistory.shift();
         this._keyHistory.push(String.fromCharCode(event.charCode));
         if(this._keyHistory.join("") == this._activationCommand)
         {
            this._activationCallback();
         }
      }
   }
}

