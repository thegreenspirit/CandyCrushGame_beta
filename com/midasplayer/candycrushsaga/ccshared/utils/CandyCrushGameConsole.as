package com.midasplayer.candycrushsaga.ccshared.utils
{
   import com.midasplayer.candycrushsaga.ccshared.ICandyCrushGameConsole;
   import com.midasplayer.console.GameConsole;
   import com.midasplayer.console.IConsoleCommandProcessor;
   import flash.display.Stage;
   
   public class CandyCrushGameConsole implements ICandyCrushGameConsole
   {
      public var console:GameConsole;
      
      public function CandyCrushGameConsole(param1:Stage, param2:int, param3:int, param4:Boolean = false, param5:Function = null)
      {
         super();
         this.console = new GameConsole(param1,param2,param3,param4,param5);
      }
      
      public function println(param1:*, param2:String = "default", param3:int = 16776960) : void
      {
         this.console.println(param1,param2,param3);
      }
      
      public function error(param1:String) : void
      {
         this.console.error(param1);
      }
      
      public function enablePrintCategory(param1:String) : void
      {
         this.console.enablePrintCategory(param1);
      }
      
      public function disablePrintCategory(param1:String) : void
      {
         this.console.disablePrintCategory(param1);
      }
      
      public function activate() : void
      {
         this.console.activate();
      }
      
      public function isActivated() : Boolean
      {
         return this.console.isActivated();
      }
      
      public function deactivate() : void
      {
         this.console.deactivate();
      }
      
      public function registerProcessor(param1:String, param2:IConsoleCommandProcessor, param3:String = "") : void
      {
         this.console.registerProcessor(param1,param2,param3);
      }
      
      public function unRegisterProcessor(param1:String, param2:IConsoleCommandProcessor) : void
      {
         this.console.unRegisterProcessor(param1,param2);
      }
      
      public function isPrintCategoryEnabled(param1:String) : Boolean
      {
         return this.console.isPrintCategoryEnabled(param1);
      }
   }
}

