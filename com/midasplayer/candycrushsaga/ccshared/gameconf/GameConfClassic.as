package com.midasplayer.candycrushsaga.ccshared.gameconf
{
   import com.midasplayer.util.*;
   
   public class GameConfClassic extends GameConf
   {
      private var _timeLimit:Number;
      
      public function GameConfClassic()
      {
         super();
         setGameModeName(GameConf.MODE_NAME_CLASSIC);
         _levelInfoVO.isTimeMode = true;
         this.setTimeLimit(120);
      }
      
      override public function loadFromObject(param1:Object) : void
      {
         super.loadFromObject(param1);
         var _loc_2:* = new TypedKeyVal(param1);
         this.setTimeLimit(_loc_2.getAsNumber("timeLimit"));
      }
      
      override public function getAsObject() : Object
      {
         var _loc_1:* = super.getAsObject();
         _loc_1["timeLimit"] = this.timeLimit();
         return _loc_1;
      }
      
      public function timeLimit() : Number
      {
         return this._timeLimit;
      }
      
      public function setTimeLimit(param1:Number) : void
      {
         this._timeLimit = param1;
      }
   }
}

