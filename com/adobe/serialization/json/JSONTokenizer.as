package com.adobe.serialization.json
{
   public class JSONTokenizer
   {
      private var ch:String;
      
      private var loc:int;
      
      private var jsonString:String;
      
      private var strict:Boolean;
      
      private var controlCharsRegExp:RegExp;
      
      private var obj:Object;
      
      public function JSONTokenizer(s:String, strict:Boolean)
      {
         this.controlCharsRegExp = /[\x00-\x1F]/;
         super();
         this.jsonString = s;
         this.strict = strict;
         this.loc = 0;
         this.nextChar();
      }
      
      private function skipComments() : void
      {
         if(this.ch == "/")
         {
            this.nextChar();
            switch(this.ch)
            {
               case "/":
                  do
                  {
                     this.nextChar();
                  }
                  while(this.ch != "\n" && this.ch != "");
                  
                  this.nextChar();
                  break;
               case "*":
                  this.nextChar();
                  while(true)
                  {
                     if(this.ch == "*")
                     {
                        this.nextChar();
                        if(this.ch == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        this.nextChar();
                     }
                     if(this.ch == "")
                     {
                        this.parseError("Multi-line comment not closed");
                     }
                  }
                  this.nextChar();
                  break;
               default:
                  this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }
      
      private function isDigit(ch:String) : Boolean
      {
         return ch >= "0" && ch <= "9";
      }
      
      private function readNumber() : JSONToken
      {
         var token:JSONToken = null;
         var input:String = "";
         if(this.ch == "-")
         {
            input += "-";
            this.nextChar();
         }
         if(!this.isDigit(this.ch))
         {
            this.parseError("Expecting a digit");
         }
         if(this.ch == "0")
         {
            input += this.ch;
            this.nextChar();
            if(this.isDigit(this.ch))
            {
               this.parseError("A digit cannot immediately follow 0");
            }
            else if(!this.strict && this.ch == "x")
            {
               input += this.ch;
               this.nextChar();
               if(this.isHexDigit(this.ch))
               {
                  input += this.ch;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Number in hex format require at least one hex digit after \"0x\"");
               }
               while(this.isHexDigit(this.ch))
               {
                  input += this.ch;
                  this.nextChar();
               }
            }
         }
         else
         {
            while(this.isDigit(this.ch))
            {
               input += this.ch;
               this.nextChar();
            }
         }
         if(this.ch == ".")
         {
            input += ".";
            this.nextChar();
            if(!this.isDigit(this.ch))
            {
               this.parseError("Expecting a digit");
            }
            while(this.isDigit(this.ch))
            {
               input += this.ch;
               this.nextChar();
            }
         }
         if(this.ch == "e" || this.ch == "E")
         {
            input += "e";
            this.nextChar();
            if(this.ch == "+" || this.ch == "-")
            {
               input += this.ch;
               this.nextChar();
            }
            if(!this.isDigit(this.ch))
            {
               this.parseError("Scientific notation number needs exponent value");
            }
            while(this.isDigit(this.ch))
            {
               input += this.ch;
               this.nextChar();
            }
         }
         var num:Number = Number(input);
         if(isFinite(num) && !isNaN(num))
         {
            token = new JSONToken();
            token.type = JSONTokenType.NUMBER;
            token.value = num;
            return token;
         }
         this.parseError("Number " + num + " is not valid!");
         return null;
      }
      
      public function unescapeString(input:String) : String
      {
         var afterBackslashIndex:* = undefined;
         var escapedChar:* = undefined;
         var _local8:* = undefined;
         var i:* = undefined;
         var possibleHexChar:* = undefined;
         var backslashIndex:int = 0;
         var nextSubstringStartPosition:int = 0;
         if(this.strict && Boolean(this.controlCharsRegExp.test(input)))
         {
            this.parseError("String contains unescaped control character (0x00-0x1F)");
         }
         var result:String = "";
         var len:int = input.length;
         do
         {
            backslashIndex = int(input.indexOf("\\",nextSubstringStartPosition));
            if(backslashIndex < 0)
            {
               result += input.substr(nextSubstringStartPosition);
               break;
            }
            result += input.substr(nextSubstringStartPosition,backslashIndex - nextSubstringStartPosition);
            nextSubstringStartPosition = backslashIndex + 2;
            afterBackslashIndex = backslashIndex + 1;
            escapedChar = input.charAt(afterBackslashIndex);
            switch(escapedChar)
            {
               case "\"":
                  result += "\"";
                  break;
               case "\\":
                  result += "\\";
                  break;
               case "n":
                  result += "\n";
                  break;
               case "r":
                  result += "\r";
                  break;
               case "t":
                  result += "\t";
                  break;
               case "u":
                  _local8 = "";
                  if(nextSubstringStartPosition + 4 > len)
                  {
                     this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                  }
                  i = nextSubstringStartPosition;
                  while(i < nextSubstringStartPosition + 4)
                  {
                     possibleHexChar = input.charAt(i);
                     if(!this.isHexDigit(possibleHexChar))
                     {
                        this.parseError("Excepted a hex digit, but found: " + possibleHexChar);
                     }
                     _local8 += possibleHexChar;
                     i++;
                  }
                  result += String.fromCharCode(parseInt(_local8,16));
                  nextSubstringStartPosition += 4;
                  break;
               case "f":
                  result += "\f";
                  break;
               case "/":
                  result += "/";
                  break;
               case "b":
                  result += "\b";
                  break;
               default:
                  result += "\\" + escapedChar;
                  break;
            }
         }
         while(nextSubstringStartPosition < len);
         
         return result;
      }
      
      private function skipWhite() : void
      {
         while(this.isWhiteSpace(this.ch))
         {
            this.nextChar();
         }
      }
      
      private function isWhiteSpace(ch:String) : Boolean
      {
         if(ch == " " || ch == "\t" || ch == "\n" || ch == "\r")
         {
            return true;
         }
         if(!this.strict && ch.charCodeAt(0) == 160)
         {
            return true;
         }
         return false;
      }
      
      public function parseError(message:String) : void
      {
         throw new JSONParseError(message,this.loc,this.jsonString);
      }
      
      private function readString() : JSONToken
      {
         var backspaceCount:* = undefined;
         var backspaceIndex:* = undefined;
         var quoteIndex:int = this.loc;
         while(true)
         {
            quoteIndex = int(this.jsonString.indexOf("\"",quoteIndex));
            if(quoteIndex >= 0)
            {
               backspaceCount = 0;
               backspaceIndex = quoteIndex - 1;
               while(this.jsonString.charAt(backspaceIndex) == "\\")
               {
                  backspaceCount++;
                  backspaceIndex--;
               }
               if(backspaceCount % 2 == 0)
               {
                  break;
               }
               quoteIndex++;
            }
            else
            {
               this.parseError("Unterminated string literal");
            }
         }
         var token:JSONToken = new JSONToken();
         token.type = JSONTokenType.STRING;
         token.value = this.unescapeString(this.jsonString.substr(this.loc,quoteIndex - this.loc));
         this.loc = quoteIndex + 1;
         this.nextChar();
         return token;
      }
      
      private function nextChar() : String
      {
         return this.ch = this.jsonString.charAt(this.loc++);
      }
      
      private function skipIgnored() : void
      {
         var originalLoc:int = 0;
         do
         {
            originalLoc = this.loc;
            this.skipWhite();
            this.skipComments();
         }
         while(originalLoc != this.loc);
         
      }
      
      private function isHexDigit(ch:String) : Boolean
      {
         return this.isDigit(ch) || ch >= "A" && ch <= "F" || ch >= "a" && ch <= "f";
      }
      
      public function getNextToken() : JSONToken
      {
         var _local2:String = null;
         var _local3:String = null;
         var _local4:String = null;
         var _local5:String = null;
         var token:JSONToken = new JSONToken();
         this.skipIgnored();
         switch(this.ch)
         {
            case "{":
               token.type = JSONTokenType.LEFT_BRACE;
               token.value = "{";
               this.nextChar();
               break;
            case "}":
               token.type = JSONTokenType.RIGHT_BRACE;
               token.value = "}";
               this.nextChar();
               break;
            case "[":
               token.type = JSONTokenType.LEFT_BRACKET;
               token.value = "[";
               this.nextChar();
               break;
            case "]":
               token.type = JSONTokenType.RIGHT_BRACKET;
               token.value = "]";
               this.nextChar();
               break;
            case ",":
               token.type = JSONTokenType.COMMA;
               token.value = ",";
               this.nextChar();
               break;
            case ":":
               token.type = JSONTokenType.COLON;
               token.value = ":";
               this.nextChar();
               break;
            case "t":
               _local2 = "t" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_local2 == "true")
               {
                  token.type = JSONTokenType.TRUE;
                  token.value = true;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'true\' but found " + _local2);
               }
               break;
            case "f":
               _local3 = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
               if(_local3 == "false")
               {
                  token.type = JSONTokenType.FALSE;
                  token.value = false;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'false\' but found " + _local3);
               }
               break;
            case "n":
               _local4 = "n" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_local4 == "null")
               {
                  token.type = JSONTokenType.NULL;
                  token.value = null;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'null\' but found " + _local4);
               }
               break;
            case "N":
               _local5 = "N" + this.nextChar() + this.nextChar();
               if(_local5 == "NaN")
               {
                  token.type = JSONTokenType.NAN;
                  token.value = NaN;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'NaN\' but found " + _local5);
               }
               break;
            case "\"":
               token = this.readString();
               break;
            default:
               if(this.isDigit(this.ch) || this.ch == "-")
               {
                  token = this.readNumber();
                  break;
               }
               if(this.ch == "")
               {
                  return null;
               }
               this.parseError("Unexpected " + this.ch + " encountered");
               break;
         }
         return token;
      }
   }
}

