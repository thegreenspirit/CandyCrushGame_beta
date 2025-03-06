package com.midasplayer.candycrushsaga.engine
{
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   
   public class LocalConstants
   {
      public static var isFan:String = "false";
      
      public static var getGameConfigurationsMethod:String = "getGameConfigurations";
      
      public static var getCandyPropertiesMethod:String = "getCandyProperties";
      
      private static var useQA:Boolean = false;
      
      public static var userId:Number = 102122;
      
      public static var sessionKey:String = "A18A2E7838DBF8B6F42E4B4F81B4358B";
      
      public static var platid:int = 2;
      
      public static var apiUrl:String = "http://candycrush.dev.midasplayer.com/api/";
      
      public static var candyApiUrl:String = "http://candycrush.dev.midasplayer.com/candycrushapi/";
      
      public static var trackingUrl:String = "http://candycrush.dev.midasplayer.com/GuiTracking";
      
      public static var platformUrl:String = "http://candycrush.dev.midasplayer.com/rpc/PlatformApi";
      
      public static var baseUrl:String = "http://candycrush.dev.midasplayer.com";
      
      if(useQA)
      {
         userId = 1199718327;
         sessionKey = "bTygwFKUHFp8XZ5V!gAi";
         isFan = "false";
         candyApiUrl = "http://candycrushqa.midasplayer.com/candycrushapi/";
         getGameConfigurationsMethod = "getGameConfigurations";
         getCandyPropertiesMethod = "getCandyProperties";
         apiUrl = "http://candycrushqa.midasplayer.com/api";
         trackingUrl = "http://candycrushqa.midasplayer.com/GuiTracking";
         platformUrl = "http://candycrushqa.midasplayer.com/rpc/PlatformApi";
         baseUrl = "http://candycrushqa.midasplayer.com";
      }
      
      public function LocalConstants()
      {
         super();
      }
      
      public static function FORMAT(fontName:String = "American Typewriter") : *
      {
         var FORMAT:TextFormat = new TextFormat();
         FORMAT.font = fontName;
         return FORMAT;
      }
   }
}