package bs.gui.win
{
   import bs.gui.BaseSprite;
   import bs.gui.props.PageBasic;
   import bs.gui.props.PageBlends;
   import bs.gui.props.PageFilters;
   import bs.utils.KeyboardHandler;
   import com.yahoo.astra.fl.controls.TabBar;
   import com.yahoo.astra.fl.events.TabBarEvent;
   import fl.controls.BaseButton;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import ion.utils.RasterMaker;
   import maplestory.display.core.Picture;
   import maplestory.events.AssetEvent;
   import maplestory.struct.Types;
   
   public class Properties extends BaseSprite
   {
      private var assetReference:*;
      
      private var boxBackground:Shape;
      
      private var tabBackground:Shape;
      
      private var tabs:TabBar;
      
      private var tabsIndex:int;
      
      private var page1:PageBasic;
      
      private var page2:PageFilters;
      
      private var page3:PageBlends;
      
      private var previewBG:Bitmap;
      
      private var preview:Bitmap;
      
      public function Properties()
      {
         super();
         this.boxBackground = this.buildBackground();
         this.tabBackground = this.buildTabBackground();
         this.previewBG = this.buildPreviewBG();
         this.page1 = new PageBasic();
         this.page2 = new PageFilters();
         this.page3 = new PageBlends();
         this.tabs = new TabBar();
         this.preview = new Bitmap();
         this.previewBG.x = 5;
         this.previewBG.y = Math.floor((this.boxBackground.height - this.previewBG.height) / 2);
         this.page1.x = this.previewBG.x + this.previewBG.width + 5;
         this.page2.x = this.page1.x;
         this.page3.x = this.page2.x;
         this.page1.y = this.previewBG.y;
         this.page2.y = 0;
         this.page3.y = this.page1.y;
         this.tabs.x = 0;
         this.tabs.y = -this.tabs.height;
         this.tabBackground.x = 0;
         this.tabBackground.y = this.tabs.y;
         this.tabs.addEventListener(TabBarEvent.ITEM_CLICK,this.tabClick);
         this.addEventListener(MouseEvent.MOUSE_UP,this.removeFocus);
         this.updateProperties(Types.ASSET_NONE,null);
         this.addChild(this.tabBackground);
         this.addChild(this.boxBackground);
         this.addChild(this.tabs);
         this.addChild(this.previewBG);
         this.addChild(this.preview);
         this.addChild(this.page1);
         this.addChild(this.page2);
         this.addChild(this.page3);
      }
      
      public function updateProperties(param1:int, param2:*) : void
      {
         var _loc3_:DataProvider = null;
         switch(param1)
         {
            case Types.ASSET_CHARACTER:
               _loc3_ = new DataProvider(["Character Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_CHAT_BALLOON:
               _loc3_ = new DataProvider(["Chat Balloon Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_EFFECT:
               _loc3_ = new DataProvider(["Effect Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_ETC:
               _loc3_ = new DataProvider(["Miscellaneous Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_ITEM:
               _loc3_ = new DataProvider(["Cash Item Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_MAP:
               _loc3_ = new DataProvider(["Map Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_MOB:
               _loc3_ = new DataProvider(["Mob Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_MORPH:
               _loc3_ = new DataProvider(["Morph Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_NAME_TAG:
               _loc3_ = new DataProvider(["Name Tag Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_NPC:
               _loc3_ = new DataProvider(["NPC Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_PET:
               _loc3_ = new DataProvider(["Pet Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_PICTURE:
               _loc3_ = new DataProvider(["Picture Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_SKILL:
               _loc3_ = new DataProvider(["Skill Properties","Color Filters","Appearance"]);
               break;
            case Types.ASSET_NONE_MOTION:
               _loc3_ = new DataProvider(["Asset Properties","Color Filters","Appearance"]);
               break;
            default:
               _loc3_ = new DataProvider(["Canvas Properties"]);
         }
         if(this.assetReference != null)
         {
            this.assetReference.removeEventListener(AssetEvent.ASSET_UPDATE,this.buildPreview);
         }
         if(param2 != null)
         {
            param2.addEventListener(AssetEvent.ASSET_UPDATE,this.buildPreview);
         }
         this.tabs.dataProvider = _loc3_;
         this.tabs.selectedIndex = this.tabsIndex >= _loc3_.length ? 0 : this.tabsIndex;
         this.assetReference = param2;
         this.preview.visible = param1 != Types.ASSET_NONE;
         this.previewBG.visible = this.preview.visible;
         this.page1.setTarget(param1,param2);
         this.page2.setTarget(param1,param2);
         this.page3.setTarget(param1,param2);
         this.buildPreview();
         this.tabClick();
      }
      
      public function refreshCoordinates() : void
      {
         this.page1.refreshCoordinates();
      }
      
      private function removeFocus(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton || param1.target is TextField)
         {
            return;
         }
         stage.focus = null;
         KeyboardHandler.canContinue = true;
      }
      
      private function tabClick(param1:TabBarEvent = null) : void
      {
         this.page1.visible = this.tabs.selectedIndex == 0;
         this.page2.visible = this.tabs.selectedIndex == 1;
         this.page3.visible = this.tabs.selectedIndex == 2;
         this.tabsIndex = this.tabs.selectedIndex;
      }
      
      override public function onStageResize() : void
      {
         this.boxBackground.width = _stageWidth;
         this.tabBackground.width = _stageWidth;
         this.y = _stageHeight - this.boxBackground.height;
      }
      
      private function buildPreview(param1:Event = null) : void
      {
         if(this.preview.bitmapData != null)
         {
            this.preview.bitmapData.dispose();
         }
         if(this.assetReference == null)
         {
            return;
         }
         var _loc2_:Number = 1;
         if(this.assetReference.width > this.assetReference.height)
         {
            _loc2_ = (this.previewBG.width - 6) / this.assetReference.width;
         }
         else
         {
            _loc2_ = (this.previewBG.height - 6) / this.assetReference.height;
         }
         this.preview.bitmapData = RasterMaker.raster(this.assetReference,true,0,Math.min(_loc2_,1),!(this.assetReference is Picture));
         this.preview.x = this.previewBG.x + Math.floor((this.previewBG.width - this.preview.width) / 2);
         this.preview.y = this.previewBG.y + Math.floor((this.previewBG.height - this.preview.height) / 2);
      }
      
      private function buildPreviewBG() : Bitmap
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = this.boxBackground.height * 0.8;
         var _loc3_:int = _loc2_ / 8;
         var _loc6_:int = 16777215;
         var _loc7_:BitmapData = new BitmapData(_loc2_,_loc2_,false,0);
         var _loc8_:Rectangle = new Rectangle(0,0,_loc3_,_loc3_);
         _loc9_ = 0;
         while(_loc9_ < 8)
         {
            _loc6_ = _loc6_ == 16777215 ? 15263976 : 16777215;
            _loc10_ = 0;
            while(_loc10_ < 8)
            {
               _loc6_ = _loc6_ == 16777215 ? 15263976 : 16777215;
               _loc8_.x = _loc10_ * _loc3_;
               _loc8_.y = _loc9_ * _loc3_;
               _loc7_.fillRect(_loc8_,_loc6_);
               _loc10_++;
            }
            _loc9_++;
         }
         _loc6_ = 10066329;
         _loc7_.fillRect(new Rectangle(0,0,_loc7_.width,1),_loc6_);
         _loc7_.fillRect(new Rectangle(_loc7_.width - 1,0,1,_loc7_.height),_loc6_);
         _loc7_.fillRect(new Rectangle(0,_loc7_.height - 1,_loc7_.width,1),_loc6_);
         _loc7_.fillRect(new Rectangle(0,0,1,_loc7_.height),_loc6_);
         return new Bitmap(_loc7_);
      }
      
      private function buildBackground() : Shape
      {
         var _loc1_:Matrix = new Matrix();
         var _loc2_:Shape = new Shape();
         _loc1_.createGradientBox(10,100,Math.PI / 2);
         _loc2_.graphics.lineStyle(0,9539985);
         _loc2_.graphics.beginGradientFill(GradientType.LINEAR,[12369084,13816530],[1,1],[0,255],_loc1_);
         _loc2_.graphics.drawRect(0,0,10,100);
         _loc2_.graphics.endFill();
         _loc2_.filters = [new GlowFilter(0,0.4,6,6,1,2,true)];
         return _loc2_;
      }
      
      private function buildTabBackground() : Shape
      {
         var _loc1_:Matrix = new Matrix();
         var _loc2_:Shape = new Shape();
         _loc1_.createGradientBox(10,50,Math.PI / 2);
         _loc2_.graphics.beginGradientFill(GradientType.LINEAR,[15066597,16119285],[1,1],[0,255],_loc1_);
         _loc2_.graphics.drawRect(0,0,10,50);
         _loc2_.graphics.endFill();
         _loc2_.filters = [new GlowFilter(0,0.4,6,6,1,2,true)];
         return _loc2_;
      }
      
      public function get canvasColor() : int
      {
         return this.page1.canvasColor;
      }
      
      public function set canvasColor(param1:int) : void
      {
         this.page1.canvasColor = param1;
      }
      
      override public function get width() : Number
      {
         return this.boxBackground.width;
      }
      
      override public function get height() : Number
      {
         return this.boxBackground.height;
      }
   }
}

