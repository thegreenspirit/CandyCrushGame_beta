package com.midasplayer.candycrushsaga.ccshared.gameconf
{
   import com.midasplayer.util.*;
   
   public class GameConfLightUp extends GameConf
   {
      private var _moveLimit:int;
      
      public function GameConfLightUp()
      {
         super();
         setGameModeName(GameConf.MODE_NAME_LIGHT_UP);
         _levelInfoVO.isLightUpMode = true;
         this.setMoveLimit(50);
      }
      
      override public function loadFromObject(param1:Object) : void
      {
         super.loadFromObject(param1);
         var _loc_2:* = new TypedKeyVal(param1);
         this.setMoveLimit(_loc_2.getAsInt("moveLimit"));
      }
      
      override public function getAsObject() : Object
      {
         var _loc_1:* = super.getAsObject();
         _loc_1["moveLimit"] = this.moveLimit();
         return _loc_1;
      }
      
      public function moveLimit() : int
      {
         return this._moveLimit;
      }
      
      public function setMoveLimit(param1:int) : void
      {
         this._moveLimit = param1;
      }
   }
}

