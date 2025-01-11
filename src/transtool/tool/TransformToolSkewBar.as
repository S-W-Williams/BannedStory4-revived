package transtool.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class TransformToolSkewBar extends TransformToolInternalControl
   {
      private var locationStart:String;
      
      private var locationEnd:String;
      
      public function TransformToolSkewBar(param1:String, param2:Function, param3:String, param4:String, param5:String)
      {
         super(param1,param2,param3);
         this.locationStart = param4;
         this.locationEnd = param5;
      }
      
      override public function draw(param1:Event = null) : void
      {
         var _loc4_:Matrix = null;
         var _loc5_:Matrix = null;
         graphics.clear();
         if(_skin)
         {
            super.draw(param1);
            return;
         }
         var _loc2_:Point = _transformTool[this.locationStart];
         var _loc3_:Point = _transformTool[this.locationEnd];
         var _loc6_:Boolean = _transformTool.maintainControlForm;
         if(_loc6_)
         {
            _loc4_ = transform.concatenatedMatrix;
            _loc5_ = _loc4_.clone();
            _loc5_.invert();
            _loc2_ = _loc4_.transformPoint(_loc2_);
            _loc3_ = _loc4_.transformPoint(_loc3_);
         }
         var _loc7_:Number = _transformTool.controlSize / 2;
         var _loc8_:Point = _loc3_.subtract(_loc2_);
         var _loc9_:Number = Math.atan2(_loc8_.y,_loc8_.x) - Math.PI / 2;
         var _loc10_:Point = Point.polar(_loc7_,_loc9_);
         var _loc11_:Point = _loc2_.add(_loc10_);
         var _loc12_:Point = _loc3_.add(_loc10_);
         var _loc13_:Point = _loc3_.subtract(_loc10_);
         var _loc14_:Point = _loc2_.subtract(_loc10_);
         if(_loc6_)
         {
            _loc11_ = _loc5_.transformPoint(_loc11_);
            _loc12_ = _loc5_.transformPoint(_loc12_);
            _loc13_ = _loc5_.transformPoint(_loc13_);
            _loc14_ = _loc5_.transformPoint(_loc14_);
         }
         graphics.beginFill(16711680,0);
         graphics.moveTo(_loc11_.x,_loc11_.y);
         graphics.lineTo(_loc12_.x,_loc12_.y);
         graphics.lineTo(_loc13_.x,_loc13_.y);
         graphics.lineTo(_loc14_.x,_loc14_.y);
         graphics.lineTo(_loc11_.x,_loc11_.y);
         graphics.endFill();
      }
      
      override public function position(param1:Event = null) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         if(_skin)
         {
            _loc2_ = _transformTool[this.locationStart];
            _loc3_ = _transformTool[this.locationEnd];
            _loc4_ = Point.interpolate(_loc2_,_loc3_,0.5);
            x = _loc4_.x;
            y = _loc4_.y;
         }
         else
         {
            x = 0;
            y = 0;
            this.draw(param1);
         }
      }
   }
}

