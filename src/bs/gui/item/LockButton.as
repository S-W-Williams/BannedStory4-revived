package bs.gui.item
{
   import bs.gui.InterfaceAssets;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class LockButton extends Sprite
   {
      private var _width:int = 50;
      
      private var _height:int = 100;
      
      private var _selected:Boolean;
      
      private var bpOpen:Bitmap;
      
      private var bpClosed:Bitmap;
      
      private var bg:Shape;
      
      public function LockButton()
      {
         super();
         this.bpOpen = new InterfaceAssets.lockOpen();
         this.bpClosed = new InterfaceAssets.lockClosed();
         this.bg = new Shape();
         this.bpOpen.height = 10;
         this.bpClosed.height = 10;
         this.bpOpen.scaleX = this.bpOpen.scaleY;
         this.bpClosed.scaleX = this.bpClosed.scaleY;
         this.bpOpen.smoothing = true;
         this.bpClosed.smoothing = true;
         this.selected = true;
         this.addEventListener(MouseEvent.CLICK,this.changeState);
         this.addChild(this.bg);
         this.addChild(this.bpOpen);
         this.addChild(this.bpClosed);
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this._width = param1;
         this._height = param2;
         this.selected = this._selected;
      }
      
      private function changeState(param1:MouseEvent) : void
      {
         this.selected = !this._selected;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this._selected = param1;
         this.bg.graphics.clear();
         this.bpOpen.visible = false;
         this.bpClosed.visible = false;
         this.bg.graphics.beginFill(0,0);
         this.bg.graphics.drawRect(0,0,this._width,this._height);
         this.bg.graphics.endFill();
         if(param1)
         {
            this.bpClosed.visible = true;
            _loc2_ = this._width / 2;
            _loc3_ = this._height / 2;
            _loc4_ = this.bpClosed.height / 2;
            this.bg.graphics.lineStyle(0,8026746);
            this.bg.graphics.moveTo(0,0);
            this.bg.graphics.lineTo(_loc2_,0);
            this.bg.graphics.lineTo(_loc2_,_loc3_ - _loc4_);
            this.bg.graphics.moveTo(_loc2_,_loc3_ + _loc4_);
            this.bg.graphics.lineTo(_loc2_,this._height);
            this.bg.graphics.lineTo(0,this._height);
            this.bpClosed.x = Math.floor((this._width - this.bpClosed.width) / 2);
            this.bpClosed.y = Math.floor((this._height - this.bpClosed.height) / 2);
         }
         else
         {
            this.bpOpen.visible = true;
            this.bpOpen.x = Math.floor((this._width - this.bpOpen.width) / 2);
            this.bpOpen.y = Math.floor((this._height - this.bpOpen.height) / 2);
         }
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = Math.floor(param1);
         this.selected = this._selected;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = Math.floor(this._height);
         this.selected = this._selected;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
   }
}

