package com.king.saga.api.net
{
   import com.king.saga.api.crafting.ItemAmount;
   
   public interface ISagaApi
   {
      function gameInit(param1:Function) : void;
      
      function sagaInit(param1:Function, param2:Boolean) : void;
      
      function gameStart(param1:Function, param2:int, param3:int) : void;
      
      function gameEnd(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:Number, param7:int, param8:String) : void;
      
      function poll(param1:Function) : void;
      
      function getMessages(param1:Function) : void;
      
      function peekMessages(param1:Function) : void;
      
      function removeMessages(param1:Function, param2:Vector.<Number>, param3:Boolean) : void;
      
      function removeLife(param1:Function) : void;
      
      function getLevelToplist(param1:Function, param2:int, param3:int) : void;
      
      function buyBooster(param1:Function, param2:String) : void;
      
      function getRecipes(param1:Function) : void;
      
      function getBalance(param1:Function) : void;
      
      function craft(param1:Function, param2:String) : void;
      
      function useItemsInGame(param1:Function, param2:Vector.<ItemAmount>, param3:int, param4:int) : void;
      
      function handOutItemWinnings(param1:Function, param2:Vector.<ItemAmount>, param3:int, param4:int, param5:String) : void;
      
      function unlockItem(param1:Function, param2:String, param3:String) : void;
      
      function activateItem(param1:Function, param2:String, param3:String) : void;
      
      function deactivateItem(param1:Function, param2:String, param3:String) : void;
      
      function getLevelToplists(param1:Function) : void;
      
      function setSound(param1:Boolean) : void;
      
      function setMusic(param1:Boolean) : void;
      
      function reportFramerate(param1:int, param2:int, param3:Number, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int) : void;
   }
}

