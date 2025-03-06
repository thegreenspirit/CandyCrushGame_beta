package com.midasplayer.candycrushsaga.charms
{
   public class SocialChannelConfig
   {
      private static var _socialChannel:String;
      
      public static const FACEBOOK:String = "facebook";
      
      public static const GOOGLE:String = "google";
      
      public function SocialChannelConfig(param1:String)
      {
         super();
         _socialChannel = param1;
      }
      
      public function getSocialChannel() : String
      {
         return _socialChannel;
      }
      
      public function hasTrialPayButton() : Boolean
      {
         if(_socialChannel == FACEBOOK)
         {
            return true;
         }
         if(_socialChannel == GOOGLE)
         {
            return false;
         }
         return false;
      }
      
      public function hasWatchAdButton() : Boolean
      {
         if(_socialChannel == FACEBOOK)
         {
            return true;
         }
         if(_socialChannel == GOOGLE)
         {
            return false;
         }
         return false;
      }
      
      public function hasSecondVisit() : Boolean
      {
         if(_socialChannel == FACEBOOK)
         {
            return true;
         }
         if(_socialChannel == GOOGLE)
         {
            return false;
         }
         return false;
      }
      
      public function getButtonSuffix() : String
      {
         if(_socialChannel == FACEBOOK)
         {
            return "";
         }
         if(_socialChannel == GOOGLE)
         {
            return "_google";
         }
         return "";
      }
      
      public function getRemoveButtonSuffix() : String
      {
         if(_socialChannel == FACEBOOK)
         {
            return "_google";
         }
         if(_socialChannel == GOOGLE)
         {
            return "";
         }
         return "_google";
      }
      
      public function getButtonSuffixWithDollar() : String
      {
         if(_socialChannel == FACEBOOK)
         {
            return "_google";
         }
         if(_socialChannel == GOOGLE)
         {
            return "_google";
         }
         return "";
      }
      
      public function getRemoveButtonSuffixWithDollar() : String
      {
         if(_socialChannel == FACEBOOK)
         {
            return "";
         }
         if(_socialChannel == GOOGLE)
         {
            return "";
         }
         return "_google";
      }
      
      public function getVideoButtonMargin() : int
      {
         if(_socialChannel == FACEBOOK)
         {
            return 0;
         }
         if(_socialChannel == GOOGLE)
         {
            return 5;
         }
         return 0;
      }
      
      public function getDailyOfferButtonMargin() : int
      {
         if(_socialChannel == FACEBOOK)
         {
            return 0;
         }
         if(_socialChannel == GOOGLE)
         {
            return 5;
         }
         return 0;
      }
      
      public function getDailyOfferButtonMarginWithDollar() : int
      {
         if(_socialChannel == FACEBOOK)
         {
            return 5;
         }
         if(_socialChannel == GOOGLE)
         {
            return 5;
         }
         return 0;
      }
      
      public function getButtonBuyCharmTextWidth() : int
      {
         if(_socialChannel == FACEBOOK)
         {
            return 40;
         }
         if(_socialChannel == GOOGLE)
         {
            return 75;
         }
         return 60;
      }
      
      public function hasLikeButton() : Boolean
      {
         if(_socialChannel == FACEBOOK)
         {
            return true;
         }
         if(_socialChannel == GOOGLE)
         {
            return false;
         }
         return false;
      }
   }
}

