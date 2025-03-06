package com.midasplayer.candycrushsaga.ccshared.event
{
   public class CCEvent
   {
      private var _type:String;
      
      private var _params:Vector.<Object>;
      
      public function CCEvent(param1:String, ... args)
      {
         var i:int = 0;
         super();
         this._type = param1;
         if(args != null)
         {
            this._params = new Vector.<Object>(args.length,true);
            i = 0;
            while(i < args.length)
            {
               this._params[args] = args[args];
               i++;
            }
         }
      }
      
      public function type() : String
      {
         return this._type;
      }
      
      public function param(param1:int = 0) : Object
      {
         return this._params != null && param1 >= 0 && param1 < this._params.length ? this._params[param1] : null;
      }
   }
}

