package com.yahoo.astra.fl.controls.menuBarClasses
{
   import com.yahoo.astra.fl.containers.IRendererContainer;
   import com.yahoo.astra.fl.controls.AbstractButtonRow;
   import com.yahoo.astra.fl.events.MenuButtonRowEvent;
   import com.yahoo.astra.fl.utils.UIComponentUtil;
   import com.yahoo.astra.utils.InstanceFactory;
   import fl.controls.Button;
   import fl.core.InvalidationType;
   import fl.core.UIComponent;
   import fl.managers.IFocusManagerComponent;
   import flash.display.DisplayObject;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class MenuButtonRow extends AbstractButtonRow implements IRendererContainer, IFocusManagerComponent
   {
      public static var createAccessibilityImplementation:Function;
      
      protected static const MENU_BUTTON_STYLES:Object = {
         "embedFonts":"embedFonts",
         "disabledTextFormat":"disabledTextFormat",
         "textFormat":"textFormat",
         "textPadding":"textPadding"
      };
      
      private static var defaultStyles:Object = {"skin":"MenuBar_background"};
      
      protected var _autoSizeButtonsToTextWidth:Boolean = true;
      
      protected var _skin:DisplayObject;
      
      private var menuButtonStyles:Object = {};
      
      public function MenuButtonRow(param1:Object = null)
      {
         super();
         tabEnabled = false;
         _focusIndex = -1;
         _selectedIndex = -1;
         if(param1 != null)
         {
            param1.addChild(this);
         }
         this.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,keyFocusChangeHandler);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,navigationKeyDownHandler,false,0,true);
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles;
      }
      
      override protected function getButton() : Button
      {
         var _loc1_:MenuButton = null;
         if(this._cachedButtons.length > 0)
         {
            _loc1_ = this._cachedButtons.shift() as MenuButton;
         }
         else
         {
            _loc1_ = new MenuButton();
            _loc1_.toggle = false;
            _loc1_.tabEnabled = false;
            this.addChild(_loc1_);
         }
         _loc1_.width = NaN;
         return _loc1_;
      }
      
      protected function keyFocusChangeHandler(param1:FocusEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB)
         {
            param1.preventDefault();
            param1.stopPropagation();
         }
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
      
      public function get autoSizeButtonsToTextWidth() : Boolean
      {
         return _autoSizeButtonsToTextWidth;
      }
      
      override protected function copyStylesToChild(param1:UIComponent, param2:Object) : void
      {
         var _loc3_:String = null;
         for(_loc3_ in param2)
         {
            param1.setStyle(_loc3_,param2[_loc3_]);
         }
      }
      
      protected function incrementSelection(param1:int = 1) : void
      {
         var _loc2_:int = 0;
         _loc2_ = _selectedIndex + param1;
         if(_loc2_ < 0)
         {
            _loc2_ = int(_buttons.length - 1);
         }
         if(_loc2_ > _buttons.length - 1)
         {
            _loc2_ = 0;
         }
         if(_buttons[_loc2_].enabled)
         {
            _buttons[_loc2_].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         }
         else if(param1 < 0)
         {
            incrementSelection(param1 - 1);
         }
         else
         {
            incrementSelection(param1 + 1);
         }
      }
      
      protected function buttonUpHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new MenuButtonRowEvent(MenuButtonRowEvent.ITEM_UP,false,false,selectedIndex,param1.currentTarget,param1.currentTarget.label));
      }
      
      public function set autoSizeButtonsToTextWidth(param1:Boolean) : void
      {
         _autoSizeButtonsToTextWidth = param1;
         if(dataProvider != null && dataProvider.length > 0)
         {
            invalidate();
         }
      }
      
      override protected function clearCache() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MenuButton = null;
         _loc1_ = int(this._cachedButtons.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._cachedButtons.pop() as MenuButton;
            _loc3_.removeEventListener(MouseEvent.ROLL_OVER,buttonRollOverHandler);
            _loc3_.removeEventListener(MouseEvent.MOUSE_DOWN,buttonDownHandler);
            _loc3_.removeEventListener(MouseEvent.MOUSE_UP,buttonUpHandler);
            this.removeChild(_loc3_);
            _loc2_++;
         }
      }
      
      override protected function configUI() : void
      {
         _skin = getDisplayObjectInstance(getStyleValue("skin"));
         this.addChildAt(_skin,0);
      }
      
      public function setRendererStyle(param1:String, param2:Object, param3:uint = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(menuButtonStyles[param1] == param2)
         {
            return;
         }
         menuButtonStyles[param1] = param2;
         if(this.buttons != null && this.buttons.length > 0)
         {
            _loc4_ = int(this.buttons.length);
            _loc5_ = 0;
            while(_loc5_ < this.buttons.length)
            {
               this.buttons[_loc5_].setStyle(param1,param2);
               _loc5_++;
            }
         }
      }
      
      public function get buttons() : Array
      {
         return _buttons;
      }
      
      protected function buttonRollOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new MenuButtonRowEvent(MenuButtonRowEvent.ITEM_ROLL_OVER,false,false,selectedIndex,param1.currentTarget,param1.currentTarget.label));
      }
      
      override protected function drawBackground() : void
      {
         if(_skin != this.getDisplayObjectInstance(getStyleValue("skin")))
         {
            if(this.getChildAt(0) == _skin)
            {
               this.removeChildAt(0);
            }
            _skin = getDisplayObjectInstance(getStyleValue("skin"));
            this.addChildAt(_skin,0);
         }
         if(_skin != null)
         {
            _skin.width = this.width;
            _skin.height = this.height;
         }
      }
      
      override protected function drawButtons() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MenuButton = null;
         var _loc6_:Object = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         _loc1_ = 0;
         _loc2_ = 0;
         _loc3_ = int(_dataProvider.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.getButton() as MenuButton;
            _loc5_.rightButton = _loc4_ == _loc3_ - 1 && _loc4_ != 0;
            _loc5_.leftButton = _loc4_ == 0 && _loc3_ > 1;
            _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,buttonDownHandler,false,0,true);
            _loc5_.addEventListener(MouseEvent.ROLL_OVER,buttonRollOverHandler,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_UP,buttonUpHandler,false,0,true);
            this._buttons.push(_loc5_);
            this.copyStylesToChild(_loc5_,menuButtonStyles);
            _loc6_ = this._dataProvider.getItemAt(_loc4_);
            _loc5_.label = this.itemToLabel(_loc6_);
            if(_loc6_.hasOwnProperty("enabled"))
            {
               _loc5_.enabled = _loc6_.enabled == "true" ? true : false;
            }
            _loc5_.selected = this._selectedIndex == _loc4_;
            if(_loc4_ == this._selectedIndex)
            {
               _loc5_.setMouseState("down");
            }
            else if(_loc4_ == this._focusIndex)
            {
               _loc5_.setMouseState("over");
            }
            else
            {
               _loc5_.setMouseState("up");
            }
            _loc5_.x = _loc1_;
            _loc5_.y = _loc2_;
            _loc5_.height = this.height;
            _loc5_.drawNow();
            _loc1_ += _loc5_.width;
            _loc4_++;
         }
         if(autoSizeButtonsToTextWidth)
         {
            this.width = _loc1_;
         }
         else if(this.width < _loc1_)
         {
            _loc7_ = _loc1_;
            _loc1_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _buttons[_loc8_].width = this.width * (_buttons[_loc8_].width / _loc7_);
               _buttons[_loc8_].x = _loc1_;
               _buttons[_loc8_].drawNow();
               _loc1_ += _buttons[_loc8_].width;
               _loc8_++;
            }
         }
      }
      
      override protected function initializeAccessibility() : void
      {
         if(MenuButtonRow.createAccessibilityImplementation != null)
         {
            MenuButtonRow.createAccessibilityImplementation(this);
         }
      }
      
      override protected function navigationKeyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(_buttons.length - 1);
         if(_selectedIndex > -1 && _loc2_ > -1)
         {
            switch(param1.keyCode)
            {
               case Keyboard.RIGHT:
                  if(_loc2_ == 0)
                  {
                     _buttons[_selectedIndex].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
                  }
                  incrementSelection(1);
                  break;
               case Keyboard.LEFT:
                  if(_loc2_ == 0)
                  {
                     _buttons[_selectedIndex].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
                  }
                  incrementSelection(-1);
            }
         }
         param1.updateAfterEvent();
      }
      
      protected function buttonDownHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new MenuButtonRowEvent(MenuButtonRowEvent.ITEM_DOWN,false,false,selectedIndex,param1.currentTarget,param1.currentTarget.label));
      }
   }
}

