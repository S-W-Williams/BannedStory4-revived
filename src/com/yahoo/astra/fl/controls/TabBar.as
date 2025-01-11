package com.yahoo.astra.fl.controls
{
   import com.yahoo.astra.fl.controls.tabBarClasses.TabButton;
   import com.yahoo.astra.fl.events.TabBarEvent;
   import fl.controls.Button;
   import fl.core.InvalidationType;
   import fl.core.UIComponent;
   import fl.data.DataProvider;
   import fl.data.SimpleCollectionItem;
   import fl.events.DataChangeEvent;
   import fl.managers.IFocusManagerComponent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol48")]
   public class TabBar extends UIComponent implements IFocusManagerComponent
   {
      public static var createAccessibilityImplementation:Function;
      
      private static var defaultStyles:Object = {"selectedTextFormat":null};
      
      private static const TAB_STYLES:Object = {
         "embedFonts":"embedFonts",
         "disabledTextFormat":"disabledTextFormat",
         "textFormat":"textFormat",
         "selectedTextFormat":"selectedTextFormat",
         "textPadding":"textPadding"
      };
      
      protected var _cachedButtons:Array = [];
      
      protected var _labelField:String = "label";
      
      protected var lastFocusIndex:int = -1;
      
      private var _autoSizeTabsToTextWidth:Boolean = true;
      
      protected var _focusIndex:int = -1;
      
      protected var _labelFunction:Function = null;
      
      protected var _selectedIndex:int = 0;
      
      protected var buttons:Array = [];
      
      protected var rendererStyles:Object = {};
      
      protected var _dataProvider:DataProvider;
      
      private var _selectionFollowsFocus:Boolean = true;
      
      private var _livePreviewMessage:TabButton;
      
      private var collectionItemImport:SimpleCollectionItem;
      
      public function TabBar()
      {
         super();
         this.focusEnabled = true;
         this.tabEnabled = true;
         this.tabChildren = false;
         this.addEventListener(KeyboardEvent.KEY_DOWN,navigationKeyDownHandler);
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(defaultStyles,UIComponent.getStyleDefinition());
      }
      
      protected function getButton() : TabButton
      {
         var _loc1_:TabButton = null;
         if(this._cachedButtons.length > 0)
         {
            _loc1_ = this._cachedButtons.shift() as TabButton;
         }
         else
         {
            _loc1_ = new TabButton();
            _loc1_.toggle = true;
            _loc1_.focusEnabled = false;
            _loc1_.addEventListener(Event.CHANGE,buttonChangeHandler,false,0,true);
            _loc1_.addEventListener(MouseEvent.CLICK,buttonClickHandler,false,0,true);
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,buttonRollOverHandler,false,0,true);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,buttonRollOutHandler,false,0,true);
            this.addChild(_loc1_);
         }
         return _loc1_;
      }
      
      protected function buttonRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:TabButton = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         _loc2_ = param1.currentTarget as TabButton;
         _loc3_ = int(this.buttons.indexOf(_loc2_));
         _loc4_ = this._dataProvider.getItemAt(_loc3_);
         this.dispatchEvent(new TabBarEvent(TabBarEvent.ITEM_ROLL_OUT,false,false,_loc3_,_loc4_));
      }
      
      public function get selectedItem() : Object
      {
         if(this.selectedIndex >= 0)
         {
            return this._dataProvider.getItemAt(this.selectedIndex);
         }
         return null;
      }
      
      public function set selectionFollowsKeyboardFocus(param1:Boolean) : void
      {
         if(this._selectionFollowsFocus != param1)
         {
            this._selectionFollowsFocus = param1;
            this.invalidate();
         }
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      override protected function focusInHandler(param1:FocusEvent) : void
      {
         this.focusIndex = this.lastFocusIndex >= 0 ? this.lastFocusIndex : 0;
      }
      
      protected function updateButtons() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TabButton = null;
         var _loc4_:Object = null;
         _loc1_ = int(this._dataProvider.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.getButton();
            this.buttons.push(_loc3_);
            _loc4_ = this._dataProvider.getItemAt(_loc2_);
            _loc3_.label = this.itemToLabel(_loc4_);
            _loc3_.buttonMode = this.buttonMode;
            _loc3_.useHandCursor = this.useHandCursor;
            _loc2_++;
         }
      }
      
      public function itemToIndex(param1:Object) : int
      {
         return this._dataProvider.getItemIndex(param1);
      }
      
      public function set selectedItem(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this._dataProvider.getItemIndex(param1);
         this.selectedIndex = _loc2_;
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
            this.invalidate(InvalidationType.DATA);
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
      
      public function getRendererStyle(param1:String) : Object
      {
         return this.rendererStyles[param1];
      }
      
      override protected function focusOutHandler(param1:FocusEvent) : void
      {
         this.lastFocusIndex = this.focusIndex;
         this.focusIndex = -1;
      }
      
      public function set autoSizeTabsToTextWidth(param1:Boolean) : void
      {
         if(this._autoSizeTabsToTextWidth != param1)
         {
            this._autoSizeTabsToTextWidth = param1;
            this.invalidate();
         }
      }
      
      public function get selectionFollowsKeyboardFocus() : Boolean
      {
         return this._selectionFollowsFocus;
      }
      
      protected function buttonClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:TabButton = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         _loc2_ = param1.currentTarget as TabButton;
         _loc3_ = int(this.buttons.indexOf(_loc2_));
         _loc4_ = this._dataProvider.getItemAt(_loc3_);
         this.dispatchEvent(new TabBarEvent(TabBarEvent.ITEM_CLICK,false,false,_loc3_,_loc4_));
      }
      
      protected function clearCache() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TabButton = null;
         _loc1_ = int(this._cachedButtons.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._cachedButtons.pop() as TabButton;
            _loc3_.removeEventListener(Event.CHANGE,buttonChangeHandler);
            _loc3_.removeEventListener(MouseEvent.CLICK,buttonClickHandler);
            _loc3_.removeEventListener(MouseEvent.ROLL_OVER,buttonRollOverHandler);
            _loc3_.removeEventListener(MouseEvent.ROLL_OUT,buttonRollOutHandler);
            this.removeChild(_loc3_);
            _loc2_++;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         if(this.isLivePreview)
         {
            this._livePreviewMessage.visible = !this.dataProvider || this.dataProvider.length == 0;
            this._livePreviewMessage.width = this.autoSizeTabsToTextWidth ? NaN : this.width;
            this._livePreviewMessage.height = this.height;
            this._livePreviewMessage.drawNow();
         }
         _loc1_ = Boolean(this.isInvalid(InvalidationType.DATA));
         if(_loc1_)
         {
            this.createCache();
            if(this._dataProvider)
            {
               this.updateButtons();
            }
            this.clearCache();
         }
         this.drawButtons();
         super.draw();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.isLivePreview)
         {
            this._livePreviewMessage = new TabButton();
            this._livePreviewMessage.label = "No live preview data";
            this.addChild(this._livePreviewMessage);
         }
      }
      
      public function clearRendererStyle(param1:String) : void
      {
         this.rendererStyles[param1] = null;
         this.invalidate(InvalidationType.RENDERER_STYLES);
      }
      
      public function setRendererStyle(param1:String, param2:Object) : void
      {
         if(this.rendererStyles[param1] == param2)
         {
            return;
         }
         this.rendererStyles[param1] = param2;
         this.invalidate(InvalidationType.RENDERER_STYLES);
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
         this.invalidate(InvalidationType.DATA);
      }
      
      protected function buttonChangeHandler(param1:Event) : void
      {
         var _loc2_:TabButton = null;
         var _loc3_:int = 0;
         _loc2_ = param1.target as TabButton;
         if(_loc2_.selected)
         {
            _loc3_ = int(this.buttons.indexOf(_loc2_));
            this.selectedIndex = _loc3_;
         }
      }
      
      protected function buttonRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:TabButton = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         _loc2_ = param1.currentTarget as TabButton;
         _loc3_ = int(this.buttons.indexOf(_loc2_));
         _loc4_ = this._dataProvider.getItemAt(_loc3_);
         this.dispatchEvent(new TabBarEvent(TabBarEvent.ITEM_ROLL_OVER,false,false,_loc3_,_loc4_));
      }
      
      public function get autoSizeTabsToTextWidth() : Boolean
      {
         return this._autoSizeTabsToTextWidth;
      }
      
      override protected function initializeAccessibility() : void
      {
         if(TabBar.createAccessibilityImplementation != null)
         {
            TabBar.createAccessibilityImplementation(this);
         }
      }
      
      public function indexToItem(param1:int) : Object
      {
         return this._dataProvider.getItemAt(param1);
      }
      
      protected function drawButtons() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Button = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         _loc1_ = Boolean(this.isInvalid(InvalidationType.STYLES));
         _loc2_ = Boolean(this.isInvalid(InvalidationType.RENDERER_STYLES));
         _loc3_ = 0;
         _loc4_ = int(this.buttons.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = Button(this.buttons[_loc5_]);
            _loc6_.selected = this._selectedIndex == _loc5_;
            _loc6_.enabled = this.enabled;
            if(_loc5_ == this._focusIndex)
            {
               _loc6_.setMouseState("over");
            }
            else
            {
               _loc6_.setMouseState("up");
            }
            if(_loc1_)
            {
               this.copyStylesToChild(_loc6_,TAB_STYLES);
            }
            if(_loc2_)
            {
               for(_loc7_ in this.rendererStyles)
               {
                  _loc6_.setStyle(_loc7_,this.rendererStyles[_loc7_]);
               }
            }
            _loc6_.x = _loc3_;
            _loc6_.width = NaN;
            _loc6_.height = this.height;
            _loc6_.drawNow();
            _loc3_ += _loc6_.width;
            _loc5_++;
         }
         if(this.autoSizeTabsToTextWidth)
         {
            this._width = _loc3_;
         }
         else
         {
            _loc8_ = _loc3_;
            _loc3_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = Button(this.buttons[_loc5_]);
               _loc6_.x = _loc3_;
               _loc6_.width = this.width * (_loc6_.width / _loc8_);
               _loc6_.drawNow();
               _loc3_ += _loc6_.width;
               _loc5_++;
            }
         }
         if(_loc2_)
         {
            for(_loc7_ in this.rendererStyles)
            {
               if(this.rendererStyles[_loc7_] == null)
               {
                  delete this.rendererStyles[_loc7_];
               }
            }
         }
      }
      
      public function set focusIndex(param1:int) : void
      {
         this._focusIndex = param1;
         this.invalidate("focus");
         this.dispatchEvent(new Event("focusUpdate"));
      }
      
      public function get dataProvider() : DataProvider
      {
         return this._dataProvider;
      }
      
      protected function navigationKeyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.keyCode)
         {
            case Keyboard.SPACE:
               this.selectedIndex = this.focusIndex;
               break;
            case Keyboard.DOWN:
            case Keyboard.RIGHT:
               _loc2_ = this.focusIndex == this.numChildren - 1 ? 0 : this.focusIndex + 1;
               if(this.selectionFollowsKeyboardFocus)
               {
                  this.selectedIndex = _loc2_;
                  break;
               }
               this.focusIndex = _loc2_;
               break;
            case Keyboard.UP:
            case Keyboard.LEFT:
               _loc2_ = this.focusIndex == 0 ? this.numChildren - 1 : this.focusIndex - 1;
               if(this.selectionFollowsKeyboardFocus)
               {
                  this.selectedIndex = _loc2_;
                  break;
               }
               this.focusIndex = _loc2_;
               break;
         }
      }
      
      protected function createCache() : void
      {
         this._cachedButtons = this.buttons.concat();
         this.buttons = [];
      }
      
      public function set labelFunction(param1:Function) : void
      {
         if(this._labelFunction != param1)
         {
            this._labelFunction = param1;
            this.invalidate(InvalidationType.DATA);
         }
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= this._dataProvider.length)
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
         this.invalidate(InvalidationType.DATA);
      }
   }
}

