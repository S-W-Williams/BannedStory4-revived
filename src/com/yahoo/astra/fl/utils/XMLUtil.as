package com.yahoo.astra.fl.utils
{
   public class XMLUtil
   {
      public function XMLUtil()
      {
         super();
      }
      
      public static function createArrayFromXML(param1:Object) : Array
      {
         var _loc2_:XMLList = null;
         var _loc3_:Array = null;
         var _loc4_:XML = null;
         var _loc5_:Object = null;
         var _loc6_:XMLList = null;
         var _loc7_:Array = null;
         _loc3_ = [];
         if(param1 is XML)
         {
            _loc2_ = XML(param1).children();
         }
         else
         {
            if(!(param1 is XMLList))
            {
               throw new TypeError("Error: Type Coercion failed: cannot convert " + param1 + " to XML or XMLList.");
            }
            _loc2_ = param1 as XMLList;
         }
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = createObjectFromXMLAttributes(_loc4_);
            _loc6_ = _loc4_.*;
            _loc7_ = createArrayFromXML(_loc6_);
            if(_loc7_.length)
            {
               _loc5_.data = _loc7_;
            }
            _loc3_.push(_loc5_);
         }
         return _loc3_;
      }
      
      public static function createObjectFromXMLAttributes(param1:XML) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         _loc2_ = {};
         _loc3_ = param1.attributes();
         for each(_loc4_ in _loc3_)
         {
            _loc2_[_loc4_.localName()] = _loc4_.toString();
         }
         return _loc2_;
      }
   }
}

