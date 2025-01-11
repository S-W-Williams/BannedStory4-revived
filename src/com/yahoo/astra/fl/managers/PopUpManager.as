package com.yahoo.astra.fl.managers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class PopUpManager
   {
      public function PopUpManager()
      {
         super();
      }
      
      public static function removePopUp(param1:DisplayObject) : void
      {
         param1.parent.removeChild(param1);
      }
      
      public static function addPopUp(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         param2.addChild(param1);
      }
   }
}

