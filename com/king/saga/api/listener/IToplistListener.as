package com.king.saga.api.listener
{
   import com.king.saga.api.toplist.LevelToplist;
   import com.king.saga.api.toplist.ToplistProfile;
   
   public interface IToplistListener
   {
      function onGetToplist(param1:Vector.<ToplistProfile>) : void;
      
      function onGetLevelToplists(param1:Vector.<LevelToplist>) : void;
   }
}

