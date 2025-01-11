package bs.gui.item
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import caurina.transitions.Tweener;
   import fl.controls.Button;
   import fl.controls.ComboBox;
   import fl.controls.Label;
   import fl.controls.NumericStepper;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ion.components.controls.IToolTip;
   import maplestory.utils.ResourceCache;
   
   public class SliderBox extends Sprite
   {
      private var sh:Shape;
      
      private var holder:Sprite;
      
      private var sliderBoxMask:Shape;
      
      private var _open:Boolean = false;
      
      private var stBrightness:NumericStepper;
      
      private var stContrast:NumericStepper;
      
      private var stSaturation:NumericStepper;
      
      private var stHue:NumericStepper;
      
      private var stAlpha:NumericStepper;
      
      private var coClients:ComboBox;
      
      public function SliderBox()
      {
         var _loc2_:Label = null;
         var _loc3_:Button = null;
         var _loc5_:Bitmap = null;
         var _loc6_:Bitmap = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Bitmap = null;
         super();
         var _loc1_:Label = new Label();
         _loc2_ = new Label();
         _loc3_ = new Button();
         var _loc4_:Bitmap = new InterfaceAssets.colorBrightness();
         _loc5_ = new InterfaceAssets.colorContrast();
         _loc6_ = new InterfaceAssets.colorSaturation();
         _loc7_ = new InterfaceAssets.colorWheel();
         _loc8_ = new InterfaceAssets.colorAlpha();
         this.holder = new Sprite();
         this.sliderBoxMask = new Shape();
         this.sh = new Shape();
         this.stBrightness = new NumericStepper();
         this.stContrast = new NumericStepper();
         this.stSaturation = new NumericStepper();
         this.stHue = new NumericStepper();
         this.stAlpha = new NumericStepper();
         this.coClients = new ComboBox();
         this.coClients.setSize(175,20);
         _loc3_.setSize(14,14);
         _loc3_.label = "";
         _loc3_.setStyle("icon",new Bitmap(InterfaceAssets.refreshSmall));
         this.coClients.dropdown.setRendererStyle("upSkin",Shape);
         _loc1_.text = "Color Transform";
         _loc2_.text = "Game Client";
         this.stBrightness.minimum = -100;
         this.stBrightness.value = 0;
         this.stBrightness.maximum = 100;
         this.stContrast.minimum = -100;
         this.stContrast.value = 0;
         this.stContrast.maximum = 100;
         this.stSaturation.minimum = -100;
         this.stSaturation.value = 0;
         this.stSaturation.maximum = 100;
         this.stHue.minimum = -180;
         this.stHue.value = 0;
         this.stHue.maximum = 180;
         this.stAlpha.minimum = 0;
         this.stAlpha.value = 1;
         this.stAlpha.maximum = 1;
         this.stAlpha.stepSize = 0.01;
         this.stBrightness.setSize(60,22);
         this.stContrast.setSize(60,22);
         this.stSaturation.setSize(60,22);
         this.stHue.setSize(60,22);
         this.stAlpha.setSize(60,22);
         _loc2_.x = 5;
         _loc2_.y = 0;
         this.coClients.x = _loc2_.x;
         this.coClients.y = _loc2_.y + _loc2_.height;
         _loc1_.x = this.coClients.x;
         _loc1_.y = this.coClients.y + this.coClients.height + 10;
         this.stBrightness.x = _loc1_.x + 20;
         this.stBrightness.y = _loc1_.y + _loc1_.height + 5;
         this.stContrast.x = this.stBrightness.x;
         this.stContrast.y = this.stBrightness.y + this.stBrightness.height + 2;
         this.stSaturation.x = this.stContrast.x;
         this.stSaturation.y = this.stContrast.y + this.stContrast.height + 2;
         this.stHue.x = 180 - this.stHue.width;
         this.stHue.y = this.stBrightness.y;
         this.stAlpha.x = this.stHue.x;
         this.stAlpha.y = this.stHue.y + this.stHue.height + 2;
         _loc4_.x = _loc1_.x;
         _loc4_.y = this.stBrightness.y + 2;
         _loc5_.x = _loc4_.x;
         _loc5_.y = this.stContrast.y + 2;
         _loc6_.x = _loc5_.x;
         _loc6_.y = this.stSaturation.y + 2;
         _loc7_.x = this.stHue.x - _loc7_.width - 4;
         _loc7_.y = this.stHue.y + 2;
         _loc8_.x = _loc7_.x;
         _loc8_.y = this.stAlpha.y + 2;
         _loc3_.x = 180 - _loc3_.width;
         _loc3_.y = this.stSaturation.y + this.stSaturation.height - _loc3_.height;
         IToolTip.setTarget(this.stBrightness,"Brightness");
         IToolTip.setTarget(this.stContrast,"Contrast");
         IToolTip.setTarget(this.stSaturation,"Saturation");
         IToolTip.setTarget(this.stHue,"Hue");
         IToolTip.setTarget(this.stAlpha,"Alpha");
         IToolTip.setTarget(_loc3_,"Reset");
         this.stBrightness.addEventListener(Event.CHANGE,this.colorChange);
         this.stContrast.addEventListener(Event.CHANGE,this.colorChange);
         this.stSaturation.addEventListener(Event.CHANGE,this.colorChange);
         this.stHue.addEventListener(Event.CHANGE,this.colorChange);
         this.stAlpha.addEventListener(Event.CHANGE,this.colorChange);
         _loc3_.addEventListener(MouseEvent.CLICK,this.resetControlsClick);
         this.coClients.addEventListener(Event.CHANGE,this.clientChange);
         this.sh.graphics.beginFill(15790320);
         this.sh.graphics.lineStyle(0,8421504,1,true);
         this.sh.graphics.drawRoundRect(0,0,this.stAlpha.x + this.stAlpha.width + 50,_loc3_.y + _loc3_.height + 10,6);
         this.sh.graphics.endFill();
         this.sliderBoxMask.graphics.beginFill(0);
         this.sliderBoxMask.graphics.drawRect(0,0,this.sh.width + 10,this.sh.height + 10);
         this.sliderBoxMask.graphics.endFill();
         this.holder.mask = this.sliderBoxMask;
         this.sliderBoxMask.x = -this.sliderBoxMask.width;
         this.sliderBoxMask.y = this.sh.y + Math.floor((this.sh.height - this.sliderBoxMask.height) / 2);
         this.holder.addChild(this.sh);
         this.holder.addChild(_loc2_);
         this.holder.addChild(this.coClients);
         this.holder.addChild(_loc1_);
         this.holder.addChild(_loc4_);
         this.holder.addChild(_loc5_);
         this.holder.addChild(_loc6_);
         this.holder.addChild(_loc7_);
         this.holder.addChild(_loc8_);
         this.holder.addChild(this.stBrightness);
         this.holder.addChild(this.stContrast);
         this.holder.addChild(this.stHue);
         this.holder.addChild(this.stSaturation);
         this.holder.addChild(this.stAlpha);
         this.holder.addChild(_loc3_);
         this.addChild(this.holder);
         this.addChild(this.sliderBoxMask);
      }
      
      public function reset() : void
      {
         this.stBrightness.value = 0;
         this.stContrast.value = 0;
         this.stSaturation.value = 0;
         this.stHue.value = 0;
         this.stAlpha.value = 1;
      }
      
      public function open() : void
      {
         this._open = true;
         Tweener.addTween(this.holder,{
            "x":-190,
            "time":0.4,
            "transition":"easeOutBack"
         });
      }
      
      public function close() : void
      {
         this._open = false;
         Tweener.addTween(this.holder,{
            "x":0,
            "time":0.4
         });
      }
      
      public function clientReference(param1:String, param2:String) : void
      {
         var _loc3_:Array = ResourceCache.getClients(param1);
         var _loc4_:int = 0;
         this.coClients.removeAll();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_].client == param2)
            {
               _loc4_ = _loc5_;
            }
            this.coClients.addItem(_loc3_[_loc5_]);
            _loc5_++;
         }
         this.coClients.selectedIndex = _loc4_;
      }
      
      private function colorChange(param1:Event) : void
      {
         this.dispatchEvent(new Event(InterfaceEvent.ITEM_COLOR));
      }
      
      private function resetControlsClick(param1:MouseEvent) : void
      {
         this.reset();
         this.dispatchEvent(new Event(InterfaceEvent.ITEM_RESET_COLOR));
      }
      
      private function clientChange(param1:Event) : void
      {
         this.dispatchEvent(new Event(InterfaceEvent.ITEM_CLIENT_CHANGE,true));
      }
      
      public function get selectedGameClient() : String
      {
         if(this.coClients.dataProvider.length <= 0)
         {
            return null;
         }
         return this.coClients.selectedItem.client;
      }
      
      public function get isOpen() : Boolean
      {
         return this._open;
      }
      
      public function get cBrightness() : Number
      {
         return this.stBrightness.value;
      }
      
      public function set cBrightness(param1:Number) : void
      {
         this.stBrightness.value = param1;
      }
      
      public function get cContrast() : Number
      {
         return this.stContrast.value;
      }
      
      public function set cContrast(param1:Number) : void
      {
         this.stContrast.value = param1;
      }
      
      public function get cSaturation() : Number
      {
         return this.stSaturation.value;
      }
      
      public function set cSaturation(param1:Number) : void
      {
         this.stSaturation.value = param1;
      }
      
      public function get cHue() : Number
      {
         return this.stHue.value;
      }
      
      public function set cHue(param1:Number) : void
      {
         this.stHue.value = param1;
      }
      
      public function get cAlpha() : Number
      {
         return this.stAlpha.value;
      }
      
      public function set cAlpha(param1:Number) : void
      {
         this.stAlpha.value = param1;
      }
      
      override public function get width() : Number
      {
         return this.sh.width;
      }
      
      override public function get height() : Number
      {
         return this.sh.height;
      }
   }
}

