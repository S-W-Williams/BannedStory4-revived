package transtool.tool
{
   import flash.events.Event;
   
   public class TransformToolRegistrationControl extends TransformToolInternalControl
   {
      public function TransformToolRegistrationControl(param1:String, param2:Function, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function draw(param1:Event = null) : void
      {
         graphics.clear();
         if(!_skin)
         {
            graphics.lineStyle(0,0);
            graphics.beginFill(16777215);
            graphics.drawCircle(0,0,Math.floor(_transformTool.controlSize / 2));
            graphics.endFill();
         }
         super.draw();
      }
   }
}

