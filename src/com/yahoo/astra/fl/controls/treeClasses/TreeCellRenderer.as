package com.yahoo.astra.fl.controls.treeClasses
{
   import com.yahoo.astra.fl.controls.Tree;
   import fl.controls.LabelButton;
   import fl.controls.listClasses.ICellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.events.MouseEvent;
   
   public class TreeCellRenderer extends LabelButton implements ICellRenderer
   {
      private static var defaultStyles:Object = {
         "upSkin":"TreeCellRenderer_upSkin",
         "downSkin":"TreeCellRenderer_downSkin",
         "overSkin":"TreeCellRenderer_overSkin",
         "disabledSkin":"TreeCellRenderer_disabledSkin",
         "selectedDisabledSkin":"TreeCellRenderer_selectedDisabledSkin",
         "selectedUpSkin":"TreeCellRenderer_selectedUpSkin",
         "selectedDownSkin":"TreeCellRenderer_selectedDownSkin",
         "selectedOverSkin":"TreeCellRenderer_selectedOverSkin",
         "closedBranchIcon":"TreeCellRenderer_closedBranchIcon",
         "openBranchIcon":"TreeCellRenderer_openBranchIcon",
         "leafIcon":"TreeCellRenderer_leafIcon",
         "textFormat":null,
         "disabledTextFormat":null,
         "embedFonts":null,
         "textPadding":5,
         "nodeIndent":5,
         "leftMargin":5
      };
      
      protected var _data:Object;
      
      protected var _listData:ListData;
      
      public function TreeCellRenderer()
      {
         super();
         toggle = true;
         focusEnabled = false;
         this.addEventListener(MouseEvent.CLICK,handleClickEvent,false,0,true);
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(defaultStyles,LabelButton.getStyleDefinition());
      }
      
      override protected function toggleSelected(param1:MouseEvent) : void
      {
      }
      
      private function handleClickEvent(param1:MouseEvent) : void
      {
         var _loc2_:TNode = null;
         _loc2_ = data as TNode;
         if(this.icon != null && _loc2_ is BranchNode && this.icon.x <= this.mouseX && this.mouseX <= this.icon.x + this.icon.width && this.icon.y <= this.mouseY && this.mouseY <= this.icon.y + this.icon.height)
         {
            param1.stopImmediatePropagation();
            if(_loc2_.isOpen())
            {
               _loc2_.closeNode();
            }
            else
            {
               _loc2_.openNode();
            }
         }
      }
      
      override public function get selected() : Boolean
      {
         return super.selected;
      }
      
      public function set listData(param1:ListData) : void
      {
         var _loc2_:Tree = null;
         _listData = param1;
         label = _listData.label;
         _loc2_ = _listData.owner as Tree;
         if(data.nodeType == TreeDataProvider.BRANCH_NODE)
         {
            if(data.nodeState == TreeDataProvider.OPEN_NODE)
            {
               if(_loc2_.iconFunction != null)
               {
                  setStyle("icon",_loc2_.iconFunction(data));
               }
               else if(_loc2_.openBranchIconField != null && data[_loc2_.openBranchIconField] != null)
               {
                  setStyle("icon",data[_loc2_.openBranchIconField]);
               }
               else
               {
                  setStyle("icon",getStyleValue("openBranchIcon"));
               }
            }
            else if(_loc2_.iconFunction != null)
            {
               setStyle("icon",_loc2_.iconFunction(data));
            }
            else if(_loc2_.closedBranchIconField != null && data[_loc2_.closedBranchIconField] != null)
            {
               setStyle("icon",data[_loc2_.closedBranchIconField]);
            }
            else
            {
               setStyle("icon",getStyleValue("closedBranchIcon"));
            }
         }
         else if(_loc2_.iconFunction != null)
         {
            setStyle("icon",_loc2_.iconFunction(data));
         }
         else if(_loc2_.openBranchIconField != null && data[_loc2_.leafIconField] != null)
         {
            setStyle("icon",data[_loc2_.leafIconField]);
         }
         else
         {
            setStyle("icon",getStyleValue("leafIcon"));
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
      }
      
      public function get listData() : ListData
      {
         return _listData;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
      }
      
      override protected function drawLayout() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc1_ = Number(getStyleValue("textPadding"));
         _loc2_ = Number(getStyleValue("nodeIndent"));
         _loc3_ = Number(getStyleValue("leftMargin"));
         _loc4_ = 0;
         if(icon != null)
         {
            icon.x = _loc3_ + data.nodeLevel * _loc2_;
            icon.y = Math.round(height - icon.height >> 1);
            _loc4_ = icon.x + icon.width + _loc1_;
         }
         if(label.length > 0)
         {
            textField.visible = true;
            _loc5_ = Math.max(0,width - _loc4_ - _loc1_ * 2);
            textField.width = _loc5_;
            textField.height = textField.textHeight + 4;
            textField.x = _loc4_;
            textField.y = Math.round(height - textField.height >> 1);
         }
         else
         {
            textField.visible = false;
         }
         background.width = width;
         background.height = height;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

