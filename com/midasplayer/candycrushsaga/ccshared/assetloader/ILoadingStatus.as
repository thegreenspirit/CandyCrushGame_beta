package com.midasplayer.candycrushsaga.ccshared.assetloader
{
   public interface ILoadingStatus
   {
      function correctTotalBytes(param1:int) : void;
      
      function updateBytesLoaded(param1:String, param2:int, param3:int = 0) : void;
      
      function percent100hook(param1:Function) : void;
      
      function setTotalBytesForNewPlayer() : void;
   }
}

