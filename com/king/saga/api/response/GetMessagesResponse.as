package com.king.saga.api.response
{
   import com.king.saga.api.event.EventParser;
   import com.king.saga.api.event.IEventFactory;
   import com.king.saga.api.event.SagaEvent;
   import com.king.saga.api.user.CurrentUser;
   import com.midasplayer.util.TypedKeyVal;
   
   public class GetMessagesResponse
   {
      private var _currentUser:CurrentUser;
      
      private var _events:Vector.<SagaEvent>;
      
      public function GetMessagesResponse(param1:Object, param2:Boolean = true, param3:IEventFactory = null)
      {
         var _loc4_:TypedKeyVal = null;
         var _loc5_:Object = null;
         super();
         _loc4_ = new TypedKeyVal(param1);
         this._currentUser = new CurrentUser(_loc4_.getAsObject("currentUser"));
         _loc5_ = _loc4_.getAsObject("events");
         var _loc6_:EventParser = new EventParser(_loc5_,param2,param3);
         this._events = _loc6_.getEvents();
      }
      
      public function getEvents() : Vector.<SagaEvent>
      {
         return this._events;
      }
      
      public function getCurrentUser() : CurrentUser
      {
         return this._currentUser;
      }
   }
}

