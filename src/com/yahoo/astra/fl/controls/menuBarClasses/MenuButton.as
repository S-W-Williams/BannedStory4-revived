package com.yahoo.astra.fl.controls.menuBarClasses
{
   import com.yahoo.astra.fl.utils.UIComponentUtil;
   import com.yahoo.astra.utils.InstanceFactory;
   import fl.controls.Button;
   import fl.core.InvalidationType;
   import fl.events.ComponentEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class MenuButton extends Button
   {
      private static var defaultStyles:Object = {
         "icon":null,
         "upSkin":"MenuButton_upSkin",
         "downSkin":"MenuButton_downSkin",
         "overSkin":"MenuButton_overSkin",
         "disabledSkin":"MenuButton_disabledSkin",
         "selectedUpSkin":"MenuButton_selectedUpSkin",
         "selectedDownSkin":"MenuButton_selectedUpSkin",
         "selectedOverSkin":"MenuButton_selectedUpSkin",
         "selectedDisabledSkin":"MenuButton_selectedDisabledSkin",
         "left_upSkin":"MenuButtonLeft_upSkin",
         "left_overSkin":"MenuButtonLeft_overSkin",
         "left_downSkin":"MenuButtonLeft_downSkin",
         "right_upSkin":"MenuButtonRight_upSkin",
         "right_overSkin":"MenuButtonRight_overSkin",
         "right_downSkin":"MenuButtonRight_downSkin",
         "focusRectSkin":null,
         "focusRectPadding":null,
         "textFormat":null,
         "disabledTextFormat":null,
         "embedFonts":null,
         "textPadding":10,
         "verticalTextPadding":2
      };
      
      public var leftButton:Boolean = false;
      
      protected var explicitWidth:Number = NaN;
      
      public var rightButton:Boolean = false;
      
      public function MenuButton()
      {
         super();
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles;
      }
      
      override protected function toggleSelected(param1:MouseEvent) : void
      {
         if(!this.selected)
         {
            this.selected = true;
            this.dispatchEvent(new Event(Event.CHANGE));
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
      
      override protected function mouseEventHandler(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            setMouseState("down");
            startPress();
         }
         else if(param1.type == MouseEvent.ROLL_OVER)
         {
            if(_selected)
            {
               setMouseState("down");
            }
            else
            {
               setMouseState("over");
            }
            endPress();
         }
         else if(param1.type == MouseEvent.MOUSE_UP)
         {
            if(_selected)
            {
               setMouseState("down");
            }
            else
            {
               setMouseState("over");
            }
            endPress();
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            if(_selected)
            {
               setMouseState("down");
            }
            else
            {
               setMouseState("up");
            }
            endPress();
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         if(this.textField.text != this._label)
         {
            this.textField.text = this._label;
         }
         if(this.isInvalid(InvalidationType.STYLES))
         {
            _loc1_ = this.getStyleValue("textFormat") as TextFormat;
            if(_loc1_ != null)
            {
               this.textField.setTextFormat(_loc1_);
            }
         }
         if(isNaN(this.explicitWidth))
         {
            super.width = this.textField.width + (this.getStyleValue("textPadding") as Number) * 2;
         }
         else
         {
            super.width = this.explicitWidth;
         }
         this.textField.autoSize = TextFieldAutoSize.NONE;
         super.draw();
      }
      
      override public function set width(param1:Number) : void
      {
         this.explicitWidth = param1;
      }
      
      override protected function drawBackground() : void
      {
         var _loc1_:* = null;
         var _loc2_:DisplayObject = null;
         _loc1_ = enabled ? mouseState : "disabled";
         if(selected)
         {
            _loc1_ = "selected" + _loc1_.substr(0,1).toUpperCase() + _loc1_.substr(1);
         }
         else
         {
            if(rightButton)
            {
               _loc1_ = "right_" + _loc1_;
            }
            if(leftButton)
            {
               _loc1_ = "left_" + _loc1_;
            }
         }
         _loc1_ += "Skin";
         _loc2_ = background;
         background = getDisplayObjectInstance(getStyleValue(_loc1_));
         addChildAt(background,0);
         if(_loc2_ != null && _loc2_ != background)
         {
            removeChild(_loc2_);
         }
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.invalidate(InvalidationType.SIZE);
         this.invalidate(InvalidationType.STYLES);
         this.dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
      }
      
      override public function drawFocus(param1:Boolean) : void
      {
         if(!this.uiFocusRect)
         {
            return;
         }
         super.drawFocus(param1);
      }
   }
}

