package com.midasplayer.console
{
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.desktop.ClipboardTransferMode;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class GameConsole extends Sprite implements IConsoleCommandProcessor
   {
      private static const VERSION:String = "1.0";
      
      private var _inputField:TextField;
      
      private var _activated:Boolean;
      
      private var _stage:Stage;
      
      private var _processors:Object;
      
      private var _commandList:Array;
      
      private var _isDebugMode:Boolean;
      
      private var _commandHistory:Vector.<String>;
      
      private var _commandHistoryIndex:Number;
      
      private var _autoCompletionField:TextField;
      
      private var _output:TextField;
      
      private var _gameHeight:Number;
      
      protected var _textFormat:TextFormat;
      
      protected var _textFormatOutput:TextFormat;
      
      protected var _textFormatAutoComplete:TextFormat;
      
      protected var _activationCallback:Function;
      
      private var _printCategoriesDisabledList:Array;
      
      private var _charMarker:Sprite;
      
      public function GameConsole(param1:Stage, param2:int, param3:int, param4:Boolean = false, param5:Function = null)
      {
         super();
         this._stage = param1;
         this._isDebugMode = param4;
         this._gameHeight = param3;
         this._activationCallback = param5;
         this._textFormat = new TextFormat();
         this._textFormat.font = "Courier New";
         this._textFormat.color = 16776960;
         this._textFormat.align = TextFormatAlign.LEFT;
         this._textFormat.bold = false;
         this._textFormat.size = 11;
         this._textFormatOutput = new TextFormat();
         this._textFormatOutput.font = "Courier New";
         this._textFormatOutput.color = 16776960;
         this._textFormatOutput.align = TextFormatAlign.LEFT;
         this._textFormatOutput.bold = false;
         this._textFormatOutput.size = 11;
         this._textFormatAutoComplete = new TextFormat();
         this._textFormatAutoComplete.font = "Courier New";
         this._textFormatAutoComplete.color = 0;
         this._textFormatAutoComplete.align = TextFormatAlign.LEFT;
         this._textFormatAutoComplete.bold = false;
         this._textFormatAutoComplete.size = 11;
         this._inputField = new TextField();
         this._inputField.multiline = false;
         this._inputField.width = param2;
         this._inputField.height = 20;
         this._inputField.y = param3 - 20;
         this._inputField.textColor = 16777215;
         this._inputField.text = "> ";
         this._inputField.selectable = false;
         this._autoCompletionField = new TextField();
         this._autoCompletionField.multiline = false;
         this._autoCompletionField.width = param2;
         this._autoCompletionField.height = 20;
         this._autoCompletionField.y = param3 - 20;
         this._autoCompletionField.textColor = 0;
         this._autoCompletionField.background = true;
         this._autoCompletionField.backgroundColor = 16776960;
         this._autoCompletionField.autoSize = TextFieldAutoSize.LEFT;
         this._autoCompletionField.selectable = false;
         this._autoCompletionField.visible = false;
         this._charMarker = new Sprite();
         this._updateCharMarker();
         this._output = new TextField();
         this._output.multiline = true;
         this._output.autoSize = TextFieldAutoSize.LEFT;
         this._output.x = 0;
         this._output.y = 0;
         this._output.textColor = 16777215;
         this._output.selectable = true;
         var _loc6_:Sprite = new Sprite();
         _loc6_.graphics.beginFill(16777215);
         _loc6_.graphics.drawRect(0,0,param2,param3 - 20);
         _loc6_.graphics.endFill();
         this._output.mask = _loc6_;
         this.graphics.beginFill(0,0.7);
         this.graphics.drawRect(0,param3 - 20,param2,20);
         this.graphics.endFill();
         this.graphics.beginFill(0,0.7);
         this.graphics.drawRect(0,0,param2,param3);
         this.graphics.endFill();
         this.addChild(this._inputField);
         this.addChild(this._autoCompletionField);
         this.addChild(this._output);
         this.addChild(_loc6_);
         this.addChild(this._charMarker);
         this.mouseEnabled = true;
         this.mouseChildren = true;
         this._commandHistory = new Vector.<String>();
         this._commandHistoryIndex = -1;
         this._commandList = new Array();
         this._printCategoriesDisabledList = new Array();
         this.disablePrintCategory("keyboard");
         this.println("> Console v " + VERSION + ". Type help for info.");
         this._processors = new Object();
         this.registerProcessor("help",this,"Console help info.");
         this.registerProcessor("clear",this,"Clear console output.");
         this.registerProcessor("pcat",this,"Print category [info/enable/disable] [category].");
         this.registerProcessor("color",this,"Generate a random color.");
         this.registerProcessor("copy2clipboard",this,"Copy console output to clipboard.");
         this._stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseScroll);
         this._stage.addEventListener(Event.PASTE,this.onPaste);
      }
      
      public function registerProcessor(param1:String, param2:IConsoleCommandProcessor, param3:String = "") : void
      {
         if(!this._processors[param1])
         {
            this._processors[param1] = {
               "description":param3,
               "processors":new Vector.<IConsoleCommandProcessor>()
            };
            this._commandList.push(param1);
         }
         this._processors[param1].processors.push(param2);
         if(param3.length > 0)
         {
            this._processors[param1].description = param3;
         }
      }
      
      public function unRegisterProcessor(param1:String, param2:IConsoleCommandProcessor) : void
      {
         var _loc4_:int = 0;
         if(this._processors[param1] == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._processors[param1].processors.length)
         {
            if(this._processors[param1].processors[_loc3_] == param2)
            {
               this._processors[param1].processors.splice(_loc3_,1);
               if(this._processors[param1].processors.length == 0)
               {
                  _loc4_ = 0;
                  while(_loc4_ < this._commandList.length)
                  {
                     if(this._commandList[_loc4_] == param1)
                     {
                        this._commandList.splice(_loc4_,1);
                        break;
                     }
                     _loc4_++;
                  }
                  this._processors[param1] = null;
                  delete this._processors[param1];
               }
               return;
            }
            _loc3_++;
         }
      }
      
      public function onPaste(param1:Event) : void
      {
         this._inputField.appendText(String(Clipboard.generalClipboard.getData(ClipboardFormats.TEXT_FORMAT,ClipboardTransferMode.CLONE_ONLY)));
         this._updateAutoCompletion();
         this._inputField.setTextFormat(this._textFormat);
         this._updateCharMarker();
      }
      
      public function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         this.println("Keyboard event " + param1.keyCode,"keyboard",7904995);
         if(param1.keyCode == 27)
         {
            if(this._activated)
            {
               this.deactivate();
            }
            else
            {
               this.activate();
            }
         }
         else if(this._activated)
         {
            if(param1.keyCode == 13)
            {
               this._inputField.text = this._inputField.text.replace(/^(.*?)([ ])*$/gs,"$1");
               _loc2_ = this.currentCommand();
               _loc3_ = this.currentParams();
               if(_loc2_.length > 0)
               {
                  this._processCommand(_loc2_,_loc3_);
                  if(_loc3_.length > 0)
                  {
                     this._commandHistory.push(this.findAutoCompletion(_loc2_) + " " + _loc3_.join(" "));
                  }
                  else
                  {
                     this._commandHistory.push(this.findAutoCompletion(_loc2_));
                  }
                  this._commandHistoryIndex = this._commandHistory.length;
               }
               else
               {
                  this.println(">");
               }
               this._inputField.text = "> ";
            }
            else if(param1.keyCode == 8)
            {
               if(this._inputField.text.length > 2)
               {
                  this._inputField.text = this._inputField.text.substr(0,this._inputField.text.length - 1);
               }
            }
            else if(param1.keyCode == 32)
            {
               _loc4_ = this.currentCommand();
               _loc5_ = this.currentParams();
               _loc6_ = this.findAutoCompletion(_loc4_);
               _loc7_ = "";
               if(Boolean(_loc6_) && _loc5_.length > 0)
               {
                  _loc7_ = " ";
               }
               this._inputField.text = "> " + _loc6_ + " " + _loc5_.join(" ") + _loc7_;
            }
            else if(param1.keyCode == 40)
            {
               if(this._commandHistory.length > 0 && this._commandHistoryIndex < this._commandHistory.length)
               {
                  ++this._commandHistoryIndex;
                  if(this._commandHistoryIndex > this._commandHistory.length - 1)
                  {
                     this._inputField.text = "> ";
                  }
                  else
                  {
                     this._inputField.text = "> " + this._commandHistory[this._commandHistoryIndex];
                  }
               }
            }
            else if(param1.keyCode == 38)
            {
               if(this._commandHistory.length > 0)
               {
                  --this._commandHistoryIndex;
                  if(this._commandHistoryIndex < 0)
                  {
                     this._commandHistoryIndex = 0;
                  }
                  this._inputField.text = "> " + this._commandHistory[this._commandHistoryIndex];
               }
            }
            else if(param1.keyCode == 76 && param1.ctrlKey)
            {
               this.triggerCommand("clear");
            }
            else if(param1.keyCode == 33)
            {
               this.onMouseScroll(new MouseEvent(MouseEvent.MOUSE_WHEEL,true,false,0,0,null,false,false,false,false,5));
            }
            else if(param1.keyCode == 34)
            {
               this.onMouseScroll(new MouseEvent(MouseEvent.MOUSE_WHEEL,true,false,0,0,null,false,false,false,false,-5));
            }
            else
            {
               this._inputField.appendText(String.fromCharCode(param1.charCode));
            }
            this._updateAutoCompletion();
         }
         this._inputField.setTextFormat(this._textFormat);
         this._updateCharMarker();
      }
      
      public function onMouseScroll(param1:MouseEvent) : void
      {
         if(!this.isActivated())
         {
            return;
         }
         if(this._output.textHeight < this._gameHeight - 25)
         {
            return;
         }
         this._output.y = Math.min(0,Math.max(this._gameHeight - 25 - this._output.textHeight,this._output.y + param1.delta * 10));
      }
      
      public function processCommand(param1:String, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         switch(param1)
         {
            case "help":
               this._printHelp();
               break;
            case "clear":
               this._output.text = "";
               this.println("> Console v " + VERSION + ". Type help for info.");
               break;
            case "pcat":
               if(param2.length > 0)
               {
                  _loc4_ = param2[0];
                  _loc5_ = "";
                  if(param2.length > 1)
                  {
                     _loc5_ = param2[1];
                  }
                  if(_loc4_ == "info")
                  {
                     _loc6_ = "";
                     for each(_loc7_ in this._printCategoriesDisabledList)
                     {
                        if(_loc7_ != null)
                        {
                           _loc6_ += _loc7_ + ",";
                        }
                     }
                     if(_loc6_ != "")
                     {
                        _loc6_ = _loc6_.substring(0,_loc6_.length - 1);
                     }
                     this.println("Disabled categories: " + _loc6_);
                     break;
                  }
                  if(_loc4_ == "enable" && _loc5_ != "")
                  {
                     this.enablePrintCategory(_loc5_);
                     this.println("Print category " + _loc5_ + " enabled.");
                     break;
                  }
                  if(_loc4_ == "disable" && _loc5_ != "")
                  {
                     this.disablePrintCategory(_loc5_);
                     this.println("Print category " + _loc5_ + " disabled.");
                     break;
                  }
                  this.println("Usage: pcat [info/enable/disable] [category]");
                  break;
               }
               this.println("Usage: pcat [info/enable/disable] [category]");
               break;
            case "color":
               _loc3_ = Math.random() * 16777215;
               this.println(_loc3_ + ": Lorem ipsum dolor sit amet, consectetur adipisicing elit, (...)","default",_loc3_);
               break;
            case "copy2clipboard":
               Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,this.getOutput());
               this.println("Output copied to clipboard.");
         }
      }
      
      public function triggerCommand(param1:String, param2:Array = null) : void
      {
         this._processCommand(param1,!!param2 ? param2 : []);
      }
      
      public function currentCommand() : String
      {
         var _loc1_:String = this._inputField.text;
         var _loc2_:Array = _loc1_.split(" ");
         _loc2_.shift();
         _loc1_ = _loc2_.shift();
         return _loc1_ != null ? _loc1_ : "";
      }
      
      public function currentParams() : Array
      {
         var _loc1_:String = this._inputField.text;
         var _loc2_:Array = _loc1_.split(" ");
         _loc2_.shift();
         _loc1_ = _loc2_.shift();
         return _loc2_;
      }
      
      public function println(param1:*, param2:String = "default", param3:int = 16776960) : void
      {
         if(!this.isPrintCategoryEnabled(param2))
         {
            return;
         }
         var _loc4_:String = String(param1);
         this._output.appendText(_loc4_);
         this._output.appendText("\n");
         this._output.y = this._gameHeight - 25 - this._output.textHeight;
         this._textFormatOutput.color = param3;
         this._output.setTextFormat(this._textFormatOutput,this._output.length - (_loc4_.length + 1),this._output.length);
      }
      
      public function error(param1:String) : void
      {
         this.println("> Error: " + param1,"error",16777215);
      }
      
      public function isPrintCategoryEnabled(param1:String) : Boolean
      {
         return this._printCategoriesDisabledList[param1] == null;
      }
      
      public function enablePrintCategory(param1:String) : void
      {
         delete this._printCategoriesDisabledList[param1];
      }
      
      public function disablePrintCategory(param1:String) : void
      {
         this._printCategoriesDisabledList[param1] = param1;
      }
      
      public function getOutput() : String
      {
         return this._output.text.split("\r").join("\n");
      }
      
      private function _updateAutoCompletion() : void
      {
         var _loc2_:String = null;
         var _loc1_:String = this.currentCommand();
         this._autoCompletionField.x = this._inputField.x + this._inputField.textWidth + 3;
         if(_loc1_.length > 0)
         {
            _loc2_ = this.findAutoCompletion(_loc1_);
            if(_loc2_.length > 0 && _loc2_ != _loc1_ && this.currentParams().length == 0)
            {
               this._autoCompletionField.text = _loc2_.substr(_loc1_.length);
               this._autoCompletionField.visible = true;
            }
            else
            {
               this._autoCompletionField.visible = false;
            }
         }
         else
         {
            this._autoCompletionField.visible = false;
         }
         this._autoCompletionField.setTextFormat(this._textFormatAutoComplete);
      }
      
      public function findAutoCompletion(param1:String) : String
      {
         var _loc2_:String = null;
         if(param1.length > 0)
         {
            this._autoCompletionField.x = this._inputField.x + this._inputField.textWidth + 3;
            for(_loc2_ in this._processors)
            {
               if(_loc2_.indexOf(param1) == 0)
               {
                  return _loc2_;
               }
            }
         }
         return param1;
      }
      
      private function _processCommand(param1:String, param2:Array) : void
      {
         var _loc3_:IConsoleCommandProcessor = null;
         if(!this._processors[param1])
         {
            param1 = this.findAutoCompletion(param1);
         }
         if(this._processors[param1] == null)
         {
            this.println("> \"" + param1 + "\"\t" + "command is not registered. Type help for more info.");
         }
         else
         {
            this.println("> " + param1 + " " + param2.join(" "));
            for each(_loc3_ in this._processors[param1].processors)
            {
               _loc3_.processCommand(param1,param2);
            }
         }
      }
      
      public function activate() : void
      {
         if(this._activated || !this._isDebugMode)
         {
            return;
         }
         this._stage.addChild(this);
         this._activated = true;
         if(this._activationCallback != null)
         {
            this._activationCallback(true);
         }
      }
      
      public function isActivated() : Boolean
      {
         return this._activated;
      }
      
      public function deactivate() : void
      {
         if(!this._activated)
         {
            return;
         }
         this._stage.removeChild(this);
         this._activated = false;
         if(this._activationCallback != null)
         {
            this._activationCallback(false);
         }
      }
      
      private function _updateCharMarker() : void
      {
         if(this._autoCompletionField.visible)
         {
            this._charMarker.graphics.beginFill(0);
         }
         else
         {
            this._charMarker.graphics.beginFill(16776960);
         }
         this._charMarker.graphics.drawRect(0,0,7,1);
         this._charMarker.graphics.endFill();
         this._charMarker.x = this._inputField.textWidth + (this._autoCompletionField.visible ? 5 : 3);
         this._charMarker.y = this._gameHeight - 4;
      }
      
      private function _printHelp() : void
      {
         var _loc2_:String = null;
         var _loc1_:PT = new PT(["command","description"]);
         for each(_loc2_ in this._commandList)
         {
            _loc1_.addRow([_loc2_,this._processors[_loc2_].description]);
         }
         this.println(_loc1_.toString());
      }
   }
}

class PT
{
   private var _tableName:String;
   
   private var _headers:Array;
   
   private var _data:Array;
   
   public function PT(param1:Array, param2:String = "")
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
      var _loc2_:int = 0;
      var _loc5_:Array = null;
      var _loc6_:int = 0;
      var _loc1_:* = "";
      var _loc3_:Array = new Array();
      var _loc4_:int = 0;
      _loc2_ = 0;
      while(_loc2_ < this._headers.length)
      {
         _loc6_ = this._longestDataLengthByColumn(_loc2_) + 4;
         _loc3_.push(_loc6_);
         _loc4_ += _loc6_;
         _loc2_++;
      }
      if(this._tableName.length > 0)
      {
         _loc4_ = Math.max(this._tableName.length,_loc4_);
      }
      if(this._tableName.length > 0)
      {
         _loc1_ += this._padString("",_loc4_ * 0.5 - this._tableName.length * 0.5,"-");
         _loc1_ += this._tableName;
         _loc1_ += this._padString("",_loc4_ * 0.5 - this._tableName.length * 0.5,"-") + "\n";
      }
      else
      {
         _loc1_ += this._padString("-",_loc4_,"-") + "\n";
      }
      _loc2_ = 0;
      while(_loc2_ < this._headers.length)
      {
         _loc1_ += this._padString(this._headers[_loc2_],_loc3_[_loc2_]);
         _loc2_++;
      }
      _loc1_ += "\n";
      _loc1_ += this._padString("-",_loc4_,"-") + "\n";
      for each(_loc5_ in this._data)
      {
         _loc2_ = 0;
         while(_loc2_ < _loc5_.length)
         {
            _loc1_ += this._padString(_loc5_[_loc2_],_loc3_[_loc2_]);
            _loc2_++;
         }
         _loc1_ += "\n";
      }
      return _loc1_ + (this._padString("-",_loc4_,"-") + "\n");
   }
   
   private function _longestDataLengthByColumn(param1:int) : int
   {
      var _loc3_:Array = null;
      var _loc2_:int = String(this._headers[param1]).length;
      for each(_loc3_ in this._data)
      {
         if(String(_loc3_[param1]).length > _loc2_)
         {
            _loc2_ = String(_loc3_[param1]).length;
         }
      }
      return _loc2_;
   }
   
   private function _padString(param1:String, param2:int, param3:String = " ") : String
   {
      var _loc4_:int = 0;
      if(param1.length < param2)
      {
         _loc4_ = param1.length;
         while(_loc4_ < param2)
         {
            param1 += param3;
            _loc4_++;
         }
      }
      return param1;
   }
}
