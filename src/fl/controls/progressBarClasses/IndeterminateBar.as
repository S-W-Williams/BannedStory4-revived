package fl.controls.progressBarClasses
{
   import fl.core.InvalidationType;
   import fl.core.UIComponent;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class IndeterminateBar extends UIComponent
   {
      private static var defaultStyles:Object = {"indeterminateSkin":"ProgressBar_indeterminateSkin"};
      
      protected var bar:Sprite;
      
      protected var barMask:Sprite;
      
      protected var patternBmp:BitmapData;
      
      protected var animationCount:uint = 0;
      
      public function IndeterminateBar()
      {
         super();
         setSize(0,0);
         startAnimation();
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles;
      }
      
      protected function drawBar() : void
      {
         var _loc1_:Graphics = null;
         if(patternBmp == null)
         {
            return;
         }
         _loc1_ = bar.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(patternBmp);
         _loc1_.drawRect(0,0,_width + patternBmp.width,_height);
         _loc1_.endFill();
      }
      
      protected function drawMask() : void
      {
         var _loc1_:Graphics = null;
         _loc1_ = barMask.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(0,0,_width,_height);
         _loc1_.endFill();
      }
      
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1)
         {
            startAnimation();
         }
         else
         {
            stopAnimation();
         }
         super.visible = param1;
      }
      
      protected function startAnimation() : void
      {
         addEventListener(Event.ENTER_FRAME,handleEnterFrame,false,0,true);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.STYLES))
         {
            drawPattern();
            invalidate(InvalidationType.SIZE,false);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            drawBar();
            drawMask();
         }
         super.draw();
      }
      
      override protected function configUI() : void
      {
         bar = new Sprite();
         addChild(bar);
         barMask = new Sprite();
         addChild(barMask);
         bar.mask = barMask;
      }
      
      protected function stopAnimation() : void
      {
         removeEventListener(Event.ENTER_FRAME,handleEnterFrame);
      }
      
      protected function drawPattern() : void
      {
         var _loc1_:DisplayObject = null;
         _loc1_ = getDisplayObjectInstance(getStyleValue("indeterminateSkin"));
         if(patternBmp)
         {
            patternBmp.dispose();
         }
         patternBmp = new BitmapData(_loc1_.width << 0,_loc1_.height << 0,true,0);
         patternBmp.draw(_loc1_);
      }
      
      protected function handleEnterFrame(param1:Event) : void
      {
         if(patternBmp == null)
         {
            return;
         }
         animationCount = (animationCount + 2) % patternBmp.width;
         bar.x = -animationCount;
      }
   }
}

