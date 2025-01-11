package com.yahoo.astra.utils
{
   import flash.utils.getQualifiedClassName;
   
   public class InstanceFactory
   {
      private var _methods:Object;
      
      private var _targetClass:Class = Object;
      
      private var _properties:Object;
      
      public function InstanceFactory(param1:Class, param2:Object = null, param3:Object = null)
      {
         super();
         this.targetClass = param1;
         this.properties = param2;
         this.methods = param3;
      }
      
      public function restoreInstance(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(!(param1 is targetClass))
         {
            throw new ArgumentError("Value to be initialized must be an instance of " + getQualifiedClassName(this.targetClass));
         }
         if(this.properties)
         {
            for(_loc2_ in this.properties)
            {
               if(param1.hasOwnProperty(_loc2_))
               {
                  param1[_loc2_] = properties[_loc2_];
               }
            }
         }
         if(this.methods)
         {
            for(_loc3_ in this.methods)
            {
               if(param1[_loc3_] is Function)
               {
                  _loc4_ = this.methods[_loc3_] as Array;
                  param1[_loc3_].apply(param1,_loc4_);
               }
            }
         }
      }
      
      public function set properties(param1:Object) : void
      {
         this._properties = param1;
      }
      
      public function set methods(param1:Object) : void
      {
         this._methods = param1;
      }
      
      public function set targetClass(param1:Class) : void
      {
         this._targetClass = param1;
      }
      
      public function createInstance() : Object
      {
         var _loc1_:Object = null;
         _loc1_ = new targetClass();
         this.restoreInstance(_loc1_);
         return _loc1_;
      }
      
      public function get targetClass() : Class
      {
         return this._targetClass;
      }
      
      public function get methods() : Object
      {
         return this._methods;
      }
      
      public function get properties() : Object
      {
         return this._properties;
      }
   }
}

