package bs.gui.win
{
   import bs.gui.BaseSprite;
   import bs.gui.InterfaceAssets;
   import fl.controls.Label;
   import flash.display.Bitmap;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   
   public class About extends BaseSprite
   {
      private var holder:Sprite;
      
      private var blocker:Shape;
      
      private var back:Shape;
      
      public function About()
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Label = null;
         var _loc5_:int = 0;
         super();
         this.holder = new Sprite();
         this.blocker = new Shape();
         this.back = new Shape();
         var _loc1_:Matrix = new Matrix();
         var _loc2_:Bitmap = new Bitmap(InterfaceAssets.logo);
         _loc3_ = new Bitmap(InterfaceAssets.logoNombre);
         _loc4_ = new Label();
         _loc5_ = 550;
         var _loc6_:int = _loc2_.height + 110;
         _loc1_.createGradientBox(_loc5_,_loc6_,Math.PI / 180 * 150);
         this.back.graphics.beginGradientFill(GradientType.LINEAR,[10930923,4757192],[1,1],[0,255],_loc1_);
         this.back.graphics.drawRect(0,0,_loc5_,_loc6_);
         this.back.graphics.endFill();
         this.back.filters = [new GlowFilter(2648211,1,25,25,0.4,2,true)];
         _loc2_.x = 5;
         _loc2_.y = 5;
         _loc3_.x = _loc2_.x + _loc2_.width + 10;
         _loc3_.y = _loc2_.y + Math.floor((_loc2_.height - _loc3_.height) / 2);
         this.blocker.graphics.beginFill(0,0.2);
         this.blocker.graphics.drawRect(0,0,50,50);
         this.blocker.graphics.endFill();
         _loc4_.text = "BannedStory 4.3 - Copyright 2006-2016, BannedStory by Ion.\n\nImages are copyright material of Nexon/Wizet. The program, site and author are not affiliated to Nexon or Wizet in any way. By using this software you agree that the author is not responsible of any harm caused by the misuse of it. This software is free of use, its by no means a comercial software.\n\nFor more information, visit us at www.maplesimulator.com";
         _loc4_.setStyle("textFormat",new TextFormat(InterfaceAssets.pfRondaSeven,8,16777215));
         _loc4_.setSize(_loc5_ - _loc2_.x * 2,500);
         _loc4_.wordWrap = true;
         _loc4_.x = _loc2_.x;
         _loc4_.y = _loc2_.y + _loc2_.height + 2;
         this.filters = [new DropShadowFilter(2,45,0,0.7,6,6,0.6,2)];
         _loc4_.filters = [new DropShadowFilter(1,45,0,0.7,1,1,0.6,2)];
         this.addEventListener(MouseEvent.CLICK,this.hideAboutClick);
         this.holder.addChild(this.back);
         this.holder.addChild(_loc2_);
         this.holder.addChild(_loc3_);
         this.holder.addChild(_loc4_);
         this.addChild(this.blocker);
         this.addChild(this.holder);
         this.visible = false;
      }
      
      override public function onStageResize() : void
      {
         this.holder.x = Math.floor((_stageWidth - this.back.width) / 2);
         this.holder.y = Math.floor((_stageHeight - this.back.height) / 2);
         this.blocker.width = _stageWidth;
         this.blocker.height = _stageHeight;
      }
      
      private function hideAboutClick(param1:MouseEvent) : void
      {
         this.visible = false;
      }
   }
}

