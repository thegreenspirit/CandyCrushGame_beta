package
{
   import flash.events.Event;
   
   public class PayEvent extends Event
   {
      public static const BUY_LIFE:String = "ON_BUY_LIFE";
      
      public static const BUY_ITEM:String = "BUY_ITEM";
      
      public static const NEXT_RANK_TRUE:String = "NEXT_RANK_TRUE";
      
      public static const ALL_PASS_TRUE:String = "ALL_PASS_TRUE";
      
      public static const GAME_OVER_TRUE:String = "GAME_OVER_TRUE";
      
      public static const GAME_OVER:String = "GAME_OVER";
      
      public var data:Object;
      
      public function PayEvent(param1:String, param2:Object = null, param3:Boolean = false)
      {
         super(param1,param3,false);
         this.data = param2;
      }
   }
}

import flash.events.Event;

