package com.yahoo.astra.fl.controls.menuClasses
{
   import com.yahoo.astra.fl.controls.Menu;
   import com.yahoo.astra.fl.utils.UIComponentUtil;
   import com.yahoo.astra.utils.InstanceFactory;
   import fl.controls.listClasses.CellRenderer;
   import fl.core.InvalidationType;
   import flash.display.DisplayObject;
   import flash.text.TextFormat;
   
   public class MenuCellRenderer extends CellRenderer
   {
      private static var defaultStyles:Object = {
         "upSkin":"MenuCellRenderer_upSkin",
         "downSkin":"MenuCellRenderer_downSkin",
         "overSkin":"MenuCellRenderer_overSkin",
         "disabledSkin":"MenuCellRenderer_disabledSkin",
         "selectedDisabledSkin":"MenuCellRenderer_selectedDisabledSkin",
         "selectedUpSkin":"MenuCellRenderer_selectedUpSkin",
         "selectedDownSkin":"MenuCellRenderer_selectedDownSkin",
         "selectedOverSkin":"MenuCellRenderer_selectedOverSkin",
         "branchIcon":"MenuBranchIcon",
         "checkIcon":"MenuCheckIcon",
         "radioIcon":"MenuRadioIcon",
         "separatorSkin":"MenuSeparatorSkin",
         "textPadding":3
      };
      
      private var _menu:Menu;
      
      private var _subMenu:Menu;
      
      protected var branchIcon:DisplayObject;
      
      protected var _selectedIcon:DisplayObject;
      
      public function MenuCellRenderer()
      {
         super();
         menu = parent as Menu;
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(defaultStyles,CellRenderer.getStyleDefinition());
      }
      
      protected function getIconDimensions(param1:Number, param2:Number, param3:Number, param4:Number) : Object
      {
         var _loc5_:Object = null;
         _loc5_ = {
            "width":param1,
            "height":param2
         };
         if(param1 > param2)
         {
            if(param1 > param3)
            {
               _loc5_.width = param3;
               _loc5_.height = param2 / param1 * param3;
            }
         }
         else if(param2 > param4)
         {
            _loc5_.height = param4;
            _loc5_.width = param1 / param2 * param4;
         }
         return _loc5_;
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
      
      public function set menu(param1:Menu) : void
      {
         _menu = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         textField.autoSize = "left";
      }
      
      public function get menu() : Menu
      {
         return _menu;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         _data = param1;
         label = _data.label != null ? _data.label : "";
         if(_data.hasOwnProperty("data"))
         {
            _loc2_ = getStyleValue("branchIcon");
            if(_loc2_ != null)
            {
               branchIcon = getDisplayObjectInstance(_loc2_);
            }
            if(branchIcon != null)
            {
               branchIcon.visible = true;
               addChild(branchIcon);
            }
         }
         if(_data.hasOwnProperty("type"))
         {
            _loc3_ = _data.type.toLowerCase();
            if(_loc3_ == "separator")
            {
               label = "";
               enabled = false;
               _loc4_ = getStyleValue("separatorSkin");
               if(_loc4_ != null)
               {
                  icon = getDisplayObjectInstance(_loc4_);
                  addChild(icon);
                  icon.visible = true;
               }
               return;
            }
            if(_loc3_ == "check")
            {
               _loc5_ = getStyleValue("checkIcon");
               if(_loc5_ != null)
               {
                  _selectedIcon = getDisplayObjectInstance(_loc5_);
                  _selectedIcon.visible = false;
                  addChild(_selectedIcon);
               }
            }
            if(_loc3_ == "radio")
            {
               _loc6_ = getStyleValue("radioIcon");
               if(_loc6_ != null)
               {
                  _selectedIcon = getDisplayObjectInstance(_loc6_);
                  _selectedIcon.visible = false;
                  addChild(_selectedIcon);
               }
            }
         }
         if(_data.hasOwnProperty("icon"))
         {
            icon = getDisplayObjectInstance(_data.icon);
            if(icon != null)
            {
               addChild(icon);
               icon.visible = true;
            }
         }
         if(_data.hasOwnProperty("selectedIcon"))
         {
            _selectedIcon = getDisplayObjectInstance(_data.selectedIcon);
            if(_selectedIcon != null)
            {
               _selectedIcon.visible = false;
               addChild(_selectedIcon);
            }
         }
      }
      
      public function set subMenu(param1:Menu) : void
      {
         _subMenu = param1;
      }
      
      override protected function drawLayout() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         _loc1_ = Number(getStyleValue("textPadding"));
         _loc2_ = 0;
         _loc3_ = height / 2;
         _loc4_ = height / 2;
         _loc5_ = width;
         _loc2_ = _loc1_ + _loc3_;
         if(Boolean(data.hasOwnProperty("type")) && data.type.toLowerCase() == "separator")
         {
            icon.width = _loc5_ - 3;
            return;
         }
         if(icon != null)
         {
            _loc6_ = getIconDimensions(icon.width,icon.height,_loc3_,_loc4_);
            icon.height = _loc6_.height;
            icon.width = _loc6_.width;
            icon.x = icon.width < _loc3_ ? Math.round((_loc3_ - icon.width) / 2) + _loc1_ : _loc1_;
            icon.y = Math.round(height - icon.height >> 1);
         }
         if(_selectedIcon != null)
         {
            _loc7_ = getIconDimensions(_selectedIcon.width,_selectedIcon.height,_loc3_,_loc4_);
            _selectedIcon.height = _loc7_.height;
            _selectedIcon.width = _loc7_.width;
            _selectedIcon.x = _selectedIcon.width < _loc3_ ? Math.round((_loc3_ - _selectedIcon.width) / 2) + _loc1_ : _loc1_;
            _selectedIcon.y = Math.round(height - _selectedIcon.height >> 1);
         }
         if(label.length > 0)
         {
            textField.visible = true;
            textField.height = textField.textHeight + 4;
            textField.x = _loc2_ + _loc1_;
            textField.y = Math.round(height - textField.height >> 1);
         }
         else
         {
            textField.visible = false;
         }
         _loc5_ = Math.max(_loc3_ * 2 + textField.textWidth + _loc1_ * 4,width);
         if(branchIcon != null)
         {
            _loc8_ = getIconDimensions(branchIcon.width,branchIcon.height,_loc3_,_loc4_);
            branchIcon.width = _loc8_.width;
            branchIcon.height = _loc8_.height;
            branchIcon.x = _loc5_ - (branchIcon.width + _loc1_);
            branchIcon.y = Math.round(height - branchIcon.height >> 1);
         }
         width = _loc5_;
         background.width = _loc5_;
         background.height = height;
         if(data.hasOwnProperty("enabled"))
         {
            if(!data.enabled is Boolean && data.enabled is String)
            {
               enabled = data.enabled.toLowerCase() == "true";
            }
         }
      }
      
      public function get subMenu() : Menu
      {
         return _subMenu;
      }
      
      override protected function drawIcon() : void
      {
         if(data.hasOwnProperty("selected"))
         {
            if(!data.selected is Boolean && data.selected is String)
            {
               data.selected = data.selected.toLowerCase() == "true";
            }
         }
         else
         {
            data.selected = false;
         }
         if(_selectedIcon != null)
         {
            _selectedIcon.visible = data.selected;
         }
         if(icon != null)
         {
            icon.visible = !data.selected;
         }
      }
   }
}

