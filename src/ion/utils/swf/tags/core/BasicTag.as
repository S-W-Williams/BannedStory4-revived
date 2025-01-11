package ion.utils.swf.tags.core
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BasicTag
   {
      public static const NO_TAG_TYPE:int = -999;
      
      public static const HEADER:int = -1;
      
      public static const END:int = 0;
      
      public static const SHOW_FRAME:int = 1;
      
      public static const DEFINE_SHAPE:int = 2;
      
      public static const PLACE_OBJECT:int = 4;
      
      public static const REMOVE_OBJECT:int = 5;
      
      public static const DEFINE_BITS:int = 6;
      
      public static const DEFINE_BUTTON:int = 7;
      
      public static const JPEG_TABLES:int = 8;
      
      public static const SET_BACKGROUND_COLOR:int = 9;
      
      public static const DEFINE_FONT:int = 10;
      
      public static const DEFINE_TEXT:int = 11;
      
      public static const DO_ACTION:int = 12;
      
      public static const DEFINE_FONT_INFO:int = 13;
      
      public static const DEFINE_SOUND:int = 14;
      
      public static const START_SOUND:int = 15;
      
      public static const DEFINE_BUTTON_SOUND:int = 17;
      
      public static const SOUND_STREAM_HEAD:int = 18;
      
      public static const SOUND_STREAM_BLOCK:int = 19;
      
      public static const DEFINE_BITS_LOSSLESS:int = 20;
      
      public static const DEFINE_BITS_JPEG2:int = 21;
      
      public static const DEFINE_SHAPE2:int = 22;
      
      public static const DEFINE_BUTTON_CXFORM:int = 23;
      
      public static const PROTECT:int = 24;
      
      public static const PLACE_OBJECT2:int = 26;
      
      public static const REMOVE_OBJECT2:int = 28;
      
      public static const DEFINE_SHAPE3:int = 32;
      
      public static const DEFINE_TEXT2:int = 33;
      
      public static const DEFINE_BUTTON2:int = 34;
      
      public static const DEFINE_BITS_JPEG3:int = 35;
      
      public static const DEFINE_BITS_LOSSLESS2:int = 36;
      
      public static const DEFINE_EDIT_TEXT:int = 37;
      
      public static const DEFINE_SPRITE:int = 39;
      
      public static const FRAME_LABEL:int = 43;
      
      public static const SOUND_STREAM_HEAD2:int = 45;
      
      public static const DEFINE_MORPH_SHAPE:int = 46;
      
      public static const DEFINE_FONT2:int = 48;
      
      public static const EXPORT_ASSETS:int = 56;
      
      public static const IMPORT_ASSETS:int = 57;
      
      public static const ENABLE_DEBUGGER:int = 58;
      
      public static const DO_INIT_ACTION:int = 59;
      
      public static const DEFINE_VIDEO_STREAM:int = 60;
      
      public static const VIDEO_FRAME:int = 61;
      
      public static const DEFINE_FONT_INFO2:int = 62;
      
      public static const ENABLE_DEBUGGER2:int = 64;
      
      public static const SCRIPT_LIMITS:int = 65;
      
      public static const SET_TAB_INDEX:int = 66;
      
      public static const FILE_ATTRIBUTES:int = 69;
      
      public static const PLACE_OBJECT3:int = 70;
      
      public static const IMPORT_ASSETS2:int = 71;
      
      public static const DEFINE_FONT_ALIGN_ZONES:int = 73;
      
      public static const CSMT_EXT_SETTINGS:int = 74;
      
      public static const DEFINE_FONT3:int = 75;
      
      public static const SYMBOL_CLASS:int = 76;
      
      public static const METADATA:int = 77;
      
      public static const DEFINE_SCALING_GRID:int = 78;
      
      public static const DO_ABC:int = 82;
      
      public static const DEFINE_SHAPE4:int = 83;
      
      public static const DEFINE_MORPH_SHAPE2:int = 84;
      
      public static const DEFINE_SCENE_AND_FRAME_LABEL_DATA:int = 86;
      
      public static const DEFINE_BINARY_DATA:int = 87;
      
      public static const DEFINE_FONT_NAME:int = 88;
      
      public static const START_SOUND2:int = 89;
      
      public static const DEFINE_BITS_JPEG4:int = 90;
      
      public static const DEFINE_FONT4:int = 91;
      
      protected static var characterCounter:int = 0;
      
      protected static var characterDepth:int = 0;
      
      protected var _type:int;
      
      protected var _bytes:ByteArray;
      
      public function BasicTag()
      {
         super();
         this._type = NO_TAG_TYPE;
      }
      
      public function get serialize() : ByteArray
      {
         this._bytes = new ByteArray();
         this._bytes.endian = Endian.LITTLE_ENDIAN;
         return this._bytes;
      }
      
      protected function si8(param1:int) : void
      {
         var _loc2_:String = this._bytes.endian;
         this._bytes.endian = Endian.LITTLE_ENDIAN;
         this._bytes.writeByte(param1);
         this._bytes.endian = _loc2_;
      }
      
      protected function si16(param1:int) : void
      {
         var _loc2_:String = this._bytes.endian;
         this._bytes.endian = Endian.LITTLE_ENDIAN;
         this._bytes.writeShort(param1);
         this._bytes.endian = _loc2_;
      }
      
      protected function si32(param1:int) : void
      {
         var _loc2_:String = this._bytes.endian;
         this._bytes.endian = Endian.LITTLE_ENDIAN;
         this._bytes.writeInt(param1);
         this._bytes.endian = _loc2_;
      }
      
      protected function ui8(param1:uint) : void
      {
         var _loc2_:String = this._bytes.endian;
         this._bytes.endian = Endian.LITTLE_ENDIAN;
         this._bytes.writeByte(param1);
         this._bytes.endian = _loc2_;
      }
      
      protected function ui16(param1:uint) : void
      {
         var _loc2_:String = this._bytes.endian;
         this._bytes.endian = Endian.LITTLE_ENDIAN;
         this._bytes.writeShort(param1);
         this._bytes.endian = _loc2_;
      }
      
      protected function ui32(param1:uint) : void
      {
         var _loc2_:String = this._bytes.endian;
         this._bytes.endian = Endian.LITTLE_ENDIAN;
         this._bytes.writeUnsignedInt(param1);
         this._bytes.endian = _loc2_;
      }
      
      protected function fixed8(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = param1;
         do
         {
            _loc3_ -= int(_loc3_);
            _loc3_ *= 16;
            _loc2_ = (int(_loc3_) << 8) + _loc2_;
         }
         while(_loc3_ > 0 && _loc3_ < 1 && _loc3_ != param1);
         
         var _loc4_:String = _loc2_.toString(2);
         _loc4_ = this.fillPadding(_loc4_);
         _loc2_ = parseInt(_loc4_,2);
         this._bytes.writeByte(_loc2_);
         this._bytes.writeByte(param1);
      }
      
      protected function sb(param1:int, param2:int) : String
      {
         var _loc3_:String = this.dec2bin(param1);
         var _loc4_:String = _loc3_.substr(-1);
         while(_loc3_.length < param2)
         {
            _loc3_ = _loc4_ + _loc3_;
         }
         return _loc3_;
      }
      
      protected function ub(param1:int, param2:int) : String
      {
         var _loc3_:String = this.dec2bin(param1);
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         if(_loc3_.length > param2)
         {
            while(_loc3_.charAt(0) == "0")
            {
               _loc3_ = _loc3_.substr(1);
            }
         }
         return _loc3_;
      }
      
      protected function rect(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:String = this.dec2bin(param1);
         var _loc6_:String = this.dec2bin(param2);
         var _loc7_:String = this.dec2bin(param3);
         var _loc8_:String = this.dec2bin(param4);
         var _loc9_:int = _loc5_.length;
         if(_loc6_.length > _loc9_)
         {
            _loc9_ = _loc6_.length;
         }
         if(_loc7_.length > _loc9_)
         {
            _loc9_ = _loc7_.length;
         }
         if(_loc8_.length > _loc9_)
         {
            _loc9_ = _loc8_.length;
         }
         var _loc10_:String = this.ub(_loc9_,5);
         var _loc11_:String = this.sb(param1,_loc9_);
         var _loc12_:String = this.sb(param3,_loc9_);
         var _loc13_:String = this.sb(param2,_loc9_);
         var _loc14_:String = this.sb(param4,_loc9_);
         var _loc15_:String = _loc10_ + _loc11_ + _loc12_ + _loc13_ + _loc14_;
         _loc15_ = this.fillPadding(_loc15_);
         this._bytes.writeBytes(this.bin2bytes(_loc15_));
      }
      
      protected function rgb(param1:int) : void
      {
         var _loc2_:* = param1 >> 16;
         var _loc3_:* = (param1 & 0xFF00) >> 8;
         var _loc4_:* = param1 & 0xFF;
         this.ui8(_loc2_);
         this.ui8(_loc3_);
         this.ui8(_loc4_);
      }
      
      protected function rgba(param1:int) : void
      {
         var _loc2_:uint = uint(param1 >> 24);
         var _loc3_:uint = uint((param1 & 0xFF0000) >> 16);
         var _loc4_:uint = uint((param1 & 0xFF00) >> 8);
         var _loc5_:uint = uint(param1 & 0xFF);
         this.ui8(_loc2_);
         this.ui8(_loc3_);
         this.ui8(_loc4_);
         this.ui8(_loc5_);
      }
      
      protected function shapeWithStyle(param1:uint, param2:uint, param3:uint) : void
      {
         this.ui8(1);
         this.ui8(67);
         this.ui16(param1);
         this._bytes.writeBytes(this.bin2bytes("11011001010000000000000000000101000000000000000000000000"));
         this.ui8(0);
         this._bytes.writeBytes(this.bin2bytes("00010000"));
         var _loc4_:int = this.dec2bin(param2).length;
         var _loc5_:int = this.dec2bin(param3).length;
         var _loc6_:String = this.ub(_loc4_ - 2,4);
         var _loc7_:String = this.ub(_loc5_ - 2,4);
         var _loc8_:String = "11" + _loc6_ + "00" + this.sb(param2,_loc4_);
         var _loc9_:String = "11" + _loc7_ + "01" + this.sb(param3,_loc5_);
         var _loc10_:String = "11" + _loc6_ + "00" + this.sb(-param2,_loc4_);
         var _loc11_:String = "11" + _loc7_ + "01" + this.sb(-param3,_loc5_);
         var _loc12_:* = "0001001" + _loc8_ + _loc9_ + _loc10_ + _loc11_ + "000000";
         _loc12_ = this.fillPadding(_loc12_);
         this._bytes.writeBytes(this.bin2bytes(_loc12_));
      }
      
      protected function cxFormWithAlpha() : void
      {
         var _loc1_:String = "";
         _loc1_ += this.ub(0,1);
         _loc1_ += this.ub(1,1);
         _loc1_ += this.ub(4,4);
         _loc1_ += this.sb(15,4);
         _loc1_ += this.sb(15,4);
         _loc1_ += this.sb(15,4);
         _loc1_ += this.sb(0,4);
         _loc1_ = this.fillPadding(_loc1_);
         this._bytes.writeBytes(this.bin2bytes(_loc1_));
      }
      
      private function fillPadding(param1:String) : String
      {
         while(param1.length % 8 > 0)
         {
            param1 += "0";
         }
         return param1;
      }
      
      protected function bin2bytes(param1:String) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = parseInt(param1.substr(_loc5_,8),2);
            _loc2_.writeByte(_loc4_);
            _loc5_ += 8;
         }
         return _loc2_;
      }
      
      private function dec2bin(param1:int) : String
      {
         var _loc4_:String = null;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = param1 < 0;
         var _loc3_:String = Math.abs(param1).toString(2);
         if(_loc2_)
         {
            _loc4_ = "";
            _loc5_ = 0;
            _loc6_ = _loc3_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc4_ += _loc3_.charAt(_loc7_) == "0" ? "1" : "0";
               _loc7_++;
            }
            _loc5_ = parseInt(_loc4_,2);
            _loc5_ = _loc5_ + 1;
            _loc4_ = _loc5_.toString(2);
            while(_loc4_.length < _loc6_)
            {
               _loc4_ = "0" + _loc4_;
            }
            _loc3_ = "1" + _loc4_;
         }
         else if(_loc3_.charAt(0) == "1")
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      protected function buildRecordHeader() : ByteArray
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = Endian.LITTLE_ENDIAN;
         var _loc2_:int = int(this._bytes.length);
         _loc3_ = this._type.toString(2);
         _loc4_ = _loc2_ < 63 ? _loc2_.toString(2) : "111111";
         while(_loc3_.length < 10)
         {
            _loc3_ = "0" + _loc3_;
         }
         while(_loc4_.length < 6)
         {
            _loc4_ = "0" + _loc4_;
         }
         var _loc5_:int = parseInt(_loc3_ + _loc4_,2);
         _loc1_.writeShort(_loc5_);
         if(_loc2_ >= 63)
         {
            _loc1_.writeInt(_loc2_);
         }
         return _loc1_;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}

