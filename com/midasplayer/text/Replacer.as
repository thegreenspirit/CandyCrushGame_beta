package com.midasplayer.text
{
   import com.midasplayer.util.*;
   
   public class Replacer
   {
      private var _keyText:TypedKeyVal;
      
      public function Replacer(param1:Object)
      {
         super();
         this._keyText = new TypedKeyVal(param1);
      }
      
      public function has(param1:String) : Boolean
      {
         return this._keyText.has(param1);
      }
      
      public function getText(param1:String) : String
      {
         var _loc_2:* = this.getReplaceable(param1).getText();
         return _loc_2 == null ? "" : _loc_2;
      }
      
      public function replaceSerie(param1:String, args:*) : String
      {
         var _loc_4:int = 0;
         args = this.getReplaceable(param1);
         while(_loc_4 < args.length)
         {
            args.replace(_loc_4.toString(),args[_loc_4]);
            _loc_4++;
         }
         return args.getText();
      }
      
      public function getReplaceable(param1:String) : Replaceable
      {
         return new Replaceable(this._keyText.getAsString(param1));
      }
   }
}

