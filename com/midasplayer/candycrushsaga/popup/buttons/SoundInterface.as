package com.midasplayer.candycrushsaga.popup.buttons
{
   public class SoundInterface
   {
      private static var _getSoundInstance:Function;
      
      private static var _getMusicInstance:Function;
      
      public static const CLICK:String = "click";
      
      public static const SHOW_SIGN:String = "showSign";
      
      public static const ZOOMING:String = "zooming";
      
      public static const SEND_LIFE:String = "sendLife";
      
      public static const THREE_STARS:String = "threeStars";
      
      public static const TWO_STARS:String = "twoStars";
      
      public static const ONE_STARS:String = "oneStars";
      
      public static const ZERO_STARS:String = "zeroStars";
      
      public static const LEVEL_UNLOCK:String = "levelUnlock";
      
      public static const STAR_SOUND:String = "starSound";
      
      public static const CLICK_WRAPPED:String = "clickWrapped";
      
      public static const EPISODE_TRANSPORT:String = "episodeTransport";
      
      public static const MAP_WALK:String = "mapWalk";
      
      public static const ERROR_ALERT:String = "errorAlert";
      
      public static const SWIPE_IN:String = "swipeIn";
      
      public static const SWIPE_OUT:String = "swipeOut";
      
      public static const PLASTIC_DROP:String = "plasticDrop";
      
      public static const FRIEND_PASSED:String = "friendPassed";
      
      public static const FRIEND_BEATEN:String = "friendBeaten";
      
      public static const BOOSTER_UNLOCKED:String = "boosterUnlocked";
      
      public static const BOOSTER_CREATED:String = "boosterCreated";
      
      public static const BOSS_OBJECTED_COMPLETED:String = "bossObjectCompleted";
      
      public static const COLLABORATION_BUTTON_UNLOCK:String = "collaborationButtonUnlock";
      
      public function SoundInterface()
      {
         super();
      }
      
      public static function setCCSoundManager(param1:Function) : void
      {
         _getSoundInstance = param1;
      }
      
      public static function playSound(param1:String, param2:Boolean = true) : void
      {
         if(_getSoundInstance != null)
         {
            _getSoundInstance().playSound(param1,param2);
         }
      }
      
      public static function getMusicPlayer() : Object
      {
         return _getMusicInstance();
      }
      
      public static function setCCMusicManager(param1:Function) : void
      {
         _getMusicInstance = param1;
      }
   }
}

