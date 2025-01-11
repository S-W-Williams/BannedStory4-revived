package org.gif.encoder
{
   import flash.utils.ByteArray;
   
   public class LZWEncoder
   {
      private static var EOF:int = -1;
      
      private static var BITS:int = 12;
      
      private static var HSIZE:int = 5003;
      
      private var imgW:int;
      
      private var imgH:int;
      
      private var pixAry:ByteArray;
      
      private var initCodeSize:int;
      
      private var remaining:int;
      
      private var curPixel:int;
      
      private var n_bits:int;
      
      private var maxbits:int = BITS;
      
      private var maxcode:int;
      
      private var maxmaxcode:int = 1 << BITS;
      
      private var htab:Array = new Array();
      
      private var codetab:Array = new Array();
      
      private var hsize:int = HSIZE;
      
      private var free_ent:int = 0;
      
      private var clear_flg:Boolean = false;
      
      private var g_init_bits:int;
      
      private var ClearCode:int;
      
      private var EOFCode:int;
      
      private var cur_accum:int = 0;
      
      private var cur_bits:int = 0;
      
      private var masks:Array = [0,1,3,7,15,31,63,127,255,511,1023,2047,4095,8191,16383,32767,65535];
      
      private var a_count:int;
      
      private var accum:ByteArray = new ByteArray();
      
      public function LZWEncoder(param1:int, param2:int, param3:ByteArray, param4:int)
      {
         super();
         this.imgW = param1;
         this.imgH = param2;
         this.pixAry = param3;
         this.initCodeSize = Math.max(2,param4);
      }
      
      private function char_out(param1:Number, param2:ByteArray) : void
      {
         var _loc3_:* = this.a_count++;
         this.accum[_loc3_] = param1;
         if(this.a_count >= 254)
         {
            this.flush_char(param2);
         }
      }
      
      private function cl_block(param1:ByteArray) : void
      {
         this.cl_hash(this.hsize);
         this.free_ent = this.ClearCode + 2;
         this.clear_flg = true;
         this.output(this.ClearCode,param1);
      }
      
      private function cl_hash(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this.htab[_loc2_] = -1;
            _loc2_++;
         }
      }
      
      public function compress(param1:int, param2:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.g_init_bits = param1;
         this.clear_flg = false;
         this.n_bits = this.g_init_bits;
         this.maxcode = this.MAXCODE(this.n_bits);
         this.ClearCode = 1 << param1 - 1;
         this.EOFCode = this.ClearCode + 1;
         this.free_ent = this.ClearCode + 2;
         this.a_count = 0;
         _loc6_ = this.nextPixel();
         _loc9_ = 0;
         _loc3_ = this.hsize;
         while(_loc3_ < 65536)
         {
            _loc9_++;
            _loc3_ *= 2;
         }
         _loc9_ = 8 - _loc9_;
         _loc8_ = this.hsize;
         this.cl_hash(_loc8_);
         this.output(this.ClearCode,param2);
         loop1:
         while(true)
         {
            _loc5_ = this.nextPixel();
            if(_loc5_ == EOF)
            {
               break;
            }
            _loc3_ = (_loc5_ << this.maxbits) + _loc6_;
            _loc4_ = _loc5_ << _loc9_ ^ _loc6_;
            if(this.htab[_loc4_] == _loc3_)
            {
               _loc6_ = int(this.codetab[_loc4_]);
            }
            else
            {
               if(this.htab[_loc4_] >= 0)
               {
                  _loc7_ = _loc8_ - _loc4_;
                  if(_loc4_ == 0)
                  {
                     _loc7_ = 1;
                  }
                  do
                  {
                     _loc4_ = _loc4_ - _loc7_;
                     if(_loc4_ < 0)
                     {
                        _loc4_ += _loc8_;
                     }
                     if(this.htab[_loc4_] == _loc3_)
                     {
                        _loc6_ = int(this.codetab[_loc4_]);
                        continue loop1;
                     }
                  }
                  while(this.htab[_loc4_] >= 0);
                  
               }
               this.output(_loc6_,param2);
               _loc6_ = _loc5_;
               if(this.free_ent < this.maxmaxcode)
               {
                  this.codetab[_loc4_] = this.free_ent++;
                  this.htab[_loc4_] = _loc3_;
               }
               else
               {
                  this.cl_block(param2);
               }
            }
         }
         this.output(_loc6_,param2);
         this.output(this.EOFCode,param2);
      }
      
      public function encode(param1:ByteArray) : void
      {
         param1.writeByte(this.initCodeSize);
         this.remaining = this.imgW * this.imgH;
         this.curPixel = 0;
         this.compress(this.initCodeSize + 1,param1);
         param1.writeByte(0);
      }
      
      private function flush_char(param1:ByteArray) : void
      {
         if(this.a_count > 0)
         {
            param1.writeByte(this.a_count);
            param1.writeBytes(this.accum,0,this.a_count);
            this.a_count = 0;
         }
      }
      
      private function MAXCODE(param1:int) : int
      {
         return (1 << param1) - 1;
      }
      
      private function nextPixel() : int
      {
         if(this.remaining == 0)
         {
            return EOF;
         }
         --this.remaining;
         var _loc1_:Number = Number(this.pixAry[this.curPixel++]);
         return _loc1_ & 0xFF;
      }
      
      private function output(param1:int, param2:ByteArray) : void
      {
         this.cur_accum &= this.masks[this.cur_bits];
         if(this.cur_bits > 0)
         {
            this.cur_accum |= param1 << this.cur_bits;
         }
         else
         {
            this.cur_accum = param1;
         }
         this.cur_bits += this.n_bits;
         while(this.cur_bits >= 8)
         {
            this.char_out(this.cur_accum & 0xFF,param2);
            this.cur_accum >>= 8;
            this.cur_bits -= 8;
         }
         if(this.free_ent > this.maxcode || this.clear_flg)
         {
            if(this.clear_flg)
            {
               this.maxcode = this.MAXCODE(this.n_bits = this.g_init_bits);
               this.clear_flg = false;
            }
            else
            {
               ++this.n_bits;
               if(this.n_bits == this.maxbits)
               {
                  this.maxcode = this.maxmaxcode;
               }
               else
               {
                  this.maxcode = this.MAXCODE(this.n_bits);
               }
            }
         }
         if(param1 == this.EOFCode)
         {
            while(this.cur_bits > 0)
            {
               this.char_out(this.cur_accum & 0xFF,param2);
               this.cur_accum >>= 8;
               this.cur_bits -= 8;
            }
            this.flush_char(param2);
         }
      }
   }
}

