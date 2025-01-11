package transtool.tool
{
   import bs.gui.InterfaceAssets;
   import flash.display.BitmapData;
   
   public class TransformToolMoveCursor extends TransformToolInternalCursor
   {
      public function TransformToolMoveCursor()
      {
         super();
      }
      
      override public function draw() : void
      {
         super.draw();
         var _loc1_:BitmapData = InterfaceAssets.moveCursor;
         icon.graphics.beginBitmapFill(_loc1_);
         icon.graphics.lineStyle(0,0,0);
         icon.graphics.drawRect(0,0,_loc1_.width,_loc1_.height);
         icon.graphics.endFill();
      }
   }
}

