package transtool.tool
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TransformToolMoveShape extends TransformToolInternalControl
   {
      private var lastTarget:DisplayObject;
      
      public function TransformToolMoveShape(param1:String, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function draw(param1:Event = null) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc4_:TransformToolCursor = null;
         var _loc3_:Boolean = _transformTool.moveUnderObjects;
         if(_loc3_)
         {
            hitArea = _transformTool.target as Sprite;
            _loc2_ = null;
            relatedObject = this;
         }
         else
         {
            hitArea = null;
            _loc2_ = _transformTool.target;
            relatedObject = _transformTool.target as InteractiveObject;
         }
         if(this.lastTarget != _loc2_)
         {
            if(this.lastTarget)
            {
               this.lastTarget.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown,false);
            }
            if(_loc2_)
            {
               _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown,false,0,true);
            }
            _loc4_ = _transformTool.moveCursor;
            _loc4_.removeReference(this.lastTarget);
            _loc4_.addReference(_loc2_);
            this.lastTarget = _loc2_;
         }
      }
      
      private function mouseDown(param1:MouseEvent) : void
      {
         dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
      }
   }
}

