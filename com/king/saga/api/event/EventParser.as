package com.king.saga.api.event
{
   import com.midasplayer.debug.*;
   
   public class EventParser
   {
      private var _events:Vector.<SagaEvent>;
      
      public function EventParser(param1:Object, param2:Boolean = true, param3:IEventFactory = null)
      {
         var _loc_5:Object = null;
         var _loc_6:SagaEvent = null;
         super();
         this._events = new Vector.<SagaEvent>();
         Debug.assert(param1 != null,"Error when trying to parse events, the events object is null.");
         if(param3 == null)
         {
            param3 = new EventFactory();
         }
         var _loc_4:* = param1 as Array;
         Debug.assert(_loc_4 != null,"Error when trying to parse events, the events object doesn\'t appear to be an array.");
         for each(_loc_5 in _loc_4)
         {
            _loc_6 = param3.create(_loc_5);
            Debug.assert(!param2 || _loc_6 != null,"An event has not been created, since it doesn\'t exist in the factory.");
            if(_loc_6 != null)
            {
               this._events.push(_loc_6);
            }
         }
      }
      
      public function getEvents() : Vector.<SagaEvent>
      {
         return this._events;
      }
   }
}

