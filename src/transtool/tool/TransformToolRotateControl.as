package transtool.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class TransformToolRotateControl extends TransformToolInternalControl
   {
      private var locationName:String;
      
      public function TransformToolRotateControl(param1:String, param2:Function, param3:String)
      {
         super(param1,param2);
         this.locationName = param3;
      }
      
      override public function draw(param1:Event = null) : void
      {
         graphics.clear();
         if(!_skin)
         {
            graphics.beginFill(255,0);
            graphics.drawCircle(0,0,_transformTool.controlSize * 2);
            graphics.endFill();
         }
         super.draw();
      }
      
      override public function position(param1:Event = null) : void
      {
         var _loc2_:Point = null;
         if(this.locationName in _transformTool)
         {
            _loc2_ = _transformTool[this.locationName];
            x = _loc2_.x;
            y = _loc2_.y;
         }
      }
   }
}

