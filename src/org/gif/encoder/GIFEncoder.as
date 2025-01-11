package org.gif.encoder
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class GIFEncoder
   {
      private var width:int;
      
      private var height:int;
      
      private var transparent:* = null;
      
      private var transIndex:int;
      
      private var repeat:int = -1;
      
      private var delay:int = 0;
      
      private var started:Boolean = false;
      
      private var out:ByteArray;
      
      private var image:Bitmap;
      
      private var pixels:ByteArray;
      
      private var indexedPixels:ByteArray;
      
      private var colorDepth:int;
      
      private var colorTab:ByteArray;
      
      private var usedEntry:Array = new Array();
      
      private var palSize:int = 7;
      
      private var dispose:int = -1;
      
      private var closeStream:Boolean = false;
      
      private var firstFrame:Boolean = true;
      
      private var sizeSet:Boolean = false;
      
      private var sample:int = 10;
      
      public function GIFEncoder()
      {
         super();
      }
      
      public function setDelay(param1:int) : void
      {
         this.delay = Math.round(param1 / 10);
      }
      
      public function setDispose(param1:int) : void
      {
         if(param1 >= 0)
         {
            this.dispose = param1;
         }
      }
      
      public function setRepeat(param1:int) : void
      {
         if(param1 >= 0)
         {
            this.repeat = param1;
         }
      }
      
      public function setTransparent(param1:Number) : void
      {
         this.transparent = param1;
      }
      
      public function addFrame(param1:BitmapData) : Boolean
      {
         var ok:Boolean;
         var im:BitmapData = param1;
         if(im == null || !this.started || this.out == null)
         {
            throw new Error("Please call start method before calling addFrame");
         }
         ok = true;
         try
         {
            this.image = new Bitmap(im);
            if(!this.sizeSet)
            {
               this.setSize(this.image.width,this.image.height);
            }
            this.getImagePixels();
            this.analyzePixels();
            if(this.firstFrame)
            {
               this.writeLSD();
               this.writePalette();
               if(this.repeat >= 0)
               {
                  this.writeNetscapeExt();
               }
            }
            this.writeGraphicCtrlExt();
            this.writeImageDesc();
            if(!this.firstFrame)
            {
               this.writePalette();
            }
            this.writePixels();
            this.firstFrame = false;
         }
         catch(e:Error)
         {
            ok = false;
         }
         return ok;
      }
      
      public function finish() : Boolean
      {
         var ok:Boolean;
         if(!this.started)
         {
            return false;
         }
         ok = true;
         this.started = false;
         try
         {
            this.out.writeByte(59);
         }
         catch(e:Error)
         {
            ok = false;
         }
         return ok;
      }
      
      private function reset() : void
      {
         this.transIndex = 0;
         this.image = null;
         this.pixels = null;
         this.indexedPixels = null;
         this.colorTab = null;
         this.closeStream = false;
         this.firstFrame = true;
      }
      
      public function setFrameRate(param1:Number) : void
      {
         if(param1 != 15)
         {
            this.delay = Math.round(100 / param1);
         }
      }
      
      public function setQuality(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         this.sample = param1;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         if(this.started && !this.firstFrame)
         {
            return;
         }
         this.width = param1;
         this.height = param2;
         if(this.width < 1)
         {
            this.width = 320;
         }
         if(this.height < 1)
         {
            this.height = 240;
         }
         this.sizeSet = true;
      }
      
      public function start() : Boolean
      {
         var ok:Boolean;
         this.reset();
         ok = true;
         this.closeStream = false;
         this.out = new ByteArray();
         try
         {
            this.out.writeUTFBytes("GIF89a");
         }
         catch(e:Error)
         {
            ok = false;
         }
         return this.started = ok;
      }
      
      private function analyzePixels() : void
      {
         var _loc6_:int = 0;
         var _loc1_:int = int(this.pixels.length);
         var _loc2_:int = _loc1_ / 3;
         this.indexedPixels = new ByteArray();
         var _loc3_:NeuQuant = new NeuQuant(this.pixels,_loc1_,this.sample);
         this.colorTab = _loc3_.process();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_ = _loc3_.map(this.pixels[_loc4_++] & 0xFF,this.pixels[_loc4_++] & 0xFF,this.pixels[_loc4_++] & 0xFF);
            this.usedEntry[_loc6_] = true;
            this.indexedPixels[_loc5_] = _loc6_;
            _loc5_++;
         }
         this.pixels = null;
         this.colorDepth = 8;
         this.palSize = 7;
         if(this.transparent != null)
         {
            this.transIndex = this.findClosest(this.transparent);
         }
      }
      
      private function findClosest(param1:Number) : int
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(this.colorTab == null)
         {
            return -1;
         }
         var _loc2_:* = (param1 & 0xFF0000) >> 16;
         var _loc3_:* = (param1 & 0xFF00) >> 8;
         var _loc4_:* = param1 & 0xFF;
         var _loc5_:int = 0;
         var _loc6_:int = 256 * 256 * 256;
         var _loc7_:int = int(this.colorTab.length);
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = _loc2_ - (this.colorTab[_loc8_++] & 0xFF);
            _loc10_ = _loc3_ - (this.colorTab[_loc8_++] & 0xFF);
            _loc11_ = _loc4_ - (this.colorTab[_loc8_] & 0xFF);
            _loc12_ = _loc9_ * _loc9_ + _loc10_ * _loc10_ + _loc11_ * _loc11_;
            _loc13_ = _loc8_ / 3;
            if(Boolean(this.usedEntry[_loc13_]) && _loc12_ < _loc6_)
            {
               _loc6_ = _loc12_;
               _loc5_ = _loc13_;
            }
            _loc8_++;
         }
         return _loc5_;
      }
      
      private function getImagePixels() : void
      {
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc1_:int = this.image.width;
         var _loc2_:int = this.image.height;
         this.pixels = new ByteArray();
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc1_)
            {
               _loc6_ = this.image.bitmapData.getPixel(_loc5_,_loc4_);
               this.pixels[_loc3_] = (_loc6_ & 0xFF0000) >> 16;
               _loc3_++;
               this.pixels[_loc3_] = (_loc6_ & 0xFF00) >> 8;
               _loc3_++;
               this.pixels[_loc3_] = _loc6_ & 0xFF;
               _loc3_++;
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      private function writeGraphicCtrlExt() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         this.out.writeByte(33);
         this.out.writeByte(249);
         this.out.writeByte(4);
         if(this.transparent == null)
         {
            _loc1_ = 0;
            _loc2_ = 0;
         }
         else
         {
            _loc1_ = 1;
            _loc2_ = 2;
         }
         if(this.dispose >= 0)
         {
            _loc2_ = this.dispose & 7;
         }
         _loc2_ <<= 2;
         this.out.writeByte(0 | _loc2_ | 0 | _loc1_);
         this.WriteShort(this.delay);
         this.out.writeByte(this.transIndex);
         this.out.writeByte(0);
      }
      
      private function writeImageDesc() : void
      {
         this.out.writeByte(44);
         this.WriteShort(0);
         this.WriteShort(0);
         this.WriteShort(this.width);
         this.WriteShort(this.height);
         if(this.firstFrame)
         {
            this.out.writeByte(0);
         }
         else
         {
            this.out.writeByte(0x80 | 0 | 0 | 0 | this.palSize);
         }
      }
      
      private function writeLSD() : void
      {
         this.WriteShort(this.width);
         this.WriteShort(this.height);
         this.out.writeByte(0x80 | 0x70 | 0 | this.palSize);
         this.out.writeByte(0);
         this.out.writeByte(0);
      }
      
      private function writeNetscapeExt() : void
      {
         this.out.writeByte(33);
         this.out.writeByte(255);
         this.out.writeByte(11);
         this.out.writeUTFBytes("NETSCAPE" + "2.0");
         this.out.writeByte(3);
         this.out.writeByte(1);
         this.WriteShort(this.repeat);
         this.out.writeByte(0);
      }
      
      private function writePalette() : void
      {
         this.out.writeBytes(this.colorTab,0,this.colorTab.length);
         var _loc1_:int = 3 * 256 - this.colorTab.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.out.writeByte(0);
            _loc2_++;
         }
      }
      
      private function WriteShort(param1:int) : void
      {
         this.out.writeByte(param1 & 0xFF);
         this.out.writeByte(param1 >> 8 & 0xFF);
      }
      
      private function writePixels() : void
      {
         var _loc1_:LZWEncoder = new LZWEncoder(this.width,this.height,this.indexedPixels,this.colorDepth);
         _loc1_.encode(this.out);
      }
      
      public function get stream() : ByteArray
      {
         return this.out;
      }
   }
}

