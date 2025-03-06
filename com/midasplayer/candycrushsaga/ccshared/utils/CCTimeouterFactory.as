package com.midasplayer.candycrushsaga.ccshared.utils
{
   import com.midasplayer.candycrushsaga.ccshared.CCConstants;
   import flash.utils.Timer;
   
   public class CCTimeouterFactory
   {
      private static var _loaderTimeoutMillis:Number = CCConstants.NET_LOADING_TIMEOUT;
      
      private static var _instance:CCTimeouterFactory = new CCTimeouterFactory();
      
      public function CCTimeouterFactory()
      {
         super();
      }
      
      public static function getInstance() : CCTimeouterFactory
      {
         return _instance;
      }
      
      public static function useLoaderTimeoutSeconds(param1:Number) : void
      {
         if(param1 is Number && param1 > 0)
         {
            _loaderTimeoutMillis = param1 * 1000;
         }
      }
      
      public function newLoaderTimeouter() : CCTimeouter
      {
         return new CCTimeouter(new Timer(_loaderTimeoutMillis));
      }
   }
}

