package com.king.saga.api.event
{
   public class InvalidLevelEvent extends SagaEvent
   {
      public static const Type:String = "InvalidLevel";
      
      public function InvalidLevelEvent(param1:Object)
      {
         super(param1,Type);
      }
   }
}

