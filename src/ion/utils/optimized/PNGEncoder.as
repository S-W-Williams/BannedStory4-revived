package ion.utils.optimized
{
   import flash.display.BitmapData;
   import flash.geom.*;
   import flash.utils.ByteArray;
   
   public class PNGEncoder
   {
      private static var crcTable:Array;
      
      private static var crcTableComputed:Boolean = false;
      
      public function PNGEncoder()
      {
         super();
      }
      
      public static function encode(param1:*, param2:Array = null, param3:int = 0, param4:int = 0) : ByteArray
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         if(param1 is BitmapData)
         {
            _loc6_ = int(param1.width);
            _loc5_ = int(param1.height);
         }
         else if(param1 is Array)
         {
            _loc5_ = getArrHeight(param1);
            _loc6_ = getArrWidth(param1);
         }
         else
         {
            if(!(param1 is ByteArray || param1 is Vector.<uint>))
            {
               return null;
            }
            if(param3 <= 0 || param4 <= 0)
            {
               return null;
            }
            _loc6_ = param3;
            _loc5_ = param4;
         }
         var _loc7_:ByteArray = new ByteArray();
         _loc7_.writeUnsignedInt(2303741511);
         _loc7_.writeUnsignedInt(218765834);
         var _loc8_:ByteArray = new ByteArray();
         _loc8_.writeInt(_loc6_);
         _loc8_.writeInt(_loc5_);
         _loc8_.writeUnsignedInt(134610944);
         _loc8_.writeByte(0);
         writeChunk(_loc7_,1229472850,_loc8_);
         if(param2 != null)
         {
            _loc10_ = 0;
            while(_loc10_ < param2.length)
            {
               _loc9_ = param2[_loc10_];
               if(_loc9_ != null)
               {
                  buildTEXTChunk(_loc9_.label,_loc9_.data,_loc7_);
               }
               _loc10_++;
            }
         }
         if(param1 is BitmapData)
         {
            buildIDATChunk(param1.getVector(param1.rect),_loc7_,param1.transparent,_loc6_);
         }
         else if(param1 is Array)
         {
            buildArrIDATChunk(param1,_loc7_,_loc6_);
         }
         else if(param1 is ByteArray)
         {
            buildByteArrayIDATChunk(param1,_loc7_,_loc6_);
         }
         else if(param1 is Vector.<uint>)
         {
            buildIDATChunk(param1,_loc7_,true,_loc6_);
         }
         writeChunk(_loc7_,1229278788,null);
         _loc8_.clear();
         _loc8_ = null;
         return _loc7_;
      }
      
      private static function buildTEXTChunk(param1:String, param2:String, param3:ByteArray) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_.writeByte(param1.charCodeAt(_loc5_));
            _loc5_++;
         }
         _loc4_.writeByte(0);
         _loc4_.writeUTFBytes(param2);
         _loc4_.position = 0;
         writeChunk(param3,1950701684,_loc4_);
         _loc4_.clear();
         _loc4_ = null;
      }
      
      private static function buildArrIDATChunk(param1:Array, param2:ByteArray, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:BitmapData = null;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         var _loc9_:Vector.<uint> = new Vector.<uint>();
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(param1[_loc6_] is Array)
            {
               _loc5_ = int(param1[_loc6_].length);
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  if(param1[_loc6_][_loc7_] is BitmapData)
                  {
                     _loc8_ = param1[_loc6_][_loc7_];
                     _loc10_ = 0;
                     while(_loc10_ < _loc8_.width)
                     {
                        _loc9_.push(_loc8_.getPixel32(_loc10_,_loc11_));
                        _loc10_++;
                     }
                  }
                  _loc7_++;
               }
               if(_loc11_ + 1 >= _loc8_.height)
               {
                  _loc11_ = 0;
               }
               else
               {
                  _loc11_++;
                  _loc6_--;
               }
            }
            _loc6_++;
         }
         buildIDATChunk(_loc9_,param2,_loc8_.transparent,param3);
      }
      
      private static function buildByteArrayIDATChunk(param1:ByteArray, param2:ByteArray, param3:int) : void
      {
         var _loc6_:uint = 0;
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:int = 0;
         param1.position = 0;
         while(param1.bytesAvailable > 0)
         {
            if(_loc5_ % param3 == 0)
            {
               _loc4_.writeByte(0);
            }
            _loc6_ = param1.readUnsignedInt();
            _loc4_.writeUnsignedInt((_loc6_ & 0xFFFFFF) << 8 | _loc6_ >>> 24);
            _loc5_++;
         }
         _loc4_.compress();
         writeChunk(param2,1229209940,_loc4_);
         _loc4_.clear();
         _loc4_ = null;
      }
      
      private static function buildIDATChunk(param1:Vector.<uint>, param2:ByteArray, param3:Boolean, param4:int) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:int = int(param1.length);
         if(param3)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_loc8_ % param4 == 0)
               {
                  _loc5_.writeByte(0);
               }
               _loc7_ = param1[_loc8_];
               _loc5_.writeUnsignedInt((_loc7_ & 0xFFFFFF) << 8 | _loc7_ >>> 24);
               _loc8_++;
            }
         }
         else
         {
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_loc8_ % param4 == 0)
               {
                  _loc5_.writeByte(0);
               }
               _loc5_.writeUnsignedInt((param1[_loc8_] & 0xFFFFFF) << 8 | 0xFF);
               _loc8_++;
            }
         }
         _loc5_.compress();
         writeChunk(param2,1229209940,_loc5_);
         _loc5_.clear();
         _loc5_ = null;
      }
      
      private static function writeChunk(param1:ByteArray, param2:uint, param3:ByteArray) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(!crcTableComputed)
         {
            crcTableComputed = true;
            crcTable = [];
            _loc5_ = 0;
            while(_loc5_ < 256)
            {
               _loc4_ = uint(_loc5_);
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(_loc4_ & 1)
                  {
                     _loc4_ = uint(3988292384 ^ _loc4_ >>> 1);
                  }
                  else
                  {
                     _loc4_ >>>= 1;
                  }
                  _loc6_++;
               }
               crcTable.push(_loc4_);
               _loc5_++;
            }
         }
         if(param3 != null)
         {
            _loc8_ = int(param3.length);
         }
         param1.writeUnsignedInt(_loc8_);
         _loc7_ = int(param1.position);
         param1.writeUnsignedInt(param2);
         if(param3 != null)
         {
            param1.writeBytes(param3);
         }
         _loc6_ = int(param1.position);
         _loc8_ = _loc6_ - _loc7_;
         param1.position = _loc7_;
         _loc4_ = 4294967295;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc4_ = uint(crcTable[(_loc4_ ^ param1.readUnsignedByte()) & 0xFF] ^ _loc4_ >>> 8);
            _loc5_++;
         }
         _loc4_ ^= 4294967295;
         param1.position = _loc6_;
         param1.writeUnsignedInt(_loc4_);
      }
      
      private static function getArrWidth(param1:Array) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(param1.length > 0 && param1[0] is Array)
         {
            _loc3_ = int(param1[0].length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(param1[0][_loc4_] is BitmapData)
               {
                  _loc2_ += param1[0][_loc4_].width;
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      private static function getArrHeight(param1:Array) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] is Array)
            {
               if(param1[_loc3_][0] is BitmapData)
               {
                  _loc2_ += param1[_loc3_][0].height;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

