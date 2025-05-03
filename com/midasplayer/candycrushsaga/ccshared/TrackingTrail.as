package com.midasplayer.candycrushsaga.ccshared
{
   public class TrackingTrail
   {
      private static var trailArr:Array = ["[TRACKING TRAIL START]"];
      
      public function TrackingTrail()
      {
         super();
      }
      
      public static function track(param1:String) : void
      {
         //trace(param1);
         trailArr.push(param1);
      }
      
      public static function getTrail() : String
      {
         return trailArr.join("-") + " [END]";
      }
   }
}

