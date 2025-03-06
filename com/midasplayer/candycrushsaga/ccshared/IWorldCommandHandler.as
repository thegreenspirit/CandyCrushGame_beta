package com.midasplayer.candycrushsaga.ccshared
{
   import com.midasplayer.candycrushsaga.engine.LevelUnlockVO;
   import com.midasplayer.candycrushsaga.engine.StarLevelVO;
   import flash.geom.Point;
   
   public interface IWorldCommandHandler
   {
      function prepareLevelUnlock(param1:LevelUnlockVO) : void;
      
      function executeLevelUnlock(param1:LevelUnlockVO, param2:Function) : void;
      
      function executeStarsAnimation(param1:StarLevelVO, param2:Function) : void;
      
      function prepareMoveSelfPic(param1:int, param2:int) : void;
      
      function executeMoveSelfPic(param1:int, param2:int, param3:Function) : void;
      
      function prepareTransportIntro(param1:int) : void;
      
      function executeTransportIntro(param1:int, param2:Function) : void;
      
      function prepareCollaborationIntro(param1:int) : void;
      
      function executeCollaborationIntro(param1:int, param2:Function) : void;
      
      function executeTransportToEpisode(param1:int, param2:Function) : void;
      
      function prepareTransportToEpisode(param1:int) : void;
      
      function prepareRemoveGrayOverlay(param1:int) : void;
      
      function executeRemoveGrayOverlay(param1:int) : void;
      
      function prepareStarAnim(param1:StarLevelVO) : void;
      
      function executeObjectAnims(param1:Function) : void;
      
      function executeMakeInteractive() : void;
      
      function executeDisableInteractive() : void;
      
      function executeSetActiveStation(param1:int, param2:int) : void;
      
      function panToPosition(param1:Point, param2:Function = null) : void;
      
      function getMapPointForStation(param1:int, param2:int) : Point;
      
      function getMapPointForSelfPic(param1:int, param2:int) : Point;
      
      function getMapPointForFirstObjectAnim() : Point;
   }
}

