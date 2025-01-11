package bs.gui.item
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import fl.controls.listClasses.CellRenderer;
   import flash.display.Bitmap;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CustomListCell extends CellRenderer
   {
      private var _layerVisible:Boolean = true;
      
      private var eyeWait:Timer;
      
      private var spEye:Sprite;
      
      public function CustomListCell()
      {
         var _loc2_:Bitmap = null;
         super();
         this.mouseChildren = true;
         this.spEye = new Sprite();
         this.eyeWait = new Timer(10);
         var _loc1_:Bitmap = new Bitmap(InterfaceAssets.eyeOn);
         _loc2_ = new Bitmap(InterfaceAssets.eyeOff);
         _loc1_.visible = true;
         _loc2_.visible = false;
         this.spEye.addEventListener(MouseEvent.CLICK,this.eyeClick);
         this.eyeWait.addEventListener(TimerEvent.TIMER,this.eyeLoop);
         this.spEye.addChild(_loc1_);
         this.spEye.addChild(_loc2_);
         this.addChild(this.spEye);
      }
      
      private function eyeLoop(param1:TimerEvent) : void
      {
         this.eyeWait.stop();
         this.spEye.getChildAt(0).visible = !this.spEye.getChildAt(0).visible;
         this.spEye.getChildAt(1).visible = !this.spEye.getChildAt(1).visible;
         this._layerVisible = this.spEye.getChildAt(0).visible;
         this.dispatchEvent(new Event(InterfaceEvent.CUSTOM_CELL_VISIBLE,true));
      }
      
      private function eyeClick(param1:MouseEvent) : void
      {
         this.eyeWait.reset();
         this.eyeWait.start();
      }
      
      override protected function draw() : void
      {
         var _loc1_:* = undefined;
         try
         {
            super.draw();
         }
         catch(err:*)
         {
         }
         this.spEye.x = 3;
         this.spEye.y = Math.floor((this.height - this.spEye.height) / 2);
         this.icon.x = this.spEye.x + this.spEye.width + 4;
         this.textField.x = this.icon.x + this.icon.width + 4;
         var _loc2_:int = this.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.getChildAt(_loc3_);
            if(_loc1_ != this.spEye && _loc1_ is InteractiveObject)
            {
               _loc1_.mouseEnabled = false;
            }
            _loc3_++;
         }
         if(_data.layerVisible != undefined)
         {
            this._layerVisible = _data.layerVisible;
            this.spEye.getChildAt(0).visible = this._layerVisible;
            this.spEye.getChildAt(1).visible = !this._layerVisible;
         }
      }
      
      public function get layerVisible() : Boolean
      {
         return this._layerVisible;
      }
      
      public function set layerVisible(param1:Boolean) : void
      {
         this._layerVisible = param1;
         this.spEye.getChildAt(0).visible = this._layerVisible;
         this.spEye.getChildAt(1).visible = !this._layerVisible;
      }
   }
}

