package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import bs.gui.item.CustomListCell;
   import bs.utils.KeyboardHandler;
   import fl.controls.Button;
   import fl.controls.List;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import ion.components.controls.IToolTip;
   import ion.utils.RasterMaker;
   import maplestory.struct.Types;
   
   public class Layer extends WindowBase
   {
      private var data:DataProvider;
      
      private var list:List;
      
      private var layerCounter:int = 0;
      
      private var floatTextFormat:TextFormat;
      
      public var removedLayer:Object;
      
      public function Layer()
      {
         super();
         resizeWindow(150,180);
         this.data = new DataProvider();
         this.list = new List();
         this.floatTextFormat = new TextFormat(InterfaceAssets.pfRondaSeven,8);
         var _loc1_:Button = new Button();
         var _loc2_:Button = new Button();
         var _loc3_:Button = new Button();
         var _loc4_:Button = new Button();
         var _loc5_:Shape = new Shape();
         _loc5_.graphics.beginFill(16777215);
         _loc5_.graphics.lineStyle(0,9539985);
         _loc5_.graphics.drawRect(0,0,10,10);
         _loc5_.graphics.endFill();
         this.list.rowHeight = 50;
         this.list.setStyle("cellRenderer",CustomListCell);
         this.list.setStyle("skin",_loc5_);
         this.list.iconField = "icon";
         this.list.setSize(150,_height - 20);
         _loc1_.setSize(20,20);
         _loc2_.setSize(20,20);
         _loc3_.setSize(20,20);
         _loc4_.setSize(20,20);
         _loc3_.label = "";
         _loc4_.label = "";
         _loc1_.label = "";
         _loc2_.label = "";
         this.list.dataProvider = this.data;
         _loc3_.x = this.list.x;
         _loc3_.y = this.list.y + this.list.height + 2;
         _loc4_.x = _loc3_.x + _loc3_.width + 2;
         _loc4_.y = _loc3_.y;
         _loc2_.x = this.list.x + this.list.width - _loc1_.width;
         _loc2_.y = _loc3_.y;
         _loc1_.x = _loc2_.x - _loc1_.width - 2;
         _loc1_.y = _loc2_.y;
         _loc3_.setStyle("icon",InterfaceAssets.upArrow);
         _loc4_.setStyle("icon",InterfaceAssets.downArrow);
         _loc1_.setStyle("icon",InterfaceAssets.addLayer);
         _loc2_.setStyle("icon",InterfaceAssets.removeLayer);
         IToolTip.setTarget(_loc3_,"Move Layer Up");
         IToolTip.setTarget(_loc4_,"Move Layer Down");
         IToolTip.setTarget(_loc1_,"Add New Layer");
         IToolTip.setTarget(_loc2_,"Remove Layer");
         _loc2_.addEventListener(MouseEvent.CLICK,this.removeLayerClick);
         _loc1_.addEventListener(MouseEvent.CLICK,this.addLayerClick);
         this.list.addEventListener(Event.CHANGE,this.listClick);
         this.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.listDoubleClick);
         this.list.addEventListener(InterfaceEvent.CUSTOM_CELL_VISIBLE,this.cellVisibleClick);
         _loc3_.addEventListener(MouseEvent.CLICK,this.layerUpClick);
         _loc4_.addEventListener(MouseEvent.CLICK,this.layerDownClick);
         this.addEventListener(MouseEvent.MOUSE_UP,this.removeFocus);
         this.addChild(this.list);
         this.addChild(_loc1_);
         this.addChild(_loc2_);
         this.addChild(_loc3_);
         this.addChild(_loc4_);
      }
      
      public function addLayer(param1:Object = null, param2:Object = null, param3:Object = null, param4:Object = null, param5:Object = null) : Object
      {
         var _loc6_:int = this.data.length == 0 || this.list.selectedIndex == -1 ? 0 : this.list.selectedIndex;
         var _loc7_:Bitmap = new Bitmap();
         var _loc8_:Object = {
            "label":"New Layer",
            "icon":_loc7_,
            "layerVisible":true,
            "type":Types.ASSET_NONE,
            "assetID":-1,
            "layerID":this.layerCounter
         };
         ++this.layerCounter;
         if(param1 is String)
         {
            _loc8_.label = param1 as String;
         }
         if(param2 is Boolean)
         {
            _loc8_.layerVisible = param2 as Boolean;
         }
         if(param3 is DisplayObject)
         {
            _loc7_.bitmapData = this.buildLayerIcon(param3);
         }
         if(param4 is Number)
         {
            _loc8_.assetID = param4 as Number;
         }
         if(param5 is Number)
         {
            _loc8_.type = param5 as Number;
         }
         if(param1 == null)
         {
            switch(_loc8_.type)
            {
               case Types.ASSET_CHARACTER:
                  _loc8_.label = "Character Layer";
                  break;
               case Types.ASSET_CHAT_BALLOON:
                  _loc8_.label = "Chat Balloon Layer";
                  break;
               case Types.ASSET_EFFECT:
                  _loc8_.label = "Effect Layer";
                  break;
               case Types.ASSET_ETC:
                  _loc8_.label = "Miscellaneous Layer";
                  break;
               case Types.ASSET_ITEM:
                  _loc8_.label = "Cash Layer";
                  break;
               case Types.ASSET_MAP:
                  _loc8_.label = "Map Layer";
                  break;
               case Types.ASSET_MOB:
                  _loc8_.label = "Mob Layer";
                  break;
               case Types.ASSET_MORPH:
                  _loc8_.label = "Morph Layer";
                  break;
               case Types.ASSET_NAME_TAG:
                  _loc8_.label = "Name Tag Layer";
                  break;
               case Types.ASSET_NPC:
                  _loc8_.label = "NPC Layer";
                  break;
               case Types.ASSET_PET:
                  _loc8_.label = "Pet Layer";
                  break;
               case Types.ASSET_PICTURE:
                  _loc8_.label = "Picture Layer";
                  break;
               case Types.ASSET_SKILL:
                  _loc8_.label = "Skill Layer";
            }
         }
         this.data.addItemAt(_loc8_,_loc6_);
         this.list.selectedIndex = _loc6_;
         return _loc8_;
      }
      
      public function getLayer(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:int = int(this.data.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.data.getItemAt(_loc4_);
            if(_loc3_.layerID == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getLayerByAssetID(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:int = int(this.data.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.data.getItemAt(_loc4_);
            if(_loc3_.assetID == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function setLayer(param1:int, param2:Object = null, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null) : void
      {
         var _loc9_:CustomListCell = null;
         var _loc10_:Object = null;
         var _loc11_:Bitmap = null;
         var _loc7_:Boolean = false;
         var _loc8_:int = int(this.data.length);
         var _loc12_:int = 0;
         while(_loc12_ < _loc8_)
         {
            _loc10_ = this.data.getItemAt(_loc12_);
            if(_loc10_.layerID == param1)
            {
               _loc7_ = true;
               break;
            }
            _loc12_++;
         }
         if(!_loc7_)
         {
            return;
         }
         if(param4 is DisplayObject)
         {
            _loc11_ = _loc10_.icon;
            if(_loc11_.bitmapData != null)
            {
               _loc11_.bitmapData.dispose();
            }
            _loc11_.bitmapData = this.buildLayerIcon(param4);
            this.list.validateNow();
         }
         if(param2 is String)
         {
            _loc10_.label = param2 as String;
            this.list.validateNow();
         }
         if(param3 is Boolean)
         {
            _loc10_.layerVisible = param3 as Boolean;
            _loc9_ = this.list.itemToCellRenderer(_loc10_) as CustomListCell;
            if(_loc9_ != null)
            {
               _loc9_.layerVisible = _loc10_.layerVisible;
            }
         }
         if(param5 is Number)
         {
            _loc10_.assetID = param5 as Number;
         }
         if(param6 is Number)
         {
            _loc10_.type = param6 as Number;
         }
      }
      
      public function setSelectedLayerByLayerID(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:int = int(this.data.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.data.getItemAt(_loc4_);
            if(_loc3_.layerID == param1)
            {
               this.list.selectedIndex = _loc4_;
               if(_loc2_ > 1)
               {
                  this.list.verticalScrollBar.scrollPosition = _loc4_ / (_loc2_ - 1) * this.list.verticalScrollBar.maxScrollPosition;
               }
               return _loc3_;
            }
            _loc4_++;
         }
         this.list.selectedIndex = -1;
         return null;
      }
      
      public function setSelectedLayerByAssetID(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:int = int(this.data.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.data.getItemAt(_loc4_);
            if(_loc3_.assetID == param1)
            {
               this.list.selectedIndex = _loc4_;
               if(_loc2_ > 1)
               {
                  this.list.verticalScrollBar.scrollPosition = _loc4_ / (_loc2_ - 1) * this.list.verticalScrollBar.maxScrollPosition;
               }
               return _loc3_;
            }
            _loc4_++;
         }
         this.list.selectedIndex = -1;
         return null;
      }
      
      public function removeAll() : void
      {
         this.removedLayer = null;
         this.layerCounter = 0;
         while(this.data.length > 0)
         {
            this.data.removeItemAt(0);
         }
      }
      
      public function removeSelected() : void
      {
         this.removeLayerClick();
      }
      
      private function removeFocus(param1:MouseEvent) : void
      {
         stage.focus = null;
         KeyboardHandler.canContinue = true;
      }
      
      private function cellVisibleClick(param1:Event) : void
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         this.data.getItemAt(this.list.selectedIndex).layerVisible = param1.target.layerVisible;
         this.dispatchEvent(new Event(InterfaceEvent.LAYER_VISIBLE));
      }
      
      private function layerUpClick(param1:MouseEvent) : void
      {
         if(this.data.length < 2)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         var _loc3_:int = _loc2_ - 1;
         if(_loc3_ < 0)
         {
            return;
         }
         var _loc4_:Object = this.data.getItemAt(_loc3_);
         this.data.replaceItemAt(this.data.getItemAt(_loc2_),_loc3_);
         this.data.replaceItemAt(_loc4_,_loc2_);
         this.list.selectedIndex = _loc3_;
         this.dispatchEvent(new Event(InterfaceEvent.LAYER_SORT));
      }
      
      private function layerDownClick(param1:MouseEvent) : void
      {
         if(this.data.length < 2)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         var _loc3_:int = _loc2_ + 1;
         if(_loc3_ >= this.data.length)
         {
            return;
         }
         var _loc4_:Object = this.data.getItemAt(_loc3_);
         this.data.replaceItemAt(this.data.getItemAt(_loc2_),_loc3_);
         this.data.replaceItemAt(_loc4_,_loc2_);
         this.list.selectedIndex = _loc3_;
         this.dispatchEvent(new Event(InterfaceEvent.LAYER_SORT));
      }
      
      private function listDoubleClick(param1:ListEvent) : void
      {
         var _loc2_:TextField = new TextField();
         _loc2_.width = this.list.width;
         _loc2_.height = 20;
         _loc2_.border = true;
         _loc2_.background = true;
         _loc2_.type = TextFieldType.INPUT;
         _loc2_.embedFonts = true;
         _loc2_.text = param1.item.label;
         _loc2_.setTextFormat(this.floatTextFormat);
         _loc2_.setSelection(0,_loc2_.text.length);
         stage.focus = _loc2_;
         _loc2_.x = -5;
         _loc2_.y = Math.floor(this.list.mouseY);
         KeyboardHandler.canContinue = false;
         _loc2_.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.textLostFocus);
         _loc2_.addEventListener(KeyboardEvent.KEY_DOWN,this.validateText);
         this.addChild(_loc2_);
      }
      
      private function validateText(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         param1.currentTarget.setTextFormat(this.floatTextFormat);
         if(param1.keyCode == 13)
         {
            _loc2_ = param1.currentTarget.text;
            param1.currentTarget.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.textLostFocus);
            param1.currentTarget.removeEventListener(KeyboardEvent.KEY_DOWN,this.validateText);
            this.removeChild(param1.currentTarget as TextField);
            KeyboardHandler.canContinue = true;
            this.list.selectedItem.label = _loc2_;
            this.list.validateNow();
         }
         else if(param1.keyCode == 27)
         {
            param1.currentTarget.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.textLostFocus);
            param1.currentTarget.removeEventListener(KeyboardEvent.KEY_DOWN,this.validateText);
            this.removeChild(param1.currentTarget as TextField);
            KeyboardHandler.canContinue = true;
         }
      }
      
      private function textLostFocus(param1:FocusEvent) : void
      {
         var _loc2_:String = param1.currentTarget.text;
         param1.currentTarget.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.textLostFocus);
         param1.currentTarget.removeEventListener(KeyboardEvent.KEY_DOWN,this.validateText);
         this.removeChild(param1.currentTarget as TextField);
         KeyboardHandler.canContinue = true;
         this.list.selectedItem.label = _loc2_;
         this.list.validateNow();
      }
      
      private function listClick(param1:Event) : void
      {
         this.dispatchEvent(new Event(InterfaceEvent.LAYER_CHANGE));
      }
      
      private function removeLayerClick(param1:MouseEvent = null) : void
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         this.removedLayer = this.data.removeItemAt(_loc2_);
         if(_loc2_ + 1 > this.data.length)
         {
            this.list.selectedIndex = this.data.length - 1;
         }
         else
         {
            this.list.selectedIndex = _loc2_;
         }
         this.dispatchEvent(new Event(InterfaceEvent.LAYER_REMOVED));
      }
      
      private function addLayerClick(param1:MouseEvent) : void
      {
         this.addLayer();
         this.dispatchEvent(new Event(InterfaceEvent.LAYER_CREATED));
      }
      
      private function buildLayerIcon(param1:*) : BitmapData
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         var _loc3_:int = this.list.rowHeight - 10;
         var _loc4_:Number = _loc3_ / 8;
         var _loc7_:int = 16777215;
         var _loc8_:BitmapData = RasterMaker.raster(param1);
         var _loc9_:BitmapData = new BitmapData(_loc3_,_loc3_,false,0);
         var _loc10_:Rectangle = new Rectangle(0,0,_loc4_,_loc4_);
         _loc11_ = 0;
         while(_loc11_ < 8)
         {
            _loc7_ = _loc7_ == 16777215 ? 15263976 : 16777215;
            _loc12_ = 0;
            while(_loc12_ < 8)
            {
               _loc7_ = _loc7_ == 16777215 ? 15263976 : 16777215;
               _loc10_.x = _loc12_ * _loc4_;
               _loc10_.y = _loc11_ * _loc4_;
               _loc9_.fillRect(_loc10_,_loc7_);
               _loc12_++;
            }
            _loc11_++;
         }
         if(_loc8_ != null)
         {
            _loc13_ = 1;
            if(_loc8_.width > _loc8_.height)
            {
               _loc13_ = (_loc3_ - 6) / _loc8_.width;
            }
            else
            {
               _loc13_ = (_loc3_ - 6) / _loc8_.height;
            }
            _loc13_ = Math.min(_loc13_,1);
            _loc9_.draw(_loc8_,new Matrix(_loc13_,0,0,_loc13_,Math.floor((_loc3_ - _loc8_.width * _loc13_) / 2),Math.floor((_loc3_ - _loc8_.height * _loc13_) / 2)));
         }
         return _loc9_;
      }
      
      public function get layersInfo() : Array
      {
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         var _loc3_:int = int(this.data.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this.data.getItemAt(_loc4_);
            _loc1_.push({
               "layerName":_loc2_.label,
               "layerVisible":_loc2_.layerVisible,
               "assetType":_loc2_.type,
               "assetID":_loc2_.assetID
            });
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function get selectedLayer() : Object
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return null;
         }
         return this.list.selectedItem;
      }
      
      public function get length() : int
      {
         return this.data.length;
      }
      
      public function get orderedAssetIDs() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         var _loc3_:int = int(this.data.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = int(this.data.getItemAt(_loc3_).assetID);
            if(_loc2_ != -1)
            {
               _loc1_.push(_loc2_);
            }
            _loc3_--;
         }
         return _loc1_;
      }
   }
}

