package bs.gui.props
{
   import bs.events.InterfaceEvent;
   import bs.gui.item.LockButton;
   import fl.controls.ComboBox;
   import fl.controls.Label;
   import fl.controls.NumericStepper;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   
   public class ControlsBlur extends Sprite
   {
      private var stBX:NumericStepper;
      
      private var stBY:NumericStepper;
      
      private var coQuality:ComboBox;
      
      private var lock:LockButton;
      
      private var filter:BlurFilter;
      
      public function ControlsBlur()
      {
         var _loc3_:Label = null;
         super();
         var _loc1_:Label = new Label();
         var _loc2_:Label = new Label();
         _loc3_ = new Label();
         this.stBX = new NumericStepper();
         this.stBY = new NumericStepper();
         this.coQuality = new ComboBox();
         this.lock = new LockButton();
         _loc1_.text = "Blur X";
         _loc2_.text = "Blur Y";
         _loc3_.text = "Quality";
         _loc1_.setSize(50,22);
         _loc2_.setSize(50,22);
         _loc3_.setSize(50,22);
         this.coQuality.setSize(80,22);
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
         this.stBX.minimum = 0;
         this.stBX.maximum = 255;
         this.stBY.minimum = 0;
         this.stBY.maximum = 255;
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc2_.x = _loc1_.x;
         _loc2_.y = _loc1_.y + _loc2_.height;
         _loc3_.x = _loc2_.x;
         _loc3_.y = _loc2_.y + 2 * _loc2_.height + 2;
         this.stBX.x = _loc1_.x + _loc1_.width;
         this.stBX.y = _loc1_.y;
         this.stBY.x = _loc2_.x + _loc2_.width;
         this.stBY.y = _loc2_.y;
         this.lock.x = this.stBX.x + this.stBX.width + 2;
         this.lock.y = this.stBX.y + 10;
         this.lock.setSize(25,this.stBY.y + this.stBY.height - this.stBX.y - 20);
         this.coQuality.x = _loc3_.x + _loc3_.width;
         this.coQuality.y = _loc3_.y;
         this.stBX.addEventListener(Event.CHANGE,this.optionsChange);
         this.stBY.addEventListener(Event.CHANGE,this.optionsChange);
         this.coQuality.addEventListener(Event.CHANGE,this.optionsChange);
         this.lock.addEventListener(Event.CHANGE,this.optionsChange);
         this.addChild(_loc1_);
         this.addChild(_loc2_);
         this.addChild(_loc3_);
         this.addChild(this.stBX);
         this.addChild(this.stBY);
         this.addChild(this.lock);
         this.addChild(this.coQuality);
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
         this.filter.quality = this.coQuality.selectedItem.data;
         this.dispatchEvent(new Event(InterfaceEvent.FILTER_COLOR_UPDATE));
      }
      
      public function set target(param1:BlurFilter) : void
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
         this.coQuality.selectedIndex = this.filter.quality;
      }
   }
}

