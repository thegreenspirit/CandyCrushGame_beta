package com.midasplayer.candycrushsaga.charms
{
   import com.midasplayer.candycrushsaga.balance.*;
   
   public class CharmsPanelInterface
   {
      private static var _panelInstance:Object;
      
      private static var _shopButtonInstance:Object;
      
      public function CharmsPanelInterface()
      {
         super();
      }
      
      public static function notifyCharmBought(param1:CCCharm) : void
      {
         _panelInstance.notifyCharmBought(param1);
      }
      
      public static function notifyCharmUnlocked() : void
      {
         _panelInstance.notifyCharmUnlocked();
         _shopButtonInstance.notifyCharmUnlocked();
      }
      
      public static function setPanelInstance(param1:*) : void
      {
         _panelInstance = param1;
      }
      
      public static function setShopButtonInstance(param1:*) : void
      {
         _shopButtonInstance = param1;
      }
   }
}

