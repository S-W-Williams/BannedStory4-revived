package bs.gui.item
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import fl.controls.Label;
   import fl.controls.Slider;
   import fl.events.SliderEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import ion.utils.RasterMaker;
   
   public class FaceMixerResult extends Sprite
   {
      private var holderRaster:Sprite;
      
      private var holder:Sprite;
      
      private var head:Bitmap;
      
      private var bg:Bitmap;
      
      private var slide:Slider;
      
      private var _zoom:Number = 1;
      
      public var currentPiece:Sprite;
      
      public function FaceMixerResult()
      {
         var _loc2_:Shape = null;
         var _loc3_:Label = null;
         super();
         this.holderRaster = new Sprite();
         this.holder = new Sprite();
         this.bg = new Bitmap(this.buildBG());
         this.head = new InterfaceAssets.faceMixHead();
         this.slide = new Slider();
         var _loc1_:int = this.bg.width / 3 - 1;
         _loc2_ = new Shape();
         _loc3_ = new Label();
         _loc3_.text = "Result";
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(0,0,this.bg.width,this.bg.height);
         _loc2_.graphics.endFill();
         this.slide.minimum = 1;
         this.slide.maximum = 4;
         this.slide.snapInterval = 1;
         this.holder.mask = _loc2_;
         this.head.alpha = 0.5;
         this.slide.width = this.bg.width * 0.9;
         _loc3_.x = 0;
         _loc3_.y = 0;
         this.bg.x = _loc3_.x;
         this.bg.y = _loc3_.y + _loc3_.height;
         _loc2_.x = this.bg.x;
         _loc2_.y = this.bg.y;
         this.slide.x = this.bg.x + Math.floor((this.bg.width - this.slide.width) / 2);
         this.slide.y = this.bg.y + this.bg.height + 12;
         this.slide.addEventListener(SliderEvent.THUMB_DRAG,this.slideChange);
         this.holderRaster.addChild(this.holder);
         this.holderRaster.addChild(_loc2_);
         this.addChild(this.bg);
         this.addChild(this.head);
         this.addChild(this.holderRaster);
         this.addChild(this.slide);
         this.addChild(_loc3_);
         this.zoom = 1;
      }
      
      public function update(param1:Sprite, param2:int) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.pieceMouseDown);
         param1.addEventListener(Event.REMOVED_FROM_STAGE,this.pieceRemoved);
         this.holder.addChildAt(param1,this.holder.numChildren - param2);
         this.zoom = this._zoom;
      }
      
      public function swapIndexes(param1:int, param2:int) : void
      {
         this.holder.swapChildrenAt(param1,param2);
      }
      
      private function pieceRemoved(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN,this.pieceMouseDown);
         param1.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE,this.pieceRemoved);
         if(param1.currentTarget == this.currentPiece)
         {
            this.currentPiece = null;
         }
         this.holder.removeChild(param1.currentTarget as Sprite);
      }
      
      private function pieceMouseDown(param1:MouseEvent) : void
      {
         this.currentPiece = param1.currentTarget as Sprite;
         this.currentPiece.startDrag();
         this.dispatchEvent(new Event(InterfaceEvent.FACE_MIXER_PIECE_CLICK));
      }
      
      private function slideChange(param1:SliderEvent) : void
      {
         this.zoom = param1.currentTarget.value;
      }
      
      private function buildBG() : BitmapData
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 22 * 8;
         var _loc3_:Number = _loc2_ / 8;
         var _loc6_:int = 16777215;
         var _loc7_:BitmapData = new BitmapData(_loc2_,_loc2_,false,0);
         var _loc8_:Rectangle = new Rectangle(0,0,_loc3_,_loc3_);
         _loc9_ = 0;
         while(_loc9_ < 8)
         {
            _loc6_ = _loc6_ == 16777215 ? 15263976 : 16777215;
            _loc10_ = 0;
            while(_loc10_ < 8)
            {
               _loc6_ = _loc6_ == 16777215 ? 15263976 : 16777215;
               _loc8_.x = _loc10_ * _loc3_;
               _loc8_.y = _loc9_ * _loc3_;
               _loc7_.fillRect(_loc8_,_loc6_);
               _loc10_++;
            }
            _loc9_++;
         }
         _loc6_ = 10066329;
         _loc7_.fillRect(new Rectangle(0,0,_loc7_.width,1),_loc6_);
         _loc7_.fillRect(new Rectangle(_loc7_.width - 1,0,1,_loc7_.height),_loc6_);
         _loc7_.fillRect(new Rectangle(0,_loc7_.height - 1,_loc7_.width,1),_loc6_);
         _loc7_.fillRect(new Rectangle(0,0,1,_loc7_.height),_loc6_);
         return _loc7_;
      }
      
      public function getImage() : Object
      {
         var _loc1_:int = this._zoom;
         this.zoom = 1;
         var _loc2_:BitmapData = RasterMaker.raster(this.holderRaster);
         var _loc3_:Rectangle = RasterMaker.getCropBounds(this.holderRaster);
         var _loc4_:Object = {
            "image":null,
            "x":0,
            "y":0
         };
         if(_loc3_ != null)
         {
            _loc4_.image = _loc2_;
            _loc4_.x = _loc3_.x - this.head.x - (23 - 8);
            _loc4_.y = _loc3_.y - this.head.y - (64 - 52);
         }
         this.zoom = _loc1_;
         return _loc4_;
      }
      
      override public function get width() : Number
      {
         return this.bg.width;
      }
      
      override public function get height() : Number
      {
         return this.bg.y + this.bg.height + 30;
      }
      
      public function set zoom(param1:Number) : void
      {
         this._zoom = param1;
         this.slide.value = this._zoom;
         this.holder.scaleX = this._zoom;
         this.holder.scaleY = this._zoom;
         this.head.scaleX = this._zoom;
         this.head.scaleY = this._zoom;
         this.head.x = this.bg.x + Math.floor((this.bg.width - this.head.width) / 2);
         this.head.y = this.bg.y + Math.floor((this.bg.height - this.head.height) / 2);
         this.holder.x = this.head.x;
         this.holder.y = this.head.y;
      }
      
      public function get zoom() : Number
      {
         return this._zoom;
      }
   }
}

