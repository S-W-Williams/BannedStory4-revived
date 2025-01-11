package transtool.tool
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class TransformToolControl extends MovieClip
   {
      protected var _transformTool:TransformTool;
      
      protected var _referencePoint:Point;
      
      protected var _relatedObject:InteractiveObject;
      
      public function TransformToolControl()
      {
         super();
         this._relatedObject = this;
      }
      
      public function get transformTool() : TransformTool
      {
         return this._transformTool;
      }
      
      public function set transformTool(param1:TransformTool) : void
      {
         this._transformTool = param1;
      }
      
      public function get relatedObject() : InteractiveObject
      {
         return this._relatedObject;
      }
      
      public function set relatedObject(param1:InteractiveObject) : void
      {
         this._relatedObject = !!param1 ? param1 : this;
      }
      
      public function get referencePoint() : Point
      {
         return this._referencePoint;
      }
      
      public function set referencePoint(param1:Point) : void
      {
         this._referencePoint = param1;
      }
      
      public function counterTransform() : void
      {
         transform.matrix = new Matrix();
         var _loc1_:Matrix = transform.concatenatedMatrix;
         _loc1_.invert();
         transform.matrix = _loc1_;
      }
   }
}

