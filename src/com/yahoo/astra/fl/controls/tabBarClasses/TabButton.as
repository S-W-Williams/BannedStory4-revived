package com.yahoo.astra.fl.controls.tabBarClasses
{
   import fl.controls.Button;
   import fl.core.InvalidationType;
   import fl.events.ComponentEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class TabButton extends Button
   {
      private static var defaultStyles:Object = {
         "icon":null,
         "upSkin":"Tab_upSkin",
         "downSkin":"Tab_downSkin",
         "overSkin":"Tab_overSkin",
         "disabledSkin":"Tab_disabledSkin",
         "selectedUpSkin":"Tab_selectedUpSkin",
         "selectedDownSkin":"Tab_selectedUpSkin",
         "selectedOverSkin":"Tab_selectedUpSkin",
         "selectedDisabledSkin":"Tab_selectedDisabledSkin",
         "textFormat":null,
         "disabledTextFormat":null,
         "selectedTextFormat":null,
         "embedFonts":null,
         "textPadding":10,
         "verticalTextPadding":2
      };
      
      protected var explicitWidth:Number = NaN;
      
      public function TabButton()
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
            this.invalidate(InvalidationType.STATE);
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      override protected function draw() : void
      {
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         if(this.textField.text != this._label)
         {
            this.textField.text = this._label;
         }
         if(this.isInvalid(InvalidationType.STYLES,InvalidationType.STATE))
         {
            this.drawTextFormat();
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
         if(this.isInvalid(InvalidationType.STYLES,InvalidationType.STATE))
         {
            this.drawBackground();
            this.drawIcon();
            this.invalidate(InvalidationType.SIZE,false);
         }
         if(this.isInvalid(InvalidationType.SIZE))
         {
            this.drawLayout();
         }
         if(this.isInvalid(InvalidationType.SIZE,InvalidationType.STYLES))
         {
            if(Boolean(this.isFocused) && this.focusManager.showFocusIndicator)
            {
               this.drawFocus(true);
            }
         }
         this.validate();
      }
      
      override public function set width(param1:Number) : void
      {
         this.explicitWidth = param1;
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.invalidate(InvalidationType.SIZE);
         this.invalidate(InvalidationType.STYLES);
         this.dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
      }
      
      override protected function drawTextFormat() : void
      {
         var _loc1_:TextFormat = null;
         if(!this.enabled)
         {
            _loc1_ = this.getStyleValue("disabledTextFormat") as TextFormat;
         }
         else if(this.selected)
         {
            _loc1_ = this.getStyleValue("selectedTextFormat") as TextFormat;
         }
         if(!this.selected || !_loc1_)
         {
            _loc1_ = this.getStyleValue("textFormat") as TextFormat;
         }
         this.textField.setTextFormat(_loc1_);
         this.setEmbedFont();
      }
   }
}

