package bs.gui.props
{
   import fl.controls.CheckBox;
   import fl.controls.ComboBox;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PageBlends extends Sprite
   {
      private var assetReference:*;
      
      private var assetType:int;
      
      private var cbBlends:ComboBox;
      
      private var ckPixelated:CheckBox;
      
      public function PageBlends()
      {
         super();
         this.cbBlends = new ComboBox();
         this.ckPixelated = new CheckBox();
         this.cbBlends.addItem({
            "label":"Normal",
            "data":BlendMode.NORMAL
         });
         this.cbBlends.addItem({
            "label":"Alpha",
            "data":BlendMode.ALPHA
         });
         this.cbBlends.addItem({
            "label":"Darken",
            "data":BlendMode.DARKEN
         });
         this.cbBlends.addItem({
            "label":"Multiply",
            "data":BlendMode.MULTIPLY
         });
         this.cbBlends.addItem({
            "label":"Lighten",
            "data":BlendMode.LIGHTEN
         });
         this.cbBlends.addItem({
            "label":"Overlay",
            "data":BlendMode.OVERLAY
         });
         this.cbBlends.addItem({
            "label":"Screen",
            "data":BlendMode.SCREEN
         });
         this.cbBlends.addItem({
            "label":"Hard Light",
            "data":BlendMode.HARDLIGHT
         });
         this.cbBlends.addItem({
            "label":"Add",
            "data":BlendMode.ADD
         });
         this.cbBlends.addItem({
            "label":"Substract",
            "data":BlendMode.SUBTRACT
         });
         this.cbBlends.addItem({
            "label":"Difference",
            "data":BlendMode.DIFFERENCE
         });
         this.cbBlends.addItem({
            "label":"Invert",
            "data":BlendMode.INVERT
         });
         this.cbBlends.setSize(150,22);
         this.cbBlends.dropdown.setRendererStyle("upSkin",Shape);
         this.cbBlends.x = 0;
         this.cbBlends.y = 0;
         this.ckPixelated.x = this.cbBlends.x + this.cbBlends.width + 5;
         this.ckPixelated.y = this.cbBlends.y;
         this.ckPixelated.setSize(100,22);
         this.ckPixelated.label = "Smooth Scaling";
         this.ckPixelated.selected = false;
         this.ckPixelated.addEventListener(MouseEvent.CLICK,this.pixelatedClick);
         this.cbBlends.addEventListener(Event.CHANGE,this.blendsChange);
         this.addChild(this.cbBlends);
         this.addChild(this.ckPixelated);
      }
      
      public function setTarget(param1:int, param2:*) : void
      {
         var _loc4_:int = 0;
         this.assetType = param1;
         this.assetReference = param2;
         var _loc3_:int = this.cbBlends.length;
         if(this.assetReference is DisplayObject)
         {
            this.ckPixelated.selected = !this.assetReference.pixelated;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(this.cbBlends.getItemAt(_loc4_).data == this.assetReference.blendMode)
               {
                  this.cbBlends.selectedIndex = _loc4_;
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      private function blendsChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.blendMode = this.cbBlends.selectedItem.data;
      }
      
      private function pixelatedClick(param1:MouseEvent) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.pixelated = !this.ckPixelated.selected;
      }
   }
}

