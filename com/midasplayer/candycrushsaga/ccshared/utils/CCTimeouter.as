package com.midasplayer.candycrushsaga.ccshared.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CCTimeouter
   {
      private var _onTimeoutCallback:Function = null;
      
      private var _timer:Timer;
      
      public function CCTimeouter(param1:Timer)
      {
         super();
         this._timer = param1;
      }
      
      public function start(param1:Function) : void
      {
         this._timer.addEventListener(TimerEvent.TIMER,this._onTimeout);
         this._onTimeoutCallback = param1;
         this._timer.start();
      }
      
      public function stop() : void
      {
         this._timer.stop();
         this._onTimeoutCallback = null;
         this._timer.removeEventListener(TimerEvent.TIMER,this._onTimeout);
      }
      
      public function extendTimeout() : void
      {
         this._timer.reset();
         this._timer.start();
      }
      
      private function _onTimeout(param1:TimerEvent) : void
      {
         if(this._onTimeoutCallback != null)
         {
            this._onTimeoutCallback();
         }
      }
   }
}

