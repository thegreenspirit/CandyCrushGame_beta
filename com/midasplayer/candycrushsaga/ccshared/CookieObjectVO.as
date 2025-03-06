package com.midasplayer.candycrushsaga.ccshared
{
   public class CookieObjectVO
   {
      public static const LIFE_GIFT_TTL:int = 14400000;
      
      public static const GIVE_LIFE:String = "giveLifeX";
      
      public static const WATCH_VIDEO_AD:String = "watchVideoAdX";
      
      public static const TUTORIAL_TTL:int = 1039228928;
      
      public var value:Object;
      
      public var ttl:Number;
      
      public var expired:Boolean = true;
      
      public function CookieObjectVO()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[CookieObjectVO value=" + this.value + " ttl=" + this.ttl + "]";
      }
   }
}

