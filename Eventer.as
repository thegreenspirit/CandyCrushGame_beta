package
{
   import flash.events.EventDispatcher;
   
   public class Eventer extends EventDispatcher
   {
      public static var instance:Eventer;
      
      public function Eventer()
      {
         super();
      }
      
      public static function getInstance() : Eventer
      {
         if(instance == null)
         {
            instance = new Eventer();
         }
         return instance;
      }
   }
}

import flash.events.EventDispatcher;

