package com.yahoo.astra.fl.controls
{
   import com.yahoo.astra.fl.containers.IRendererContainer;
   import com.yahoo.astra.fl.controls.menuClasses.MenuCellRenderer;
   import com.yahoo.astra.fl.data.XMLDataProvider;
   import com.yahoo.astra.fl.events.MenuEvent;
   import com.yahoo.astra.fl.managers.PopUpManager;
   import com.yahoo.astra.fl.utils.UIComponentUtil;
   import com.yahoo.astra.utils.InstanceFactory;
   import fl.containers.BaseScrollPane;
   import fl.controls.List;
   import fl.core.InvalidationType;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import fl.transitions.*;
   import fl.transitions.easing.*;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol191")]
   public class Menu extends List implements IRendererContainer
   {
      public static var createAccessibilityImplementation:Function;
      
      private static var defaultStyles:Object = {
         "skin":"MenuSkin",
         "cellRenderer":MenuCellRenderer,
         "focusRectSkin":null,
         "focusRectPadding":null,
         "contentPadding":null,
         "disabledAlpha":null,
         "leftMargin":0,
         "rightMargin":0,
         "topMargin":0,
         "bottomMargin":0,
         "xOffset":0,
         "yOffset":0
      };
      
      private static var defaultRendererStyles:Object = {};
      
      private var closeTimer:int = 0;
      
      public var specifiedPoint:Point;
      
      public var groups:Object;
      
      private var openSubMenuTimer:int = 0;
      
      public var closeOnMouseLeave:Boolean;
      
      protected var tween:Tween;
      
      private var anchor:String;
      
      protected var _parentMenu:Menu;
      
      private var anchorRow:MenuCellRenderer;
      
      private var anchorIndex:int = -1;
      
      private var subMenu:Menu;
      
      public var parentMenuClickable:Boolean;
      
      private var realParent:DisplayObjectContainer;
      
      public function Menu()
      {
         super();
         visible = false;
         tabEnabled = false;
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
         addEventListener(FocusEvent.KEY_FOCUS_CHANGE,keyFocusChangeHandler);
         addEventListener(MenuEvent.ITEM_ROLL_OVER,itemRollOver);
         addEventListener(MenuEvent.ITEM_ROLL_OUT,itemRollOut);
      }
      
      private static function menuHideHandler(param1:MenuEvent) : void
      {
         var _loc2_:Menu = null;
         _loc2_ = Menu(param1.target);
         if(!param1.isDefaultPrevented() && param1.menu == _loc2_)
         {
            PopUpManager.removePopUp(_loc2_);
            _loc2_.removeEventListener(MenuEvent.MENU_HIDE,menuHideHandler);
         }
      }
      
      public static function popUpMenu(param1:Menu, param2:DisplayObjectContainer, param3:Object = null) : void
      {
         if(!param3)
         {
            param3 = new XML();
         }
         if(param3 is XML)
         {
            param1.dataProvider = new XMLDataProvider(param3);
         }
         else
         {
            param1.dataProvider = new DataProvider(param3);
         }
         param1.invalidateList();
      }
      
      public static function createMenu(param1:DisplayObjectContainer, param2:Object = null) : Menu
      {
         var _loc3_:Menu = null;
         _loc3_ = new Menu();
         _loc3_.realParent = param1;
         popUpMenu(_loc3_,param1,param2);
         return _loc3_;
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(defaultStyles,BaseScrollPane.getStyleDefinition());
      }
      
      protected function keyFocusChangeHandler(param1:FocusEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB)
         {
            hideAllMenus();
         }
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:MenuCellRenderer = null;
         var _loc3_:Object = null;
         var _loc4_:Menu = null;
         var _loc5_:int = 0;
         var _loc6_:Menu = null;
         var _loc7_:Menu = null;
         _loc2_ = selectedIndex < 0 ? null : itemToCellRenderer(dataProvider.getItemAt(selectedIndex)) as MenuCellRenderer;
         _loc3_ = !!_loc2_ ? _loc2_.data.data : null;
         _loc4_ = !!_loc2_ ? MenuCellRenderer(_loc2_).menu : null;
         if(!selectable)
         {
            return;
         }
         switch(param1.keyCode)
         {
            case Keyboard.UP:
            case Keyboard.DOWN:
            case Keyboard.END:
            case Keyboard.HOME:
            case Keyboard.PAGE_UP:
            case Keyboard.PAGE_DOWN:
               moveSelectionVertically(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
               break;
            case Keyboard.LEFT:
               if(parentMenu)
               {
                  parentMenu.selectedIndex = anchorIndex;
                  parentMenu.setFocus();
                  hide();
                  param1.stopPropagation();
               }
               break;
            case Keyboard.RIGHT:
               if(_loc2_)
               {
                  if(_loc3_)
                  {
                     _loc6_ = openSubMenu(_loc2_);
                     _loc6_.selectedIndex = 0;
                     param1.stopPropagation();
                  }
               }
               break;
            case Keyboard.SPACE:
               if(_loc2_)
               {
                  if(_loc3_)
                  {
                     _loc7_ = openSubMenu(_loc2_);
                     _loc7_.selectedIndex = 0;
                     break;
                  }
                  _loc2_.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               }
               break;
            case Keyboard.ENTER:
               if(_loc2_)
               {
                  _loc2_.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               }
               break;
            case Keyboard.ESCAPE:
               hideAllMenus();
               break;
            default:
               _loc5_ = getNextIndexAtLetter(String.fromCharCode(param1.keyCode),selectedIndex);
               if(_loc5_ > -1)
               {
                  selectedIndex = _loc5_;
                  scrollToSelected();
                  break;
               }
         }
      }
      
      public function get subMenus() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:MenuCellRenderer = null;
         var _loc5_:Menu = null;
         _loc1_ = [];
         _loc2_ = 0;
         while(_loc2_ < dataProvider.length)
         {
            _loc3_ = dataProvider.getItemAt(_loc2_);
            if(_loc3_)
            {
               _loc4_ = MenuCellRenderer(itemToCellRenderer(_loc3_));
               if(_loc4_)
               {
                  _loc5_ = _loc4_.subMenu;
                  if(_loc5_)
                  {
                     _loc1_.push(_loc5_);
                  }
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function mouseDownOutsideHandler(param1:MouseEvent) : void
      {
         if(!isMouseOverMenu(param1))
         {
            hide();
         }
      }
      
      override public function set labelField(param1:String) : void
      {
         if(param1.indexOf("@") == 0)
         {
            param1 = param1.slice(1);
         }
         super.labelField = param1;
      }
      
      public function get parentMenu() : Menu
      {
         return _parentMenu;
      }
      
      protected function hideAllMenus() : void
      {
         getRootMenu().hide();
         getRootMenu().deleteDependentSubMenus();
      }
      
      protected function mouseOutsideApplicationHandler(param1:Event) : void
      {
         hide();
      }
      
      public function hide(param1:Boolean = true) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:BlurFilter = null;
         var _loc4_:Array = null;
         var _loc5_:MenuEvent = null;
         if(stage != null)
         {
            stage.removeEventListener(Event.RESIZE,stageResizeHandler);
         }
         if(closeOnMouseLeave)
         {
            stage.removeEventListener(Event.MOUSE_LEAVE,mouseOutsideApplicationHandler);
         }
         if(tween)
         {
            tween.stop();
         }
         if(subMenus.length > 0)
         {
            deleteDependentSubMenus();
         }
         if(param1)
         {
            if(visible)
            {
               _loc2_ = getStyle("openDuration") as Number;
               if(!_loc2_)
               {
                  _loc2_ = 0.125;
               }
               if(filters.length < 1)
               {
                  _loc3_ = new BlurFilter(0,0,1);
                  _loc4_ = [_loc3_];
                  filters = _loc4_;
               }
               tween = new Tween(this,"alpha",Regular.easeOut,1,0,_loc2_,true);
               tween.addEventListener(TweenEvent.MOTION_FINISH,onTweenEnd);
            }
         }
         else
         {
            alpha = 1;
            visible = false;
            stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownOutsideHandler);
            _loc5_ = new MenuEvent(MenuEvent.MENU_HIDE);
            _loc5_.menu = this;
            dispatchEvent(_loc5_);
         }
      }
      
      override public function setRendererStyle(param1:String, param2:Object, param3:uint = 0) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         super.setRendererStyle(param1,param2,param3);
         if(this.subMenus != null && this.subMenus.length > 0)
         {
            _loc4_ = this.subMenus;
            _loc5_ = int(_loc4_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               this.copyRendererStylesToChild(_loc4_[_loc6_],this.rendererStyles);
               _loc6_++;
            }
         }
      }
      
      protected function onTweenEnd(param1:TweenEvent) : void
      {
         var _loc2_:Menu = null;
         var _loc3_:MenuEvent = null;
         _loc2_ = param1.currentTarget.obj as Menu;
         _loc2_.visible = false;
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownOutsideHandler);
         _loc2_.alpha = 1;
         _loc3_ = new MenuEvent(MenuEvent.MENU_HIDE);
         _loc3_.menu = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      protected function stageResizeHandler(param1:Event) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         if(!isNaN(this.stage.stageWidth) && !isNaN(this.stage.stageHeight) && specifiedPoint != null)
         {
            if(visible && !isNaN(width) && !isNaN(specifiedPoint.x) && !isNaN(specifiedPoint.y) && !isNaN(height))
            {
               _loc2_ = new Point(x,y);
               _loc2_ = realParent.localToGlobal(_loc2_);
               _loc3_ = realParent.localToGlobal(specifiedPoint);
               if(_loc2_.x + width > this.stage.stageWidth - Number(getStyleValue("rightMargin")))
               {
                  x = realParent.globalToLocal(new Point(Math.max(this.stage.stageWidth - width - Number(getStyleValue("rightMargin")),Number(getStyleValue("leftMargin"))),0)).x;
               }
               else if(_loc2_.x < _loc3_.x)
               {
                  x = Math.min(realParent.globalToLocal(new Point(this.stage.stageWidth - width - Number(getStyleValue("rightMargin")),0)).x,specifiedPoint.x);
               }
               if(_loc2_.y + height > this.stage.stageHeight - Number(getStyleValue("bottomMargin")))
               {
                  y = Math.max(this.stage.stageHeight - height - Number(getStyleValue("bottomMargin")),getRootMenu().specifiedPoint.y + Number(getStyleValue("topMargin")));
               }
               else if(_loc2_.y < _loc3_.y)
               {
                  y = Math.min(realParent.globalToLocal(new Point(0,this.stage.stageHeight - height - Number(getStyleValue("bottomMargin")))).y,specifiedPoint.y);
               }
            }
         }
      }
      
      protected function openSubMenu(param1:MenuCellRenderer) : Menu
      {
         var _loc2_:Menu = null;
         var _loc3_:Menu = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:Point = null;
         _loc2_ = getRootMenu();
         if(!MenuCellRenderer(param1).menu)
         {
            _loc3_ = Menu.createMenu(_loc2_,param1.data.data);
            this.copyRendererStylesToChild(_loc3_,this.rendererStyles);
            _loc3_.parentMenuClickable = _loc2_.parentMenuClickable;
            _loc3_.setStyle("xOffset",Number(_loc2_.getStyleValue("xOffset")));
            _loc3_.setStyle("yOffset",Number(_loc2_.getStyleValue("yOffset")));
            _loc3_.visible = false;
            _loc3_.parentMenu = this;
            _loc3_.labelField = _loc2_.labelField;
            _loc3_.labelFunction = _loc2_.labelFunction;
            _loc3_.iconField = _loc2_.iconField;
            _loc3_.iconFunction = _loc2_.iconFunction;
            _loc3_.rowHeight = _loc2_.rowHeight;
            _loc3_.setStyle("leftMargin",Number(getStyleValue("leftMargin")));
            _loc3_.setStyle("topMargin",Number(getStyleValue("topMargin")));
            _loc3_.setStyle("rightMargin",Number(getStyleValue("rightMargin")));
            _loc3_.setStyle("bottomMargin",Number(getStyleValue("bottomMargin")));
            _loc3_.anchorRow = param1;
            _loc3_.anchorIndex = param1.listData.index;
            selectedIndex = param1.listData.index;
            param1.subMenu = _loc3_;
            _loc3_.realParent = this.realParent;
         }
         else
         {
            _loc3_ = MenuCellRenderer(param1).menu;
         }
         _loc4_ = DisplayObject(param1);
         _loc5_ = new Point(0,0);
         _loc5_ = _loc4_.localToGlobal(_loc5_);
         if(_loc4_.root)
         {
            _loc5_ = _loc4_.root.globalToLocal(_loc5_);
         }
         _loc3_.specifiedPoint = new Point(specifiedPoint.x + width + Number(getStyleValue("xOffset")),specifiedPoint.y + param1.y + Number(getStyleValue("yOffset")));
         _loc3_.show(_loc3_.specifiedPoint.x,_loc3_.specifiedPoint.y);
         _loc3_.caretIndex = 0;
         return _loc3_;
      }
      
      override public function dispatchEvent(param1:Event) : Boolean
      {
         var _loc2_:MenuEvent = null;
         var _loc3_:MenuEvent = null;
         if(!(param1 is MenuEvent) && param1 is ListEvent && (param1.type == ListEvent.ITEM_ROLL_OUT || param1.type == ListEvent.ITEM_ROLL_OVER))
         {
            param1.stopImmediatePropagation();
            _loc2_ = new MenuEvent(param1.type,param1.bubbles,param1.cancelable,null,this,ListEvent(param1).item,null,itemToLabel(ListEvent(param1).item),ListEvent(param1).index);
            return super.dispatchEvent(_loc2_);
         }
         if(!(param1 is MenuEvent) && param1 is ListEvent && param1.type == ListEvent.ITEM_CLICK)
         {
            param1.stopImmediatePropagation();
            _loc3_ = new MenuEvent(param1.type,param1.bubbles,param1.cancelable,null,this,ListEvent(param1).item,null,itemToLabel(ListEvent(param1).item),ListEvent(param1).index);
            return super.dispatchEvent(_loc3_);
         }
         return super.dispatchEvent(param1);
      }
      
      public function set parentMenu(param1:Menu) : void
      {
         _parentMenu = param1;
      }
      
      protected function deleteDependentSubMenus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Menu = null;
         if(subMenus.length > 0)
         {
            _loc1_ = int(subMenus.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = subMenus[_loc2_] as Menu;
               _loc3_.deleteDependentSubMenus();
               _loc3_.visible = false;
               _loc2_++;
            }
         }
      }
      
      override public function get labelField() : String
      {
         return _labelField;
      }
      
      override public function setStyle(param1:String, param2:Object) : void
      {
         if(instanceStyles[param1] === param2 && !(param2 is TextFormat))
         {
            return;
         }
         if(param2 is InstanceFactory)
         {
            instanceStyles[param1] = UIComponentUtil.getDisplayObjectInstance(this,(param2 as InstanceFactory).createInstance());
         }
         else
         {
            instanceStyles[param1] = param2;
         }
         invalidate(InvalidationType.STYLES);
      }
      
      override protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:MenuCellRenderer = null;
         var _loc9_:MenuCellRenderer = null;
         _loc4_ = Math.max(Math.floor(calculateAvailableHeight() / rowHeight),1);
         _loc5_ = -1;
         _loc6_ = 0;
         switch(param1)
         {
            case Keyboard.UP:
               if(caretIndex > 0)
               {
                  _loc5_ = caretIndex - 1;
                  break;
               }
               _loc5_ = int(length - 1);
               break;
            case Keyboard.DOWN:
               if(caretIndex < length - 1)
               {
                  _loc5_ = caretIndex + 1;
                  break;
               }
               _loc5_ = 0;
               break;
            case Keyboard.PAGE_UP:
               if(caretIndex > 0)
               {
                  _loc5_ = Math.max(caretIndex - _loc4_,0);
               }
               break;
            case Keyboard.PAGE_DOWN:
               if(caretIndex < length - 1)
               {
                  _loc5_ = Math.min(caretIndex + _loc4_,length - 1);
               }
               break;
            case Keyboard.HOME:
               if(caretIndex > 0)
               {
                  _loc5_ = 0;
               }
               break;
            case Keyboard.END:
               if(caretIndex < length - 1)
               {
                  _loc5_ = int(length - 1);
                  break;
               }
         }
         if(_loc5_ >= 0)
         {
            if(caretIndex > -1 && !isNaN(caretIndex))
            {
               _loc9_ = itemToCellRenderer(dataProvider.getItemAt(caretIndex)) as MenuCellRenderer;
               _loc9_.selected = false;
            }
            _loc7_ = dataProvider.getItemAt(_loc5_);
            _loc8_ = itemToCellRenderer(_loc7_) as MenuCellRenderer;
            doKeySelection(_loc5_,param2,param3);
            scrollToSelected();
            if(!_loc8_.enabled)
            {
               moveSelectionVertically(param1,param2,param3);
            }
         }
      }
      
      private function closeSubMenu(param1:Menu) : void
      {
         param1.hide();
         param1.closeTimer = 0;
      }
      
      protected function getRootMenu() : Menu
      {
         var _loc1_:Menu = null;
         _loc1_ = this;
         while(_loc1_.parentMenu)
         {
            _loc1_ = _loc1_.parentMenu;
         }
         return _loc1_;
      }
      
      override protected function handleCellRendererClick(param1:MouseEvent) : void
      {
         var _loc2_:MenuCellRenderer = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:MenuCellRenderer = null;
         _loc2_ = param1.currentTarget as MenuCellRenderer;
         _loc3_ = _loc2_.listData.index;
         if(parentMenuClickable || !_loc2_.data.data)
         {
            if(!getRootMenu().dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK,false,true,null,_loc2_.listData.owner as Menu,_loc2_.data,_loc2_,itemToLabel(_loc2_.data),_loc3_)) || !_selectable)
            {
               return;
            }
            _loc4_ = int(selectedIndices.indexOf(_loc3_));
            _loc2_.selected = true;
            _selectedIndices = [_loc3_];
            lastCaretIndex = caretIndex = _loc3_;
            _loc6_ = _loc2_.data;
            _loc7_ = Boolean(_loc6_.hasOwnProperty("selectedIcon")) || Boolean(_loc6_.hasOwnProperty("type")) && (_loc6_.type.toLowerCase() == "check" || _loc6_.type.toLowerCase() == "radio");
            if(_loc7_)
            {
               if(_loc6_.hasOwnProperty("group"))
               {
                  _loc8_ = groups[_loc6_.group] as Array;
                  _loc9_ = int(_loc8_.length);
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc11_ = _loc8_[_loc10_] as MenuCellRenderer;
                     if(_loc11_ != _loc2_)
                     {
                        _loc11_.data.selected = "false";
                     }
                     _loc10_++;
                  }
               }
               _loc2_.data.selected = !_loc2_.data.selected;
               invalidate();
            }
            hideAllMenus();
            invalidate(InvalidationType.DATA);
         }
      }
      
      public function show(param1:Object = null, param2:Object = null) : void
      {
         var maxW:int = 0;
         var totalHeights:int = 0;
         var n:int = 0;
         var i:int = 0;
         var t:int = 0;
         var menuEvent:MenuEvent = null;
         var pt:Point = null;
         var func:Function = null;
         var item:Object = null;
         var c:MenuCellRenderer = null;
         var w:int = 0;
         var h:int = 0;
         var j:String = null;
         var key:String = null;
         var isArray:Boolean = false;
         var itm:Object = null;
         var r:MenuCellRenderer = null;
         var xShow:Object = param1;
         var yShow:Object = param2;
         if(!parentMenu)
         {
            specifiedPoint = new Point(Number(xShow),Number(yShow));
         }
         if(Boolean(dataProvider) && dataProvider.length == 0)
         {
            return;
         }
         if(parentMenu && !parentMenu.visible && parentMenu.selectedIndex < 0)
         {
            return;
         }
         selectedIndex = caretIndex = 0;
         selectedIndex = caretIndex = -1;
         if(!this.parent && Boolean(realParent))
         {
            PopUpManager.addPopUp(this,realParent);
         }
         else if(parent)
         {
            realParent = parent;
            parent.removeChild(this);
            PopUpManager.addPopUp(this,realParent);
         }
         maxW = 0;
         totalHeights = 0;
         n = int(dataProvider.length);
         rowCount = n;
         drawNow();
         groups = {};
         i = 0;
         while(i < n)
         {
            item = dataProvider.getItemAt(i);
            c = itemToCellRenderer(item) as MenuCellRenderer;
            for(j in item)
            {
               if(j == "group")
               {
                  key = item[j].toString();
                  isArray = groups[key] != null && groups[key] is Array;
                  if(!isArray)
                  {
                     groups[key] = [];
                  }
                  groups[key].push(c);
               }
            }
            if(!c)
            {
               trace(itemToLabel(item) + " couldn\'t be coerced into a MenuCellRenderer");
            }
            w = !!c.width ? int(c.width) : 10;
            h = c.height;
            totalHeights += h;
            if(w > maxW)
            {
               maxW = w;
            }
            i++;
         }
         width = maxW < 10 ? 10 : maxW;
         t = 0;
         while(t < n)
         {
            itm = dataProvider.getItemAt(t);
            r = itemToCellRenderer(itm) as MenuCellRenderer;
            if(!r)
            {
               break;
            }
            r.width = maxW;
            r.drawNow();
            t++;
         }
         addEventListener(MenuEvent.MENU_HIDE,menuHideHandler,false,-50);
         menuEvent = new MenuEvent(MenuEvent.MENU_SHOW);
         menuEvent.menu = this;
         getRootMenu().dispatchEvent(menuEvent);
         if(xShow !== null && !isNaN(Number(xShow)))
         {
            x = Number(xShow);
         }
         if(yShow !== null && !isNaN(Number(yShow)))
         {
            y = Number(yShow);
         }
         visible = true;
         drawNow();
         pt = new Point(x,y);
         pt = realParent.localToGlobal(pt);
         if(pt.x + width > this.stage.stageWidth - Number(getStyleValue("rightMargin")))
         {
            x = realParent.globalToLocal(new Point(Math.max(this.stage.stageWidth - width - Number(getStyleValue("rightMargin")),Number(getStyleValue("leftMargin"))),0)).x;
         }
         if(pt.y + height > this.stage.stageHeight)
         {
            y = realParent.globalToLocal(new Point(0,Math.max(this.stage.stageHeight - height - Number(getStyleValue("bottomMargin")),realParent.y + realParent.height + Number(getStyleValue("topMargin"))))).y;
         }
         stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownOutsideHandler,false,0,true);
         stage.addEventListener(Event.RESIZE,stageResizeHandler,false,0,true);
         if(closeOnMouseLeave)
         {
            stage.addEventListener(Event.MOUSE_LEAVE,mouseOutsideApplicationHandler,false,0,true);
         }
         setFocus();
         func = function():*
         {
            dispatchEvent(new Event(Event.CHANGE));
         };
         callLater(func);
      }
      
      protected function itemRollOut(param1:MenuEvent) : void
      {
         var _loc2_:MenuCellRenderer = null;
         _loc2_ = itemToCellRenderer(param1.item) as MenuCellRenderer;
         if(_loc2_)
         {
            if((!_loc2_.subMenu || !_loc2_.subMenu.visible) && param1.index == selectedIndex)
            {
               selectedIndex = -1;
            }
         }
      }
      
      private function isMouseOverMenu(param1:MouseEvent) : Boolean
      {
         var _loc2_:DisplayObject = null;
         _loc2_ = DisplayObject(param1.target);
         while(_loc2_)
         {
            if(_loc2_ is Menu || _loc2_ == realParent)
            {
               return true;
            }
            _loc2_ = _loc2_.parent;
         }
         return false;
      }
      
      protected function itemRollOver(param1:MenuEvent) : void
      {
         var row:MenuCellRenderer = null;
         var event:MenuEvent = param1;
         deleteDependentSubMenus();
         row = itemToCellRenderer(event.item) as MenuCellRenderer;
         selectedIndex = caretIndex = event.index;
         if(row.data.data)
         {
            if(!row.subMenu || !row.subMenu.visible)
            {
               if(openSubMenuTimer)
               {
                  clearInterval(openSubMenuTimer);
               }
               openSubMenuTimer = setTimeout(function(param1:MenuCellRenderer):void
               {
                  if(mouseX > 0 && mouseX < param1.x + param1.width && mouseY > 0 && mouseY < param1.y + param1.height && visible)
                  {
                     openSubMenu(param1);
                  }
               },175,row);
            }
         }
      }
      
      override public function set dataProvider(param1:DataProvider) : void
      {
         if(param1 is DataProvider || param1 is XMLDataProvider)
         {
            _dataProvider = param1;
            clearSelection();
            invalidateList();
            return;
         }
         throw new TypeError("Error: Type Coercion failed: cannot convert " + param1 + " to fl.data.DataProvider");
      }
      
      override protected function initializeAccessibility() : void
      {
         if(Menu.createAccessibilityImplementation != null)
         {
            Menu.createAccessibilityImplementation(this);
         }
      }
      
      protected function copyRendererStylesToChild(param1:Menu, param2:Object) : void
      {
         var _loc3_:String = null;
         for(_loc3_ in param2)
         {
            param1.setRendererStyle(_loc3_,param2[_loc3_]);
         }
      }
      
      override public function get dataProvider() : DataProvider
      {
         return _dataProvider;
      }
   }
}

