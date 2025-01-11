package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import bs.gui.item.CustomListCell;
   import bs.gui.item.SliderBox;
   import bs.manager.Data;
   import bs.manager.Thumbnail;
   import bs.utils.KeyboardHandler;
   import fl.controls.BaseButton;
   import fl.controls.Button;
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import ion.components.controls.IToolTip;
   import ion.geom.ColorMatrix;
   import maplestory.display.maple.AssetMaple;
   
   public class Inventory extends WindowBase
   {
      private var assetReference:*;
      
      private var sliderBox:SliderBox;
      
      private var list:List;
      
      private var data:DataProvider;
      
      private var _colorMatrix:ColorMatrix;
      
      private var _removedItemID:String;
      
      private var _previousSelectedIndex:String;
      
      public function Inventory()
      {
         var _loc2_:Button = null;
         super();
         resizeWindow(150,180);
         this._colorMatrix = new ColorMatrix();
         this.sliderBox = new SliderBox();
         this.data = new DataProvider();
         this.list = new List();
         var _loc1_:Button = new Button();
         _loc2_ = new Button();
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215);
         _loc3_.graphics.lineStyle(0,9539985);
         _loc3_.graphics.drawRect(0,0,10,10);
         _loc3_.graphics.endFill();
         this.list.rowHeight = 38;
         this.list.setStyle("cellRenderer",CustomListCell);
         this.list.setStyle("skin",_loc3_);
         this.list.iconField = "icon";
         this.list.dataProvider = this.data;
         this.list.setSize(150,_height - 20);
         _loc2_.label = "";
         _loc2_.setStyle("icon",InterfaceAssets.removeLayer);
         _loc2_.setSize(20,20);
         _loc1_.label = "";
         _loc1_.setStyle("icon",InterfaceAssets.colorAdjustment);
         _loc1_.setSize(20,20);
         _loc2_.x = this.list.x + this.list.width - _loc2_.width;
         _loc2_.y = this.list.y + this.list.height + 2;
         _loc1_.x = _loc2_.x - _loc1_.width - 2;
         _loc1_.y = _loc2_.y;
         this.sliderBox.x = -6;
         this.sliderBox.y = _height - this.sliderBox.height - 10;
         IToolTip.setTarget(_loc2_,"Remove Selected Item from Inventory");
         IToolTip.setTarget(_loc1_,"Aply color filters to the selected item");
         this.list.addEventListener(InterfaceEvent.CUSTOM_CELL_VISIBLE,this.cellVisibleClick);
         this.list.addEventListener(Event.CHANGE,this.listChange);
         _loc2_.addEventListener(MouseEvent.CLICK,this.removeLayerClick);
         _loc1_.addEventListener(MouseEvent.CLICK,this.editColorClick);
         this.sliderBox.addEventListener(InterfaceEvent.ITEM_COLOR,this.colorChange);
         this.sliderBox.addEventListener(InterfaceEvent.ITEM_RESET_COLOR,this.colorReset);
         this.sliderBox.addEventListener(InterfaceEvent.ITEM_CLIENT_CHANGE,this.clientChange);
         this.addEventListener(MouseEvent.MOUSE_UP,this.removeFocus);
         this.addChild(this.list);
         this.addChild(_loc2_);
         this.addChild(_loc1_);
         this.addChild(this.sliderBox);
      }
      
      public function updateInventory(param1:*) : void
      {
         this.assetReference = param1;
         this.sliderBox.reset();
         this.removeAll();
         if(!(this.assetReference is AssetMaple))
         {
            this.assetReference = null;
            this.editColorClick();
            return;
         }
         var _loc3_:XMLList = param1.urlIDs;
      }
      
      private function removeFocus(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton || param1.target is TextField)
         {
            return;
         }
         stage.focus = null;
         KeyboardHandler.canContinue = true;
      }
      
      private function listChange(param1:Event = null) : void
      {
         var url:String;
         var obj:Object;
         var e:Event = param1;
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         url = this.list.selectedItem.data;
         obj = this.assetReference.itemColorMatrixCache[url];
         this.sliderBox.clientReference(url,this.assetReference.urlIDs.(@url == url)[0].@c);
         this._previousSelectedIndex = url;
         if(obj == null)
         {
            this.sliderBox.cBrightness = 0;
            this.sliderBox.cContrast = 0;
            this.sliderBox.cSaturation = 0;
            this.sliderBox.cHue = 0;
            this.sliderBox.cAlpha = 1;
         }
         else
         {
            this.sliderBox.cBrightness = obj.brightness;
            this.sliderBox.cContrast = obj.contrast;
            this.sliderBox.cSaturation = obj.saturation;
            this.sliderBox.cHue = obj.hue;
            this.sliderBox.cAlpha = obj.alpha;
         }
      }
      
      private function colorChange(param1:Event = null) : void
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         this._colorMatrix.reset();
         this._colorMatrix.adjustColor(this.sliderBox.cBrightness,this.sliderBox.cContrast,this.sliderBox.cSaturation,this.sliderBox.cHue,this.sliderBox.cAlpha);
         this.list.selectedItem.icon.filters = [new ColorMatrixFilter(this._colorMatrix.matrix)];
         this.dispatchEvent(new Event(InterfaceEvent.ITEM_COLOR));
      }
      
      private function editColorClick(param1:MouseEvent = null) : void
      {
         if(this.sliderBox.isOpen)
         {
            this.sliderBox.close();
         }
         else
         {
            if(this.assetReference == null || this.data.length == 0 || this.list.selectedIndex == -1)
            {
               return;
            }
            this.sliderBox.open();
         }
      }
      
      private function cellVisibleClick(param1:Event) : void
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         this.data.getItemAt(this.list.selectedIndex).layerVisible = param1.target.layerVisible;
         this.dispatchEvent(new Event(InterfaceEvent.ITEM_VISIBLE));
      }
      
      private function removeLayerClick(param1:MouseEvent) : void
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         this._removedItemID = this.data.removeItemAt(_loc2_).data;
         if(_loc2_ + 1 > this.data.length)
         {
            this.list.selectedIndex = this.data.length - 1;
         }
         else
         {
            this.list.selectedIndex = _loc2_;
         }
         if(this.data.length == 0)
         {
            this.editColorClick();
         }
         this.listChange();
         this.dispatchEvent(new Event(InterfaceEvent.ITEM_REMOVED));
      }
      
      private function colorReset(param1:Event) : void
      {
         this.colorChange();
      }
      
      private function clientChange(param1:Event) : void
      {
         this._previousSelectedIndex = this.list.selectedItem.data;
      }
      
      private function addListItem(param1:XML) : void
      {
         var _loc2_:String = param1.@url;
         var _loc3_:String = Data.getName(_loc2_);
         if(_loc2_.indexOf("/Hair/") != -1)
         {
            if(_loc3_.indexOf("Black ") == 0)
            {
               _loc3_ = _loc3_.split("Black ")[1];
            }
         }
         var _loc4_:Bitmap = new Bitmap(this.prepareIcon(Thumbnail.getThumbnailSafeUrl(_loc2_)));
         var _loc5_:Object = this.assetReference.itemColorMatrixCache[_loc2_];
         if(_loc5_ != null)
         {
            this._colorMatrix.reset();
            this._colorMatrix.adjustColor(_loc5_.brightness,_loc5_.contrast,_loc5_.saturation,_loc5_.hue,_loc5_.alpha);
            _loc4_.filters = [new ColorMatrixFilter(this._colorMatrix.matrix)];
         }
         this.data.addItem({
            "label":_loc3_,
            "icon":_loc4_,
            "data":_loc2_,
            "layerVisible":String(param1.@v) == "1"
         });
      }
      
      private function prepareIcon(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = new BitmapData(32,32,true,0);
         var _loc3_:BitmapData = Thumbnail.getThumbnail(param1);
         var _loc4_:Matrix = new Matrix();
         var _loc5_:Number = 1;
         if(_loc3_.width > _loc3_.height)
         {
            if(_loc3_.width > _loc2_.width)
            {
               _loc5_ = _loc2_.width / _loc3_.width;
            }
         }
         else if(_loc3_.height > _loc2_.height)
         {
            _loc5_ = _loc2_.height / _loc3_.height;
         }
         _loc4_.a = _loc5_;
         _loc4_.d = _loc5_;
         _loc4_.tx = Math.floor((_loc2_.width - _loc3_.width * _loc5_) / 2);
         _loc4_.ty = Math.floor((_loc2_.height - _loc3_.height * _loc5_) / 2);
         _loc2_.draw(_loc3_,_loc4_);
         return _loc2_;
      }
      
      private function removeAll() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(this.data.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            Thumbnail.removeThumbnail(this.data.getItemAt(_loc2_).data);
            _loc2_++;
         }
         this.data.removeAll();
      }
      
      public function get selectedGameClient() : String
      {
         return this.sliderBox.selectedGameClient;
      }
      
      public function get colorMatrix() : ColorMatrix
      {
         return this._colorMatrix.clone();
      }
      
      public function get selectedLayerVisible() : Boolean
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return false;
         }
         return this.list.selectedItem.layerVisible;
      }
      
      public function set selectedLayerVisible(param1:Boolean) : void
      {
         if(this.data.length == 0 || this.list.selectedItem == null)
         {
            return;
         }
         this.list.selectedItem.layerVisible = param1;
         var _loc2_:CustomListCell = this.list.itemToCellRenderer(this.list.selectedItem) as CustomListCell;
         if(_loc2_ != null)
         {
            _loc2_.layerVisible = param1;
         }
      }
      
      public function get removedItemID() : String
      {
         return this._removedItemID;
      }
      
      public function get selectedItemID() : String
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return "";
         }
         return this.list.selectedItem.data;
      }
   }
}

