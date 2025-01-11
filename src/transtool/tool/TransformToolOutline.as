package transtool.tool
{
   import flash.events.Event;
   import flash.geom.Point;
   
   public class TransformToolOutline extends TransformToolInternalControl
   {
      public function TransformToolOutline(param1:String)
      {
         super(param1);
      }
      
      override public function draw(param1:Event = null) : void
      {
         var _loc2_:Point = _transformTool.boundsTopLeft;
         var _loc3_:Point = _transformTool.boundsTopRight;
         var _loc4_:Point = _transformTool.boundsBottomRight;
         var _loc5_:Point = _transformTool.boundsBottomLeft;
         graphics.clear();
         graphics.lineStyle(0,0,0.2);
         graphics.moveTo(_loc2_.x,_loc2_.y);
         graphics.lineTo(_loc3_.x,_loc3_.y);
         graphics.lineTo(_loc4_.x,_loc4_.y);
         graphics.lineTo(_loc5_.x,_loc5_.y);
         graphics.lineTo(_loc2_.x,_loc2_.y);
      }
      
      override public function position(param1:Event = null) : void
      {
         this.draw(param1);
      }
   }
}

