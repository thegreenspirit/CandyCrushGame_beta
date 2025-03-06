package com.midasplayer.candycrushsaga.engine
{
   import flash.events.Event;
   
   public class ModelEvent extends Event
   {
      public var value:Object;
      
      public function ModelEvent(param1:String, param2:*)
      {
         super(param1);
         this.value = param2;
      }
      
      override public function clone() : Event
      {
         return new ModelEvent(this.type,this.value);
      }
   }
}

import flash.events.Event;

