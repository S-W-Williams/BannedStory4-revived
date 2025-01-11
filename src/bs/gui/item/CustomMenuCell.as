package bs.gui.item
{
   import bs.gui.InterfaceAssets;
   import com.yahoo.astra.fl.controls.menuClasses.MenuCellRenderer;
   import fl.controls.Label;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   
   public class CustomMenuCell extends MenuCellRenderer
   {
      private var imgIcon:Bitmap;
      
      private var short:Label;
      
      private var previousShortX:Array;
      
      private var labelOffset:int = 22;
      
      public function CustomMenuCell()
      {
         super();
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
         if(_data.icon is String && this.imgIcon == null)
         {
            _loc1_ = InterfaceAssets[_data.icon];
            if(_loc1_ is BitmapData)
            {
               this.imgIcon = new Bitmap(_loc1_.clone());
            }
            else if(_loc1_ == null)
            {
               this.imgIcon = new Bitmap();
            }
            else
            {
               this.imgIcon = new _loc1_();
            }
            if(this.imgIcon.height > this.height - 4)
            {
               this.imgIcon.height = this.height - 4;
               this.imgIcon.scaleX = this.imgIcon.scaleY;
               this.imgIcon.smoothing = true;
            }
            this.addChild(this.imgIcon);
         }
         if(this.imgIcon != null)
         {
            this.imgIcon.x = 2;
            this.imgIcon.y = Math.floor((this.height - this.imgIcon.height) / 2);
         }
         this.textField.x = this.labelOffset;
         if(_data.shortcut is String && this.short == null)
         {
            this.short = new Label();
            this.short.autoSize = TextFieldAutoSize.LEFT;
            this.short.text = _data.shortcut;
            this.previousShortX = [this.short.x,-999,-999];
            this.short.addEventListener(Event.ENTER_FRAME,this.loop);
            this.short.addEventListener(Event.REMOVED_FROM_STAGE,this.shortRemovedFromStage);
            this.addChild(this.short);
         }
      }
      
      private function shortRemovedFromStage(param1:Event = null) : void
      {
         this.short.removeEventListener(Event.REMOVED_FROM_STAGE,this.shortRemovedFromStage);
         this.short.removeEventListener(Event.ENTER_FRAME,this.loop);
      }
      
      private function loop(param1:Event) : void
      {
         if(this.short != null)
         {
            this.previousShortX.shift();
            this.previousShortX.push(this.short.x);
            this.short.x = this.width - this.short.width;
            this.short.y = this.textField.y;
            if(this.previousShortX[0] == this.previousShortX[1] && this.previousShortX[0] == this.previousShortX[2])
            {
               this.shortRemovedFromStage();
            }
         }
      }
   }
}

