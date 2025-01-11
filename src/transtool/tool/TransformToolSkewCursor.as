package transtool.tool
{
   import bs.gui.InterfaceAssets;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class TransformToolSkewCursor extends TransformToolInternalCursor
   {
      private var cursor1:BitmapData;
      
      private var cursor2:BitmapData;
      
      private var currentCursor:BitmapData;
      
      public function TransformToolSkewCursor()
      {
         super();
         _mouseOffset = new Point(12,12);
         this.cursor1 = InterfaceAssets.skewH;
         this.cursor2 = InterfaceAssets.skewV;
         this.currentCursor = this.cursor1;
      }
      
      override public function draw() : void
      {
         super.draw();
         icon.graphics.clear();
         icon.graphics.beginBitmapFill(this.currentCursor);
         icon.graphics.lineStyle(0,0,0);
         icon.graphics.drawRect(0,0,this.currentCursor.width,this.currentCursor.height);
         icon.graphics.endFill();
      }
      
      override public function updateVisible(param1:Event = null) : void
      {
         var _loc2_:TransformToolSkewBar = null;
         super.updateVisible(param1);
         if(param1)
         {
            _loc2_ = param1.target as TransformToolSkewBar;
            if(_loc2_)
            {
               switch(_loc2_)
               {
                  case _transformTool.skewLeftControl:
                  case _transformTool.skewRightControl:
                     this.currentCursor = this.cursor2;
                     break;
                  default:
                     this.currentCursor = this.cursor1;
               }
               this.draw();
            }
         }
      }
   }
}

