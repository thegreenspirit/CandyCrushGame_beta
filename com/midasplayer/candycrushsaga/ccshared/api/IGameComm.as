package com.midasplayer.candycrushsaga.ccshared.api
{
   import com.midasplayer.candycrushsaga.ccshared.CurrentGameStatus;
   import com.midasplayer.candycrushsaga.ccshared.Hint;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConf;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   
   public interface IGameComm
   {
      function start(param1:GameConf, param2:Vector.<ApplicationDomain>, param3:Vector.<String>) : void;
      
      function pauseGame() : void;
      
      function resumeGame() : void;
      
      function startReplay(param1:String, param2:Vector.<ApplicationDomain>) : void;
      
      function shutDown() : void;
      
      function rageQuit() : void;
      
      function destruct() : void;
      
      function activateBooster(param1:String) : void;
      
      function deactivateBooster(param1:String) : void;
      
      function addEventListener(param1:String, param2:Function) : void;
      
      function removeEventListener(param1:String, param2:Function) : void;
      
      function lockBoard(param1:Vector.<Point>) : void;
      
      function unlockBoard() : void;
      
      function soundOn() : void;
      
      function soundOff() : void;
      
      function musicOn() : void;
      
      function musicOff() : void;
      
      function freeze() : void;
      
      function unFreeze() : void;
      
      function getVersion() : Number;
      
      function getPlayData() : String;
      
      function getNextHint() : Hint;
      
      function prespawnSpecialCandy(param1:int, param2:int, param3:int) : void;
      
      function getFrameTrackingBuckets() : Vector.<int>;
      
      function enableQuitButton() : void;
      
      function disableQuitButton() : void;
      
      function setTutorialActive(param1:Boolean) : void;
      
      function setTutorialDisabled(param1:Boolean) : void;
      
      function getTutorialDisabled() : Boolean;
      
      function getCurrentGameStatus() : CurrentGameStatus;
      
      function disableUI() : void;
   }
}

