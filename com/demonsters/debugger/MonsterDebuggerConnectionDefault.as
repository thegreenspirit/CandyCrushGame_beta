package com.demonsters.debugger
{
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   
   internal class MonsterDebuggerConnectionDefault implements IMonsterDebuggerConnection
   {
      private const MAX_QUEUE_LENGTH:int = 500;
      
      private var _socket:Socket;
      
      private var _connecting:Boolean;
      
      private var _process:Boolean;
      
      private var _bytes:ByteArray;
      
      private var _package:ByteArray;
      
      private var _length:uint;
      
      private var _retry:Timer;
      
      private var _timeout:Timer;
      
      private var _address:String;
      
      private var _port:int;
      
      private var _queue:Array;
      
      private var _onConnect:Function;
      
      public function MonsterDebuggerConnectionDefault()
      {
         super();
         this._queue = [];
         this._socket = new Socket();
         this._socket.addEventListener(Event.CONNECT,this.connectHandler,false,0,false);
         this._socket.addEventListener(Event.CLOSE,this.closeHandler,false,0,false);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.closeHandler,false,0,false);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.closeHandler,false,0,false);
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.dataHandler,false,0,false);
         this._connecting = false;
         this._process = false;
         this._address = "127.0.0.1";
         this._port = 5800;
         this._timeout = new Timer(2000,1);
         this._timeout.addEventListener(TimerEvent.TIMER,this.closeHandler,false,0,false);
         this._retry = new Timer(1000,1);
         this._retry.addEventListener(TimerEvent.TIMER,this.retryHandler,false,0,false);
      }
      
      public function set address(param1:String) : void
      {
         this._address = param1;
      }
      
      public function set onConnect(param1:Function) : void
      {
         this._onConnect = param1;
      }
      
      public function get connected() : Boolean
      {
         if(this._socket == null)
         {
            return false;
         }
         return this._socket.connected;
      }
      
      public function processQueue() : void
      {
         if(!this._process)
         {
            this._process = true;
            if(this._queue.length > 0)
            {
               this.next();
            }
         }
      }
      
      public function send(param1:String, param2:Object, param3:Boolean = false) : void
      {
         var _loc_4:ByteArray = null;
         if(param3 && param1 == MonsterDebuggerCore.ID && this._socket.connected)
         {
            _loc_4 = new MonsterDebuggerData(param1,param2).bytes;
            this._socket.writeUnsignedInt(_loc_4.length);
            this._socket.writeBytes(_loc_4);
            this._socket.flush();
            return;
         }
         this._queue.push(new MonsterDebuggerData(param1,param2));
         if(this._queue.length > this.MAX_QUEUE_LENGTH)
         {
            this._queue.shift();
         }
         if(this._queue.length > 0)
         {
            this.next();
         }
      }
      
      public function connect() : void
      {
         if(!this._connecting && MonsterDebugger.enabled)
         {
            try
            {
               Security.loadPolicyFile("xmlsocket://" + this._address + ":" + this._port);
               this._connecting = true;
               this._socket.connect(this._address,this._port);
               this._retry.stop();
               this._timeout.reset();
               this._timeout.start();
            }
            catch(e:Error)
            {
               closeHandler();
            }
         }
      }
      
      private function next() : void
      {
         if(!MonsterDebugger.enabled)
         {
            return;
         }
         if(!this._process)
         {
            return;
         }
         if(!this._socket.connected)
         {
            this.connect();
            return;
         }
         var _loc_1:* = MonsterDebuggerData(this._queue.shift()).bytes;
         this._socket.writeUnsignedInt(_loc_1.length);
         this._socket.writeBytes(_loc_1);
         this._socket.flush();
         _loc_1 = null;
         if(this._queue.length > 0)
         {
            this.next();
         }
      }
      
      private function connectHandler(event:Event) : void
      {
         this._timeout.stop();
         this._retry.stop();
         if(this._onConnect != null)
         {
            this._onConnect();
         }
         this._connecting = false;
         this._bytes = new ByteArray();
         this._package = new ByteArray();
         this._length = 0;
         this._socket.writeUTFBytes("<hello/>" + "\n");
         this._socket.writeByte(0);
         this._socket.flush();
      }
      
      private function retryHandler(event:TimerEvent) : void
      {
         this._retry.stop();
         this.connect();
      }
      
      private function closeHandler(event:Event = null) : void
      {
         MonsterDebuggerUtils.resume();
         if(!this._retry.running)
         {
            this._connecting = false;
            this._process = false;
            this._timeout.stop();
            this._retry.reset();
            this._retry.start();
         }
      }
      
      private function dataHandler(event:ProgressEvent) : void
      {
         this._bytes = new ByteArray();
         this._socket.readBytes(this._bytes,0,this._socket.bytesAvailable);
         this._bytes.position = 0;
         this.processPackage();
      }
      
      private function processPackage() : void
      {
         var _loc_1:uint = 0;
         var _loc_2:MonsterDebuggerData = null;
         if(this._bytes.bytesAvailable == 0)
         {
            return;
         }
         if(this._length == 0)
         {
            this._length = this._bytes.readUnsignedInt();
            this._package = new ByteArray();
         }
         if(this._package.length < this._length && this._bytes.bytesAvailable > 0)
         {
            _loc_1 = this._bytes.bytesAvailable;
            if(_loc_1 > this._length - this._package.length)
            {
               _loc_1 = uint(this._length - this._package.length);
            }
            this._bytes.readBytes(this._package,this._package.length,_loc_1);
         }
         if(this._length != 0 && this._package.length == this._length)
         {
            _loc_2 = MonsterDebuggerData.read(this._package);
            if(_loc_2.id != null)
            {
               MonsterDebuggerCore.handle(_loc_2);
            }
            this._length = 0;
            this._package = null;
         }
         if(this._length == 0 && this._bytes.bytesAvailable > 0)
         {
            this.processPackage();
         }
      }
   }
}

