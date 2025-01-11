package ion.components.core
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import ion.components.IComponentAlign;
   import ion.components.containers.IComponentContent;
   import ion.components.events.IComponentEvent;
   import ion.components.skin.ISkinAssets;
   import ion.components.skin.ISkinGrid;
   import ion.components.skin.ISkinSplit;
   
   public class IComponentInteractive extends IComponentCore
   {
      protected var _masking:Boolean = true;
      
      protected var _holderContent:IComponentContent;
      
      protected var skinBack:ISkinGrid;
      
      protected var _holderMask:Shape;
      
      protected var _alignX:int = 4;
      
      protected var _alignY:int = 5;
      
      public function IComponentInteractive(param1:int = 0, param2:int = 0)
      {
         super(param1,param2);
         this.mouseChildren = true;
         this._holderMask = new Shape();
         this._holderContent = new IComponentContent();
         this.skinBack = new ISkinGrid();
         this._holderMask.graphics.beginFill(0);
         this._holderMask.graphics.drawRect(0,0,10,10);
         this._holderMask.graphics.endFill();
         this._holderContent.mask = this._holderMask;
         this.skinBack.addEventListener(IComponentEvent.SKIN_CHANGE,this.skinChange);
         addChild(this.skinBack);
         addChild(this._holderContent);
         addChild(this._holderMask);
      }
      
      public function setStyle(param1:BitmapData) : void
      {
         this.styleDefinition(ISkinSplit.getSkinAssets(param1),this.skinBack.state);
      }
      
      protected function styleDefinition(param1:ISkinAssets, param2:int) : void
      {
         this.skinBack.skin = param1;
         this.skinBack.resize(_width,_height,param2);
         this.updateContent();
      }
      
      protected function updateContent() : void
      {
         switch(this._alignX)
         {
            case IComponentAlign.LEFT:
               this._holderContent.x = this.skinBack.center.x;
               break;
            case IComponentAlign.CENTER:
               this._holderContent.x = Math.floor((_width - this._holderContent.width) / 2);
               break;
            case IComponentAlign.RIGHT:
               this._holderContent.x = this.skinBack.center.width - this._holderContent.width;
         }
         switch(this._alignY)
         {
            case IComponentAlign.TOP:
               this._holderContent.y = this.skinBack.center.y;
               break;
            case IComponentAlign.MIDDLE:
               this._holderContent.y = Math.floor((_height - this._holderContent.height) / 2);
               break;
            case IComponentAlign.BOTTOM:
               this._holderContent.y = this.skinBack.center.height - this._holderContent.height;
         }
         this.updateMask(this.skinBack.center);
      }
      
      override protected function destroy() : void
      {
         this.skinBack.removeEventListener(IComponentEvent.SKIN_CHANGE,this.skinChange);
         while(this._holderContent.numChildren > 0)
         {
            this._holderContent.removeChildAt(0);
         }
         this.skinBack.destroy();
         this.skinBack = null;
         this._holderContent.mask = null;
         this._holderContent = null;
         this._holderMask = null;
         super.destroy();
      }
      
      protected function updateMask(param1:Rectangle = null) : void
      {
         if(param1 == null)
         {
            param1 = new Rectangle(0,0,width,height);
         }
         this._holderMask.x = param1.x - 1;
         this._holderMask.y = param1.y - 1;
         this._holderMask.width = param1.width + 2;
         this._holderMask.height = param1.height + 2;
      }
      
      protected function skinChange(param1:Event) : void
      {
         dispatchEvent(param1.clone());
      }
      
      public function set masking(param1:Boolean) : void
      {
         this._masking = param1;
         this._holderMask.visible = param1;
         if(param1)
         {
            this._holderContent.mask = this._holderMask;
         }
         else
         {
            this._holderContent.mask = null;
         }
      }
      
      public function get masking() : Boolean
      {
         return this._masking;
      }
      
      public function set alignX(param1:int) : void
      {
         if(param1 != IComponentAlign.LEFT && param1 != IComponentAlign.CENTER && param1 != IComponentAlign.RIGHT)
         {
            return;
         }
         this._alignX = param1;
         this.updateContent();
      }
      
      public function get alignX() : int
      {
         return this._alignX;
      }
      
      public function set alignY(param1:int) : void
      {
         if(param1 != IComponentAlign.TOP && param1 != IComponentAlign.MIDDLE && param1 != IComponentAlign.BOTTOM)
         {
            return;
         }
         this._alignY = param1;
         this.updateContent();
      }
      
      public function get alignY() : int
      {
         return this._alignY;
      }
      
      public function get skinState() : int
      {
         return this.skinBack.state;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this.skinBack.resize(_width,_height);
         this.updateContent();
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this.skinBack.resize(_width,_height);
         this.updateContent();
      }
   }
}

