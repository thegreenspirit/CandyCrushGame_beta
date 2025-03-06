package com.midasplayer.candycrushsaga.ccshared.event
{
   import com.king.saga.api.crafting.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   
   public class GameCommEvent extends CCEvent
   {
      public static const GAME_COMPLETED:String = "GameCommEvent.GAME_COMPLETED";
      
      public static const GAME_FAILED:String = "GameCommEvent.GAME_FAILED";
      
      public static const USER_QUIT:String = "GameCommEvent.USER_QUIT";
      
      public static const SHUT_DOWN_COMPLETE:String = "GameCommEvent.SHUT_DOWN_COMPLETE";
      
      public static const SUCCESSFUL_SWITCH:String = "GameCommEvent.SUCCESSFUL_SWITCH";
      
      public static const FAILED_SWITCH:String = "GameCommEvent.FAILED_SWITCH";
      
      public static const SUCCESFUL_LIGHTUP:String = "GameCommEvent.SUCCESFUL_LIGHTUP";
      
      public static const SCORE_TARGET_REACHED:String = "GameCommEvent.SCORE_TARGET_REACHED";
      
      public static const GAME_PLAY_START:String = "GameCommEvent.GAME_PLAY_START";
      
      public static const GAME_PLAY_END:String = "GameCommEvent.GAME_PLAY_END";
      
      public static const INGAME_BOOSTER_PREPARED:String = "GameCommEvent.INGAME_BOOSTER_PREPARED";
      
      public static const INGAME_BOOSTER_CONSUMED:String = "GameCommEvent.INGAME_BOOSTER_CONSUMED";
      
      public static const EXTRA_MOVES_REMINDER_CLICKED:String = "GameCommEvent.EXTRA_MOVES_REMINDER_CLICKED";
      
      public static const SHOW_EXTRA_MOVES_REMINDER:String = "GameCommEvent.SHOW_EXTRA_MOVES_REMINDER";
      
      public static const HIDE_EXTRA_MOVED_REMINDER:String = "GameCommEvent.HIDE_EXTRA_MOVES_REMINDER";
      
      public static const CAP_EXTRA_MOVES_REMINDER:String = "GameCommEvent.CAP_EXTRA_MOVES_REMINDER";
      
      private var _score:int;
      
      private var _failReason:String;
      
      private var _drops:Vector.<ItemAmount>;
      
      public function GameCommEvent(param1:String)
      {
         super(param1);
         this._score = 0;
         this._drops = new Vector.<ItemAmount>();
      }
      
      public function score() : int
      {
         return this._score;
      }
      
      public function drops() : Vector.<ItemAmount>
      {
         return this._drops;
      }
      
      public function setScore(param1:int) : void
      {
         this._score = param1;
      }
      
      public function failReason() : String
      {
         return this._failReason;
      }
      
      public function setFailReason(param1:String) : void
      {
         this._failReason = param1;
      }
      
      public function toString() : String
      {
         var _loc_1:* = new PrintTable(["event_type","score"]);
         _loc_1.addRow([type(),this._score]);
         return _loc_1.toString();
      }
   }
}

