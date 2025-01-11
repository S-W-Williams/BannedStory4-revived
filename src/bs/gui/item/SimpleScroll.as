package bs.gui.item
{
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class SimpleScroll extends Sprite
   {
      private const minBarDim:int = 40;
      
      private var base:Sprite;
      
      private var bar:Sprite;
      
      private var dispRef:DisplayObject;
      
      private var recRef:Rectangle;
      
      private var outLeft:int;
      
      private var outRight:int;
      
      private var _width:int = 100;
      
      private var _height:int = 20;
      
      private var _useVertical:Boolean = false;
      
      public function SimpleScroll()
      {
         super();
         this.base = new Sprite();
         this.bar = new Sprite();
         this.base.graphics.lineStyle(0,13553358,1,true);
         this.base.graphics.beginFill(14803425);
         this.base.graphics.drawRect(0,0,50,50);
         this.base.graphics.endFill();
         this.drawBar();
         this.base.addEventListener(MouseEvent.CLICK,this.baseClick);
         this.bar.addEventListener(MouseEvent.MOUSE_DOWN,this.barClick);
         this.bar.addEventListener(MouseEvent.MOUSE_UP,this.barRelease);
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.addChild(this.base);
         this.addChild(this.bar);
      }
      
      public function updateBar(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         this.dispRef = param1;
         this.recRef = this.dispRef.getBounds(this.dispRef.parent);
         if(this._useVertical)
         {
            this.outLeft = this.recRef.y - this.dispRef.y;
            this.outRight = this.recRef.y + this.recRef.height - (this.dispRef.y + this._height);
            this.outLeft = this.outLeft > 0 ? 0 : int(Math.abs(this.outLeft));
            this.outRight = this.outRight < 0 ? 0 : this.outRight;
            if(this.outLeft > 0 || this.outRight > 0)
            {
               _loc2_ = this._height - this.outLeft - this.outRight;
               _loc2_ = _loc2_ < this.minBarDim ? this.minBarDim : _loc2_;
               this.visible = true;
               this.bar.height = _loc2_;
            }
            else
            {
               this.visible = false;
               this.bar.height = 0;
               this.bar.y = 0;
            }
            this.percent = (this.y - this.recRef.y - this.dispRef.parent.y) / (this.outLeft + this.outRight);
            if(this.bar.y < 0)
            {
               this.bar.y = 0;
            }
            if(this.bar.y + this.bar.height > this.base.y + this.base.height)
            {
               this.bar.y = this.base.y + this.base.height - this.bar.height;
            }
         }
         else
         {
            this.outLeft = this.recRef.x - this.dispRef.x;
            this.outRight = this.recRef.x + this.recRef.width - (this.dispRef.x + this._width);
            this.outLeft = this.outLeft > 0 ? 0 : int(Math.abs(this.outLeft));
            this.outRight = this.outRight < 0 ? 0 : this.outRight;
            if(this.outLeft > 0 || this.outRight > 0)
            {
               _loc3_ = this._width - this.outLeft - this.outRight;
               _loc3_ = _loc3_ < this.minBarDim ? this.minBarDim : _loc3_;
               this.visible = true;
               this.bar.width = _loc3_;
            }
            else
            {
               this.visible = false;
               this.bar.width = 0;
               this.bar.x = 0;
            }
            this.percent = (this.x - this.recRef.x - this.dispRef.parent.x) / (this.outLeft + this.outRight);
            if(this.bar.x < 0)
            {
               this.bar.x = 0;
            }
            if(this.bar.x + this.bar.width > this.base.x + this.base.width)
            {
               this.bar.x = this.base.x + this.base.width - this.bar.width;
            }
         }
         this.loopBar();
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this._width = param1;
         this._height = param2;
         if(this._useVertical)
         {
            this.bar.width = this._width;
         }
         else
         {
            this.bar.height = this._height;
         }
         this.base.width = this._width;
         this.base.height = this._height;
         this.updateBar(this.dispRef);
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.barRelease);
      }
      
      private function baseClick(param1:MouseEvent) : void
      {
         var _loc2_:Number = this._useVertical ? param1.stageY / this._height : param1.stageX / this._width;
         this.percent = _loc2_;
      }
      
      private function barClick(param1:MouseEvent) : void
      {
         this.bar.addEventListener(Event.ENTER_FRAME,this.loopBar);
         if(this._useVertical)
         {
            this.bar.startDrag(false,new Rectangle(this.base.x,this.base.y,0,this._height - this.bar.height));
         }
         else
         {
            this.bar.startDrag(false,new Rectangle(this.base.x,this.base.y,this._width - this.bar.width,0));
         }
      }
      
      private function barRelease(param1:MouseEvent) : void
      {
         this.bar.removeEventListener(Event.ENTER_FRAME,this.loopBar);
         stopDrag();
      }
      
      private function loopBar(param1:Event = null) : void
      {
         if(this.dispRef == null)
         {
            return;
         }
         if(this._useVertical)
         {
            this.dispRef.parent.y = Math.floor(this.y - this.recRef.y - this.percent * (this.outLeft + this.outRight));
         }
         else
         {
            this.dispRef.parent.x = Math.floor(this.x - this.recRef.x - this.percent * (this.outLeft + this.outRight));
         }
      }
      
      private function drawBar() : void
      {
         var _loc1_:Matrix = new Matrix();
         if(this._useVertical)
         {
            _loc1_.createGradientBox(50,50,0);
         }
         else
         {
            _loc1_.createGradientBox(50,50,Math.PI / 2);
         }
         this.bar.graphics.clear();
         this.bar.graphics.lineStyle(0,22446,1,true);
         this.bar.graphics.beginGradientFill(GradientType.LINEAR,[9948159,33023,33023,9948159],[1,1,1,1],[0,70,255 - 70,255],_loc1_);
         this.bar.graphics.drawRect(0,0,50,50);
         this.bar.graphics.endFill();
      }
      
      public function set useVertical(param1:Boolean) : void
      {
         this._useVertical = param1;
         this.drawBar();
         this.updateBar(this.dispRef);
      }
      
      public function get useVertical() : Boolean
      {
         return this._useVertical;
      }
      
      public function get percent() : Number
      {
         if(this._useVertical)
         {
            return this.bar.y / (this.base.height - this.bar.height);
         }
         return this.bar.x / (this.base.width - this.bar.width);
      }
      
      public function set percent(param1:Number) : void
      {
         if(this._useVertical)
         {
            this.bar.y = Math.floor(param1 * (this.base.height - this.bar.height));
         }
         else
         {
            this.bar.x = Math.floor(param1 * (this.base.width - this.bar.width));
         }
         this.loopBar();
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         if(this._useVertical)
         {
            this.bar.width = this._width;
         }
         this.base.width = this._width;
         this.updateBar(this.dispRef);
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = param1;
         if(!this._useVertical)
         {
            this.bar.height = this._height;
         }
         this.base.height = this._height;
         this.updateBar(this.dispRef);
      }
   }
}

