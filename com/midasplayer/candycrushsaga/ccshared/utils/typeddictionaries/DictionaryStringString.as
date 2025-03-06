package com.midasplayer.candycrushsaga.ccshared.utils.typeddictionaries
{
   import flash.utils.Dictionary;
   
   public class DictionaryStringString
   {
      private var _dictionary:Dictionary = new Dictionary();
      
      public function DictionaryStringString(param1:Boolean = false)
      {
         super();
         this._dictionary = new Dictionary(param1);
      }
      
      public function addKeyValuePair(param1:String, param2:String) : void
      {
         this._dictionary[param1] = param2;
      }
      
      public function getValueByKey(param1:String) : String
      {
         var _loc2_:String = this._dictionary[param1];
         if(_loc2_ == null)
         {
            throw new Error("Could not get correct value for key: " + param1 + ". You probably entered an incorrect key.");
         }
         return _loc2_;
      }
      
      public function getLength() : uint
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for(_loc2_ in this._dictionary)
         {
            _loc1_++;
         }
         return _loc1_;
      }
   }
}

