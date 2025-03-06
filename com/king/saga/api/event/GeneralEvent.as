package com.king.saga.api.event
{
   public class GeneralEvent extends SagaEvent
   {
      public static const Type:String = "GENERAL_EVENT";
      
      public function GeneralEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
      }
   }
}

