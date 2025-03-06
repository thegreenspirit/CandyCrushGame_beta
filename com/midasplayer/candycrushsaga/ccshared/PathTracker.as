package com.midasplayer.candycrushsaga.ccshared
{
   public class PathTracker
   {
      private static var trackersArr:Array = [];
      
      public var addedPaths:Array;
      
      public var completedPaths:Array;
      
      public var failedPaths:Array;
      
      private var name:String;
      
      public function PathTracker(param1:String)
      {
         super();
         this.name = param1;
         this.initArrays();
         trackersArr.push(this);
      }
      
      public static function isUsed() : Boolean
      {
         if(trackersArr.length > 0)
         {
            return true;
         }
         return false;
      }
      
      public static function getStatusForAll() : String
      {
         var _loc_2:PathTracker = null;
         var _loc_1:String = "[PATH-TRACKERS]\n";
         for each(_loc_2 in trackersArr)
         {
            _loc_1 += _loc_2.getStatus();
         }
         return _loc_1;
      }
      
      private function initArrays() : void
      {
         this.addedPaths = [];
         this.completedPaths = [];
         this.failedPaths = [];
      }
      
      private function getStatus() : String
      {
         var _loc_11:String = null;
         var _loc_12:Boolean = false;
         var _loc_13:int = 0;
         var _loc_14:String = null;
         var _loc_4:int = 0;
         var _loc_6:int = 0;
         var _loc_8:int = 0;
         var _loc_10:int = 0;
         var _loc_1:* = " -------- [*" + this.name + "] --------\n";
         var _loc_2:Array = [];
         var _loc_3:Array = [];
         while(_loc_4 < this.addedPaths.length)
         {
            _loc_11 = this.addedPaths[_loc_4];
            _loc_12 = false;
            _loc_13 = 0;
            while(_loc_13 < this.completedPaths.length)
            {
               _loc_14 = this.completedPaths[_loc_13];
               if(_loc_14 == _loc_11)
               {
                  _loc_12 = true;
                  break;
               }
               _loc_13++;
            }
            if(_loc_12)
            {
               _loc_2.push(_loc_11);
            }
            else
            {
               _loc_3.push(_loc_11);
            }
            _loc_4++;
         }
         var _loc_5:String = "[FINISHED]\n";
         while(_loc_6 < _loc_2.length)
         {
            _loc_5 += "\t" + _loc_2[_loc_6] + "\n";
            _loc_6++;
         }
         var _loc_7:String = "[UNFINISHED]\n";
         while(_loc_8 < _loc_3.length)
         {
            _loc_7 += "\t" + _loc_3[_loc_8] + "\n";
            _loc_8++;
         }
         var _loc_9:String = "[ERRORS]\n";
         while(_loc_10 < this.failedPaths.length)
         {
            _loc_9 += "\t" + this.failedPaths[_loc_10] + "\n";
            _loc_10++;
         }
         if(_loc_2.length > 0)
         {
            _loc_1 += _loc_5;
         }
         if(_loc_3.length > 0)
         {
            _loc_1 += _loc_7;
         }
         if(this.failedPaths.length > 0)
         {
            _loc_1 += _loc_9;
         }
         return _loc_1;
      }
   }
}

