package bs.gui.item
{
   import com.yahoo.astra.fl.controls.treeClasses.TreeCellRenderer;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   
   public class CustomTreeCell extends TreeCellRenderer
   {
      private var bg:Shape;
      
      private var firstTime:Boolean = true;
      
      public function CustomTreeCell()
      {
         super();
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseMove);
         this.bg = new Shape();
         this.bg.filters = [new GlowFilter(16777215,1,2,2,1,2,true),new GlowFilter(0,0.7,2,2,1,2,true)];
      }
      
      private function mouseMove(param1:MouseEvent) : void
      {
         if(_data.type == undefined)
         {
            return;
         }
         if(param1.type == MouseEvent.MOUSE_OUT)
         {
            this.drawBack(3552822,7500402);
         }
         else
         {
            this.drawBack(3824233,6525865);
         }
      }
      
      private function drawBack(param1:int, param2:int) : void
      {
         var _loc3_:Matrix = new Matrix();
         _loc3_.createGradientBox(150,28,Math.PI / 2);
         this.bg.graphics.clear();
         this.bg.graphics.beginGradientFill(GradientType.LINEAR,[param1,param2],[1,1],[0,255],_loc3_);
         this.bg.graphics.drawRect(0,0,150,28);
         this.bg.graphics.endFill();
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:TextFormat = this.textField.getTextFormat();
         if(_data.type != undefined)
         {
            if(this.firstTime)
            {
               this.firstTime = false;
               this.drawBack(3552822,7500402);
            }
            this.addChildAt(this.bg,1);
            _loc1_.color = 16777215;
            this.textField.setTextFormat(_loc1_);
            this.textField.filters = [new DropShadowFilter(1,45,0,0.5,2,2)];
         }
         else
         {
            this.bg.graphics.clear();
            this.firstTime = true;
            _loc1_.color = 0;
            this.textField.setTextFormat(_loc1_);
            this.textField.filters = [];
         }
      }
   }
}

