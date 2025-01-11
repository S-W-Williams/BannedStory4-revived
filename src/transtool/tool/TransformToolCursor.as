package transtool.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.Dictionary;
   
   public class TransformToolCursor extends TransformToolControl
   {
      protected var _mouseOffset:Point = new Point(20,20);
      
      protected var contact:Boolean = false;
      
      protected var active:Boolean = false;
      
      protected var references:Dictionary = new Dictionary(true);
      
      public function TransformToolCursor()
      {
         super();
         addEventListener(TransformTool.CONTROL_INIT,this.init);
      }
      
      public function get mouseOffset() : Point
      {
         return this._mouseOffset.clone();
      }
      
      public function set mouseOffset(param1:Point) : void
      {
         this._mouseOffset = param1;
      }
      
      public function addReference(param1:DisplayObject) : void
      {
         if(Boolean(param1) && !this.references[param1])
         {
            this.references[param1] = true;
            this.addReferenceListeners(param1);
         }
      }
      
      public function removeReference(param1:DisplayObject) : DisplayObject
      {
         if(Boolean(param1) && Boolean(this.references[param1]))
         {
            this.removeReferenceListeners(param1);
            delete this.references[param1];
            return param1;
         }
         return null;
      }
      
      public function updateVisible(param1:Event = null) : void
      {
         if(this.active)
         {
            if(!visible)
            {
               visible = true;
            }
         }
         else if(visible != this.contact)
         {
            visible = this.contact;
         }
         this.position(param1);
      }
      
      public function position(param1:Event = null) : void
      {
         if(parent)
         {
            x = parent.mouseX + this.mouseOffset.x;
            y = parent.mouseY + this.mouseOffset.y;
         }
      }
      
      private function init(param1:Event) : void
      {
         _transformTool.addEventListener(TransformTool.TRANSFORM_TOOL,this.position,false,0,true);
         _transformTool.addEventListener(TransformTool.NEW_TARGET,this.referenceUnset,false,0,true);
         _transformTool.addEventListener(TransformTool.CONTROL_TRANSFORM_TOOL,this.position,false,0,true);
         _transformTool.addEventListener(TransformTool.CONTROL_DOWN,this.controlMouseDown,false,0,true);
         _transformTool.addEventListener(TransformTool.CONTROL_MOVE,this.controlMove,false,0,true);
         _transformTool.addEventListener(TransformTool.CONTROL_UP,this.controlMouseUp,false,0,true);
         this.updateVisible(param1);
         this.position(param1);
      }
      
      private function addReferenceListeners(param1:DisplayObject) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_MOVE,this.referenceMove,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.referenceSet,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.referenceSet,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.referenceUnset,false,0,true);
      }
      
      private function removeReferenceListeners(param1:DisplayObject) : void
      {
         param1.removeEventListener(MouseEvent.MOUSE_MOVE,this.referenceMove,false);
         param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.referenceSet,false);
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.referenceSet,false);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.referenceUnset,false);
      }
      
      protected function referenceMove(param1:MouseEvent) : void
      {
         this.position(param1);
         param1.updateAfterEvent();
      }
      
      protected function referenceSet(param1:Event) : void
      {
         this.contact = true;
         if(!_transformTool.currentControl)
         {
            this.updateVisible(param1);
         }
      }
      
      protected function referenceUnset(param1:Event) : void
      {
         this.contact = false;
         if(!_transformTool.currentControl)
         {
            this.updateVisible(param1);
         }
      }
      
      protected function controlMouseDown(param1:Event) : void
      {
         if(this.references[_transformTool.currentControl.relatedObject])
         {
            this.active = true;
         }
         this.updateVisible(param1);
      }
      
      protected function controlMove(param1:Event) : void
      {
         if(this.references[_transformTool.currentControl.relatedObject])
         {
            this.position(param1);
         }
      }
      
      protected function controlMouseUp(param1:Event) : void
      {
         if(this.references[_transformTool.currentControl.relatedObject])
         {
            this.active = false;
         }
         this.updateVisible(param1);
      }
   }
}

