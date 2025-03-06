package com.midasplayer.candycrushsaga.ccshared
{
   public class PrintTable
   {
      private var _tableName:String;
      
      private var _headers:Array;
      
      private var _data:Array;
      
      public function PrintTable(param1:Array, param2:String = "")
      {
         super();
         this._headers = param1;
         this._tableName = param2.length > 0 ? "--- " + param2 + " ---" : "";
         this._data = new Array();
      }
      
      public function addRow(param1:Array) : void
      {
         this._data.push(param1);
      }
      
      public function toString() : String
      {
         var _loc_2:int = 0;
         var _loc_5:Array = null;
         var _loc_6:int = 0;
         var _loc_4:int = 0;
         var _loc_1:String = "";
         var _loc_3:* = new Array();
         _loc_2 = 0;
         while(_loc_2 < this._headers.length)
         {
            _loc_6 = this._longestDataLengthByColumn(_loc_2) + 4;
            _loc_3.push(_loc_6);
            _loc_4 += _loc_6;
            _loc_2++;
         }
         if(this._tableName.length > 0)
         {
            _loc_4 = Math.max(this._tableName.length,_loc_4);
         }
         if(this._tableName.length > 0)
         {
            _loc_1 += this._padString("",_loc_4 * 0.5 - this._tableName.length * 0.5,"-");
            _loc_1 += this._tableName;
            _loc_1 += this._padString("",_loc_4 * 0.5 - this._tableName.length * 0.5,"-") + "\n";
         }
         else
         {
            _loc_1 += this._padString("-",_loc_4,"-") + "\n";
         }
         _loc_2 = 0;
         while(_loc_2 < this._headers.length)
         {
            _loc_1 += this._padString(this._headers[_loc_2],_loc_3[_loc_2]);
            _loc_2++;
         }
         _loc_1 += "\n";
         _loc_1 += this._padString("-",_loc_4,"-") + "\n";
         for each(_loc_5 in this._data)
         {
            _loc_2 = 0;
            while(_loc_2 < _loc_5.length)
            {
               _loc_1 += this._padString(_loc_5[_loc_2],_loc_3[_loc_2]);
               _loc_2++;
            }
            _loc_1 += "\n";
         }
         return _loc_1 + (this._padString("-",_loc_4,"-") + "\n");
      }
      
      private function _longestDataLengthByColumn(param1:int) : int
      {
         var _loc_3:Array = null;
         var _loc_2:* = String(this._headers[param1]).length;
         for each(_loc_3 in this._data)
         {
            if(String(_loc_3[param1]).length > _loc_2)
            {
               _loc_2 = String(_loc_3[param1]).length;
            }
         }
         return _loc_2;
      }
      
      private function _padString(param1:String, param2:int, param3:String = " ") : String
      {
         var _loc_4:int = 0;
         if(param1.length < param2)
         {
            _loc_4 = param1.length;
            while(_loc_4 < param2)
            {
               param1 += param3;
               _loc_4++;
            }
         }
         return param1;
      }
   }
}

