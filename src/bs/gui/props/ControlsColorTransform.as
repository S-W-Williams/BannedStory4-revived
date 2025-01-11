package bs.gui.props
{
   import bs.events.InterfaceEvent;
   import fl.controls.Label;
   import fl.controls.Slider;
   import fl.events.SliderEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import ion.geom.ColorMatrix;
   
   public class ControlsColorTransform extends Sprite
   {
      private var slBrightness:Slider;
      
      private var slContrast:Slider;
      
      private var slSaturation:Slider;
      
      private var slHue:Slider;
      
      private var slAlpha:Slider;
      
      private var matrix:ColorMatrix;
      
      private var filter:ColorMatrixFilter;
      
      public function ControlsColorTransform()
      {
         super();
         var _loc1_:Label = new Label();
         var _loc2_:Label = new Label();
         var _loc3_:Label = new Label();
         var _loc4_:Label = new Label();
         var _loc5_:Label = new Label();
         this.slBrightness = new Slider();
         this.slContrast = new Slider();
         this.slSaturation = new Slider();
         this.slHue = new Slider();
         this.slAlpha = new Slider();
         _loc1_.text = "Brightness";
         _loc2_.text = "Contrast";
         _loc3_.text = "Saturation";
         _loc4_.text = "Hue";
         _loc5_.text = "Alpha";
         _loc1_.setSize(60,22);
         _loc2_.setSize(60,22);
         _loc3_.setSize(60,22);
         _loc4_.setSize(60,22);
         _loc5_.setSize(60,22);
         this.slBrightness.setSize(200,22);
         this.slContrast.setSize(200,22);
         this.slSaturation.setSize(200,22);
         this.slHue.setSize(200,22);
         this.slAlpha.setSize(200,22);
         this.slBrightness.minimum = -100;
         this.slBrightness.value = 0;
         this.slBrightness.maximum = 100;
         this.slContrast.minimum = -100;
         this.slContrast.value = 0;
         this.slContrast.maximum = 100;
         this.slSaturation.minimum = -100;
         this.slSaturation.value = 0;
         this.slSaturation.maximum = 100;
         this.slHue.minimum = -180;
         this.slHue.value = 0;
         this.slHue.maximum = 180;
         this.slAlpha.minimum = 0;
         this.slAlpha.value = 1;
         this.slAlpha.maximum = 1;
         this.slAlpha.snapInterval = 0.01;
         _loc1_.x = 40;
         _loc1_.y = 15;
         _loc2_.x = _loc1_.x;
         _loc2_.y = _loc1_.y + _loc1_.height;
         _loc3_.x = _loc2_.x;
         _loc3_.y = _loc2_.y + _loc2_.height;
         this.slBrightness.x = _loc1_.x + _loc1_.width;
         this.slBrightness.y = _loc1_.y + 5;
         _loc4_.x = this.slBrightness.x + this.slBrightness.width + 20;
         _loc4_.y = _loc1_.y;
         _loc5_.x = _loc4_.x;
         _loc5_.y = _loc4_.y + _loc4_.height;
         this.slContrast.x = _loc2_.x + _loc2_.width;
         this.slContrast.y = _loc2_.y + 5;
         this.slSaturation.x = _loc3_.x + _loc3_.width;
         this.slSaturation.y = _loc3_.y + 5;
         this.slHue.x = _loc4_.x + _loc4_.width;
         this.slHue.y = _loc4_.y + 5;
         this.slAlpha.x = _loc5_.x + _loc5_.width;
         this.slAlpha.y = _loc5_.y + 5;
         this.slBrightness.addEventListener(SliderEvent.THUMB_DRAG,this.sliderChange);
         this.slContrast.addEventListener(SliderEvent.THUMB_DRAG,this.sliderChange);
         this.slSaturation.addEventListener(SliderEvent.THUMB_DRAG,this.sliderChange);
         this.slHue.addEventListener(SliderEvent.THUMB_DRAG,this.sliderChange);
         this.slAlpha.addEventListener(SliderEvent.THUMB_DRAG,this.sliderChange);
         this.addChild(_loc1_);
         this.addChild(_loc2_);
         this.addChild(_loc3_);
         this.addChild(_loc4_);
         this.addChild(_loc5_);
         this.addChild(this.slAlpha);
         this.addChild(this.slHue);
         this.addChild(this.slSaturation);
         this.addChild(this.slContrast);
         this.addChild(this.slBrightness);
      }
      
      private function sliderChange(param1:SliderEvent) : void
      {
         this.matrix.reset();
         this.matrix.adjustColor(this.slBrightness.value,this.slContrast.value,this.slSaturation.value,this.slHue.value,this.slAlpha.value);
         this.filter.matrix = this.matrix.matrix;
         this.dispatchEvent(new Event(InterfaceEvent.FILTER_COLOR_UPDATE));
      }
      
      public function set target(param1:ColorMatrixFilter) : void
      {
         this.filter = param1;
      }
      
      public function set colorMatrix(param1:ColorMatrix) : void
      {
         this.matrix = param1;
         if(param1 != null)
         {
            this.slBrightness.value = param1.brightness;
            this.slContrast.value = param1.contrast;
            this.slSaturation.value = param1.saturation;
            this.slHue.value = param1.hue;
            this.slAlpha.value = param1.alpha;
         }
      }
   }
}

