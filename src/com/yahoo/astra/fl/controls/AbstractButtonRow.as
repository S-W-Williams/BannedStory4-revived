package com.yahoo.astra.fl.controls
{
   import fl.controls.Button;
   import fl.core.UIComponent;
   import fl.data.DataProvider;
   import fl.data.SimpleCollectionItem;
   import fl.events.DataChangeEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class AbstractButtonRow extends UIComponent
   {
      public static var createAccessibilityImplementation:Function;
      
      protected var _cachedButtons:Array = [];
      
      protected var _labelField:String = "label";
      
      protected var _buttons:Array = [];
      
      protected var _focusIndex:int = 0;
      
      protected var _labelFunction:Function = null;
      
      protected var _selectedIndex:int = 0;
      
      protected var _dataProvider:DataProvider;
      
      private var collectionItemImport:SimpleCollectionItem;
      
      public function AbstractButtonRow()
      {
         super();
      }
      
      protected function getButton() : Button
      {
         return new Button();
      }
      
      public function get selectedItem() : Object
      {
         if(this.selectedIndex >= 0)
         {
            return this._dataProvider.getItemAt(this.selectedIndex);
         }
         return null;
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      public function set selectedItem(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this._dataProvider.getItemIndex(param1);
         this.selectedIndex = _loc2_;
      }
      
      public function itemToIndex(param1:Object) : int
      {
         return this._dataProvider.getItemIndex(param1);
      }
      
      public function itemToLabel(param1:Object) : String
      {
         if(this.labelFunction != null)
         {
            this.labelFunction(param1,this.itemToIndex(param1));
         }
         else if(Boolean(this.labelField) && Boolean(param1.hasOwnProperty(this.labelField)))
         {
            return param1[this.labelField];
         }
         return "";
      }
      
      public function set labelField(param1:String) : void
      {
         if(this._labelField != param1)
         {
            this._labelField = param1;
            this.invalidate();
         }
      }
      
      public function get focusIndex() : int
      {
         return this._focusIndex;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      protected function clearCache() : void
      {
      }
      
      override protected function draw() : void
      {
         this.createCache();
         if(this._dataProvider)
         {
            this.drawButtons();
         }
         this.clearCache();
         this.drawBackground();
         super.draw();
      }
      
      public function set dataProvider(param1:DataProvider) : void
      {
         if(this._dataProvider)
         {
            this._dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE,dataChangeHandler);
         }
         this._dataProvider = param1;
         if(this._dataProvider)
         {
            this._dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE,dataChangeHandler,false,0,true);
         }
         this.invalidate();
      }
      
      protected function drawBackground() : void
      {
      }
      
      protected function drawButtons() : void
      {
      }
      
      override protected function initializeAccessibility() : void
      {
         if(AbstractButtonRow.createAccessibilityImplementation != null)
         {
            AbstractButtonRow.createAccessibilityImplementation(this);
         }
      }
      
      public function indexToItem(param1:int) : Object
      {
         return this._dataProvider.getItemAt(param1);
      }
      
      protected function navigationKeyDownHandler(param1:KeyboardEvent) : void
      {
      }
      
      public function set focusIndex(param1:int) : void
      {
         var _loc2_:Button = null;
         this._focusIndex = param1;
         if(this._focusIndex >= 0)
         {
            _loc2_ = this._buttons[this._focusIndex];
            _loc2_.setFocus();
            this.dispatchEvent(new Event("focusUpdate"));
         }
         this.invalidate();
      }
      
      public function get dataProvider() : DataProvider
      {
         return this._dataProvider;
      }
      
      protected function createCache() : void
      {
         this._cachedButtons = this._buttons.concat();
         this._buttons = [];
      }
      
      public function set labelFunction(param1:Function) : void
      {
         if(this._labelFunction != param1)
         {
            this._labelFunction = param1;
            this.invalidate();
         }
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(param1 >= this._dataProvider.length)
         {
            param1 = -1;
         }
         if(this._selectedIndex != param1)
         {
            this._selectedIndex = param1;
            this.focusIndex = param1;
            this.invalidate();
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      protected function dataChangeHandler(param1:DataChangeEvent) : void
      {
         this.invalidate();
      }
   }
}

