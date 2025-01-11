package org.gif.encoder
{
   import flash.utils.ByteArray;
   
   public class NeuQuant
   {
      private static var netsize:int = 256;
      
      private static var prime1:int = 499;
      
      private static var prime2:int = 491;
      
      private static var prime3:int = 487;
      
      private static var prime4:int = 503;
      
      private static var minpicturebytes:int = 3 * prime4;
      
      private static var maxnetpos:int = netsize - 1;
      
      private static var netbiasshift:int = 4;
      
      private static var ncycles:int = 100;
      
      private static var intbiasshift:int = 16;
      
      private static var intbias:int = 1 << intbiasshift;
      
      private static var gammashift:int = 10;
      
      private static var gamma:int = 1 << gammashift;
      
      private static var betashift:int = 10;
      
      private static var beta:int = intbias >> betashift;
      
      private static var betagamma:int = intbias << gammashift - betashift;
      
      private static var initrad:int = netsize >> 3;
      
      private static var radiusbiasshift:int = 6;
      
      private static var radiusbias:int = 1 << radiusbiasshift;
      
      private static var initradius:int = initrad * radiusbias;
      
      private static var radiusdec:int = 30;
      
      private static var alphabiasshift:int = 10;
      
      private static var initalpha:int = 1 << alphabiasshift;
      
      private static var radbiasshift:int = 8;
      
      private static var radbias:int = 1 << radbiasshift;
      
      private static var alpharadbshift:int = alphabiasshift + radbiasshift;
      
      private static var alpharadbias:int = 1 << alpharadbshift;
      
      private var alphadec:int;
      
      private var thepicture:ByteArray;
      
      private var lengthcount:int;
      
      private var samplefac:int;
      
      private var network:Array;
      
      protected var netindex:Array;
      
      private var bias:Array;
      
      private var freq:Array;
      
      private var radpower:Array;
      
      public function NeuQuant(param1:ByteArray, param2:int, param3:int)
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         this.netindex = new Array();
         this.bias = new Array();
         this.freq = new Array();
         this.radpower = new Array();
         super();
         this.thepicture = param1;
         this.lengthcount = param2;
         this.samplefac = param3;
         this.network = new Array(netsize);
         _loc4_ = 0;
         while(_loc4_ < netsize)
         {
            this.network[_loc4_] = new Array(4);
            _loc5_ = this.network[_loc4_];
            _loc5_[0] = _loc5_[1] = _loc5_[2] = (_loc4_ << netbiasshift + 8) / netsize;
            this.freq[_loc4_] = intbias / netsize;
            this.bias[_loc4_] = 0;
            _loc4_++;
         }
      }
      
      private function colorMap() : ByteArray
      {
         var _loc6_:int = 0;
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:Array = new Array(netsize);
         var _loc3_:int = 0;
         while(_loc3_ < netsize)
         {
            _loc2_[this.network[_loc3_][3]] = _loc3_;
            _loc3_++;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < netsize)
         {
            _loc6_ = int(_loc2_[_loc5_]);
            var _loc7_:*;
            _loc1_[_loc7_ = _loc4_++] = this.network[_loc6_][0];
            var _loc8_:*;
            _loc1_[_loc8_ = _loc4_++] = this.network[_loc6_][1];
            var _loc9_:*;
            _loc1_[_loc9_ = _loc4_++] = this.network[_loc6_][2];
            _loc5_++;
         }
         return _loc1_;
      }
      
      private function inxbuild() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc7_ = 0;
         _loc8_ = 0;
         _loc1_ = 0;
         while(_loc1_ < netsize)
         {
            _loc5_ = this.network[_loc1_];
            _loc3_ = _loc1_;
            _loc4_ = int(_loc5_[1]);
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < netsize)
            {
               _loc6_ = this.network[_loc2_];
               if(_loc6_[1] < _loc4_)
               {
                  _loc3_ = _loc2_;
                  _loc4_ = int(_loc6_[1]);
               }
               _loc2_++;
            }
            _loc6_ = this.network[_loc3_];
            if(_loc1_ != _loc3_)
            {
               _loc2_ = int(_loc6_[0]);
               _loc6_[0] = _loc5_[0];
               _loc5_[0] = _loc2_;
               _loc2_ = int(_loc6_[1]);
               _loc6_[1] = _loc5_[1];
               _loc5_[1] = _loc2_;
               _loc2_ = int(_loc6_[2]);
               _loc6_[2] = _loc5_[2];
               _loc5_[2] = _loc2_;
               _loc2_ = int(_loc6_[3]);
               _loc6_[3] = _loc5_[3];
               _loc5_[3] = _loc2_;
            }
            if(_loc4_ != _loc7_)
            {
               this.netindex[_loc7_] = _loc8_ + _loc1_ >> 1;
               _loc2_ = _loc7_ + 1;
               while(_loc2_ < _loc4_)
               {
                  this.netindex[_loc2_] = _loc1_;
                  _loc2_++;
               }
               _loc7_ = _loc4_;
               _loc8_ = _loc1_;
            }
            _loc1_++;
         }
         this.netindex[_loc7_] = _loc8_ + maxnetpos >> 1;
         _loc2_ = _loc7_ + 1;
         while(_loc2_ < 256)
         {
            this.netindex[_loc2_] = maxnetpos;
            _loc2_++;
         }
      }
      
      private function learn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:ByteArray = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         if(this.lengthcount < minpicturebytes)
         {
            this.samplefac = 1;
         }
         this.alphadec = 30 + (this.samplefac - 1) / 3;
         _loc12_ = this.thepicture;
         _loc13_ = 0;
         _loc14_ = this.lengthcount;
         _loc11_ = this.lengthcount / (3 * this.samplefac);
         _loc10_ = _loc11_ / ncycles;
         _loc8_ = initalpha;
         _loc6_ = initradius;
         _loc7_ = _loc6_ >> radiusbiasshift;
         if(_loc7_ <= 1)
         {
            _loc7_ = 0;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc7_)
         {
            this.radpower[_loc1_] = _loc8_ * ((_loc7_ * _loc7_ - _loc1_ * _loc1_) * radbias / (_loc7_ * _loc7_));
            _loc1_++;
         }
         if(this.lengthcount < minpicturebytes)
         {
            _loc9_ = 3;
         }
         else if(this.lengthcount % prime1 != 0)
         {
            _loc9_ = 3 * prime1;
         }
         else if(this.lengthcount % prime2 != 0)
         {
            _loc9_ = 3 * prime2;
         }
         else if(this.lengthcount % prime3 != 0)
         {
            _loc9_ = 3 * prime3;
         }
         else
         {
            _loc9_ = 3 * prime4;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc11_)
         {
            _loc3_ = (_loc12_[_loc13_ + 0] & 0xFF) << netbiasshift;
            _loc4_ = (_loc12_[_loc13_ + 1] & 0xFF) << netbiasshift;
            _loc5_ = (_loc12_[_loc13_ + 2] & 0xFF) << netbiasshift;
            _loc2_ = this.contest(_loc3_,_loc4_,_loc5_);
            this.altersingle(_loc8_,_loc2_,_loc3_,_loc4_,_loc5_);
            if(_loc7_ != 0)
            {
               this.alterneigh(_loc7_,_loc2_,_loc3_,_loc4_,_loc5_);
            }
            _loc13_ += _loc9_;
            if(_loc13_ >= _loc14_)
            {
               _loc13_ -= this.lengthcount;
            }
            _loc1_++;
            if(_loc10_ == 0)
            {
               _loc10_ = 1;
            }
            if(_loc1_ % _loc10_ == 0)
            {
               _loc8_ -= _loc8_ / this.alphadec;
               _loc6_ -= _loc6_ / radiusdec;
               _loc7_ = _loc6_ >> radiusbiasshift;
               if(_loc7_ <= 1)
               {
                  _loc7_ = 0;
               }
               _loc2_ = 0;
               while(_loc2_ < _loc7_)
               {
                  this.radpower[_loc2_] = _loc8_ * ((_loc7_ * _loc7_ - _loc2_ * _loc2_) * radbias / (_loc7_ * _loc7_));
                  _loc2_++;
               }
            }
         }
      }
      
      public function map(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         _loc8_ = 1000;
         _loc10_ = -1;
         _loc4_ = int(this.netindex[param2]);
         _loc5_ = _loc4_ - 1;
         while(_loc4_ < netsize || _loc5_ >= 0)
         {
            if(_loc4_ < netsize)
            {
               _loc9_ = this.network[_loc4_];
               _loc6_ = _loc9_[1] - param2;
               if(_loc6_ >= _loc8_)
               {
                  _loc4_ = netsize;
               }
               else
               {
                  _loc4_++;
                  if(_loc6_ < 0)
                  {
                     _loc6_ = -_loc6_;
                  }
                  _loc7_ = _loc9_[0] - param1;
                  if(_loc7_ < 0)
                  {
                     _loc7_ = -_loc7_;
                  }
                  _loc6_ += _loc7_;
                  if(_loc6_ < _loc8_)
                  {
                     _loc7_ = _loc9_[2] - param3;
                     if(_loc7_ < 0)
                     {
                        _loc7_ = -_loc7_;
                     }
                     _loc6_ += _loc7_;
                     if(_loc6_ < _loc8_)
                     {
                        _loc8_ = _loc6_;
                        _loc10_ = int(_loc9_[3]);
                     }
                  }
               }
            }
            if(_loc5_ >= 0)
            {
               _loc9_ = this.network[_loc5_];
               _loc6_ = param2 - _loc9_[1];
               if(_loc6_ >= _loc8_)
               {
                  _loc5_ = -1;
               }
               else
               {
                  _loc5_--;
                  if(_loc6_ < 0)
                  {
                     _loc6_ = -_loc6_;
                  }
                  _loc7_ = _loc9_[0] - param1;
                  if(_loc7_ < 0)
                  {
                     _loc7_ = -_loc7_;
                  }
                  _loc6_ += _loc7_;
                  if(_loc6_ < _loc8_)
                  {
                     _loc7_ = _loc9_[2] - param3;
                     if(_loc7_ < 0)
                     {
                        _loc7_ = -_loc7_;
                     }
                     _loc6_ += _loc7_;
                     if(_loc6_ < _loc8_)
                     {
                        _loc8_ = _loc6_;
                        _loc10_ = int(_loc9_[3]);
                     }
                  }
               }
            }
         }
         return _loc10_;
      }
      
      public function process() : ByteArray
      {
         this.learn();
         this.unbiasnet();
         this.inxbuild();
         return this.colorMap();
      }
      
      private function unbiasnet() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < netsize)
         {
            this.network[_loc1_][0] >>= netbiasshift;
            this.network[_loc1_][1] >>= netbiasshift;
            this.network[_loc1_][2] >>= netbiasshift;
            this.network[_loc1_][3] = _loc1_;
            _loc1_++;
         }
      }
      
      private function alterneigh(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Array = null;
         _loc8_ = param2 - param1;
         if(_loc8_ < -1)
         {
            _loc8_ = -1;
         }
         _loc9_ = param2 + param1;
         if(_loc9_ > netsize)
         {
            _loc9_ = netsize;
         }
         _loc6_ = param2 + 1;
         _loc7_ = param2 - 1;
         _loc11_ = 1;
         while(_loc6_ < _loc9_ || _loc7_ > _loc8_)
         {
            _loc10_ = int(this.radpower[_loc11_++]);
            if(_loc6_ < _loc9_)
            {
               _loc12_ = this.network[_loc6_++];
               try
               {
                  _loc12_[0] -= _loc10_ * (_loc12_[0] - param3) / alpharadbias;
                  _loc12_[1] -= _loc10_ * (_loc12_[1] - param4) / alpharadbias;
                  _loc12_[2] -= _loc10_ * (_loc12_[2] - param5) / alpharadbias;
               }
               catch(e:Error)
               {
               }
            }
            if(_loc7_ > _loc8_)
            {
               _loc12_ = this.network[_loc7_--];
               try
               {
                  _loc12_[0] -= _loc10_ * (_loc12_[0] - param3) / alpharadbias;
                  _loc12_[1] -= _loc10_ * (_loc12_[1] - param4) / alpharadbias;
                  _loc12_[2] -= _loc10_ * (_loc12_[2] - param5) / alpharadbias;
               }
               catch(e:Error)
               {
               }
            }
         }
      }
      
      private function altersingle(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:Array = this.network[param2];
         _loc6_[0] = _loc6_[0] - param1 * (_loc6_[0] - param3) / initalpha;
         _loc6_[1] -= param1 * (_loc6_[1] - param4) / initalpha;
         _loc6_[2] -= param1 * (_loc6_[2] - param5) / initalpha;
      }
      
      private function contest(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         _loc12_ = _loc11_ = ~(1 << 31);
         _loc10_ = _loc9_ = -1;
         _loc4_ = 0;
         while(_loc4_ < netsize)
         {
            _loc13_ = this.network[_loc4_];
            _loc5_ = _loc13_[0] - param1;
            if(_loc5_ < 0)
            {
               _loc5_ = -_loc5_;
            }
            _loc6_ = _loc13_[1] - param2;
            if(_loc6_ < 0)
            {
               _loc6_ = -_loc6_;
            }
            _loc5_ += _loc6_;
            _loc6_ = _loc13_[2] - param3;
            if(_loc6_ < 0)
            {
               _loc6_ = -_loc6_;
            }
            _loc5_ += _loc6_;
            if(_loc5_ < _loc11_)
            {
               _loc11_ = _loc5_;
               _loc9_ = _loc4_;
            }
            _loc7_ = _loc5_ - (this.bias[_loc4_] >> intbiasshift - netbiasshift);
            if(_loc7_ < _loc12_)
            {
               _loc12_ = _loc7_;
               _loc10_ = _loc4_;
            }
            _loc8_ = this.freq[_loc4_] >> betashift;
            this.freq[_loc4_] -= _loc8_;
            this.bias[_loc4_] += _loc8_ << gammashift;
            _loc4_++;
         }
         this.freq[_loc9_] += beta;
         this.bias[_loc9_] -= betagamma;
         return _loc10_;
      }
   }
}

