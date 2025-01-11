package maplestory.display.core
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import maplestory.events.AssetEvent;
   import maplestory.utils.AssetProperties;
   import org.gif.frames.GIFFrame;
   import org.gif.player.GIFPlayer;
   
   public class Picture extends Asset
   {
      private var _animate:Boolean;
      
      private var _frame:int;
      
      private var animTimer:Timer;
      
      private var imageList:Array;
      
      private var image:Bitmap;
      
      private var fileRef:FileReference;
      
      public function Picture()
      {
         super();
         this.image = new Bitmap();
         this.animTimer = new Timer(1);
         this.fileRef = new FileReference();
         this._frame = 0;
         this._animate = false;
         this.imageList = [];
         this.animTimer.addEventListener(TimerEvent.TIMER,this.loopTimer);
         this.fileRef.addEventListener(Event.SELECT,this.browseSelect);
         this.fileRef.addEventListener(Event.COMPLETE,this.browseDone);
         this.addChild(this.image);
      }
      
      public function load(param1:BitmapData = null) : void
      {
         if(param1 == null)
         {
            this.fileRef.browse([new FileFilter("Images (JPG, PNG, GIF)","*.jpg;*.gif;*.png")]);
         }
         else
         {
            this.appendPicture(param1);
            this.draw();
            this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
            this.dispatchEvent(new Event(AssetEvent.ASSET_ITEM_LOADED,true));
         }
      }
      
      public function clone() : *
      {
         var _loc3_:int = 0;
         var _loc1_:Picture = new Picture();
         var _loc2_:int = int(this.imageList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.appendPicture(this.imageList[_loc3_].image.clone(),this.imageList[_loc3_].delay);
            _loc3_++;
         }
         this.cloneCommonProperties(_loc1_);
         _loc1_.draw();
         return _loc1_;
      }
      
      public function getFrameImages(param1:int = -1) : Array
      {
         var _loc4_:int = 0;
         var _loc9_:Rectangle = null;
         var _loc10_:Rectangle = null;
         var _loc11_:BitmapData = null;
         var _loc12_:Matrix = null;
         var _loc2_:int = this.frame;
         var _loc3_:int = this.maxFrames;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 65535;
         var _loc8_:int = 65535;
         if(this.parent == null)
         {
            return null;
         }
         this.frame = 0;
         _loc9_ = this.getBounds(this.parent);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.frame = _loc4_;
            _loc10_ = this.getBounds(this.parent);
            _loc9_ = _loc9_.union(_loc10_);
            if(_loc9_.width > _loc5_)
            {
               _loc5_ = _loc9_.width;
            }
            if(_loc9_.height > _loc6_)
            {
               _loc6_ = _loc9_.height;
            }
            if(_loc10_.x < _loc7_)
            {
               _loc7_ = _loc10_.x;
            }
            if(_loc10_.y < _loc8_)
            {
               _loc8_ = _loc10_.y;
            }
            _loc4_++;
         }
         _loc7_ = this.x - _loc7_;
         _loc8_ = this.y - _loc8_;
         if(_loc5_ <= 0 || _loc6_ <= 0)
         {
            return null;
         }
         var _loc13_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.frame = _loc4_;
            _loc12_ = this.transform.matrix.clone();
            _loc11_ = new BitmapData(_loc5_,_loc6_,param1 <= -1,param1 <= -1 ? 0 : uint(param1));
            _loc12_.tx = _loc7_;
            _loc12_.ty = _loc8_;
            _loc11_.draw(this,_loc12_);
            _loc13_.push({
               "image":_loc11_,
               "delay":this.activeDelay
            });
            _loc4_++;
         }
         this.frame = _loc2_;
         return _loc13_;
      }
      
      override public function getImagePieces() : Array
      {
         var _loc2_:BitmapData = null;
         var _loc1_:Array = [];
         var _loc3_:int = int(this.imageList.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this.imageList[_loc4_].image;
            if(_loc2_ != null)
            {
               _loc1_.push({
                  "image":_loc2_.clone(),
                  "x":0,
                  "y":0
               });
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function getRawData() : ByteArray
      {
         var _loc2_:BitmapData = null;
         var _loc3_:ByteArray = null;
         var _loc1_:ByteArray = new ByteArray();
         var _loc4_:Object = {};
         var _loc5_:Array = [];
         var _loc6_:int = int(this.imageList.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc2_ = this.imageList[_loc7_].image;
            _loc3_ = _loc2_.getPixels(_loc2_.rect);
            _loc5_.push({
               "image":_loc3_,
               "delay":this.imageList[_loc7_].delay,
               "width":_loc2_.width,
               "height":_loc2_.height
            });
            _loc7_++;
         }
         _loc4_.images = _loc5_;
         this.cloneCommonProperties(_loc4_);
         _loc1_.writeObject(_loc4_);
         _loc1_.compress();
         return _loc1_;
      }
      
      override public function setProperties(param1:AssetProperties) : void
      {
         super.setProperties(param1);
         var _loc2_:int = int(param1.images.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.appendPicture(param1.images[_loc3_].image,param1.images[_loc3_].delay);
            _loc3_++;
         }
         this._frame = param1.frame;
         this.animate = param1.animate;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      private function browseSelect(param1:Event) : void
      {
         this.fileRef.load();
      }
      
      private function browseDone(param1:Event) : void
      {
         var _loc2_:GIFPlayer = null;
         var _loc3_:Loader = null;
         if(this.fileRef.type == ".gif")
         {
            _loc2_ = new GIFPlayer();
            _loc2_.addEventListener(Event.COMPLETE,this.externalGIFLoaded);
            _loc2_.loadBytes(this.fileRef.data);
         }
         else
         {
            _loc3_ = new Loader();
            _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.externalImageLoaded);
            _loc3_.loadBytes(this.fileRef.data);
         }
      }
      
      private function externalGIFLoaded(param1:Event) : void
      {
         var _loc4_:GIFFrame = null;
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.externalGIFLoaded);
         var _loc2_:Array = param1.currentTarget.frames;
         var _loc3_:int = int(_loc2_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            if(_loc4_.bitmapData != null)
            {
               this.appendPicture(_loc4_.bitmapData.clone(),_loc4_.delay);
            }
            _loc5_++;
         }
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
         this.dispatchEvent(new Event(AssetEvent.ASSET_ITEM_LOADED,true));
      }
      
      private function externalImageLoaded(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.externalImageLoaded);
         this.appendPicture(param1.currentTarget.loader.content.bitmapData);
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
         this.dispatchEvent(new Event(AssetEvent.ASSET_ITEM_LOADED,true));
      }
      
      private function loopTimer(param1:TimerEvent) : void
      {
         if(this._frame + 1 >= this.imageList.length)
         {
            this._frame = 0;
         }
         else
         {
            ++this._frame;
         }
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.FRAME_CHANGE));
      }
      
      override protected function cloneCommonProperties(param1:*) : void
      {
         super.cloneCommonProperties(param1);
         param1.animate = this._animate;
         param1.frame = this._frame;
      }
      
      private function appendPicture(param1:BitmapData, param2:int = 1) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 <= 0)
         {
            param2 = 1;
         }
         this.imageList.push({
            "image":param1,
            "delay":param2
         });
      }
      
      override protected function draw() : void
      {
         if(this.imageList.length == 0)
         {
            return;
         }
         if(this._frame < 0)
         {
            this._frame = 0;
         }
         if(this._frame > this.imageList.length)
         {
            this._frame = this.imageList.length - 1;
         }
         this.image.bitmapData = this.imageList[this._frame].image;
         this.image.smoothing = !_pixelated;
         this.animTimer.delay = this.imageList[this._frame].delay;
      }
      
      override protected function destroy() : void
      {
         var _loc1_:Object = null;
         this.animTimer.stop();
         this.animTimer.removeEventListener(TimerEvent.TIMER,this.loopTimer);
         while(this.imageList.length > 0)
         {
            _loc1_ = this.imageList.shift();
            if(_loc1_.image != null)
            {
               _loc1_.image.dispose();
            }
         }
         this.image = null;
         this.imageList = null;
         this.animTimer = null;
         colorMatrix = null;
         super.destroy();
      }
      
      public function get maxFrames() : int
      {
         return this.imageList.length;
      }
      
      public function get activeDelay() : int
      {
         if(this.imageList.length == 0)
         {
            return 0;
         }
         return this.imageList[this._frame].delay;
      }
      
      public function set frame(param1:int) : void
      {
         this._frame = param1;
         this.draw();
      }
      
      public function get frame() : int
      {
         return this._frame;
      }
      
      public function set animate(param1:Boolean) : void
      {
         this._animate = param1;
         if(param1)
         {
            this.animTimer.reset();
            this.animTimer.start();
         }
         else
         {
            this.animTimer.stop();
         }
      }
      
      public function get animate() : Boolean
      {
         return this._animate;
      }
   }
}

