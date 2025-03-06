package com.king.saga.api.event
{
   public class GameCompletedEvent extends SagaEvent
   {
      public static const Type:String = "GAME_COMPLETED";
      
      public function GameCompletedEvent(param1:Object)
      {
         super(param1,Type);
      }
   }
}

