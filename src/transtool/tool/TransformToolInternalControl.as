package transtool.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class TransformToolInternalControl extends TransformToolControl
   {
      public var interactionMethod:Function;
      
      public var referenceName:String;
      
      public var _skin:DisplayObject;
      
      public function TransformToolInternalControl(param1:String, param2:Function = null, param3:String = null)
      {
         super();
         this.name = param1;
         this.interactionMethod = param2;
         this.referenceName = param3;
         addEventListener(TransformTool.CONTROL_INIT,this.init);
      }
      
      public function set skin(param1:DisplayObject) : void
      {
         if(Boolean(this._skin) && contains(this._skin))
         {
            removeChild(this._skin);
         }
         this._skin = param1;
         if(this._skin)
         {
            addChild(this._skin);
         }
         this.draw();
      }
      
      public function get skin() : DisplayObject
      {
         return this._skin;
      }
      
      override public function get referencePoint() : Point
      {
         if(this.referenceName in _transformTool)
         {
            return _transformTool[this.referenceName];
         }
         return null;
      }
      
      protected function init(param1:Event) : void
      {
         _transformTool.addEventListener(TransformTool.NEW_TARGET,this.draw);
         _transformTool.addEventListener(TransformTool.TRANSFORM_TOOL,this.draw);
         _transformTool.addEventListener(TransformTool.CONTROL_TRANSFORM_TOOL,this.position);
         _transformTool.addEventListener(TransformTool.CONTROL_PREFERENCE,this.draw);
         _transformTool.addEventListener(TransformTool.CONTROL_MOVE,this.controlMove);
         this.draw();
      }
      
      public function draw(param1:Event = null) : void
      {
         if(_transformTool.maintainControlForm)
         {
            counterTransform();
         }
         this.position();
      }
      
      public function position(param1:Event = null) : void
      {
         var _loc2_:Point = this.referencePoint;
         if(_loc2_)
         {
            x = _loc2_.x;
            y = _loc2_.y;
         }
      }
      
      private function controlMove(param1:Event) : void
      {
         if(this.interactionMethod != null && _transformTool.currentControl == this)
         {
            this.interactionMethod();
         }
      }
   }
}

