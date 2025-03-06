package com.midasplayer.candycrushsaga.ccshared
{
   import com.midasplayer.console.IConsoleCommandProcessor;
   
   public interface ICandyCrushGameConsole
   {
      function println(param1:*, param2:String = "default", param3:int = 16776960) : void;
      
      function error(param1:String) : void;
      
      function enablePrintCategory(param1:String) : void;
      
      function disablePrintCategory(param1:String) : void;
      
      function activate() : void;
      
      function isActivated() : Boolean;
      
      function deactivate() : void;
      
      function registerProcessor(param1:String, param2:IConsoleCommandProcessor, param3:String = "") : void;
      
      function unRegisterProcessor(param1:String, param2:IConsoleCommandProcessor) : void;
      
      function isPrintCategoryEnabled(param1:String) : Boolean;
   }
}

