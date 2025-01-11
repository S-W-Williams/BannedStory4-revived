package maplestory.utils
{
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import ion.geom.ColorMatrix;
   import ion.utils.SingleList;
   import maplestory.struct.Types;
   
   public class AssetProperties
   {
      private var _layerName:String;
      
      private var _layerVisible:Boolean;
      
      private var _assetType:int;
      
      private var _assetID:int;
      
      private var _frame:int;
      
      private var _frameFace:int;
      
      private var _state:String;
      
      private var _stateFace:String;
      
      private var _animate:Boolean;
      
      private var _animateFace:Boolean;
      
      private var _pixelated:Boolean;
      
      private var _flatHair:Boolean;
      
      private var _pointedEars:Boolean;
      
      private var _hatExists:Boolean;
      
      private var _headID:int;
      
      private var _text:String;
      
      private var _tileX:int;
      
      private var _tileY:int;
      
      private var _balloonX:Boolean;
      
      private var _balloonY:Boolean;
      
      private var _arrowPercent:Number;
      
      private var _petID:String;
      
      private var _blendMode:String;
      
      private var _transformMatrix:Matrix;
      
      private var _itemColorMatrixCache:Object;
      
      private var _colorMatrix:ColorMatrix;
      
      private var _filters:Array;
      
      private var _structure:XML;
      
      private var _structureFace:XML;
      
      private var _items:Array;
      
      private var _images:Array;
      
      public function AssetProperties()
      {
         super();
         this._items = [];
         this._layerVisible = true;
         this._assetType = Types.ASSET_NONE;
         this._assetID = -1;
         this._frame = 0;
         this._frameFace = 0;
         this._animate = false;
         this._animateFace = false;
         this._pixelated = false;
         this._flatHair = true;
         this._pointedEars = false;
         this._hatExists = false;
         this._headID = 0;
         this._tileX = 1;
         this._tileY = 1;
         this._balloonX = false;
         this._balloonY = false;
         this._arrowPercent = 0;
      }
      
      public function toString() : String
      {
         var _loc2_:String = null;
         var _loc1_:* = "";
         _loc1_ += "layerName: " + this.layerName + "\n";
         _loc1_ += "layerVisible: " + this.layerVisible + "\n";
         _loc1_ += "assetType: " + this.assetType + "\n";
         _loc1_ += "assetID: " + this.assetID + "\n";
         _loc1_ += "frame: " + this.frame + "\n";
         _loc1_ += "frameFace: " + this.frameFace + "\n";
         _loc1_ += "state: " + this.state + "\n";
         _loc1_ += "stateFace: " + this.stateFace + "\n";
         _loc1_ += "animate: " + this.animate + "\n";
         _loc1_ += "animateFace: " + this.animateFace + "\n";
         _loc1_ += "pixelated: " + this.pixelated + "\n";
         _loc1_ += "flatHair: " + this.flatHair + "\n";
         _loc1_ += "pointedEars: " + this.pointedEars + "\n";
         _loc1_ += "hatExists: " + this.hatExists + "\n";
         _loc1_ += "headID: " + this.headID + "\n";
         _loc1_ += "text: " + this.text + "\n";
         _loc1_ += "tileX: " + this.tileX + "\n";
         _loc1_ += "tileY: " + this.tileY + "\n";
         _loc1_ += "balloonX: " + this.balloonX + "\n";
         _loc1_ += "balloonY: " + this.balloonY + "\n";
         _loc1_ += "arrowPercent: " + this.arrowPercent + "\n";
         _loc1_ += "transformMatrix: " + this.transformMatrix + "\n";
         _loc1_ += "itemColorMatrixCache:\n";
         for(_loc2_ in this.itemColorMatrixCache)
         {
            _loc1_ += "\t" + _loc2_ + ": " + this.itemColorMatrixCache[_loc2_] + "\n";
         }
         _loc1_ += "colorMatrix: " + this.colorMatrix + "\n";
         _loc1_ += "filters: " + this.filters + "\n";
         _loc1_ += "structure:\n" + this.structure + "\n";
         _loc1_ += "structureFace:\n " + this.structureFace + "\n";
         _loc1_ += "items: " + this.items + "\n";
         return _loc1_ + ("images: " + this.images + "\n");
      }
      
      public function get petID() : String
      {
         return this._petID;
      }
      
      public function set petID(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._petID = String(param1);
      }
      
      public function get arrowPercent() : Number
      {
         return this._arrowPercent;
      }
      
      public function set arrowPercent(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._arrowPercent = parseFloat(param1);
         this._arrowPercent = isNaN(this._arrowPercent) ? 0 : this._arrowPercent;
         if(this._arrowPercent < 0)
         {
            this._arrowPercent = 0;
         }
      }
      
      public function get balloonY() : Boolean
      {
         return this._balloonY;
      }
      
      public function set balloonY(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._balloonY = param1;
      }
      
      public function get balloonX() : Boolean
      {
         return this._balloonX;
      }
      
      public function set balloonX(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._balloonX = param1;
      }
      
      public function get tileY() : int
      {
         return this._tileY;
      }
      
      public function set tileY(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._tileY = parseInt(param1);
         this._tileY = isNaN(this._tileY) ? 1 : this._tileY;
         if(this._tileY < 1)
         {
            this._tileY = 1;
         }
      }
      
      public function get tileX() : int
      {
         return this._tileX;
      }
      
      public function set tileX(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._tileX = parseInt(param1);
         this._tileX = isNaN(this._tileX) ? 1 : this._tileX;
         if(this._tileX < 1)
         {
            this._tileX = 1;
         }
      }
      
      public function get text() : String
      {
         if(this._text == null)
         {
            this._text = "";
         }
         return this._text;
      }
      
      public function set text(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._text = String(param1);
      }
      
      public function get headID() : int
      {
         return this._headID;
      }
      
      public function set headID(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._headID = parseInt(param1);
         this._headID = isNaN(this._headID) ? 0 : this._headID;
         if(this._headID < 0)
         {
            this._headID = 0;
         }
      }
      
      public function get hatExists() : Boolean
      {
         return this._hatExists;
      }
      
      public function set hatExists(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._hatExists = param1;
      }
      
      public function get flatHair() : Boolean
      {
         return this._flatHair;
      }
      
      public function set flatHair(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._flatHair = param1;
      }
      
      public function get pointedEars() : Boolean
      {
         return this._pointedEars;
      }
      
      public function set pointedEars(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._pointedEars = param1;
      }
      
      public function get pixelated() : Boolean
      {
         return this._pixelated;
      }
      
      public function set pixelated(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._pixelated = param1;
      }
      
      public function get animateFace() : Boolean
      {
         return this._animateFace;
      }
      
      public function set animateFace(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._animateFace = param1;
      }
      
      public function get animate() : Boolean
      {
         return this._animate;
      }
      
      public function set animate(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._animate = param1;
      }
      
      public function get stateFace() : String
      {
         if(this._stateFace == null)
         {
            this._stateFace = "";
         }
         return this._stateFace;
      }
      
      public function set stateFace(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._stateFace = String(param1);
      }
      
      public function get state() : String
      {
         if(this._state == null)
         {
            this._state = "";
         }
         return this._state;
      }
      
      public function set state(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._state = String(param1);
      }
      
      public function get frameFace() : int
      {
         return this._frameFace;
      }
      
      public function set frameFace(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._frameFace = parseInt(param1);
         this._frameFace = isNaN(this._frameFace) ? 0 : this._frameFace;
         if(this._frameFace < 0)
         {
            this._frameFace = 0;
         }
      }
      
      public function get frame() : int
      {
         return this._frame;
      }
      
      public function set frame(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._frame = parseInt(param1);
         this._frame = isNaN(this._frame) ? 0 : this._frame;
         if(this._frame < 0)
         {
            this._frame = 0;
         }
      }
      
      public function get assetID() : int
      {
         return this._assetID;
      }
      
      public function set assetID(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._assetID = parseInt(param1);
         this._assetID = isNaN(this._assetID) ? -1 : this._assetID;
      }
      
      public function get assetType() : int
      {
         return this._assetType;
      }
      
      public function set assetType(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._assetType = parseInt(param1);
         this._assetType = isNaN(this._assetType) ? Types.ASSET_NONE : this._assetType;
      }
      
      public function get layerVisible() : Boolean
      {
         return this._layerVisible;
      }
      
      public function set layerVisible(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._layerVisible = param1;
      }
      
      public function get layerName() : String
      {
         if(this._layerName == null)
         {
            this._layerName = "New Layer";
         }
         return this._layerName;
      }
      
      public function set layerName(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._layerName = String(param1);
      }
      
      public function get blendMode() : String
      {
         if(this._blendMode == null)
         {
            this._blendMode = BlendMode.NORMAL;
         }
         return this._blendMode;
      }
      
      public function set blendMode(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._blendMode = String(param1);
      }
      
      public function get images() : Array
      {
         if(this._images == null)
         {
            this._images = [];
         }
         return this._images;
      }
      
      public function set images(param1:*) : void
      {
         var _loc4_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         if(!(param1 is Array))
         {
            return;
         }
         var _loc2_:Array = param1 as Array;
         var _loc3_:int = int(_loc2_.length);
         this._images = [];
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new BitmapData(_loc2_[_loc5_].width,_loc2_[_loc5_].height,true,0);
            _loc4_.setPixels(_loc4_.rect,_loc2_[_loc5_].image);
            this._images.push({
               "image":_loc4_,
               "delay":_loc2_[_loc5_].delay
            });
            _loc5_++;
         }
      }
      
      public function get transformMatrix() : Matrix
      {
         if(this._transformMatrix == null)
         {
            this._transformMatrix = new Matrix();
         }
         return this._transformMatrix;
      }
      
      public function set transformMatrix(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is Matrix)
         {
            this._transformMatrix = (param1 as Matrix).clone();
         }
         else
         {
            this._transformMatrix = new Matrix();
            this._transformMatrix.a = param1.a;
            this._transformMatrix.b = param1.b;
            this._transformMatrix.c = param1.c;
            this._transformMatrix.d = param1.d;
            this._transformMatrix.tx = param1.tx;
            this._transformMatrix.ty = param1.ty;
         }
      }
      
      public function get itemColorMatrixCache() : Object
      {
         if(this._itemColorMatrixCache == null)
         {
            this._itemColorMatrixCache = {};
         }
         return this._itemColorMatrixCache;
      }
      
      public function set itemColorMatrixCache(param1:*) : void
      {
         var _loc2_:ColorMatrix = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         if(param1 == null)
         {
            return;
         }
         this._itemColorMatrixCache = {};
         for(_loc4_ in param1)
         {
            _loc2_ = new ColorMatrix();
            _loc3_ = param1[_loc4_];
            _loc3_.brightness = isNaN(_loc3_.brightness) ? 0 : _loc3_.brightness;
            _loc3_.contrast = isNaN(_loc3_.contrast) ? 0 : _loc3_.contrast;
            _loc3_.saturation = isNaN(_loc3_.saturation) ? 0 : _loc3_.saturation;
            _loc3_.hue = isNaN(_loc3_.hue) ? 0 : _loc3_.hue;
            _loc3_.alpha = isNaN(_loc3_.alpha) ? 1 : _loc3_.alpha;
            _loc2_.adjustColor(_loc3_.brightness,_loc3_.contrast,_loc3_.saturation,_loc3_.hue,_loc3_.alpha);
            this._itemColorMatrixCache[_loc4_] = _loc2_;
         }
      }
      
      public function get colorMatrix() : ColorMatrix
      {
         if(this._colorMatrix == null)
         {
            this._colorMatrix = new ColorMatrix();
         }
         return this._colorMatrix;
      }
      
      public function set colorMatrix(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._colorMatrix = new ColorMatrix();
         param1.brightness = isNaN(param1.brightness) ? 0 : param1.brightness;
         param1.contrast = isNaN(param1.contrast) ? 0 : param1.contrast;
         param1.saturation = isNaN(param1.saturation) ? 0 : param1.saturation;
         param1.hue = isNaN(param1.hue) ? 0 : param1.hue;
         param1.alpha = isNaN(param1.alpha) ? 1 : param1.alpha;
         this._colorMatrix.adjustColor(param1.brightness,param1.contrast,param1.saturation,param1.hue,param1.alpha);
      }
      
      public function get filters() : Array
      {
         if(this._filters == null)
         {
            this._filters = [];
         }
         return this._filters;
      }
      
      public function set filters(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         if(param1 == null)
         {
            return;
         }
         if(!(param1 is Array))
         {
            return;
         }
         var _loc2_:Array = param1 as Array;
         var _loc3_:int = int(_loc2_.length);
         this._filters = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = FilterSerializer.unserialize(_loc2_[_loc4_]);
            if(_loc5_ != null)
            {
               this._filters.push(_loc5_);
            }
            _loc4_++;
         }
      }
      
      public function get structure() : XML
      {
         if(this._structure == null)
         {
            this._structure = <i/>;
         }
         return this._structure;
      }
      
      public function set structure(param1:*) : void
      {
         var _loc2_:XMLList = null;
         if(param1 is String)
         {
            this._structure = XML(param1);
            _loc2_ = this._structure.*.*.*;
            this.cleanPathAttributes(_loc2_);
            this._items = this._items.concat(SingleList.singleXMLList(_loc2_.@url));
         }
      }
      
      public function get structureFace() : XML
      {
         if(this._structureFace == null)
         {
            this._structureFace = <i/>;
         }
         return this._structureFace;
      }
      
      public function set structureFace(param1:*) : void
      {
         var _loc2_:XMLList = null;
         if(param1 is String)
         {
            this._structureFace = XML(param1);
            _loc2_ = this._structureFace.*.*.*;
            this.cleanPathAttributes(_loc2_);
            this._items = this._items.concat(SingleList.singleXMLList(_loc2_.@url));
         }
      }
      
      public function get items() : Array
      {
         return this._items;
      }
      
      private function cleanOldPaths(param1:String) : Object
      {
         var _loc2_:Array = param1.split("/");
         var _loc3_:String = _loc2_.pop();
         var _loc4_:String = "";
         if(Types.isWeapon(param1))
         {
            _loc3_ = _loc3_.split("_")[0];
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            switch(_loc2_[_loc5_])
            {
               case "0_jms":
               case "1_cms":
               case "2_gms":
               case "3_msea":
               case "4_tms":
               case "5_thms":
               case "6_ems":
               case "7_kms":
                  _loc4_ = _loc2_.splice(_loc5_,1);
                  _loc4_ = _loc4_.split("_")[0];
                  _loc5_--;
                  break;
            }
            _loc5_++;
         }
         if(_loc3_.substr(-4).toLowerCase() == ".pak")
         {
            _loc3_ = _loc3_.substr(0,-4);
         }
         _loc3_ = _loc3_.split("-")[0];
         _loc2_.push(_loc3_);
         return {
            "url":_loc2_.join("/"),
            "client":_loc4_
         };
      }
      
      private function cleanPathAttributes(param1:XMLList) : void
      {
         var _loc2_:String = null;
         var _loc4_:Object = null;
         var _loc3_:int = int(param1.length());
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = String(param1[_loc5_].@image);
            _loc4_ = this.cleanOldPaths(param1[_loc5_].@url);
            param1[_loc5_].@url = _loc4_.url;
            if(_loc4_.client != "")
            {
               param1[_loc5_].@c = _loc4_.client;
            }
            if(_loc2_.substr(-4) == ".png")
            {
               _loc2_ = _loc2_.substr(0,-4);
            }
            param1[_loc5_].@image = _loc2_;
            _loc5_++;
         }
      }
   }
}

