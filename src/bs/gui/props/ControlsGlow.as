package bs.gui.props
{
   import bs.events.InterfaceEvent;
   import bs.gui.item.LockButton;
   import fl.controls.CheckBox;
   import fl.controls.ColorPicker;
   import fl.controls.ComboBox;
   import fl.controls.Label;
   import fl.controls.NumericStepper;
   import fl.events.ColorPickerEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class ControlsGlow extends Sprite
   {
      private var stBX:NumericStepper;
      
      private var stBY:NumericStepper;
      
      private var stAlpha:NumericStepper;
      
      private var cpColor:ColorPicker;
      
      private var coQuality:ComboBox;
      
      private var ckExtract:CheckBox;
      
      private var ckInner:CheckBox;
      
      private var lock:LockButton;
      
      private var filter:GlowFilter;
      
      public function ControlsGlow()
      {
         var _loc3_:Label = null;
         var _loc4_:Label = null;
         super();
         var _loc1_:Label = new Label();
         var _loc2_:Label = new Label();
         _loc3_ = new Label();
         _loc4_ = new Label();
         var _loc5_:Label = new Label();
         this.stBX = new NumericStepper();
         this.stBY = new NumericStepper();
         this.cpColor = new ColorPicker();
         this.stAlpha = new NumericStepper();
         this.coQuality = new ComboBox();
         this.lock = new LockButton();
         this.ckExtract = new CheckBox();
         this.ckInner = new CheckBox();
         _loc1_.text = "Blur X";
         _loc2_.text = "Blur Y";
         _loc3_.text = "Alpha";
         _loc4_.text = "Quality";
         _loc5_.text = "Color";
         this.ckExtract.label = "Knock Out";
         this.ckInner.label = "Inner Shadow";
         _loc1_.setSize(50,22);
         _loc2_.setSize(50,22);
         _loc3_.setSize(50,22);
         _loc4_.setSize(50,22);
         _loc5_.setSize(50,22);
         this.coQuality.setSize(80,22);
         this.cpColor.setSize(20,20);
         this.coQuality.addItem({
            "label":"Low",
            "data":0
         });
         this.coQuality.addItem({
            "label":"Medium",
            "data":1
         });
         this.coQuality.addItem({
            "label":"High",
            "data":2
         });
         this.stAlpha.minimum = 0;
         this.stAlpha.maximum = 100;
         this.stBX.minimum = 0;
         this.stBX.maximum = 255;
         this.stBY.minimum = 0;
         this.stBY.maximum = 255;
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc2_.x = _loc1_.x;
         _loc2_.y = _loc1_.y + _loc2_.height;
         _loc3_.x = _loc2_.x;
         _loc3_.y = _loc2_.y + _loc2_.height;
         _loc4_.x = _loc2_.x;
         _loc4_.y = _loc3_.y + _loc3_.height + 2;
         this.stBX.x = _loc1_.x + _loc1_.width;
         this.stBX.y = _loc1_.y;
         this.stBY.x = _loc2_.x + _loc2_.width;
         this.stBY.y = _loc2_.y;
         this.stAlpha.x = _loc3_.x + _loc3_.width;
         this.stAlpha.y = _loc3_.y;
         this.lock.x = this.stBX.x + this.stBX.width + 2;
         this.lock.y = this.stBX.y + 10;
         this.lock.setSize(25,this.stBY.y + this.stBY.height - this.stBX.y - 20);
         _loc5_.x = this.lock.x + this.lock.width + 35;
         _loc5_.y = this.stBX.y;
         this.cpColor.x = _loc5_.x + _loc5_.width;
         this.cpColor.y = _loc5_.y;
         this.coQuality.x = _loc4_.x + _loc4_.width;
         this.coQuality.y = _loc4_.y;
         this.ckExtract.x = this.cpColor.x + this.cpColor.width + 20;
         this.ckExtract.y = _loc5_.y;
         this.ckInner.x = this.ckExtract.x;
         this.ckInner.y = _loc2_.y;
         this.stBX.addEventListener(Event.CHANGE,this.optionsChange);
         this.stBY.addEventListener(Event.CHANGE,this.optionsChange);
         this.stAlpha.addEventListener(Event.CHANGE,this.optionsChange);
         this.cpColor.addEventListener(ColorPickerEvent.CHANGE,this.optionsChange);
         this.coQuality.addEventListener(Event.CHANGE,this.optionsChange);
         this.ckExtract.addEventListener(MouseEvent.CLICK,this.optionsChange);
         this.ckInner.addEventListener(MouseEvent.CLICK,this.optionsChange);
         this.lock.addEventListener(Event.CHANGE,this.optionsChange);
         this.addChild(_loc1_);
         this.addChild(_loc2_);
         this.addChild(_loc3_);
         this.addChild(_loc4_);
         this.addChild(_loc5_);
         this.addChild(this.stBX);
         this.addChild(this.stBY);
         this.addChild(this.lock);
         this.addChild(this.stAlpha);
         this.addChild(this.cpColor);
         this.addChild(this.coQuality);
         this.addChild(this.ckExtract);
         this.addChild(this.ckInner);
      }
      
      private function optionsChange(param1:*) : void
      {
         if(this.lock.selected)
         {
            if(param1.currentTarget == this.stBY)
            {
               this.stBX.value = this.stBY.value;
            }
            else
            {
               this.stBY.value = this.stBX.value;
            }
         }
         this.filter.blurX = this.stBX.value;
         this.filter.blurY = this.stBY.value;
         this.filter.color = this.cpColor.selectedColor;
         this.filter.alpha = this.stAlpha.value / 100;
         this.filter.quality = this.coQuality.selectedItem.data;
         this.filter.inner = this.ckInner.selected;
         this.filter.knockout = this.ckExtract.selected;
         this.dispatchEvent(new Event(InterfaceEvent.FILTER_COLOR_UPDATE));
      }
      
      public function set target(param1:GlowFilter) : void
      {
         this.filter = param1;
         if(this.filter.blurX == this.filter.blurY)
         {
            this.lock.selected = true;
         }
         else
         {
            this.lock.selected = false;
         }
         this.stBX.value = this.filter.blurX;
         this.stBY.value = this.filter.blurY;
         this.cpColor.selectedColor = this.filter.color;
         this.stAlpha.value = this.filter.alpha * 100;
         this.coQuality.selectedIndex = this.filter.quality;
         this.ckExtract.selected = this.filter.knockout;
         this.ckInner.selected = this.filter.inner;
      }
   }
}

