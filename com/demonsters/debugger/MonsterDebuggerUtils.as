package com.demonsters.debugger
{
   import flash.display.*;
   import flash.geom.*;
   import flash.system.*;
   import flash.utils.*;
   
   internal class MonsterDebuggerUtils
   {
      private static var _references:Dictionary = new Dictionary(true);
      
      private static var _reference:int = 0;
      
      public function MonsterDebuggerUtils()
      {
         super();
      }
      
      public static function snapshot(param1:DisplayObject, param2:Rectangle = null) : BitmapData
      {
         var m:Matrix = null;
         var scaled:Rectangle = null;
         var s:Number = NaN;
         var b:BitmapData = null;
         var bitmapData:BitmapData = null;
         var object:* = param1;
         var rectangle:* = param2;
         if(object == null)
         {
            return null;
         }
         var visible:* = object.visible;
         var alpha:* = object.alpha;
         var rotation:* = object.rotation;
         var scaleX:* = object.scaleX;
         var scaleY:* = object.scaleY;
         try
         {
            object.visible = true;
            object.alpha = 1;
            object.rotation = 0;
            object.scaleX = 1;
            object.scaleY = 1;
         }
         catch(e1:Error)
         {
         }
         var bounds:* = object.getBounds(object);
         bounds.x = int(bounds.x + 0.5);
         bounds.y = int(bounds.y + 0.5);
         bounds.width = int(bounds.width + 0.5);
         bounds.height = int(bounds.height + 0.5);
         if(object is Stage)
         {
            bounds.x = 0;
            bounds.y = 0;
            bounds.width = Stage(object).stageWidth;
            bounds.height = Stage(object).stageHeight;
         }
         if(bounds.width <= 0 || bounds.height <= 0)
         {
            return null;
         }
         bitmapData = new BitmapData(bounds.width,bounds.height,false,16777215);
         m = new Matrix();
         m.tx = -bounds.x;
         m.ty = -bounds.y;
         bitmapData.draw(object,m,null,null,null,false);
         try
         {
            object.visible = visible;
            object.alpha = alpha;
            object.rotation = rotation;
            object.scaleX = scaleX;
            object.scaleY = scaleY;
         }
         catch(e2:Error)
         {
         }
         if(rectangle != null)
         {
            if(bounds.width <= rectangle.width && bounds.height <= rectangle.height)
            {
               return bitmapData;
            }
            scaled = bounds.clone();
            scaled.width = rectangle.width;
            scaled.height = rectangle.width * (bounds.height / bounds.width);
            if(scaled.height > rectangle.height)
            {
               scaled = bounds.clone();
               scaled.width = rectangle.height * (bounds.width / bounds.height);
               scaled.height = rectangle.height;
            }
            s = scaled.width / bounds.width;
            b = new BitmapData(scaled.width,scaled.height,false,0);
            m = new Matrix();
            m.scale(s,s);
            b.draw(bitmapData,m,null,null,null,true);
            return b;
         }
         return bitmapData;
      }
      
      public static function getMemory() : uint
      {
         return System.totalMemory;
      }
      
      public static function pause() : Boolean
      {
         System.pause();
         return true;
      }
      
      public static function resume() : Boolean
      {
         System.resume();
         return true;
      }
      
      public static function stackTrace() : XML
      {
         var childXML:XML = null;
         var rootXML:* = undefined;
         rootXML = <root/>;
         childXML = <node/>;
         throw new Error();
      }
      
      public static function getReferenceID(param1:*) : String
      {
         if(param1 in _references)
         {
            return _references[param1];
         }
         var _loc_2:* = "#" + String(_reference);
         _references[param1] = _loc_2;
         var _loc_4:* = _reference + 1;
         _reference = _loc_4;
         return _loc_2;
      }
      
      public static function getReference(param1:String) : *
      {
         var _loc_3:String = null;
         var _loc_2:* = undefined;
         if(param1.charAt(0) != "#")
         {
            return null;
         }
         for(_loc_2 in _references)
         {
            _loc_3 = _references[_loc_2];
            if(_loc_3 == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
      
      public static function getObject(param1:*, param2:String = "", param3:int = 0) : *
      {
         var object:*;
         var splitted:*;
         var index:Number = NaN;
         var i:int = 0;
         var base:* = param1;
         var target:* = param2;
         var parent:* = param3;
         if(target == null || target == "")
         {
            return base;
         }
         if(target.charAt(0) == "#")
         {
            return getReference(target);
         }
         object = base;
         splitted = target.split(MonsterDebuggerConstants.DELIMITER);
         while(i < splitted.length - parent)
         {
            if(splitted[i] != "")
            {
               try
               {
                  if(splitted[i] == "children()")
                  {
                     object = object.children();
                  }
                  else if(object is DisplayObjectContainer && splitted[i].indexOf("getChildAt(") == 0)
                  {
                     index = Number(splitted[i].substring(11,splitted[i].indexOf(")",11)));
                     object = DisplayObjectContainer(object).getChildAt(index);
                  }
                  else
                  {
                     object = object[splitted[i]];
                  }
               }
               catch(e:Error)
               {
                  break;
               }
            }
            i += 1;
         }
         return object;
      }
      
      public static function parse(param1:*, param2:String = "", param3:int = 1, param4:int = 5, param5:Boolean = true) : XML
      {
         var _loc_8:XML = null;
         var _loc_13:int = 0;
         var _loc_14:XML = null;
         var _loc_12:Boolean = false;
         var _loc_6:* = <root/>;
         var _loc_7:* = <node/>;
         var _loc_9:* = new XML();
         var _loc_10:String = "";
         var _loc_11:String = "";
         if(param4 != -1 && param3 > param4)
         {
            return _loc_6;
         }
         if(param1 == null)
         {
            _loc_8 = <node/>;
            _loc_8.@icon = MonsterDebuggerConstants.ICON_WARNING;
            _loc_8.@label = "Null object";
            _loc_8.@name = "Null object";
            _loc_8.@type = MonsterDebuggerConstants.TYPE_WARNING;
            _loc_7.appendChild(_loc_8);
            _loc_10 = "null";
         }
         else
         {
            _loc_9 = MonsterDebuggerDescribeType.get(param1);
            _loc_10 = parseType(_loc_9.@name);
            _loc_11 = parseType(_loc_9.@base);
            _loc_12 = Boolean(_loc_9.@isDynamic);
            if(param1 is Class)
            {
               _loc_7.appendChild(parseClass(param1,param2,_loc_9,param3,param4,param5).children());
            }
            else if(_loc_10 == MonsterDebuggerConstants.TYPE_XML)
            {
               _loc_7.appendChild(parseXML(param1,param2 + "." + "children()",param3,param4).children());
            }
            else if(_loc_10 == MonsterDebuggerConstants.TYPE_XMLLIST)
            {
               _loc_8 = <node/>;
               _loc_8.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
               _loc_8.@type = MonsterDebuggerConstants.TYPE_UINT;
               _loc_8.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               _loc_8.@permission = MonsterDebuggerConstants.PERMISSION_READONLY;
               _loc_8.@target = param2 + "." + "length";
               _loc_8.@label = "length" + " (" + MonsterDebuggerConstants.TYPE_UINT + ") = " + param1.length();
               _loc_8.@name = "length";
               _loc_8.@value = param1.length();
               _loc_13 = 0;
               while(_loc_13 < param1.length())
               {
                  _loc_8.appendChild(parseXML(param1[_loc_13],param2 + "." + String(_loc_13) + ".children()",param3,param4).children());
                  _loc_13++;
               }
               _loc_7.appendChild(_loc_8);
            }
            else if(_loc_10 == MonsterDebuggerConstants.TYPE_STRING || _loc_10 == MonsterDebuggerConstants.TYPE_BOOLEAN || _loc_10 == MonsterDebuggerConstants.TYPE_NUMBER || _loc_10 == MonsterDebuggerConstants.TYPE_INT || _loc_10 == MonsterDebuggerConstants.TYPE_UINT)
            {
               _loc_7.appendChild(parseBasics(param1,param2,_loc_10).children());
            }
            else if(_loc_10 == MonsterDebuggerConstants.TYPE_ARRAY || _loc_10.indexOf(MonsterDebuggerConstants.TYPE_VECTOR) == 0)
            {
               _loc_7.appendChild(parseArray(param1,param2,param3,param4).children());
            }
            else if(_loc_10 == MonsterDebuggerConstants.TYPE_OBJECT)
            {
               _loc_7.appendChild(parseObject(param1,param2,param3,param4,param5).children());
            }
            else
            {
               _loc_7.appendChild(parseClass(param1,param2,_loc_9,param3,param4,param5).children());
            }
         }
         if(param3 == 1)
         {
            _loc_14 = <node/>;
            _loc_14.@icon = MonsterDebuggerConstants.ICON_ROOT;
            _loc_14.@label = "(" + _loc_10 + ")";
            _loc_14.@type = _loc_10;
            _loc_14.@target = param2;
            _loc_14.appendChild(_loc_7.children());
            _loc_6.appendChild(_loc_14);
         }
         else
         {
            _loc_6.appendChild(_loc_7.children());
         }
         return _loc_6;
      }
      
      private static function parseBasics(param1:*, param2:String, param3:String, param4:int = 1, param5:int = 5) : XML
      {
         var isXML:Boolean = false;
         var object:* = param1;
         var target:* = param2;
         var type:* = param3;
         var currentDepth:* = param4;
         var maxDepth:* = param5;
         var rootXML:* = <root/>;
         var nodeXML:* = <node/>;
         var isXMLString:* = new XML();
         if(type == MonsterDebuggerConstants.TYPE_STRING)
         {
            try
            {
               isXMLString = new XML(object);
               isXML = !isXMLString.hasSimpleContent() && isXMLString.children().length() > 0;
            }
            catch(error:TypeError)
            {
            }
         }
         if(!isXML)
         {
            nodeXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
            nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
            nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
            nodeXML.@label = "(" + type + ") = " + printValue(object,type);
            nodeXML.@name = "";
            nodeXML.@type = type;
            nodeXML.@value = printValue(object,type);
            nodeXML.@target = target;
         }
         else
         {
            nodeXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
            nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
            nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
            nodeXML.@label = "(" + MonsterDebuggerConstants.TYPE_XML + ")";
            nodeXML.@name = "";
            nodeXML.@type = MonsterDebuggerConstants.TYPE_XML;
            nodeXML.@value = "";
            nodeXML.@target = target;
            nodeXML.appendChild(parseXML(isXMLString,target + "." + "children()",currentDepth,maxDepth).children());
         }
         rootXML.appendChild(nodeXML);
         return rootXML;
      }
      
      private static function parseArray(param1:*, param2:String, param3:int = 1, param4:int = 5, param5:Boolean = true) : XML
      {
         var nodeXML:XML = null;
         var childXML:XML = null;
         var key:* = undefined;
         var childType:String = null;
         var childTarget:String = null;
         var i:int = 0;
         var object:* = param1;
         var target:* = param2;
         var currentDepth:* = param3;
         var maxDepth:* = param4;
         var includeDisplayObjects:* = param5;
         var rootXML:* = <root/>;
         var isXMLString:* = new XML();
         nodeXML = <node/>;
         nodeXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
         nodeXML.@label = "length" + " (" + MonsterDebuggerConstants.TYPE_UINT + ") = " + object["length"];
         nodeXML.@name = "length";
         nodeXML.@type = MonsterDebuggerConstants.TYPE_UINT;
         nodeXML.@value = object["length"];
         nodeXML.@target = target + "." + "length";
         nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
         nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READONLY;
         var _loc_8:* = object;
         while(_loc_8 in 0)
         {
            key = _loc_8[0];
            if(key is int)
            {
            }
            null.push(key);
         }
         null.sort(Array.CASEINSENSITIVE);
         while(i < null.length)
         {
            childType = parseType(MonsterDebuggerDescribeType.get(object[null[i]]).@name);
            childTarget = target + "." + String(null[i]);
            if(childType == MonsterDebuggerConstants.TYPE_STRING || childType == MonsterDebuggerConstants.TYPE_BOOLEAN || childType == MonsterDebuggerConstants.TYPE_NUMBER || childType == MonsterDebuggerConstants.TYPE_INT || childType == MonsterDebuggerConstants.TYPE_UINT || childType == MonsterDebuggerConstants.TYPE_FUNCTION)
            {
               isXMLString = new XML();
               if(childType == MonsterDebuggerConstants.TYPE_STRING)
               {
                  try
                  {
                     isXMLString = new XML(object[null[i]]);
                     if(!isXMLString.hasSimpleContent() && isXMLString.children().length() > 0)
                     {
                     }
                  }
                  catch(error:TypeError)
                  {
                  }
               }
               childXML = <node/>;
               childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
               childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               childXML.@label = "[" + null[i] + "] (" + childType + ") = " + printValue(object[null[i]],childType);
               childXML.@name = "[" + null[i] + "]";
               childXML.@type = childType;
               childXML.@value = printValue(object[null[i]],childType);
               childXML.@target = childTarget;
               nodeXML.appendChild(childXML);
            }
            else
            {
               childXML = <node/>;
               childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
               childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               childXML.@label = "[" + null[i] + "] (" + childType + ")";
               childXML.@name = "[" + null[i] + "]";
               childXML.@type = childType;
               childXML.@value = "";
               childXML.@target = childTarget;
               childXML.appendChild(parse(object[null[i]],childTarget,currentDepth + 1,maxDepth,includeDisplayObjects).children());
               nodeXML.appendChild(childXML);
            }
            i += 1;
         }
         rootXML.appendChild(nodeXML);
         return rootXML;
      }
      
      public static function parseXML(param1:*, param2:String = "", param3:int = 1, param4:int = -1) : XML
      {
         var _loc_6:XML = null;
         var _loc_7:XML = null;
         var _loc_9:String = null;
         var _loc_8:int = 0;
         var _loc_5:* = <root/>;
         if(param4 != -1 && param3 > param4)
         {
            return _loc_5;
         }
         if(param2.indexOf("@") != -1)
         {
            _loc_6 = <node/>;
            _loc_6.@icon = MonsterDebuggerConstants.ICON_XMLATTRIBUTE;
            _loc_6.@type = MonsterDebuggerConstants.TYPE_XMLATTRIBUTE;
            _loc_6.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
            _loc_6.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
            _loc_6.@label = param1;
            _loc_6.@name = "";
            _loc_6.@value = param1;
            _loc_6.@target = param2;
            _loc_5.appendChild(_loc_6);
         }
         else if("name" in param1 && param1.name() == null)
         {
            _loc_6 = <node/>;
            _loc_6.@icon = MonsterDebuggerConstants.ICON_XMLVALUE;
            _loc_6.@type = MonsterDebuggerConstants.TYPE_XMLVALUE;
            _loc_6.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
            _loc_6.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
            _loc_6.@label = "(" + MonsterDebuggerConstants.TYPE_XMLVALUE + ") = " + printValue(param1,MonsterDebuggerConstants.TYPE_XMLVALUE);
            _loc_6.@name = "";
            _loc_6.@value = printValue(param1,MonsterDebuggerConstants.TYPE_XMLVALUE);
            _loc_6.@target = param2;
            _loc_5.appendChild(_loc_6);
         }
         else if("hasSimpleContent" in param1 && Boolean(param1.hasSimpleContent()))
         {
            _loc_6 = <node/>;
            _loc_6.@icon = MonsterDebuggerConstants.ICON_XMLNODE;
            _loc_6.@type = MonsterDebuggerConstants.TYPE_XMLNODE;
            _loc_6.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
            _loc_6.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
            _loc_6.@label = param1.name() + " (" + MonsterDebuggerConstants.TYPE_XMLNODE + ")";
            _loc_6.@name = param1.name();
            _loc_6.@value = "";
            _loc_6.@target = param2;
            if(param1 != "")
            {
               _loc_7 = <node/>;
               _loc_7.@icon = MonsterDebuggerConstants.ICON_XMLVALUE;
               _loc_7.@type = MonsterDebuggerConstants.TYPE_XMLVALUE;
               _loc_7.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               _loc_7.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               _loc_7.@label = "(" + MonsterDebuggerConstants.TYPE_XMLVALUE + ") = " + printValue(param1,MonsterDebuggerConstants.TYPE_XMLVALUE);
               _loc_7.@name = "";
               _loc_7.@value = printValue(param1,MonsterDebuggerConstants.TYPE_XMLVALUE);
               _loc_7.@target = param2;
               _loc_6.appendChild(_loc_7);
            }
            _loc_8 = 0;
            while(_loc_8 < param1.attributes().length())
            {
               _loc_7 = <node/>;
               _loc_7.@icon = MonsterDebuggerConstants.ICON_XMLATTRIBUTE;
               _loc_7.@type = MonsterDebuggerConstants.TYPE_XMLATTRIBUTE;
               _loc_7.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               _loc_7.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               _loc_7.@label = "@" + param1.attributes()[_loc_8].name() + " (" + MonsterDebuggerConstants.TYPE_XMLATTRIBUTE + ") = " + param1.attributes()[_loc_8];
               _loc_7.@name = "";
               _loc_7.@value = param1.attributes()[_loc_8];
               _loc_7.@target = param2 + "." + "@" + param1.attributes()[_loc_8].name();
               _loc_6.appendChild(_loc_7);
               _loc_8++;
            }
            _loc_5.appendChild(_loc_6);
         }
         else
         {
            _loc_6 = <node/>;
            _loc_6.@icon = MonsterDebuggerConstants.ICON_XMLNODE;
            _loc_6.@type = MonsterDebuggerConstants.TYPE_XMLNODE;
            _loc_6.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
            _loc_6.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
            _loc_6.@label = param1.name() + " (" + MonsterDebuggerConstants.TYPE_XMLNODE + ")";
            _loc_6.@name = param1.name();
            _loc_6.@value = "";
            _loc_6.@target = param2;
            _loc_8 = 0;
            while(_loc_8 < param1.attributes().length())
            {
               _loc_7 = <node/>;
               _loc_7.@icon = MonsterDebuggerConstants.ICON_XMLATTRIBUTE;
               _loc_7.@type = MonsterDebuggerConstants.TYPE_XMLATTRIBUTE;
               _loc_7.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               _loc_7.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               _loc_7.@label = "@" + param1.attributes()[_loc_8].name() + " (" + MonsterDebuggerConstants.TYPE_XMLATTRIBUTE + ") = " + param1.attributes()[_loc_8];
               _loc_7.@name = "";
               _loc_7.@value = param1.attributes()[_loc_8];
               _loc_7.@target = param2 + "." + "@" + param1.attributes()[_loc_8].name();
               _loc_6.appendChild(_loc_7);
               _loc_8++;
            }
            _loc_8 = 0;
            while(_loc_8 < param1.children().length())
            {
               _loc_9 = param2 + "." + "children()" + "." + _loc_8;
               _loc_6.appendChild(parseXML(param1.children()[_loc_8],_loc_9,param3 + 1,param4).children());
               _loc_8++;
            }
            _loc_5.appendChild(_loc_6);
         }
         return _loc_5;
      }
      
      private static function parseObject(param1:*, param2:String, param3:int = 1, param4:int = 5, param5:Boolean = true) : XML
      {
         var childXML:XML = null;
         var prop:* = undefined;
         var childType:String = null;
         var childTarget:String = null;
         var i:int = 0;
         var object:* = param1;
         var target:* = param2;
         var currentDepth:* = param3;
         var maxDepth:* = param4;
         var includeDisplayObjects:* = param5;
         var rootXML:* = <root/>;
         var nodeXML:* = <node/>;
         var isXMLString:* = new XML();
         var _loc_8:* = object;
         while(_loc_8 in 0)
         {
            prop = _loc_8[0];
            if(prop is int)
            {
            }
            null.push(prop);
         }
         null.sort(Array.CASEINSENSITIVE);
         while(i < null.length)
         {
            childType = parseType(MonsterDebuggerDescribeType.get(object[null[i]]).@name);
            childTarget = target + "." + null[i];
            if(childType == MonsterDebuggerConstants.TYPE_STRING || childType == MonsterDebuggerConstants.TYPE_BOOLEAN || childType == MonsterDebuggerConstants.TYPE_NUMBER || childType == MonsterDebuggerConstants.TYPE_INT || childType == MonsterDebuggerConstants.TYPE_UINT || childType == MonsterDebuggerConstants.TYPE_FUNCTION)
            {
               isXMLString = new XML();
               if(childType == MonsterDebuggerConstants.TYPE_STRING)
               {
                  try
                  {
                     isXMLString = new XML(object[null[i]]);
                     if(!isXMLString.hasSimpleContent() && isXMLString.children().length() > 0)
                     {
                     }
                  }
                  catch(error:TypeError)
                  {
                  }
               }
               childXML = <node/>;
               childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
               childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               childXML.@label = null[i] + " (" + childType + ") = " + printValue(object[null[i]],childType);
               childXML.@name = null[i];
               childXML.@type = childType;
               childXML.@value = printValue(object[null[i]],childType);
               childXML.@target = childTarget;
               nodeXML.appendChild(childXML);
            }
            else
            {
               childXML = <node/>;
               childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
               childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
               childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               childXML.@label = null[i] + " (" + childType + ")";
               childXML.@name = null[i];
               childXML.@type = childType;
               childXML.@value = "";
               childXML.@target = childTarget;
               childXML.appendChild(parse(object[null[i]],childTarget,currentDepth + 1,maxDepth,includeDisplayObjects).children());
               nodeXML.appendChild(childXML);
            }
            i += 1;
         }
         rootXML.appendChild(nodeXML.children());
         return rootXML;
      }
      
      private static function parseClass(param1:*, param2:String, param3:XML, param4:int = 1, param5:int = 5, param6:Boolean = true) : XML
      {
         var key:String = null;
         var itemsArrayLength:int = 0;
         var itemXML:XML = null;
         var itemAccess:String = null;
         var itemPermission:String = null;
         var itemIcon:String = null;
         var itemType:String = null;
         var itemName:String = null;
         var itemTarget:String = null;
         var isXMLString:XML = null;
         var i:int = 0;
         var displayObject:DisplayObjectContainer = null;
         var child:DisplayObject = null;
         var childLength:int = 0;
         var itemsArray:Array = null;
         var isXML:Boolean = false;
         var _loc_8:int = 0;
         var item:* = undefined;
         var prop:* = undefined;
         var _loc_9:* = undefined;
         var object:* = param1;
         var target:* = param2;
         var description:* = param3;
         var currentDepth:* = param4;
         var maxDepth:* = param5;
         var includeDisplayObjects:* = param6;
         var rootXML:* = <root/>;
         var nodeXML:* = <node/>;
         var variables:* = description..variable;
         var accessors:* = description..accessor;
         var constants:* = description..constant;
         var isDynamic:* = description.@isDynamic;
         var variablesLength:* = variables.length();
         var accessorsLength:* = accessors.length();
         var constantsLength:* = constants.length();
         if(isDynamic)
         {
            _loc_8 = 0;
            _loc_9 = object;
            while(_loc_9 in _loc_8)
            {
               prop = _loc_9[_loc_8];
               key = String(prop);
               if(!null.hasOwnProperty(key))
               {
                  null[key] = key;
                  itemName = key;
                  itemType = parseType(getQualifiedClassName(object[key]));
                  itemTarget = target + "." + key;
                  itemAccess = MonsterDebuggerConstants.ACCESS_VARIABLE;
                  itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                  itemIcon = MonsterDebuggerConstants.ICON_VARIABLE;
                  itemsArray[itemsArray.length] = {
                     "name":itemName,
                     "type":itemType,
                     "target":itemTarget,
                     "access":itemAccess,
                     "permission":itemPermission,
                     "icon":itemIcon
                  };
               }
            }
         }
         while(i < variablesLength)
         {
            key = variables[i].@name;
            if(!null.hasOwnProperty(key))
            {
               null[key] = key;
               itemName = key;
               itemType = parseType(variables[i].@type);
               itemTarget = target + "." + key;
               itemAccess = MonsterDebuggerConstants.ACCESS_VARIABLE;
               itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               itemIcon = MonsterDebuggerConstants.ICON_VARIABLE;
               itemsArray[itemsArray.length] = {
                  "name":itemName,
                  "type":itemType,
                  "target":itemTarget,
                  "access":itemAccess,
                  "permission":itemPermission,
                  "icon":itemIcon
               };
            }
            i += 1;
         }
         while(i < accessorsLength)
         {
            key = accessors[i].@name;
            if(!null.hasOwnProperty(key))
            {
               null[key] = key;
               itemName = key;
               itemType = parseType(accessors[i].@type);
               itemTarget = target + "." + key;
               itemAccess = MonsterDebuggerConstants.ACCESS_ACCESSOR;
               itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
               itemIcon = MonsterDebuggerConstants.ICON_VARIABLE;
               if(accessors[i].@access == MonsterDebuggerConstants.PERMISSION_READONLY)
               {
                  itemPermission = MonsterDebuggerConstants.PERMISSION_READONLY;
                  itemIcon = MonsterDebuggerConstants.ICON_VARIABLE_READONLY;
               }
               if(accessors[i].@access == MonsterDebuggerConstants.PERMISSION_WRITEONLY)
               {
                  itemPermission = MonsterDebuggerConstants.PERMISSION_WRITEONLY;
                  itemIcon = MonsterDebuggerConstants.ICON_VARIABLE_WRITEONLY;
               }
               itemsArray[itemsArray.length] = {
                  "name":itemName,
                  "type":itemType,
                  "target":itemTarget,
                  "access":itemAccess,
                  "permission":itemPermission,
                  "icon":itemIcon
               };
            }
            i += 1;
         }
         while(i < constantsLength)
         {
            key = constants[i].@name;
            if(!null.hasOwnProperty(key))
            {
               null[key] = key;
               itemName = key;
               itemType = parseType(constants[i].@type);
               itemTarget = target + "." + key;
               itemAccess = MonsterDebuggerConstants.ACCESS_CONSTANT;
               itemPermission = MonsterDebuggerConstants.PERMISSION_READONLY;
               itemIcon = MonsterDebuggerConstants.ICON_VARIABLE_READONLY;
               itemsArray[itemsArray.length] = {
                  "name":itemName,
                  "type":itemType,
                  "target":itemTarget,
                  "access":itemAccess,
                  "permission":itemPermission,
                  "icon":itemIcon
               };
            }
            i += 1;
         }
         itemsArray.sortOn("name",Array.CASEINSENSITIVE);
         if(includeDisplayObjects && object is DisplayObjectContainer)
         {
            displayObject = DisplayObjectContainer(object);
            childLength = displayObject.numChildren;
            while(i < childLength)
            {
               try
               {
                  child = displayObject.getChildAt(i);
               }
               catch(e1:Error)
               {
               }
               if(child != null)
               {
                  itemXML = MonsterDebuggerDescribeType.get(child);
                  itemType = parseType(itemXML.@name);
                  if(child.name != null)
                  {
                     itemName += " - " + child.name;
                  }
                  itemTarget = target + "." + "getChildAt(" + i + ")";
                  itemAccess = MonsterDebuggerConstants.ACCESS_DISPLAY_OBJECT;
                  itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                  itemIcon = child is DisplayObjectContainer ? MonsterDebuggerConstants.ICON_ROOT : MonsterDebuggerConstants.ICON_DISPLAY_OBJECT;
                  null[null.length] = {
                     "name":itemName,
                     "type":itemType,
                     "target":itemTarget,
                     "access":itemAccess,
                     "permission":itemPermission,
                     "icon":itemIcon,
                     "index":i
                  };
               }
               i += 1;
            }
            null.sortOn("name",Array.CASEINSENSITIVE);
            itemsArray = null.concat(itemsArray);
         }
         itemsArrayLength = int(itemsArray.length);
         while(i < itemsArrayLength)
         {
            itemType = itemsArray[i].type;
            itemName = itemsArray[i].name;
            itemTarget = itemsArray[i].target;
            itemPermission = itemsArray[i].permission;
            itemAccess = itemsArray[i].access;
            itemIcon = itemsArray[i].icon;
            try
            {
               if(itemAccess == MonsterDebuggerConstants.ACCESS_DISPLAY_OBJECT)
               {
                  item = DisplayObjectContainer(object).getChildAt(itemsArray[i].index);
               }
               else
               {
                  item = object[itemName];
               }
            }
            catch(e2:Error)
            {
            }
            if(item != null && itemPermission != MonsterDebuggerConstants.PERMISSION_WRITEONLY)
            {
               if(itemType == MonsterDebuggerConstants.TYPE_STRING || itemType == MonsterDebuggerConstants.TYPE_BOOLEAN || itemType == MonsterDebuggerConstants.TYPE_NUMBER || itemType == MonsterDebuggerConstants.TYPE_INT || itemType == MonsterDebuggerConstants.TYPE_UINT || itemType == MonsterDebuggerConstants.TYPE_FUNCTION)
               {
                  isXMLString = new XML();
                  if(itemType == MonsterDebuggerConstants.TYPE_STRING)
                  {
                     try
                     {
                        isXMLString = new XML(item);
                        isXML = !isXMLString.hasSimpleContent() && isXMLString.children().length() > 0;
                     }
                     catch(error:TypeError)
                     {
                     }
                  }
                  if(!isXML)
                  {
                     nodeXML = <node/>;
                     nodeXML.@icon = itemIcon;
                     nodeXML.@label = itemName + " (" + itemType + ") = " + printValue(item,itemType);
                     nodeXML.@name = itemName;
                     nodeXML.@type = itemType;
                     nodeXML.@value = printValue(item,itemType);
                     nodeXML.@target = itemTarget;
                     nodeXML.@access = itemAccess;
                     nodeXML.@permission = itemPermission;
                     rootXML.appendChild(nodeXML);
                  }
                  else
                  {
                     nodeXML = <node/>;
                     nodeXML.@icon = itemIcon;
                     nodeXML.@label = itemName + " (" + itemType + ")";
                     nodeXML.@name = itemName;
                     nodeXML.@type = itemType;
                     nodeXML.@value = "";
                     nodeXML.@target = itemTarget;
                     nodeXML.@access = itemAccess;
                     nodeXML.@permission = itemPermission;
                     nodeXML.appendChild(parseXML(isXMLString,itemTarget + "." + "children()",currentDepth,maxDepth).children());
                     rootXML.appendChild(nodeXML);
                  }
               }
               else
               {
                  nodeXML = <node/>;
                  nodeXML.@icon = itemIcon;
                  nodeXML.@label = itemName + " (" + itemType + ")";
                  nodeXML.@name = itemName;
                  nodeXML.@type = itemType;
                  nodeXML.@target = itemTarget;
                  nodeXML.@access = itemAccess;
                  nodeXML.@permission = itemPermission;
                  if(item != null && itemType != MonsterDebuggerConstants.TYPE_BYTEARRAY)
                  {
                     nodeXML.appendChild(parse(item,itemTarget,currentDepth + 1,maxDepth,includeDisplayObjects).children());
                  }
                  rootXML.appendChild(nodeXML);
               }
            }
            i += 1;
         }
         return rootXML;
      }
      
      public static function parseFunctions(param1:*, param2:String = "") : XML
      {
         var itemXML:XML = null;
         var key:String = null;
         var returnType:String = null;
         var parameters:XMLList = null;
         var parametersLength:int = 0;
         var argsString:String = null;
         var methodXML:XML = null;
         var parameterXML:XML = null;
         var itemType:String = null;
         var itemName:String = null;
         var itemTarget:String = null;
         var i:int = 0;
         var n:int = 0;
         var object:* = param1;
         var target:* = param2;
         var rootXML:* = <root/>;
         var description:* = MonsterDebuggerDescribeType.get(object);
         var type:* = parseType(description.@name);
         var methods:* = description..method;
         var methodsLength:* = methods.length();
         itemXML = <node/>;
         itemXML.@icon = MonsterDebuggerConstants.ICON_DEFAULT;
         itemXML.@label = "(" + type + ")";
         itemXML.@target = target;
         while(i < methodsLength)
         {
            key = methods[i].@name;
            try
            {
               if(!null.hasOwnProperty(key))
               {
                  null[key] = key;
                  null[null.length] = {
                     "name":key,
                     "xml":methods[i],
                     "access":MonsterDebuggerConstants.ACCESS_METHOD
                  };
               }
            }
            catch(e:Error)
            {
            }
            i += 1;
         }
         null.sortOn("name",Array.CASEINSENSITIVE);
         methodsLength = null.length;
         while(i < methodsLength)
         {
            itemType = MonsterDebuggerConstants.TYPE_FUNCTION;
            itemName = null[i].xml.@name;
            itemTarget = target + MonsterDebuggerConstants.DELIMITER + itemName;
            returnType = parseType(null[i].xml.@returnType);
            parameters = null[i].xml..parameter;
            parametersLength = int(parameters.length());
            while(n < parametersLength)
            {
               if(parameters[n].@optional == "true")
               {
                  null[null.length] = "[";
               }
               null[null.length] = parseType(parameters[n].@type);
               n += 1;
            }
            argsString = null.join(", ");
            argsString = argsString.replace("[, ","[");
            argsString = argsString.replace(", ]","]");
            methodXML = <node/>;
            methodXML.@icon = MonsterDebuggerConstants.ICON_FUNCTION;
            methodXML.@type = MonsterDebuggerConstants.TYPE_FUNCTION;
            methodXML.@access = MonsterDebuggerConstants.ACCESS_METHOD;
            methodXML.@label = itemName + "(" + argsString + "):" + returnType;
            methodXML.@name = itemName;
            methodXML.@target = itemTarget;
            methodXML.@args = argsString;
            methodXML.@returnType = returnType;
            while(n < parametersLength)
            {
               parameterXML = <node/>;
               parameterXML.@type = parseType(parameters[n].@type);
               parameterXML.@index = parameters[n].@index;
               parameterXML.@optional = parameters[n].@optional;
               methodXML.appendChild(parameterXML);
               n += 1;
            }
            itemXML.appendChild(methodXML);
            i += 1;
         }
         rootXML.appendChild(itemXML);
         return rootXML;
      }
      
      public static function parseType(param1:String) : String
      {
         var _loc_2:String = null;
         var _loc_3:String = null;
         if(param1.indexOf("::") != -1)
         {
            param1 = param1.substring(param1.indexOf("::") + 2,param1.length);
         }
         if(param1.indexOf("::") != -1)
         {
            _loc_2 = param1.substring(0,param1.indexOf("<") + 1);
            _loc_3 = param1.substring(param1.indexOf("::") + 2,param1.length);
            param1 = _loc_2 + _loc_3;
         }
         param1 = param1.replace("()","");
         return param1.replace(MonsterDebuggerConstants.TYPE_METHOD,MonsterDebuggerConstants.TYPE_FUNCTION);
      }
      
      public static function isDisplayObject(param1:*) : Boolean
      {
         return param1 is DisplayObject || param1 is DisplayObjectContainer;
      }
      
      public static function printValue(param1:*, param2:String) : String
      {
         if(param2 == MonsterDebuggerConstants.TYPE_BYTEARRAY)
         {
            return param1["length"] + " bytes";
         }
         if(param1 == null)
         {
            return "null";
         }
         return String(param1);
      }
      
      public static function getObjectUnderPoint(param1:DisplayObjectContainer, param2:Point) : DisplayObject
      {
         var _loc_3:Array = null;
         var _loc_4:DisplayObject = null;
         var _loc_6:DisplayObject = null;
         var _loc_5:int = 0;
         if(param1.areInaccessibleObjectsUnderPoint(param2))
         {
            return param1;
         }
         _loc_3 = param1.getObjectsUnderPoint(param2);
         _loc_3.reverse();
         if(_loc_3 == null || _loc_3.length == 0)
         {
            return param1;
         }
         _loc_4 = _loc_3[0];
         _loc_3.length = 0;
         while(true)
         {
            _loc_3[_loc_3.length] = _loc_4;
            if(_loc_4.parent == null)
            {
               break;
            }
            _loc_4 = _loc_4.parent;
         }
         _loc_3.reverse();
         while(_loc_5 < _loc_3.length)
         {
            _loc_6 = _loc_3[_loc_5];
            if(!(_loc_6 is DisplayObjectContainer))
            {
               break;
            }
            _loc_4 = _loc_6;
            if(!DisplayObjectContainer(_loc_6).mouseChildren)
            {
               break;
            }
            _loc_5++;
         }
         return _loc_4;
      }
   }
}

