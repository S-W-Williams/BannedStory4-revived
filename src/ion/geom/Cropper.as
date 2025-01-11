package ion.geom
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class Cropper extends Sprite
   {
      private var w:int;
      
      private var h:int;
      
      private var border0:Sprite;
      
      private var border1:Sprite;
      
      private var border2:Sprite;
      
      private var border3:Sprite;
      
      private var center:Sprite = new Sprite();
      
      private var shade0:Shape = new Shape();
      
      private var shade1:Shape = new Shape();
      
      private var shade2:Shape = new Shape();
      
      private var shade3:Shape = new Shape();
      
      private var bpIcon:Bitmap = new Bitmap();
      
      private var iconTop:BitmapData;
      
      private var iconRight:BitmapData;
      
      private var iconDown:BitmapData;
      
      private var iconLeft:BitmapData;
      
      private var iconCenter:BitmapData;
      
      private var _margins:Rectangle;
      
      private var _userInteract:Boolean = false;
      
      private const lineRange:int = 3;
      
      private const lineColors:int = 16711680;
      
      public function Cropper(param1:int, param2:int)
      {
         super();
         this.w = param1;
         this.h = param2;
         this.center.graphics.lineStyle(0,this.lineColors);
         this.center.graphics.beginFill(0,0);
         this.center.graphics.drawRect(0,0,10,10);
         this.center.graphics.endFill();
         this.border0 = this.buildVLine();
         this.border1 = this.buildHLine();
         this.border2 = this.buildVLine();
         this.border3 = this.buildHLine();
         this.border0.visible = false;
         this.border1.visible = false;
         this.border2.visible = false;
         this.border3.visible = false;
         this.center.visible = false;
         this.border0.addEventListener(MouseEvent.MOUSE_DOWN,this.dragLines);
         this.border1.addEventListener(MouseEvent.MOUSE_DOWN,this.dragLines);
         this.border2.addEventListener(MouseEvent.MOUSE_DOWN,this.dragLines);
         this.border3.addEventListener(MouseEvent.MOUSE_DOWN,this.dragLines);
         this.center.addEventListener(MouseEvent.MOUSE_DOWN,this.dragCenter);
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         addEventListener(MouseEvent.MOUSE_MOVE,this.moveIcon);
         addEventListener(MouseEvent.MOUSE_OUT,this.killIcon);
         addChild(this.shade0);
         addChild(this.shade1);
         addChild(this.shade2);
         addChild(this.shade3);
         addChild(this.center);
         addChild(this.border0);
         addChild(this.border1);
         addChild(this.border2);
         addChild(this.border3);
         addChild(this.bpIcon);
      }
      
      public function setIcons(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:BitmapData, param5:BitmapData) : void
      {
         this.iconTop = param1;
         this.iconRight = param2;
         this.iconDown = param3;
         this.iconLeft = param4;
         this.iconCenter = param5;
      }
      
      public function reset() : void
      {
         this.border0.x = this._margins.x;
         this.border1.y = this._margins.y;
         this.border2.x = this._margins.x + this._margins.width;
         this.border3.y = this._margins.y + this._margins.height;
         this.updateCenter(new Event(""));
      }
      
      private function buildHLine() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Shape = new Shape();
         var _loc3_:Shape = new Shape();
         _loc2_.graphics.moveTo(0,0);
         _loc2_.graphics.lineTo(this.w,0);
         _loc3_.graphics.beginFill(0,0);
         _loc3_.graphics.drawRect(0,-this.lineRange,this.w,2 * this.lineRange);
         _loc3_.graphics.endFill();
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      private function buildVLine() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Shape = new Shape();
         var _loc3_:Shape = new Shape();
         _loc2_.graphics.moveTo(0,0);
         _loc2_.graphics.lineTo(0,this.h);
         _loc3_.graphics.beginFill(0,0);
         _loc3_.graphics.drawRect(-this.lineRange,0,2 * this.lineRange,this.h);
         _loc3_.graphics.endFill();
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      private function killIcon(param1:MouseEvent) : void
      {
         this.bpIcon.bitmapData = null;
      }
      
      private function moveIcon(param1:MouseEvent) : void
      {
         this.bpIcon.x = this.mouseX + 20;
         this.bpIcon.y = this.mouseY + 20;
         switch(param1.target)
         {
            case this.border0:
               this.bpIcon.bitmapData = this.iconLeft;
               break;
            case this.border1:
               this.bpIcon.bitmapData = this.iconTop;
               break;
            case this.border2:
               this.bpIcon.bitmapData = this.iconRight;
               break;
            case this.border3:
               this.bpIcon.bitmapData = this.iconDown;
               break;
            case this.center:
               this.bpIcon.bitmapData = this.iconCenter;
               break;
            default:
               this.bpIcon.bitmapData = null;
         }
      }
      
      private function dragCenter(param1:MouseEvent) : void
      {
         this._userInteract = true;
         this.center.startDrag(false,new Rectangle(this._margins.x,this._margins.y,this._margins.width - this.center.width,this._margins.height - this.center.height));
         this.center.removeEventListener(Event.ENTER_FRAME,this.updateCenter);
         this.center.removeEventListener(Event.ENTER_FRAME,this.updateLines);
         this.center.addEventListener(Event.ENTER_FRAME,this.updateLines);
      }
      
      private function addedToStage(param1:Event) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,this.killDrag);
      }
      
      private function dragLines(param1:MouseEvent) : void
      {
         this._userInteract = true;
         if(param1.currentTarget == this.border0)
         {
            this.border0.startDrag(true,new Rectangle(this._margins.x,0,this.border2.x - 1 - this._margins.x,0));
         }
         else if(param1.currentTarget == this.border1)
         {
            this.border1.startDrag(true,new Rectangle(0,this._margins.y,0,this.border3.y - 1 - this._margins.y));
         }
         else if(param1.currentTarget == this.border2)
         {
            this.border2.startDrag(true,new Rectangle(this.border0.x + 1,0,this._margins.x + this._margins.width - this.border0.x - 1,0));
         }
         else if(param1.currentTarget == this.border3)
         {
            this.border3.startDrag(true,new Rectangle(0,this.border1.y + 1,0,this._margins.y + this._margins.height - this.border1.y - 1));
         }
         this.center.addEventListener(Event.ENTER_FRAME,this.updateCenter);
      }
      
      private function killDrag(param1:MouseEvent) : void
      {
         this.center.removeEventListener(Event.ENTER_FRAME,this.updateCenter);
         this.center.removeEventListener(Event.ENTER_FRAME,this.updateLines);
         this._userInteract = false;
         stopDrag();
         this.updateCenter();
      }
      
      private function updateLines(param1:Event = null) : void
      {
         this.border0.x = this.center.x;
         this.border0.y = this.center.y;
         this.border1.x = this.center.x;
         this.border1.y = this.center.y;
         this.border2.x = this.center.x + this.center.width;
         this.border2.y = this.center.y;
         this.border3.x = this.center.x;
         this.border3.y = this.center.y + this.center.height;
         this.updateShades();
      }
      
      private function updateCenter(param1:Event = null) : void
      {
         this.center.x = this.border0.x;
         this.center.y = this.border1.y;
         this.center.width = this.border2.x - this.border0.x;
         this.center.height = this.border3.y - this.border1.y;
         this.border0.height = this.border2.height = this.center.height;
         this.border1.width = this.border3.width = this.center.width;
         this.border0.x = this.center.x;
         this.border0.y = this.center.y;
         this.border1.x = this.center.x;
         this.border1.y = this.center.y;
         this.border2.x = this.center.x + this.center.width;
         this.border2.y = this.center.y;
         this.border3.x = this.center.x;
         this.border3.y = this.center.y + this.center.height;
         this.updateShades();
      }
      
      private function updateShades() : void
      {
         this.shade0.graphics.clear();
         this.shade1.graphics.clear();
         this.shade2.graphics.clear();
         this.shade3.graphics.clear();
         this.shade0.graphics.beginFill(0,0.1);
         this.shade0.graphics.drawRect(0,0,this.w,this.center.y);
         this.shade0.graphics.endFill();
         this.shade1.graphics.beginFill(0,0.1);
         this.shade1.graphics.drawRect(this.center.x + this.center.width,this.center.y,this.w - (this.center.x + this.center.width),this.h - this.center.y);
         this.shade1.graphics.endFill();
         this.shade2.graphics.beginFill(0,0.1);
         this.shade2.graphics.drawRect(0,this.center.y + this.center.height,this.center.x + this.center.width,this.h - (this.center.y + this.center.height));
         this.shade2.graphics.endFill();
         this.shade3.graphics.beginFill(0,0.1);
         this.shade3.graphics.drawRect(0,this.center.y,this.center.x,this.center.height);
         this.shade3.graphics.endFill();
         if(this._userInteract)
         {
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function get selection() : Rectangle
      {
         return new Rectangle(this.center.x,this.center.y,this.center.width + 1,this.center.height + 1);
      }
      
      public function set selection(param1:Rectangle) : void
      {
         this.center.x = param1.x;
         this.center.y = param1.y;
         this.center.width = param1.width - 1;
         this.center.height = param1.height - 1;
         this.updateLines();
      }
      
      public function get margins() : Rectangle
      {
         return this._margins;
      }
      
      public function set margins(param1:Rectangle) : void
      {
         if(param1.x < 0 || param1.x > this.w)
         {
            param1.x = 0;
         }
         if(param1.x + param1.width > this.w)
         {
            param1.width = this.w - param1.x;
         }
         if(param1.y < 0 || param1.y > this.h)
         {
            param1.y = 0;
         }
         if(param1.y + param1.height > this.h)
         {
            param1.height = this.h - param1.y;
         }
         this._margins = param1;
         this.border0.height = this.border2.height = this._margins.height;
         this.border1.width = this.border3.width = this._margins.width;
         this.border0.x = this._margins.x;
         this.border0.y = this._margins.y;
         this.border1.x = this._margins.x;
         this.border1.y = this._margins.y;
         this.border2.x = this._margins.x + this._margins.width;
         this.border2.y = this._margins.y;
         this.border3.x = this._margins.x;
         this.border3.y = this._margins.y + this._margins.height;
         this.updateCenter();
         this.border0.visible = true;
         this.border1.visible = true;
         this.border2.visible = true;
         this.border3.visible = true;
         this.center.visible = true;
      }
      
      override public function get width() : Number
      {
         return this.w;
      }
      
      override public function get height() : Number
      {
         return this.h;
      }
   }
}

