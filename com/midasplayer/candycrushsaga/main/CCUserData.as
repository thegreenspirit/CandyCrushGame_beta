package com.midasplayer.candycrushsaga.main
{
   public class CCUserData
   {
      public var activeEpisode:int = 1;
      
      public var activeLevel:int = 1;
      
      public var userId:Number = 0;
      
      public function CCUserData()
      {
         super();
      }
      
      public function setUserActivePosition(param1:int, param2:int) : void
      {
         this.activeEpisode = param1;
         this.activeLevel = param2;
      }
   }
}

