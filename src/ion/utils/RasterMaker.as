package ion.utils
{
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class RasterMaker
   {
      public function RasterMaker()
      {
         super();
      }
      
      public static function raster(param1:*, param2:Boolean = true, param3:uint = 0, param4:Number = 1, param5:Boolean = true, param6:Boolean = false) : *
      {
         if(param6)
         {
            return tiledRaster(param1,param2,param3,param4,param5);
         }
         return normalRaster(param1,param2,param3,param4,param5);
      }
      
      public static function getCropBounds(param1:*, param2:Boolean = true, param3:uint = 0, param4:Number = 1, param5:Boolean = true) : Rectangle
      {
         var _loc6_:BitmapData = getRasterWithMatrix(param1,param2,param3);
         var _loc7_:Rectangle = param1 is DisplayObject ? param1.getBounds(param1.parent) : new Rectangle();
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc8_:Rectangle = getRasterWithBounds(param1,_loc6_,param3,param4,param5);
         if(_loc8_ == null)
         {
            return null;
         }
         _loc8_.y += _loc7_.y;
         return _loc8_;
      }
      
      private static function getRasterWithMatrix(param1:*, param2:Boolean, param3:uint) : BitmapData
      {
         var _loc4_:Rectangle = null;
         var _loc5_:BitmapData = null;
         var _loc6_:Matrix = null;
         if(param1 is BitmapData)
         {
            _loc5_ = param1;
         }
         else
         {
            if(!(param1 is DisplayObject))
            {
               return null;
            }
            if(param1.width > 2800 || param1.height > 2800)
            {
               return null;
            }
            _loc4_ = param1.getBounds(param1.parent);
            _loc6_ = param1.transform.matrix;
            if(_loc4_.width <= 0 || _loc4_.height <= 0)
            {
               return null;
            }
            _loc4_.x = Math.floor(_loc4_.x);
            _loc4_.y = Math.floor(_loc4_.y);
            _loc4_.width = Math.ceil(_loc4_.width);
            _loc4_.height = Math.ceil(_loc4_.height);
            _loc6_.tx = Math.floor(_loc6_.tx);
            _loc6_.ty = Math.floor(_loc6_.ty);
            _loc6_.tx -= _loc4_.x;
            _loc6_.ty -= _loc4_.y;
            _loc5_ = new BitmapData(_loc4_.width,_loc4_.height,param2,param3);
            _loc5_.draw(param1,_loc6_);
         }
         return _loc5_;
      }
      
      private static function getRasterWithBounds(param1:*, param2:BitmapData, param3:uint, param4:Number, param5:Boolean) : Rectangle
      {
         var _loc6_:Rectangle = null;
         if(param5)
         {
            _loc6_ = param2.getColorBoundsRect(4294967295,param3,false);
         }
         else
         {
            _loc6_ = new Rectangle(0,0,param1.width,param1.height);
         }
         _loc6_.x *= param4;
         _loc6_.y *= param4;
         _loc6_.width *= param4;
         _loc6_.height *= param4;
         if(_loc6_.width <= 0 || _loc6_.height <= 0)
         {
            return null;
         }
         return _loc6_;
      }
      
      private static function tiledRaster(param1:*, param2:Boolean, param3:uint, param4:Number, param5:Boolean) : Array
      {
         var _loc6_:Rectangle = null;
         var _loc9_:BitmapData = null;
         var _loc10_:Matrix = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Array = null;
         var _loc19_:BitmapData = null;
         var _loc8_:Array = [];
         if(param1 is BitmapData)
         {
            _loc9_ = param1;
            _loc6_ = _loc9_.rect;
            _loc10_ = new Matrix();
         }
         else
         {
            if(!(param1 is DisplayObject))
            {
               return null;
            }
            _loc6_ = param1.getBounds(param1.parent);
            _loc10_ = param1.transform.matrix;
            if(_loc6_.width <= 0 || _loc6_.height <= 0)
            {
               return null;
            }
            _loc6_.x = Math.floor(_loc6_.x);
            _loc6_.y = Math.floor(_loc6_.y);
            _loc6_.width = Math.ceil(_loc6_.width);
            _loc6_.height = Math.ceil(_loc6_.height);
            _loc10_.tx = Math.floor(_loc10_.tx);
            _loc10_.ty = Math.floor(_loc10_.ty);
            _loc10_.tx -= _loc6_.x;
            _loc10_.ty -= _loc6_.y;
         }
         var _loc14_:int = _loc6_.height;
         var _loc15_:int = _loc6_.width;
         var _loc20_:Matrix = new Matrix();
         _loc12_ = 0;
         while(_loc12_ < _loc14_)
         {
            _loc17_ = _loc12_ + 2800 > _loc14_ ? _loc14_ - _loc12_ : 2800;
            _loc18_ = [];
            _loc13_ = 0;
            while(_loc13_ < _loc15_)
            {
               _loc16_ = _loc13_ + 2800 > _loc15_ ? _loc15_ - _loc13_ : 2800;
               _loc19_ = new BitmapData(_loc16_ * param4,_loc17_ * param4,param2,param3);
               _loc20_.a = param4;
               _loc20_.d = param4;
               _loc20_.tx = (_loc10_.tx - _loc13_) * param4;
               _loc20_.ty = (_loc10_.ty - _loc12_) * param4;
               _loc19_.draw(param1,_loc20_);
               _loc18_.push(_loc19_);
               _loc13_ += 2800;
            }
            _loc8_.push(_loc18_);
            _loc12_ += 2800;
         }
         return _loc8_;
      }
      
      private static function normalRaster(param1:*, param2:Boolean, param3:uint, param4:Number, param5:Boolean) : BitmapData
      {
         var _loc6_:BitmapData = getRasterWithMatrix(param1,param2,param3);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc7_:Rectangle = getRasterWithBounds(param1,_loc6_,param3,param4,param5);
         if(_loc7_ == null)
         {
            return null;
         }
         var _loc8_:BitmapData = new BitmapData(_loc7_.width,_loc7_.height,param2,param3);
         _loc8_.draw(_loc6_,new Matrix(param4,0,0,param4,-_loc7_.x,-_loc7_.y));
         return _loc8_;
      }
   }
}

