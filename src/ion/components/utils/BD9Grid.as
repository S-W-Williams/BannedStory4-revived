package ion.components.utils
{
   import flash.display.BitmapData;
   import flash.geom.*;
   
   public class BD9Grid
   {
      public function BD9Grid()
      {
         super();
      }
      
      public static function resize(param1:BitmapData, param2:BitmapData, param3:Rectangle, param4:Rectangle = null) : Rectangle
      {
         var _loc11_:Rectangle = null;
         var _loc12_:Rectangle = null;
         var _loc5_:BitmapData = new BitmapData(param4.width,param4.height,true,0);
         var _loc6_:Point = new Point();
         _loc5_.copyPixels(param1,param4,_loc6_);
         param1 = _loc5_;
         param4 = param1.rect;
         var _loc7_:Array = getGrid(param3,param4);
         var _loc8_:Array = getGrid(new Rectangle(param3.x,param3.y,param2.width - param4.width + param3.width,param2.height - param4.height + param3.height),param2.rect);
         var _loc9_:Matrix = new Matrix();
         var _loc10_:int = 9;
         while(_loc10_-- > 0)
         {
            _loc11_ = _loc7_[_loc10_];
            _loc12_ = _loc8_[_loc10_];
            if(_loc10_ % 2 == 0 && _loc10_ != 4)
            {
               _loc6_.x = _loc12_.x;
               _loc6_.y = _loc12_.y;
               param2.copyPixels(param1,_loc11_,_loc6_);
            }
            else
            {
               _loc9_.a = _loc12_.width / _loc11_.width;
               _loc9_.d = _loc12_.height / _loc11_.height;
               _loc9_.tx = _loc12_.x - _loc11_.x * _loc9_.a;
               _loc9_.ty = _loc12_.y - _loc11_.y * _loc9_.d;
               param2.draw(param1,_loc9_,null,null,_loc12_);
            }
         }
         _loc5_.dispose();
         param1 = null;
         _loc5_ = null;
         param2 = null;
         return _loc8_[4];
      }
      
      private static function getGrid(param1:Rectangle, param2:Rectangle) : Array
      {
         var _loc3_:Array = [];
         _loc3_[0] = new Rectangle(param2.x,param2.y,param1.x,param1.y);
         _loc3_[1] = new Rectangle(_loc3_[0].x + param1.x,_loc3_[0].y,param1.width,_loc3_[0].height);
         _loc3_[2] = new Rectangle(_loc3_[1].x + param1.width,_loc3_[1].y,param2.width - param1.width - param1.x,_loc3_[1].height);
         _loc3_[3] = new Rectangle(_loc3_[0].x,_loc3_[0].y + param1.y,_loc3_[0].width,param1.height);
         _loc3_[4] = new Rectangle(_loc3_[1].x,_loc3_[3].y,_loc3_[1].width,_loc3_[3].height);
         _loc3_[5] = new Rectangle(_loc3_[2].x,_loc3_[3].y,_loc3_[2].width,_loc3_[3].height);
         _loc3_[6] = new Rectangle(_loc3_[0].x,_loc3_[3].y + param1.height,_loc3_[0].width,param2.height - param1.height - param1.y);
         _loc3_[7] = new Rectangle(_loc3_[1].x,_loc3_[6].y,_loc3_[1].width,_loc3_[6].height);
         _loc3_[8] = new Rectangle(_loc3_[2].x,_loc3_[6].y,_loc3_[2].width,_loc3_[6].height);
         return _loc3_;
      }
   }
}

