package com.yahoo.astra.fl.events
{
   import com.yahoo.astra.fl.controls.Menu;
   import fl.controls.listClasses.CellRenderer;
   import fl.events.ListEvent;
   import flash.events.Event;
   
   public class MenuEvent extends ListEvent
   {
      public static const CHANGE:String = "change";
      
      public static const ITEM_CLICK:String = "itemClick";
      
      public static const MENU_HIDE:String = "menuHide";
      
      public static const ITEM_ROLL_OUT:String = "itemRollOut";
      
      public static const ITEM_ROLL_OVER:String = "itemRollOver";
      
      public static const MENU_SHOW:String = "menuShow";
      
      public var menu:Menu;
      
      public var label:String;
      
      public function MenuEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Object = null, param5:Menu = null, param6:Object = null, param7:CellRenderer = null, param8:String = null, param9:int = -1)
      {
         super(param1,param2,param3);
         this.menu = param5;
         this._item = param6;
         this.label = param8;
         this._index = param9;
      }
      
      override public function toString() : String
      {
         return formatToString("MenuEvent","type","bubbles","cancelable","menu","item","label","index");
      }
      
      override public function clone() : Event
      {
         return new MenuEvent(type,bubbles,cancelable,null,menu,_item,null,label,index);
      }
   }
}

