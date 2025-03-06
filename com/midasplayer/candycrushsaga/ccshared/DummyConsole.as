package com.midasplayer.candycrushsaga.ccshared
{
   import com.midasplayer.console.IConsoleCommandProcessor;
   
   public class DummyConsole implements ICandyCrushGameConsole
   {
      public function DummyConsole()
      {
         super();
      }
      
      public function println(param1:*, param2:String = "default", param3:int = 16776960) : void
      {
      }
      
      public function error(param1:String) : void
      {
      }
      
      public function enablePrintCategory(param1:String) : void
      {
      }
      
      public function disablePrintCategory(param1:String) : void
      {
      }
      
      public function activate() : void
      {
      }
      
      public function isActivated() : Boolean
      {
         return false;
      }
      
      public function deactivate() : void
      {
      }
      
      public function registerProcessor(param1:String, param2:IConsoleCommandProcessor, param3:String = "") : void
      {
      }
      
      public function unRegisterProcessor(param1:String, param2:IConsoleCommandProcessor) : void
      {
      }
      
      public function isPrintCategoryEnabled(param1:String) : Boolean
      {
         return false;
      }
   }
}

