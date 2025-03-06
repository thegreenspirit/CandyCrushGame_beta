package com.midasplayer.candycrushsaga.ccshared
{
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConf;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConfClassicMoves;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConfDropDown;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConfLightUp;
   
   public class CurrentGameStatus
   {
      public var totalMoves:int;
      
      public var movesLeft:int;
      
      public var currentScore:int;
      
      public function CurrentGameStatus(param1:GameConf, param2:int, param3:int)
      {
         super();
         this.totalMoves = this.getTotalMoves(param1);
         this.movesLeft = this.totalMoves - param3;
         this.currentScore = param2;
      }
      
      private function getTotalMoves(param1:GameConf) : int
      {
         if(param1 is GameConfLightUp)
         {
            return GameConfLightUp(param1).moveLimit();
         }
         if(param1 is GameConfClassicMoves)
         {
            return GameConfClassicMoves(param1).moveLimit();
         }
         if(param1 is GameConfDropDown)
         {
            return GameConfDropDown(param1).moveLimit();
         }
         return -1;
      }
   }
}

