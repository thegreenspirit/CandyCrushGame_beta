package com.midasplayer.candycrushsaga.ccshared.gameconf
{
   import com.adobe.serialization.json.*;
   import com.midasplayer.debug.*;
   
   public class GameConfFactory
   {
      public function GameConfFactory()
      {
         super();
      }
      
      public function createNewFromGameMode(param1:String) : GameConf
      {
         if(param1 == GameConf.MODE_NAME_CLASSIC)
         {
            return new GameConfClassic();
         }
         if(param1 == GameConf.MODE_NAME_CLASSIC_MOVES)
         {
            return new GameConfClassicMoves();
         }
         if(param1 == GameConf.MODE_NAME_LIGHT_UP)
         {
            return new GameConfLightUp();
         }
         if(param1 == GameConf.MODE_NAME_DROP_DOWN)
         {
            return new GameConfDropDown();
         }
         Debug.assert(false,"Trying to create a game conf from unknown game mode name.");
         return null;
      }
      
      public function createFromJSON(param1:String) : GameConf
      {
         var decoder:JSONDecoder = null;
         var jsonStr:* = param1;
         decoder = new JSONDecoder(jsonStr,false);
         return this.createFromObject(decoder.getValue());
      }
      
      public function createFromObject(param1:Object) : GameConf
      {
         var _loc_2:* = new GameConf();
         _loc_2.loadFromObject(param1);
         trace(_loc_2.gameModeName());
         _loc_2 = this.createNewFromGameMode(_loc_2.gameModeName());
         _loc_2.loadFromObject(param1);
         return _loc_2;
      }
   }
}

