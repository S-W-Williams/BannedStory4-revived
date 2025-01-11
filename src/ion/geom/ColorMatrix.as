package ion.geom
{
   public class ColorMatrix
   {
      private var delta:Array = [0,0.01,0.02,0.04,0.05,0.06,0.07,0.08,0.1,0.11,0.12,0.14,0.15,0.16,0.17,0.18,0.2,0.21,0.22,0.24,0.25,0.27,0.28,0.3,0.32,0.34,0.36,0.38,0.4,0.42,0.44,0.46,0.48,0.5,0.53,0.56,0.59,0.62,0.65,0.68,0.71,0.74,0.77,0.8,0.83,0.86,0.89,0.92,0.95,0.98,1,1.06,1.12,1.18,1.24,1.3,1.36,1.42,1.48,1.54,1.6,1.66,1.72,1.78,1.84,1.9,1.96,2,2.12,2.25,2.37,2.5,2.62,2.75,2.87,3,3.2,3.4,3.6,3.8,4,4.3,4.7,4.9,5,5.5,6,6.5,6.8,7,7.3,7.5,7.8,8,8.4,8.7,9,9.4,9.6,9.8,10];
      
      public var matrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1];
      
      public var brightness:Number = 0;
      
      public var contrast:Number = 0;
      
      public var saturation:Number = 0;
      
      public var hue:Number = 0;
      
      public var alpha:Number = 1;
      
      public function ColorMatrix()
      {
         super();
      }
      
      public function adjustColor(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.brightness = param1;
         this.contrast = param2;
         this.saturation = param3;
         this.hue = param4;
         this.alpha = param5;
         this.setBrightness(param1);
         this.setContrast(param2);
         this.setSaturation(param3);
         this.setHue(param4);
         this.setAlpha(param5);
      }
      
      public function reset() : void
      {
         this.matrix = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1];
         this.delta = [0,0.01,0.02,0.04,0.05,0.06,0.07,0.08,0.1,0.11,0.12,0.14,0.15,0.16,0.17,0.18,0.2,0.21,0.22,0.24,0.25,0.27,0.28,0.3,0.32,0.34,0.36,0.38,0.4,0.42,0.44,0.46,0.48,0.5,0.53,0.56,0.59,0.62,0.65,0.68,0.71,0.74,0.77,0.8,0.83,0.86,0.89,0.92,0.95,0.98,1,1.06,1.12,1.18,1.24,1.3,1.36,1.42,1.48,1.54,1.6,1.66,1.72,1.78,1.84,1.9,1.96,2,2.12,2.25,2.37,2.5,2.62,2.75,2.87,3,3.2,3.4,3.6,3.8,4,4.3,4.7,4.9,5,5.5,6,6.5,6.8,7,7.3,7.5,7.8,8,8.4,8.7,9,9.4,9.6,9.8,10];
         this.brightness = 0;
         this.contrast = 0;
         this.saturation = 0;
         this.hue = 0;
         this.alpha = 1;
      }
      
      public function serialize() : Object
      {
         return {
            "brightness":this.brightness,
            "contrast":this.contrast,
            "saturation":this.saturation,
            "hue":this.hue,
            "alpha":this.alpha
         };
      }
      
      public function clone() : ColorMatrix
      {
         var _loc1_:ColorMatrix = new ColorMatrix();
         _loc1_.adjustColor(this.brightness,this.contrast,this.saturation,this.hue,this.alpha);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "(brightness=" + this.brightness + ", contrast=" + this.contrast + ", saturation=" + this.saturation + ", hue=" + this.hue + ", alpha=" + this.alpha + ")";
      }
      
      public function copyFrom(param1:ColorMatrix) : void
      {
         this.reset();
         this.adjustColor(param1.brightness,param1.contrast,param1.saturation,param1.hue,param1.alpha);
      }
      
      private function setBrightness(param1:Number) : void
      {
         param1 = this.clean(param1,100);
         if(param1 == 0 || isNaN(param1))
         {
            return;
         }
         this.multiplyMatrix([1,0,0,0,param1,0,1,0,0,param1,0,0,1,0,param1,0,0,0,1,0,0,0,0,0,1]);
      }
      
      private function setContrast(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         param1 = this.clean(param1,100);
         if(param1 == 0 || isNaN(param1))
         {
            return;
         }
         if(param1 < 0)
         {
            _loc2_ = 127 + param1 / 100 * 127;
         }
         else
         {
            _loc2_ = param1 % 1;
            if(_loc2_ == 0)
            {
               _loc2_ = Number(this.delta[param1]);
            }
            else
            {
               _loc2_ = this.delta[param1 << 0] * (1 - _loc2_) + this.delta[(param1 << 0) + 1] * _loc2_;
            }
            _loc2_ = _loc2_ * 127 + 127;
         }
         this.multiplyMatrix([_loc2_ / 127,0,0,0,0.5 * (127 - _loc2_),0,_loc2_ / 127,0,0,0.5 * (127 - _loc2_),0,0,_loc2_ / 127,0,0.5 * (127 - _loc2_),0,0,0,1,0,0,0,0,0,1]);
      }
      
      private function setSaturation(param1:Number) : void
      {
         param1 = this.clean(param1,100);
         if(param1 == 0 || isNaN(param1))
         {
            return;
         }
         var _loc2_:Number = 1 + (param1 > 0 ? 3 * param1 / 100 : param1 / 100);
         this.multiplyMatrix([0.3086 * (1 - _loc2_) + _loc2_,0.6094 * (1 - _loc2_),0.082 * (1 - _loc2_),0,0,0.3086 * (1 - _loc2_),0.6094 * (1 - _loc2_) + _loc2_,0.082 * (1 - _loc2_),0,0,0.3086 * (1 - _loc2_),0.6094 * (1 - _loc2_),0.082 * (1 - _loc2_) + _loc2_,0,0,0,0,0,1,0,0,0,0,0,1]);
      }
      
      private function setHue(param1:Number) : void
      {
         param1 = this.clean(param1,180) / 180 * Math.PI;
         if(param1 == 0 || isNaN(param1))
         {
            return;
         }
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         this.multiplyMatrix([0.213 + _loc2_ * (1 - 0.213) + _loc3_ * -0.213,0.715 + _loc2_ * -0.715 + _loc3_ * -0.715,0.072 + _loc2_ * -0.072 + _loc3_ * (1 - 0.072),0,0,0.213 + _loc2_ * -0.213 + _loc3_ * 0.143,0.715 + _loc2_ * (1 - 0.715) + _loc3_ * 0.14,0.072 + _loc2_ * -0.072 + _loc3_ * -0.283,0,0,0.213 + _loc2_ * -0.213 + _loc3_ * -(1 - 0.213),0.715 + _loc2_ * -0.715 + _loc3_ * 0.715,0.072 + _loc2_ * (1 - 0.072) + _loc3_ * 0.072,0,0,0,0,0,1,0,0,0,0,0,1]);
      }
      
      private function setAlpha(param1:Number) : void
      {
         this.multiplyMatrix([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,param1,0,0,0,0,0,param1]);
      }
      
      private function multiplyMatrix(param1:Array) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc2_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               _loc2_[_loc4_] = this.matrix[_loc4_ + _loc3_ * 5];
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               _loc6_ = 0;
               _loc5_ = 0;
               while(_loc5_ < 5)
               {
                  _loc6_ += param1[_loc4_ + _loc5_ * 5] * _loc2_[_loc5_];
                  _loc5_++;
               }
               this.matrix[_loc4_ + _loc3_ * 5] = _loc6_;
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function clean(param1:Number, param2:Number) : Number
      {
         return Math.min(param2,Math.max(-param2,param1));
      }
   }
}

