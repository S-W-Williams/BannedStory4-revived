package com.yahoo.astra.fl.controls
{
   import com.yahoo.astra.fl.containers.IRendererContainer;
   import com.yahoo.astra.fl.controls.menuBarClasses.MenuButton;
   import com.yahoo.astra.fl.controls.menuBarClasses.MenuButtonRow;
   import com.yahoo.astra.fl.events.MenuButtonRowEvent;
   import com.yahoo.astra.fl.events.MenuEvent;
   import com.yahoo.astra.fl.utils.XMLUtil;
   import fl.core.InvalidationType;
   import fl.core.UIComponent;
   import fl.data.DataProvider;
   import fl.managers.IFocusManagerComponent;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol244")]
   public class MenuBar extends UIComponent implements IFocusManagerComponent
   {
      public static var createAccessibilityImplementation:Function;
      
      private static var defaultStyles:Object = {
         "xOffset":0,
         "yOffset":0,
         "menuLeftMargin":0,
         "menuTopMargin":0,
         "menuBottomMargin":0,
         "menuRightMargin":0,
         "subMenuXOffset":0,
         "subMenuYOffset":0,
         "focusRectSkin":null,
         "focusRectPadding":null,
         "menuBarBackground":"MenuBar_background"
      };
      
      private static const MENU_BUTTON_STYLES:Object = {
         "embedFonts":"embedFonts",
         "disabledTextFormat":"disabledTextFormat",
         "textFormat":"textFormat",
         "textPadding":"textPadding"
      };
      
      private static var menuRendererStyles:Object = {};
      
      private static var menuBarStyles:Object = {};
      
      private static var menuBarRendererStyles:Object = {};
      
      protected var _labelField:String = "label";
      
      protected var _autoSizeButtonsToTextWidth:Boolean = true;
      
      public var selectedIndex:int;
      
      private var menuStyles:Object = {};
      
      public var closeMenuOnMouseLeave:Boolean = false;
      
      protected var _dataProvider:DataProvider;
      
      public var parentMenuClickable:Boolean = true;
      
      public var _buttonRow:MenuButtonRow;
      
      protected var _menus:Array = [];
      
      public function MenuBar(param1:Object = null)
      {
         selectedIndex = !!_buttonRow ? _buttonRow.selectedIndex : -1;
         super();
         if(param1 != null)
         {
            param1.addChild(this);
         }
         tabEnabled = true;
         _buttonRow = new MenuButtonRow(this);
         _buttonRow.height = height;
         _buttonRow.addEventListener(MenuButtonRowEvent.ITEM_DOWN,itemDownHandler,false,0,true);
         _buttonRow.addEventListener(MenuButtonRowEvent.ITEM_ROLL_OVER,itemRollOverHandler,false,0,true);
         _buttonRow.addEventListener(MenuButtonRowEvent.ITEM_UP,itemUpHandler,false,0,true);
         if(this.isLivePreview)
         {
            _buttonRow.dataProvider = new DataProvider(["No preview data available."]);
         }
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles;
      }
      
      protected function clearSelected(param1:MenuEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Menu = null;
         var _loc4_:int = 0;
         var _loc5_:MenuButton = null;
         _loc2_ = _buttonRow.selectedIndex;
         _loc3_ = param1.target as Menu;
         _loc4_ = int(_menus.indexOf(_loc3_));
         _loc5_ = _buttonRow.buttons[_loc4_];
         if(_loc4_ == _loc2_)
         {
            _buttonRow.selectedIndex = -1;
         }
      }
      
      protected function keyFocusChangeHandler(param1:FocusEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB)
         {
            param1.preventDefault();
            param1.stopPropagation();
         }
      }
      
      protected function itemUpHandler(param1:MenuButtonRowEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = _buttonRow.selectedIndex;
         if(_loc2_ > -1)
         {
            _menus[_loc2_].setFocus();
         }
      }
      
      public function get labelField() : String
      {
         return _labelField;
      }
      
      public function setMenuBarRendererStyle(param1:String, param2:Object) : void
      {
         if(menuBarRendererStyles[param1] == param2)
         {
            return;
         }
         menuBarRendererStyles[param1] = param2;
         if(_buttonRow != null)
         {
            _buttonRow.setRendererStyle(param1,param2);
         }
      }
      
      override public function setStyle(param1:String, param2:Object) : void
      {
         if(menuBarStyles[param1] == param2)
         {
            return;
         }
         menuBarStyles[param1] = param2;
         if(_buttonRow != null)
         {
            (_buttonRow as UIComponent).setStyle(param1,param2);
         }
      }
      
      protected function copyStylesToMenus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.menus != null && this.menus.length > 0)
         {
            _loc1_ = int(this.menus.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.copyStylesToChild(this.menus[_loc2_],menuStyles);
               this.copyRendererStylesToChild(this.menus[_loc2_],menuRendererStyles);
               _loc2_++;
            }
         }
      }
      
      public function get autoSizeButtonsToTextWidth() : Boolean
      {
         return _autoSizeButtonsToTextWidth;
      }
      
      public function itemToLabel(param1:Object) : String
      {
         if(param1 is XML)
         {
            param1 = XMLUtil.createObjectFromXMLAttributes(param1 as XML);
         }
         return param1[_labelField] != null ? String(param1[_labelField]) : "";
      }
      
      override protected function copyStylesToChild(param1:UIComponent, param2:Object) : void
      {
         var _loc3_:String = null;
         for(_loc3_ in param2)
         {
            param1.setStyle(_loc3_,param2[_loc3_]);
         }
      }
      
      public function set labelField(param1:String) : void
      {
         if(param1.indexOf("@") == 0)
         {
            param1 = param1.slice(1);
         }
         if(param1 == _labelField)
         {
            return;
         }
         _labelField = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function set autoSizeButtonsToTextWidth(param1:Boolean) : void
      {
         if(param1 != _autoSizeButtonsToTextWidth)
         {
            _autoSizeButtonsToTextWidth = param1;
            invalidate();
         }
      }
      
      public function get menus() : Array
      {
         return _menus;
      }
      
      protected function itemDownHandler(param1:MenuButtonRowEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MenuButton = null;
         var _loc4_:int = 0;
         _loc2_ = param1.index;
         _loc3_ = param1.item as MenuButton;
         _loc4_ = int(_buttonRow.buttons.indexOf(_loc3_));
         if(_loc4_ == _loc2_)
         {
            _buttonRow.selectedIndex = -1;
            _menus[_loc4_].hide();
            _loc3_.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         }
         else
         {
            if(_loc2_ != -1)
            {
               _menus[_loc2_].hide(false);
            }
            _buttonRow.selectedIndex = _loc4_;
            _menus[_loc4_].show(_loc3_.x + Number(getStyleValue("xOffset")),_loc3_.y + _loc3_.height + Number(getStyleValue("yOffset")));
            _menus[_loc4_].setFocus();
         }
      }
      
      public function setMenuRendererStyle(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(menuRendererStyles[param1] == param2)
         {
            return;
         }
         menuRendererStyles[param1] = param2;
         if(this.menus != null && this.menus.length > 0)
         {
            _loc3_ = int(this.menus.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this.menus[_loc4_].setRendererStyle(param1,param2);
               _loc4_++;
            }
         }
      }
      
      override protected function draw() : void
      {
         _buttonRow.setSize(this.width,this.height);
         _buttonRow.autoSizeButtonsToTextWidth = autoSizeButtonsToTextWidth;
         this.copyStylesToChild(_buttonRow,menuBarStyles);
         this.copyStylesToMenus();
         this.copyRendererStylesToChild(_buttonRow,menuBarRendererStyles);
         super.draw();
         if(this.isLivePreview)
         {
            _buttonRow.drawNow();
         }
      }
      
      public function setMenuStyle(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(menuStyles[param1] == param2)
         {
            return;
         }
         menuStyles[param1] = param2;
         if(this.menus != null && this.menus.length > 0)
         {
            _loc3_ = int(this.menus.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this.menus[_loc4_].setStyle(param1,param2);
               _loc4_++;
            }
         }
      }
      
      public function set dataProvider(param1:DataProvider) : void
      {
         var _loc2_:Array = null;
         var _loc3_:* = undefined;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Menu = null;
         if(_menus != null && _menus.length > 0 && !isNaN(_menus.length) && _buttonRow.selectedIndex > -1 && !isNaN(_buttonRow.selectedIndex))
         {
            _loc4_ = _buttonRow.selectedIndex;
            _menus[_loc4_].hide(false);
         }
         _menus = [];
         _dataProvider = param1;
         _loc2_ = [];
         for each(_loc3_ in param1.toArray())
         {
            _loc5_ = itemToLabel(_loc3_);
            _loc2_.push(_loc5_);
            _loc6_ = Menu.createMenu(this,_loc3_.data);
            _loc6_.parentMenuClickable = parentMenuClickable;
            _loc6_.setStyle("xOffset",Number(getStyleValue("subMenuXOffset")));
            _loc6_.setStyle("yOffset",Number(getStyleValue("subMenuYOffset")));
            _loc6_.setStyle("leftMargin",Number(getStyleValue("menuLeftMargin")));
            _loc6_.setStyle("rightMargin",Number(getStyleValue("menuRightMargin")));
            _loc6_.setStyle("topMargin",Number(getStyleValue("menuTopMargin")));
            _loc6_.setStyle("bottomMargin",Number(getStyleValue("menuBottomMargin")));
            _loc6_.name = _loc5_;
            _loc6_.labelField = labelField;
            _loc6_.closeOnMouseLeave = closeMenuOnMouseLeave;
            _loc6_.addEventListener(MenuEvent.MENU_HIDE,clearSelected);
            _loc6_.addEventListener(MenuEvent.ITEM_CLICK,dispatchMenuEvents);
            _loc6_.addEventListener(MenuEvent.MENU_HIDE,dispatchMenuEvents);
            _loc6_.addEventListener(MenuEvent.MENU_SHOW,dispatchMenuEvents);
            _menus.push(_loc6_);
         }
         _buttonRow.dataProvider = new DataProvider(_loc2_);
      }
      
      protected function dispatchMenuEvents(param1:MenuEvent) : void
      {
         dispatchEvent(param1 as MenuEvent);
      }
      
      public function get buttons() : Array
      {
         return _buttonRow.buttons;
      }
      
      protected function itemRollOverHandler(param1:MenuButtonRowEvent) : void
      {
         var _loc2_:MenuButton = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.item as MenuButton;
         _loc3_ = param1.index;
         _loc4_ = int(_buttonRow.buttons.indexOf(_loc2_));
         if(_loc4_ != _loc3_ && _loc3_ != -1)
         {
            _menus[_loc3_].hide(false);
            _buttonRow.selectedIndex = _loc4_;
            _menus[_loc4_].show(_loc2_.x + Number(getStyleValue("xOffset")),_loc2_.y + _loc2_.height + Number(getStyleValue("yOffset")));
         }
      }
      
      override protected function initializeAccessibility() : void
      {
         if(MenuBar.createAccessibilityImplementation != null)
         {
            MenuBar.createAccessibilityImplementation(this);
         }
      }
      
      protected function copyRendererStylesToChild(param1:UIComponent, param2:Object) : void
      {
         var _loc3_:String = null;
         for(_loc3_ in param2)
         {
            (param1 as IRendererContainer).setRendererStyle(_loc3_,param2[_loc3_]);
         }
      }
      
      public function get dataProvider() : DataProvider
      {
         return _dataProvider;
      }
   }
}

