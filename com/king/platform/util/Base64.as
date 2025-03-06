package com.king.platform.util
{
   import flash.utils.ByteArray;
   
   public class Base64
   {
      private static const encodingMap:Vector.<String> = new Vector.<String>(65,true);
      
      private static const decodingMap:Object = new Object();
      
      initMaps();
      
      public function Base64()
      {
         super();
      }
      
      private static function initMaps() : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < 65)
         {
            _loc3_ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(_loc2_);
            encodingMap[_loc2_] = _loc3_;
            decodingMap[_loc3_] = _loc2_;
            _loc2_++;
         }
      }
      
      public static function encode(param1:ByteArray, param2:int = 0, param3:int = -1) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         if(param3 == -1)
         {
            param3 = int(param1.length);
         }
         var _loc4_:int = param3 - param2;
         param1.position = param2;
         var _loc5_:String = "";
         while(_loc4_ > 0)
         {
            _loc6_ = int(param1.readUnsignedByte());
            _loc4_--;
            _loc9_ = _loc6_ >> 2;
            if(_loc4_ == 0)
            {
               _loc10_ = (_loc6_ & 3) << 4;
               _loc11_ = 64;
               _loc12_ = 64;
            }
            else
            {
               _loc7_ = int(param1.readUnsignedByte());
               _loc4_--;
               _loc10_ = (_loc6_ & 3) << 4 | _loc7_ >> 4;
               if(_loc4_ == 0)
               {
                  _loc11_ = (_loc7_ & 0x0F) << 2;
                  _loc12_ = 64;
               }
               else
               {
                  _loc8_ = int(param1.readUnsignedByte());
                  _loc4_--;
                  _loc11_ = (_loc7_ & 0x0F) << 2 | _loc8_ >> 6;
                  _loc12_ = _loc8_ & 0x3F;
               }
            }
            _loc5_ += encodingMap[_loc9_];
            _loc5_ = _loc5_ + encodingMap[_loc10_];
            _loc5_ = _loc5_ + encodingMap[_loc11_];
            _loc5_ = _loc5_ + encodingMap[_loc12_];
         }
         return _loc5_;
      }
      
      public static function decode(param1:String) : ByteArray
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = param1.length / 4 * 3;
         var _loc3_:int = param1.length - 1;
         while(param1.charAt(_loc3_) == encodingMap[64])
         {
            _loc2_--;
            _loc3_--;
         }
         var _loc4_:ByteArray = new ByteArray();
         var _loc9_:int = 0;
         while(_loc2_ > 0)
         {
            _loc5_ = int(decodingMap[param1.charAt(_loc9_++)]);
            _loc6_ = int(decodingMap[param1.charAt(_loc9_++)]);
            _loc4_.writeByte(_loc5_ << 2 | _loc6_ >> 4);
            _loc2_--;
            if(_loc2_ > 0)
            {
               _loc7_ = int(decodingMap[param1.charAt(_loc9_++)]);
               _loc4_.writeByte((_loc6_ & 0x0F) << 4 | _loc7_ >> 2);
               _loc2_--;
               if(_loc2_ > 0)
               {
                  _loc8_ = int(decodingMap[param1.charAt(_loc9_++)]);
                  _loc4_.writeByte((_loc7_ & 3) << 6 | _loc8_);
                  _loc2_--;
               }
            }
         }
         _loc4_.position = 0;
         return _loc4_;
      }
   }
}

