package transtool.tool
{
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   
   public class TransformToolScaleControl extends TransformToolInternalControl
   {
      public function TransformToolScaleControl(param1:String, param2:Function, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function draw(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         graphics.clear();
         if(!_skin)
         {
            graphics.lineStyle(0,16777215,0.7);
            graphics.beginFill(16777215,0.5);
            _loc2_ = Math.floor(_transformTool.controlSize / 1.2);
            _loc3_ = Math.floor(_loc2_ / 1.8);
            graphics.drawRect(-_loc3_,-_loc3_,_loc2_,_loc2_);
            graphics.endFill();
         }
         filters = new Array(new DropShadowFilter(1,45,0,1,2,2,1,2));
         super.draw();
      }
   }
}

