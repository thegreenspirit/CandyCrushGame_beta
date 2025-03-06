package com.midasplayer.text
{
   import com.midasplayer.debug.Debug;
   
   public class Replaceable
   {
      private var _text:String;
      
      public function Replaceable(param1:String)
      {
         super();
         Debug.assert(param1 != null,"Trying to set a null text in a replaceable.");
         this._text = param1 == null ? "" : param1;
      }
      
      public function replace(param1:String, param2:String) : Replaceable
      {
         var _loc_3:* = "{" + param1 + "}";
         Debug.assert(this._text.indexOf(_loc_3) != -1,"Could not find \'" + param1 + "\' to replace with \'" + param2 + "\' in the text: " + this._text.substr(0,Math.min(64,this._text.length)));
         this._text = this._text.split(_loc_3).join(param2);
         return this;
      }
      
      public function getText() : String
      {
         var _loc_1:* = this._text.match("\\{.*\\}");
         Debug.assert(_loc_1 == null,"Trying to get a text that still has unreplaced elements.");
         return this._text;
      }
      
      public function getTextExt() : String
      {
         return this._text;
      }
   }
}

