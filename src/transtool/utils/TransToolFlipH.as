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
   
   public class TransToolFlipH extends TransformToolControl
   {
      private var button:Button = new Button();
      
      public function TransToolFlipH()
      {
         super();
         this.button.setSize(20,20);
         this.button.label = "";
         this.button.setStyle("icon",new Bitmap(InterfaceAssets.shapeFlipHorizontal));
         IToolTip.setTarget(this.button,"Flip Horizontal");
         addChild(this.button);
         addEventListener(TransformTool.CONTROL_INIT,this.init,false,0,true);
      }
      
      private function init(param1:Event) : void
      {
         transformTool.addEventListener(TransformTool.NEW_TARGET,this.update,false,0,true);
         transformTool.addEventListener(TransformTool.TRANSFORM_TOOL,this.update,false,0,true);
         transformTool.addEventListener(TransformTool.CONTROL_TRANSFORM_TOOL,this.update,false,0,true);
         this.button.addEventListener(MouseEvent.CLICK,this.flipClick);
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
            x = Math.floor(_loc2_ + this.button.width * 2);
            y = Math.floor(_loc3_ + 5);
         }
      }
      
      private function flipClick(param1:MouseEvent) : void
      {
         var _loc2_:Point = transformTool.registration;
         var _loc3_:Matrix = transformTool.toolMatrix;
         _loc3_.a *= -1;
         _loc3_.tx = 2 * _loc2_.x - _loc3_.tx;
         transformTool.toolMatrix = _loc3_;
         transformTool.apply();
      }
   }
}

