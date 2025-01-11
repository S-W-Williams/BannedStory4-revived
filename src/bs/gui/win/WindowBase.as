package bs.gui.win
{
   import bs.gui.BaseSprite;
   import bs.gui.InterfaceAssets;
   import caurina.transitions.Tweener;
   import fl.controls.Label;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   
   public class WindowBase extends BaseSprite
   {
      private static var paddingTop:int = 0;
      
      private static var paddingBottom:int = 0;
      
      private static var paddingLeft:int = 0;
      
      private static var paddingRight:int = 0;
      
      protected var _width:int;
      
      protected var _height:int;
      
      protected var _modal:Boolean = false;
      
      protected var _modalTransparency:Number = 0.5;
      
      private var realWindow:Sprite;
      
      private var winHolder:Sprite;
      
      private var winTitle:Sprite;
      
      private var winTitleInner:Shape;
      
      private var winBackground:Shape;
      
      private var winLabel:Label;
      
      private var winClose:Sprite;
      
      private var winModalBG:Shape;
      
      private var winPadding:int = 6;
      
      private var winLabelFormat:TextFormat;
      
      public function WindowBase()
      {
         super();
         var _loc1_:Bitmap = new InterfaceAssets.windowClose();
         this.realWindow = new Sprite();
         this.winModalBG = new Shape();
         this.winClose = new Sprite();
         this.winHolder = new Sprite();
         this.winTitle = new Sprite();
         this.winTitleInner = new Shape();
         this.winBackground = new Shape();
         this.winLabel = new Label();
         this.winLabelFormat = new TextFormat(InterfaceAssets.pfRondaSeven,8,16777215,true);
         this.winLabel.setStyle("textFormat",this.winLabelFormat);
         this.winLabel.mouseEnabled = false;
         this.winLabel.mouseChildren = false;
         this.winLabel.filters = [new DropShadowFilter(1,45,0,0.5,2,2,2)];
         this.winClose.buttonMode = true;
         this.winClose.useHandCursor = true;
         this.winClose.addEventListener(MouseEvent.CLICK,this.closeWindow);
         this.winClose.addEventListener(MouseEvent.MOUSE_OVER,this.hoverClose);
         this.winClose.addEventListener(MouseEvent.MOUSE_OUT,this.hoverClose);
         this.winTitle.addEventListener(MouseEvent.MOUSE_DOWN,this.dragWindow);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.bringTopClick);
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.winClose.addChild(_loc1_);
         this.winTitle.addChild(this.winTitleInner);
         this.realWindow.addChild(this.winBackground);
         this.realWindow.addChild(this.winHolder);
         this.realWindow.addChild(this.winTitle);
         this.realWindow.addChild(this.winLabel);
         this.realWindow.addChild(this.winClose);
         super.addChild(this.winModalBG);
         super.addChild(this.realWindow);
      }
      
      public static function setPadding(param1:int, param2:int, param3:int, param4:int) : void
      {
         paddingTop = param1;
         paddingRight = param2;
         paddingBottom = param3;
         paddingLeft = param4;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         this.winHolder.addChild(param1);
         return param1;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         return this.winHolder.removeChild(param1);
      }
      
      public function open() : void
      {
         super.visible = true;
         super.alpha = 1;
         this.bringTopClick();
         this.dispatchEvent(new Event(Event.OPEN));
      }
      
      public function close() : void
      {
         super.visible = false;
         super.alpha = 0;
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      protected function resizeWindow(param1:int, param2:int) : void
      {
         var _loc4_:Graphics = this.winBackground.graphics;
         var _loc5_:Graphics = this.winTitleInner.graphics;
         var _loc6_:Matrix = new Matrix();
         _loc4_.clear();
         _loc5_.clear();
         this._width = param1;
         this._height = param2;
         _loc4_.beginFill(15790320);
         _loc4_.moveTo(0,0);
         _loc4_.lineTo(param1 + 2 * this.winPadding,0);
         _loc4_.lineStyle(0,8421504,1,true);
         _loc4_.lineTo(param1 + 2 * this.winPadding,param2 + 2 * this.winPadding - 6);
         _loc4_.curveTo(param1 + 2 * this.winPadding,param2 + 2 * this.winPadding,param1 + 2 * this.winPadding - 6,param2 + 2 * this.winPadding);
         _loc4_.lineTo(6,param2 + 2 * this.winPadding);
         _loc4_.curveTo(0,param2 + 2 * this.winPadding,0,param2 + 2 * this.winPadding - 6);
         _loc4_.lineTo(0,0);
         _loc4_.endFill();
         _loc6_.createGradientBox(this.winBackground.width,20,Math.PI / 2);
         _loc5_.lineStyle(0,5789784,1,true);
         _loc5_.beginGradientFill(GradientType.LINEAR,[8421504,11184810],[1,1],[0,255],_loc6_);
         _loc5_.drawRect(0,0,this.winBackground.width,20);
         _loc5_.endFill();
         this.winTitleInner.filters = [new GlowFilter(0,0.5,4,4,1,2,true)];
         this.winLabel.x = this.winTitleInner.x + 5;
         this.winLabel.y = this.winTitleInner.y + Math.floor((this.winTitleInner.height - this.winLabel.height) / 2);
         this.winBackground.x = 0;
         this.winBackground.y = this.winTitleInner.height;
         this.winHolder.x = this.winBackground.x + Math.floor((this.winBackground.width - param1) / 2);
         this.winHolder.y = this.winBackground.y + Math.floor((this.winBackground.height - param2) / 2);
         this.winClose.x = this.winTitleInner.x + this.winTitleInner.width - this.winClose.width - 2;
         this.winClose.y = Math.floor((this.winTitleInner.height - this.winClose.height) / 2);
         this.onStageResize();
      }
      
      protected function hideComplete() : void
      {
         super.visible = false;
         this.checkArrangement();
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function checkArrangement() : void
      {
         if(this.stage == null)
         {
            return;
         }
         if(this.realWindow.x + this.width < paddingLeft)
         {
            this.realWindow.x = paddingLeft;
         }
         else if(this.realWindow.x > stage.stageWidth - paddingRight)
         {
            this.realWindow.x = stage.stageWidth - paddingRight - this.width;
         }
         if(this.realWindow.y < paddingTop)
         {
            this.realWindow.y = paddingTop;
         }
         else if(this.realWindow.y > stage.stageHeight - paddingBottom)
         {
            this.realWindow.y = stage.stageHeight - paddingBottom - this.height;
         }
      }
      
      private function hoverClose(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_OVER)
         {
            this.winClose.alpha = 0.7;
         }
         else
         {
            this.winClose.alpha = 1;
         }
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.stopDragWindow);
         this.checkArrangement();
         this.modal = this._modal;
      }
      
      private function stopDragWindow(param1:MouseEvent) : void
      {
         stopDrag();
         this.checkArrangement();
      }
      
      private function bringTopClick(param1:MouseEvent = null) : void
      {
         super.parent.addChild(this);
      }
      
      private function dragWindow(param1:MouseEvent) : void
      {
         this.realWindow.startDrag();
      }
      
      private function closeWindow(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function onStageResize() : void
      {
         if(!this._modal)
         {
            return;
         }
         this.winModalBG.width = _stageWidth;
         this.winModalBG.height = _stageHeight;
         this.realWindow.x = Math.floor((_stageWidth - this.winBackground.width) / 2);
         this.realWindow.y = Math.floor((_stageHeight - this.winBackground.height) / 2);
      }
      
      public function set modalTransparency(param1:Number) : void
      {
         if(param1 < 0 || param1 > 1)
         {
            return;
         }
         this._modalTransparency = param1;
         this.modal = this._modal;
      }
      
      public function get modalTransparency() : Number
      {
         return this._modalTransparency;
      }
      
      public function set modal(param1:Boolean) : void
      {
         this._modal = param1;
         this.winModalBG.graphics.clear();
         if(this._modal)
         {
            this.winModalBG.graphics.beginFill(0,this._modalTransparency);
            this.winModalBG.graphics.drawRect(0,0,100,100);
            this.winModalBG.graphics.endFill();
            this.winTitle.removeEventListener(MouseEvent.MOUSE_DOWN,this.dragWindow);
         }
         else
         {
            this.winTitle.addEventListener(MouseEvent.MOUSE_DOWN,this.dragWindow);
         }
      }
      
      public function get modal() : Boolean
      {
         return this._modal;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1)
         {
            super.visible = param1;
            Tweener.addTween(this,{
               "alpha":1,
               "time":0.4
            });
            this.bringTopClick();
         }
         else
         {
            Tweener.addTween(this,{
               "alpha":0,
               "time":0.4,
               "onComplete":this.hideComplete
            });
         }
      }
      
      public function set label(param1:String) : void
      {
         this.winLabel.text = param1;
      }
      
      public function get label() : String
      {
         return this.winLabel.text;
      }
      
      override public function get width() : Number
      {
         return this.winBackground.x + this.winBackground.width;
      }
      
      override public function get height() : Number
      {
         return this.winBackground.y + this.winBackground.height;
      }
      
      override public function set x(param1:Number) : void
      {
         this.realWindow.x = Math.floor(param1);
         this.checkArrangement();
      }
      
      override public function get x() : Number
      {
         return this.realWindow.x;
      }
      
      override public function set y(param1:Number) : void
      {
         this.realWindow.y = Math.floor(param1);
         this.checkArrangement();
      }
      
      override public function get y() : Number
      {
         return this.realWindow.y;
      }
   }
}

