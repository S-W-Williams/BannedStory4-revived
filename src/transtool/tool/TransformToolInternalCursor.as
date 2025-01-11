package transtool.tool
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class TransformToolInternalCursor extends TransformToolCursor
   {
      public var offset:Point = new Point();
      
      public var icon:Sprite = new Sprite();
      
      public function TransformToolInternalCursor()
      {
         super();
         addChild(this.icon);
         this.offset = _mouseOffset;
         addEventListener(TransformTool.CONTROL_INIT,this.init);
      }
      
      private function init(param1:Event) : void
      {
         _transformTool.addEventListener(TransformTool.NEW_TARGET,this.maintainTransform);
         _transformTool.addEventListener(TransformTool.CONTROL_PREFERENCE,this.maintainTransform);
         this.draw();
      }
      
      protected function maintainTransform(param1:Event) : void
      {
         var _loc2_:Matrix = null;
         this.offset = _mouseOffset;
         if(_transformTool.maintainControlForm)
         {
            transform.matrix = new Matrix();
            _loc2_ = transform.concatenatedMatrix;
            _loc2_.invert();
            transform.matrix = _loc2_;
            this.offset = _loc2_.deltaTransformPoint(this.offset);
         }
         updateVisible(param1);
      }
      
      protected function drawArc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean = true) : void
      {
         var _loc12_:int = 0;
         var _loc7_:Number = param5 - param4;
         var _loc8_:Number = 1 + Math.floor(Math.abs(_loc7_) / (Math.PI / 4));
         var _loc9_:Number = _loc7_ / (2 * _loc8_);
         var _loc10_:Number = Math.cos(_loc9_);
         var _loc11_:Number = !!_loc10_ ? param3 / _loc10_ : 0;
         if(param6)
         {
            this.icon.graphics.moveTo(param1 + Math.cos(param4) * param3,param2 - Math.sin(param4) * param3);
         }
         else
         {
            this.icon.graphics.lineTo(param1 + Math.cos(param4) * param3,param2 - Math.sin(param4) * param3);
         }
         _loc12_ = 0;
         while(_loc12_ < _loc8_)
         {
            param5 = param4 + _loc9_;
            param4 = param5 + _loc9_;
            this.icon.graphics.curveTo(param1 + Math.cos(param5) * _loc11_,param2 - Math.sin(param5) * _loc11_,param1 + Math.cos(param4) * param3,param2 - Math.sin(param4) * param3);
            _loc12_++;
         }
      }
      
      protected function getGlobalAngle(param1:Point) : Number
      {
         var _loc2_:Matrix = _transformTool.globalMatrix;
         param1 = _loc2_.deltaTransformPoint(param1);
         return Math.atan2(param1.y,param1.x) * (180 / Math.PI);
      }
      
      override public function position(param1:Event = null) : void
      {
         if(parent)
         {
            x = parent.mouseX + this.offset.x;
            y = parent.mouseY + this.offset.y;
         }
      }
      
      public function draw() : void
      {
         this.icon.graphics.beginFill(0);
         this.icon.graphics.lineStyle(1,16777215);
      }
   }
}

