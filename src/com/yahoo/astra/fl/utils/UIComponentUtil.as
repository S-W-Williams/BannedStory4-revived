package com.yahoo.astra.fl.utils
{
   import com.yahoo.astra.utils.InstanceFactory;
   import fl.core.UIComponent;
   import fl.managers.StyleManager;
   import flash.display.DisplayObject;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   
   public class UIComponentUtil
   {
      public function UIComponentUtil()
      {
         super();
      }
      
      public static function getDisplayObjectInstance(param1:DisplayObject, param2:Object) : DisplayObject
      {
         var classDef:Object = null;
         var target:DisplayObject = param1;
         var input:Object = param2;
         if(input is InstanceFactory)
         {
            return InstanceFactory(input).createInstance() as DisplayObject;
         }
         if(input is Class || input is Function)
         {
            return new input() as DisplayObject;
         }
         if(input is DisplayObject)
         {
            (input as DisplayObject).x = 0;
            (input as DisplayObject).y = 0;
            return input as DisplayObject;
         }
         classDef = null;
         try
         {
            classDef = getDefinitionByName(input.toString());
         }
         catch(e:Error)
         {
            try
            {
               classDef = target.loaderInfo.applicationDomain.getDefinition(input.toString()) as Object;
            }
            catch(e:Error)
            {
            }
         }
         if(classDef == null)
         {
            return null;
         }
         return new classDef() as DisplayObject;
      }
      
      public static function getClassDefinition(param1:Object) : Class
      {
         var target:Object = param1;
         if(target is Class)
         {
            return target as Class;
         }
         try
         {
            return getDefinitionByName(getQualifiedClassName(target)) as Class;
         }
         catch(e:Error)
         {
            if(target is DisplayObject)
            {
               try
               {
                  return target.loaderInfo.applicationDomain.getDefinition(getQualifiedClassName(target)) as Class;
               }
               catch(e:Error)
               {
               }
            }
         }
         return null;
      }
      
      public static function getStyleValue(param1:UIComponent, param2:String) : Object
      {
         var value:Object = null;
         var classDef:Class = null;
         var defaultStyles:Object = null;
         var target:UIComponent = param1;
         var styleName:String = param2;
         value = target.getStyle(styleName);
         value = !!value ? value : StyleManager.getComponentStyle(target,styleName);
         if(value)
         {
            return value;
         }
         classDef = UIComponentUtil.getClassDefinition(target);
         while(defaultStyles == null)
         {
            if(classDef["getStyleDefinition"] != null)
            {
               defaultStyles = classDef["getStyleDefinition"]();
               break;
            }
            try
            {
               classDef = target.loaderInfo.applicationDomain.getDefinition(getQualifiedSuperclassName(classDef)) as Class;
            }
            catch(err:Error)
            {
               try
               {
                  classDef = getDefinitionByName(getQualifiedSuperclassName(classDef)) as Class;
               }
               catch(e:Error)
               {
                  defaultStyles = UIComponent.getStyleDefinition();
                  break;
               }
            }
         }
         if(defaultStyles.hasOwnProperty(styleName))
         {
            return defaultStyles[styleName];
         }
         return null;
      }
   }
}

