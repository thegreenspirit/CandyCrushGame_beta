package com.midasplayer.candycrushsaga.ccshared
{
   public class CCConstants
   {
      public static const CATEGORY_ID_GOLD_CATEGORY:int = 1;
      
      public static const CATEGORY_ID_LIFE_CATEGORY:int = 2;
      
      public static const CATEGORY_ID_LEVEL_UNLOCK_CATEGORY:int = 4;
      
      public static const CATEGORY_ID_INGAME_CATEGORY:int = 5;
      
      public static const CATEGORY_ID_MULTI_CATEGORY:int = 6;
      
      public static const CATEGORY_ID_ITEM_CATEGORY:int = 7;
      
      public static const CATEGORY_ID_EXTRA_LIFE_PRODUCT:int = 10;
      
      public static const VERSION:Number = 0.1;
      
      public static const STAGE_WIDTH:int = 755;
      
      public static const STAGE_HEIGHT:int = 650;
      
      public static const TOPNAV_HEIGHT:int = 50;
      
      public static const MAP_TOP:int = -335;
      
      public static const MAP_LEFT:int = -172;
      
      public static const CC_FRAMERATE:int = 60;
      
      public static const EVENT_HIDE_PRELOADER_SCREEN:String = "eventHidePreloaderScreen";
      
      public static const GAME_OVER_REASON_VICTORY:int = 0;
      
      public static const GAME_OVER_REASON_QUIT_BUTTON:int = 1;
      
      public static const GAME_OVER_REASON_LOSS:int = 2;
      
      public static const DEACTIVATE_QUEUE_ELEMENT:String = "deactivateQueueElement";
      
      public static const SKIP_TUTORIALS:String = "skipTutorials";
      
      public static const WITHDRAW_CUTSCENE_FROM_QUEUE:String = "withdrawCutsceneFromQueue";
      
      public static const ADD_POPUP:String = "addPopup";
      
      public static const LOCK_GAME_BOARD:String = "lockGameBoard";
      
      public static const UNLOCK_GAME_BOARD:String = "unLockGameBoard";
      
      public static const QUEUEHANDLER_IS_EMPTY:String = "queueHandlerIsEmpty";
      
      public static const RESUME_GAME:String = "resumeGame";
      
      public static const MINIMUM_REQUIRED_GAME_ENGINE_VERSION:Number = 2.1;
      
      public static const GAME_FAIL_REASON_OUT_OF_TIME:String = "fail_reason_out_of_time";
      
      public static const GAME_FAIL_REASON_LOW_SCORE:String = "fail_reason_low_score";
      
      public static const GAME_FAIL_REASON_NO_MORE_MOVES:String = "fail_reason_no_more_moves";
      
      public static const GAME_FAIL_REASON_LIGHTS_UNLIT:String = "fail_reason_lights_unlit";
      
      public static const GAME_FAIL_REASON_UNCOLLECTED_INGREDIENTS:String = "fail_reason_uncollected_ingredients";
      
      public static const GAME_FAIL_REASON_PEPPER_EXPLODED:String = "fail_reason_pepper_exploded";
      
      public static const MAP_HEIGHT:int = 1560;
      
      public static const MAP_WIDTH:int = 1600;
      
      public static const GAME_RESULT_SALT:String = "BuFu6gBFv79BH9hk";
      
      public static const MAIN_CLASS:String = "mainClass";
      
      public static const GAME_CLASS:String = "gameClass";
      
      public static const WORLD_CLASS:String = "worldClass";
      
      public static const WORLD_ASSETS:String = "worldAssets";
      
      public static const CUTSCENE:String = "cutscene";
      
      public static const LAST_EPISODE:int = 8;
      
      public static const TOP_LEVEL:int = 15;
      
      public function CCConstants()
      {
         super();
      }
      
      public static function calculateGameFailReasonCode(param1:String) : int
      {
         var _loc_2:int = 0;
         var _loc_3:int = 0;
         while(_loc_3 < param1.length)
         {
            _loc_2 += param1.charCodeAt(_loc_3);
            _loc_3++;
         }
         return _loc_2;
      }
   }
}

