package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import bs.gui.item.CustomListCell;
   import bs.gui.item.FaceMixerOptions;
   import bs.gui.item.FaceMixerResult;
   import bs.manager.Data;
   import bs.manager.Thumbnail;
   import fl.controls.Button;
   import fl.controls.Label;
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import ion.components.controls.IToolTip;
   import ion.crypto.MD5;
   import maplestory.struct.Types;
   
   public class FaceMixer extends WindowBase
   {
      private const dimMinW:int = 150;
      
      private const dimMaxW:int = 600;
      
      private const dimMaxH:int = 245;
      
      private var isLoading:Boolean = false;
      
      private var loadList:XMLList;
      
      private var loadCount:int;
      
      private var loadMax:int;
      
      private var data:DataProvider;
      
      private var btnOk:Button;
      
      private var btnClose:Button;
      
      private var thumbs:FaceMixerThumbs;
      
      private var result:FaceMixerResult;
      
      private var optionsHolder:Sprite;
      
      private var list:List;
      
      private var oldLoadData:XML;
      
      public var customFacePak:ByteArray;
      
      public var customFaceUrl:String;
      
      public function FaceMixer(param1:Sprite)
      {
         var _loc3_:Button = null;
         var _loc4_:Button = null;
         var _loc5_:Button = null;
         var _loc7_:Label = null;
         super();
         resizeWindow(this.dimMinW,this.dimMaxH);
         var _loc2_:Button = new Button();
         _loc3_ = new Button();
         _loc4_ = new Button();
         _loc5_ = new Button();
         var _loc6_:Shape = new Shape();
         _loc7_ = new Label();
         this.btnOk = new Button();
         this.btnClose = new Button();
         this.data = new DataProvider();
         this.optionsHolder = new Sprite();
         this.result = new FaceMixerResult();
         this.thumbs = new FaceMixerThumbs();
         this.list = new List();
         _loc6_.graphics.beginFill(16777215);
         _loc6_.graphics.lineStyle(0,9539985);
         _loc6_.graphics.drawRect(0,0,10,10);
         _loc6_.graphics.endFill();
         this.list.rowHeight = 38;
         this.list.setStyle("cellRenderer",CustomListCell);
         this.list.setStyle("skin",_loc6_);
         this.list.iconField = "icon";
         _loc4_.setSize(20,20);
         _loc5_.setSize(20,20);
         _loc3_.setSize(20,20);
         _loc2_.setSize(20,20);
         this.list.setSize(150,_height - 80);
         _loc7_.setSize(this.list.width,22);
         this.btnClose.setSize(45,20);
         this.btnOk.setSize(45,20);
         _loc3_.setStyle("icon",InterfaceAssets.minus);
         _loc2_.setStyle("icon",InterfaceAssets.plus);
         _loc4_.setStyle("icon",InterfaceAssets.upArrow);
         _loc5_.setStyle("icon",InterfaceAssets.downArrow);
         IToolTip.setTarget(_loc4_,"Move Face Up");
         IToolTip.setTarget(_loc5_,"Move Face Down");
         IToolTip.setTarget(_loc2_,"Add New Face");
         IToolTip.setTarget(_loc3_,"Remove Face");
         _loc4_.label = "";
         _loc5_.label = "";
         _loc3_.label = "";
         _loc2_.label = "";
         this.thumbs.label = "Add Face";
         _loc7_.text = "Selected Faces";
         this.btnOk.label = "Add";
         this.btnClose.label = "Close";
         this.list.dataProvider = this.data;
         this.thumbs.modalTransparency = 0;
         this.thumbs.modal = true;
         this.thumbs.close();
         this.optionsHolder.visible = false;
         this.result.visible = false;
         this.btnOk.visible = false;
         _loc7_.x = 0;
         _loc7_.y = 0;
         this.list.x = _loc7_.x;
         this.list.y = _loc7_.y + _loc7_.height;
         this.optionsHolder.x = this.list.x + this.list.width + 20;
         this.optionsHolder.y = 0;
         _loc3_.x = this.list.x + this.list.width - _loc3_.width;
         _loc3_.y = this.list.y + this.list.height + 2;
         _loc2_.x = _loc3_.x - _loc2_.width - 2;
         _loc2_.y = _loc3_.y;
         _loc4_.x = this.list.x;
         _loc4_.y = this.list.y + this.list.height + 2;
         _loc5_.x = _loc4_.x + _loc4_.width + 2;
         _loc5_.y = _loc4_.y;
         this.result.x = this.dimMaxW - this.result.width;
         this.result.y = 0;
         this.btnOk.y = _height - this.btnOk.height;
         this.btnClose.x = _width - this.btnClose.width;
         this.btnClose.y = this.btnOk.y;
         this.list.addEventListener(Event.CHANGE,this.listChange);
         this.list.addEventListener(InterfaceEvent.CUSTOM_CELL_VISIBLE,this.cellVisibleClick);
         _loc4_.addEventListener(MouseEvent.CLICK,this.layerUpClick);
         _loc5_.addEventListener(MouseEvent.CLICK,this.layerDownClick);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btnAddClick);
         _loc3_.addEventListener(MouseEvent.CLICK,this.btnRemoveClick);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.btnOkClick);
         this.btnClose.addEventListener(MouseEvent.CLICK,this.btnCloseClick);
         this.thumbs.addEventListener(InterfaceEvent.THUMBNAIL_CLICK,this.thumbsClick);
         this.result.addEventListener(InterfaceEvent.FACE_MIXER_PIECE_CLICK,this.pieceClick);
         param1.addChild(this.thumbs);
         this.addChild(_loc2_);
         this.addChild(_loc3_);
         this.addChild(_loc4_);
         this.addChild(_loc5_);
         this.addChild(this.list);
         this.addChild(this.result);
         this.addChild(this.optionsHolder);
         this.addChild(_loc7_);
         this.addChild(this.btnOk);
         this.addChild(this.btnClose);
      }
      
      public function load(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 == this.oldLoadData)
         {
            return;
         }
         this.reset();
         this.oldLoadData = param1;
         this.loadList = param1.*;
         this.loadMax = this.loadList.length();
         this.loadCount = 0;
         this.isLoading = true;
         this.startLoadProcess();
      }
      
      public function reset() : void
      {
         while(this.list.length > 0)
         {
            this.list.selectedIndex = 0;
            this.btnRemoveClick();
         }
         this.result.zoom = 1;
         this.customFaceUrl = "";
         this.customFacePak = null;
         this.oldLoadData = null;
      }
      
      private function cellVisibleClick(param1:Event) : void
      {
         this.data.getItemAt(this.list.selectedIndex).layerVisible = param1.target.layerVisible;
         this.list.selectedItem.options.croppedImage.visible = param1.target.layerVisible;
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
         this.result.swapIndexes(_loc2_,_loc3_);
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
         this.result.swapIndexes(_loc2_,_loc3_);
      }
      
      private function listChange(param1:Event = null) : void
      {
         var _loc3_:FaceMixerOptions = null;
         var _loc2_:int = this.optionsHolder.numChildren;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.optionsHolder.getChildAt(_loc4_) as FaceMixerOptions;
            _loc3_.visible = _loc3_ == this.list.selectedItem.options;
            _loc4_++;
         }
      }
      
      private function faceLoaded(param1:Event) : void
      {
         var _loc2_:FaceMixerOptions = param1.currentTarget as FaceMixerOptions;
         var _loc3_:String = this.thumbs.currentURL;
         var _loc4_:String = Thumbnail.getThumbnailSafeUrl(_loc3_);
         var _loc5_:String = Data.getName(_loc4_);
         var _loc6_:int = this.data.length == 0 || this.list.selectedIndex == -1 ? 0 : this.list.selectedIndex;
         var _loc7_:Bitmap = new Bitmap(this.prepareIcon(_loc4_));
         this.data.addItemAt({
            "label":_loc5_,
            "icon":_loc7_,
            "options":_loc2_,
            "layerVisible":_loc2_.croppedImage.visible
         },_loc6_);
         this.optionsHolder.addChild(_loc2_);
         this.list.selectedIndex = _loc6_;
         this.result.update(_loc2_.croppedImage,_loc6_);
         this.listChange();
         if(this.list.length == 1)
         {
            resizeWindow(this.dimMaxW,this.dimMaxH);
            this.optionsHolder.visible = true;
            this.result.visible = true;
            this.btnOk.visible = true;
            this.btnOk.x = _width - this.btnOk.width;
            this.btnClose.x = this.btnOk.x - this.btnClose.width - 2;
         }
         if(this.isLoading)
         {
            ++this.loadCount;
            this.startLoadProcess();
         }
      }
      
      private function pieceClick(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.list.length)
         {
            if(this.list.getItemAt(_loc2_).options.croppedImage == this.result.currentPiece)
            {
               this.list.selectedIndex = _loc2_;
               this.listChange();
               break;
            }
            _loc2_++;
         }
      }
      
      private function thumbsClick(param1:Event) : void
      {
         this.thumbs.visible = false;
         var _loc2_:FaceMixerOptions = new FaceMixerOptions();
         _loc2_.addEventListener(InterfaceEvent.FACE_MIXER_ITEM_LOADED,this.faceLoaded);
         _loc2_.load(this.thumbs.currentURL);
      }
      
      private function btnAddClick(param1:MouseEvent) : void
      {
         this.thumbs.visible = true;
      }
      
      private function btnRemoveClick(param1:MouseEvent = null) : void
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         var _loc3_:Object = this.data.removeItemAt(_loc2_);
         var _loc4_:FaceMixerOptions = _loc3_.options;
         if(_loc2_ + 1 > this.data.length)
         {
            this.list.selectedIndex = this.data.length - 1;
         }
         else
         {
            this.list.selectedIndex = _loc2_;
         }
         _loc4_.removeEventListener(InterfaceEvent.FACE_MIXER_ITEM_LOADED,this.faceLoaded);
         _loc4_.destroy();
         this.optionsHolder.removeChild(_loc4_);
         this.listChange();
         if(this.list.length <= 0)
         {
            resizeWindow(this.dimMinW,this.dimMaxH);
            this.optionsHolder.visible = false;
            this.result.visible = false;
            this.btnOk.visible = false;
            this.btnClose.x = _width - this.btnClose.width;
         }
      }
      
      private function btnCloseClick(param1:MouseEvent) : void
      {
         this.visible = false;
         this.reset();
      }
      
      private function btnOkClick(param1:MouseEvent) : void
      {
         var _loc13_:* = null;
         var _loc15_:ByteArray = null;
         var _loc2_:Object = this.result.getImage();
         var _loc3_:XML = this.buildFaceMixerData();
         var _loc4_:XML = this.buildAnimData(_loc2_.x,_loc2_.y);
         var _loc5_:XML = <i name="face_mixer"/>;
         var _loc6_:XML = <i name="animation"/>;
         var _loc7_:XML = <i name="images"/>;
         var _loc8_:ByteArray = new ByteArray();
         var _loc9_:ByteArray = new ByteArray();
         var _loc11_:XML = <i name={Types.CUSTOM_FACE_STRING}/>;
         var _loc12_:BitmapData = _loc2_.image;
         XML.prettyPrinting = false;
         _loc5_.appendChild(_loc3_);
         _loc6_.appendChild(_loc4_);
         _loc7_.appendChild(_loc11_);
         if(_loc12_ != null)
         {
            _loc15_ = _loc12_.getPixels(_loc12_.rect);
            _loc15_.compress();
         }
         if(_loc15_ != null)
         {
            _loc11_.appendChild(<i client="99" width={_loc12_.width} height={_loc12_.height} length={_loc15_.length} position={_loc8_.length}/>);
            _loc8_.writeBytes(_loc15_);
            _loc15_.clear();
         }
         _loc13_ = "<i>" + _loc5_.toXMLString() + _loc6_.toXMLString() + _loc7_.toXMLString() + "</i>";
         _loc15_ = new ByteArray();
         _loc15_.writeUTFBytes(_loc13_);
         _loc15_.compress();
         _loc9_.writeUnsignedInt(_loc15_.length);
         _loc9_.writeBytes(_loc15_);
         _loc8_.position = 0;
         _loc9_.writeBytes(_loc8_);
         _loc9_.position = 0;
         this.customFacePak = _loc9_;
         this.customFaceUrl = String(this.customFacePak.length) + String(getTimer()) + String(Math.random()).split(".").join("");
         this.customFaceUrl = Types.CUSTOM_FACE_STRING + "/" + MD5.calculate(this.customFaceUrl) + this.customFaceUrl;
         XML.prettyPrinting = true;
         _loc15_.clear();
         _loc8_.clear();
         if(_loc12_ != null)
         {
            _loc12_.dispose();
         }
         this.dispatchEvent(new Event(InterfaceEvent.FACE_MIXER_DONE));
      }
      
      private function startLoadProcess() : void
      {
         var _loc1_:FaceMixerOptions = null;
         var _loc2_:String = null;
         if(this.loadCount >= this.loadMax)
         {
            this.isLoading = false;
            this.loadList = null;
            this.loadCount = 0;
            this.loadMax = 0;
         }
         else
         {
            _loc1_ = new FaceMixerOptions();
            _loc2_ = this.loadList[this.loadCount].@url;
            this.thumbs.currentURL = _loc2_;
            _loc1_.addEventListener(InterfaceEvent.FACE_MIXER_ITEM_LOADED,this.faceLoaded);
            _loc1_.load(this.loadList[this.loadCount]);
         }
      }
      
      private function buildFaceMixerData() : XML
      {
         var _loc3_:XML = null;
         var _loc4_:Object = null;
         var _loc1_:XML = <i/>;
         var _loc2_:int = int(this.list.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = this.list.getItemAt(_loc5_);
            _loc3_ = _loc4_.options.data;
            _loc3_.@visible = !!_loc4_.options.croppedImage.visible ? "1" : "0";
            _loc1_.appendChild(_loc3_);
            _loc5_++;
         }
         return _loc1_;
      }
      
      private function buildAnimData(param1:int, param2:int) : XML
      {
         return <i client="99">
				<i path="blink.0" image={Types.CUSTOM_FACE_STRING} x={param1} y={param2} z="face"/>
				<i path="blink.1" image={Types.CUSTOM_FACE_STRING} x={param1} y={param2} z="face"/>
				<i path="blink.2" image={Types.CUSTOM_FACE_STRING} x={param1} y={param2} z="face"/>
			</i>;
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
   }
}

