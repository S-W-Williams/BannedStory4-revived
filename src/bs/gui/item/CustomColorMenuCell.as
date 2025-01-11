package bs.gui.item
{
   import com.yahoo.astra.fl.controls.menuClasses.MenuCellRenderer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   
   public class CustomColorMenuCell extends MenuCellRenderer
   {
      private var imgIcon:Bitmap;
      
      private var labelOffset:int = 22;
      
      public function CustomColorMenuCell()
      {
         super();
      }
      
      override protected function draw() : void
      {
         try
         {
            super.draw();
         }
         catch(err:*)
         {
         }
         if(_data.color is String && this.imgIcon == null)
         {
            this.imgIcon = new Bitmap(new BitmapData(18,18,false,parseInt(_data.color)));
            this.imgIcon.filters = [new GlowFilter(0,0.7,2,2,1,1,true)];
            this.addChild(this.imgIcon);
         }
         if(this.imgIcon != null)
         {
            this.imgIcon.x = 2;
            this.imgIcon.y = Math.floor((this.height - this.imgIcon.height) / 2);
         }
         this.textField.x = this.labelOffset;
      }
   }
}

