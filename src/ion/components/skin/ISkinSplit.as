package ion.components.skin
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ISkinSplit
   {
      public function ISkinSplit()
      {
         super();
      }
      
      public static function getSkinAssets(param1:BitmapData) : ISkinAssets
      {
         var _loc7_:int = 0;
         var _loc12_:Rectangle = null;
         var _loc2_:Point = new Point(0,0);
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:int = param1.width;
         var _loc6_:int = 1;
         var _loc8_:int = int(param1.getPixel32(1,_loc6_));
         while(param1.getPixel32(1,_loc6_) == _loc8_ && _loc6_ < param1.height)
         {
            _loc6_++;
         }
         _loc6_++;
         if(_loc6_ >= param1.height || _loc5_ - 2 <= 0 || _loc6_ - 2 <= 0)
         {
            return getNoSkinAssets();
         }
         var _loc9_:BitmapData = new BitmapData(_loc5_ - 2,_loc6_ - 2,true,0);
         _loc9_.copyPixels(param1,new Rectangle(1,1,_loc5_ - 2,_loc6_ - 2),_loc2_);
         var _loc10_:Rectangle = _loc9_.getColorBoundsRect(4294967295,0,false);
         _loc10_.x += 1;
         _loc10_.y += 1;
         --_loc10_.width;
         --_loc10_.height;
         _loc7_ = _loc6_;
         while(_loc7_ < param1.height)
         {
            _loc12_ = new Rectangle(0,_loc7_,param1.width,_loc6_);
            _loc3_.push(_loc12_);
            _loc7_ += _loc6_;
         }
         var _loc11_:int = (param1.height - _loc6_) / _loc6_;
         _loc7_ = 0;
         while(_loc7_ < _loc11_)
         {
            _loc8_ = int(param1.getPixel(_loc7_,param1.height - 1));
            _loc4_.push(_loc8_);
            _loc7_++;
         }
         _loc9_.dispose();
         _loc9_ = null;
         return new ISkinAssets(_loc3_,_loc4_,_loc10_,param1);
      }
      
      public static function getNoSkinAssets() : ISkinAssets
      {
         return new ISkinAssets([new Rectangle(0,0,20,20)],[0],new Rectangle(5,5,10,10),new BitmapData(20,20,false,Math.random() * 16777215));
      }
   }
}

