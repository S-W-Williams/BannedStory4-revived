package com.yahoo.astra.fl.data
{
   import com.yahoo.astra.fl.utils.XMLUtil;
   import fl.data.DataProvider;
   
   public class XMLDataProvider extends DataProvider
   {
      public function XMLDataProvider(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function getDataFromObject(param1:Object) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Object = null;
         var _loc6_:XML = null;
         var _loc7_:XMLList = null;
         if(param1 is Array)
         {
            _loc3_ = param1 as Array;
            if(_loc3_.length > 0)
            {
               if(_loc3_[0] is String || _loc3_[0] is Number)
               {
                  _loc2_ = [];
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.length)
                  {
                     _loc5_ = {
                        "label":String(_loc3_[_loc4_]),
                        "data":_loc3_[_loc4_]
                     };
                     _loc2_.push(_loc5_);
                     _loc4_++;
                  }
                  return _loc2_;
               }
            }
            return param1.concat();
         }
         if(param1 is DataProvider)
         {
            return param1.toArray();
         }
         if(param1 is XML)
         {
            _loc6_ = param1 as XML;
            _loc7_ = _loc6_.*;
            return XMLUtil.createArrayFromXML(_loc7_);
         }
         throw new TypeError("Error: Type Coercion failed: cannot convert " + param1 + " to Array or DataProvider.");
      }
   }
}

