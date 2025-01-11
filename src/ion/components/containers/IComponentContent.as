package ion.components.containers
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class IComponentContent extends Sprite
   {
      public function IComponentContent()
      {
         super();
      }
      
      override public function get width() : Number
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.numChildren;
         while(--_loc2_ >= 0)
         {
            _loc3_ = this.getChildAt(_loc2_);
            if(_loc3_.x + _loc3_.width > _loc1_ && _loc3_.width > 0)
            {
               _loc1_ = _loc3_.x + _loc3_.width;
            }
         }
         return _loc1_;
      }
      
      override public function get height() : Number
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.numChildren;
         while(--_loc2_ >= 0)
         {
            _loc3_ = this.getChildAt(_loc2_);
            if(_loc3_.y + _loc3_.height > _loc1_ && _loc3_.height > 0)
            {
               _loc1_ = _loc3_.y + _loc3_.height;
            }
         }
         return _loc1_;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = Math.floor(param1);
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = Math.floor(param1);
      }
   }
}

