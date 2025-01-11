package transtool.utils
{
   import bs.gui.InterfaceAssets;
   import fl.controls.Button;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import ion.components.controls.IToolTip;
   import transtool.tool.TransformTool;
   import transtool.tool.TransformToolControl;
   
   public class TransToolReset extends TransformToolControl
   {
      private var button:Button = new Button();
      
      public function TransToolReset()
      {
         super();
         this.button.setSize(20,20);
         this.button.label = "";
         this.button.setStyle("icon",new Bitmap(InterfaceAssets.refreshSmall));
         IToolTip.setTarget(this.button,"Restore");
         addChild(this.button);
         addEventListener(TransformTool.CONTROL_INIT,this.init,false,0,true);
      }
      
      private function init(param1:Event) : void
      {
         transformTool.addEventListener(TransformTool.NEW_TARGET,this.update,false,0,true);
         transformTool.addEventListener(TransformTool.TRANSFORM_TOOL,this.update,false,0,true);
         transformTool.addEventListener(TransformTool.CONTROL_TRANSFORM_TOOL,this.update,false,0,true);
         this.button.addEventListener(MouseEvent.CLICK,this.resetClick);
         this.update();
      }
      
      private function update(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(transformTool.target)
         {
            _loc2_ = Math.max(transformTool.boundsTopLeft.x,transformTool.boundsTopRight.x);
            _loc2_ = Math.max(_loc2_,transformTool.boundsBottomRight.x);
            _loc2_ = Math.max(_loc2_,transformTool.boundsBottomLeft.x);
            _loc3_ = Math.max(transformTool.boundsTopLeft.y,transformTool.boundsTopRight.y);
            _loc3_ = Math.max(_loc3_,transformTool.boundsBottomRight.y);
            _loc3_ = Math.max(_loc3_,transformTool.boundsBottomLeft.y);
            x = Math.floor(_loc2_);
            y = Math.floor(_loc3_ + 5);
         }
      }
      
      private function resetClick(param1:MouseEvent) : void
      {
         var _loc2_:Point = transformTool.registration;
         transformTool.globalMatrix = new Matrix();
         var _loc3_:Point = _loc2_.subtract(transformTool.registration);
         var _loc4_:Matrix = transformTool.toolMatrix;
         _loc4_.tx += _loc3_.x;
         _loc4_.ty += _loc3_.y;
         transformTool.toolMatrix = _loc4_;
         transformTool.apply();
      }
   }
}

