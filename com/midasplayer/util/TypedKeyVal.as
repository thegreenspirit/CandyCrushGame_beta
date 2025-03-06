package com.midasplayer.util
{
   import com.midasplayer.debug.*;
   
   public class TypedKeyVal
   {
      private var _keyVal:Object;
      
      public function TypedKeyVal(param1:Object)
      {
         super();
         Debug.assert(param1 != null,"Trying to create a TypedKeyVal from a null object.");
         this._keyVal = param1;
      }
      
      public function has(param1:String) : Boolean
      {
         return this._keyVal[param1] != null;
      }
      
      public function getAsString(param1:String, param2:String = null) : String
      {
         var _loc_3:* = this._keyVal[param1] != null ? this._getAsString(param1) : null;
         if(_loc_3 == null)
         {
            Debug.assert(param2 != null,"Trying to get a string key that doesn\'t exist and has no default value: " + param1);
            return param2;
         }
         return _loc_3;
      }
      
      public function getAsNumber(param1:String, param2:Number = NaN) : Number
      {
         var _loc_3:* = this._getAsString(param1);
         if(_loc_3 == null)
         {
            Debug.assert(!isNaN(param2),"Trying to get a number key that doesn\'t exist and has no default value: " + param1);
            return param2;
         }
         var _loc_4:* = parseFloat(_loc_3);
         Debug.assert(!isNaN(_loc_4),"Trying to get an int that is NaN: " + param1);
         Debug.assert(isFinite(_loc_4),"Trying to get an int that is not finite: " + param1);
         return _loc_4;
      }
      
      public function getAsIntNumber(param1:String, param2:Number = NaN) : Number
      {
         var _loc_3:* = this.getAsNumber(param1,param2);
         Debug.assert(_loc_3 == Math.round(_loc_3),"Trying to get an integer number (number without decimals) that has decimals: " + param1);
         return _loc_3;
      }
      
      public function getAsInt(param1:String) : int
      {
         var _loc_2:Number = NaN;
         _loc_2 = this.getAsNumber(param1);
         Debug.assert(_loc_2 >= int.MIN_VALUE && _loc_2 <= int.MAX_VALUE,"The expected integer is out of range: " + param1);
         var _loc_3:* = int(_loc_2);
         Debug.assert(_loc_3 == _loc_2,"Trying to get an int that has decimals: " + param1);
         return _loc_3;
      }
      
      public function getAsIntDef(param1:String, param2:int) : int
      {
         var _loc_3:Number = NaN;
         _loc_3 = this.getAsNumber(param1,param2);
         Debug.assert(_loc_3 >= int.MIN_VALUE && _loc_3 <= int.MAX_VALUE,"The expected integer is out of range: " + param1);
         var _loc_4:* = int(_loc_3);
         Debug.assert(_loc_4 == _loc_3,"Trying to get an int that has decimals: " + param1);
         return _loc_4;
      }
      
      public function getAsBool(param1:String) : Boolean
      {
         var _loc_2:* = this.getAsString(param1).toLowerCase();
         Debug.assert(_loc_2 == "0" || _loc_2 == "1" || _loc_2 == "false" || _loc_2 == "true","Trying to get a boolean that has invalid format (must be \'true\', \'false\', \'0\' or \'1\'): " + param1);
         return _loc_2 == "1" || _loc_2 == "true";
      }
      
      public function getAsBoolDef(param1:String, param2:Boolean) : Boolean
      {
         var _loc_3:* = this._getAsString(param1);
         if(_loc_3 == null)
         {
            return param2;
         }
         return this.getAsBool(param1);
      }
      
      public function getAsArray(param1:String) : Array
      {
         var _loc_2:Object = null;
         Debug.assert(param1 != null,"Trying to get array value for a null key.");
         Debug.assert(param1.length > 0,"Trying to get array value for an empty key.");
         _loc_2 = this._keyVal[param1];
         Debug.assert(_loc_2 != null,"Trying to get a non existing array: " + param1);
         var _loc_3:* = _loc_2 as Array;
         Debug.assert(_loc_3 != null,"The field is not an array. String to array has not been implemented yet: " + param1);
         return _loc_3;
      }
      
      public function getAsIntVector(param1:String) : Vector.<int>
      {
         return this.Vector.<int>(this.getAsArray(param1));
      }
      
      public function getAsObject(param1:String) : Object
      {
         Debug.assert(param1 != null,"Trying to get value for a null key.");
         Debug.assert(param1.length > 0,"Trying to get value for an empty key.");
         var _loc_2:* = this._keyVal[param1];
         Debug.assert(_loc_2 != null,"Trying to get a non existing object from typed key value " + param1);
         return _loc_2;
      }
      
      private function _getAsString(param1:String) : String
      {
         Debug.assert(param1 != null,"Trying to get value for a null key.");
         Debug.assert(param1.length > 0,"Trying to get value for an empty key.");
         return this._keyVal[param1];
      }
   }
}

