package com.yahoo.astra.fl.events
{
   import flash.events.Event;
   
   public class TabBarEvent extends Event
   {
      public static const ITEM_CLICK:String = "itemClick";
      
      public static const ITEM_ROLL_OVER:String = "itemRollOver";
      
      public static const ITEM_ROLL_OUT:String = "itemRollOut";
      
      public var item:Object = null;
      
      public var index:int = -1;
      
      public function TabBarEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:Object = null)
      {
         super(param1,param2,param3);
         this.index = param4;
         this.item = param5;
      }
      
      override public function clone() : Event
      {
         return new TabBarEvent(this.type,this.bubbles,this.cancelable,this.index,this.item);
      }
   }
}

