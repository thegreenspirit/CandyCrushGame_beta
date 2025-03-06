package com.demonsters.debugger
{
   import flash.utils.*;
   
   public class MonsterDebuggerData
   {
      private var _id:String;
      
      private var _data:Object;
      
      public function MonsterDebuggerData(param1:String, param2:Object)
      {
         super();
         this._id = param1;
         this._data = param2;
      }
      
      public static function read(param1:ByteArray) : MonsterDebuggerData
      {
         var _loc_2:* = new MonsterDebuggerData(null,null);
         _loc_2.bytes = param1;
         return _loc_2;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc_1:* = new ByteArray();
         var _loc_2:* = new ByteArray();
         _loc_1.writeObject(this._id);
         _loc_2.writeObject(this._data);
         var _loc_3:* = new ByteArray();
         _loc_3.writeUnsignedInt(_loc_1.length);
         _loc_3.writeBytes(_loc_1);
         _loc_3.writeUnsignedInt(_loc_2.length);
         _loc_3.writeBytes(_loc_2);
         _loc_3.position = 0;
         _loc_1 = null;
         _loc_2 = null;
         return _loc_3;
      }
      
      public function set bytes(param1:ByteArray) : void
      {
         var value:* = param1;
         var bytesId:* = new ByteArray();
         var bytesData:* = new ByteArray();
         try
         {
            value.readBytes(bytesId,0,value.readUnsignedInt());
            value.readBytes(bytesData,0,value.readUnsignedInt());
            this._id = bytesId.readObject() as String;
            this._data = bytesData.readObject() as Object;
         }
         catch(e:Error)
         {
            _id = null;
            _data = null;
         }
      }
   }
}

