package bs.gui.props
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import com.yahoo.astra.fl.controls.Menu;
   import com.yahoo.astra.fl.data.XMLDataProvider;
   import com.yahoo.astra.fl.events.MenuEvent;
   import fl.controls.Button;
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BevelFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import ion.components.controls.IToolTip;
   
   public class PageFilters extends Sprite
   {
      private var assetReference:*;
      
      private var assetType:int;
      
      private var data:DataProvider;
      
      private var list:List;
      
      private var btnAdd:Button;
      
      private var btnRemove:Button;
      
      private var btnUp:Button;
      
      private var btnDown:Button;
      
      private var filterList:Array;
      
      private var colorMenu:Menu;
      
      private var cShadow:ControlsShadow;
      
      private var cBlur:ControlsBlur;
      
      private var cGlow:ControlsGlow;
      
      private var cBevel:ControlsBevel;
      
      private var cColorTransform:ControlsColorTransform;
      
      private var withColorTransform:Boolean;
      
      public function PageFilters()
      {
         super();
         this.data = new DataProvider();
         this.list = new List();
         this.colorMenu = new Menu();
         this.btnAdd = new Button();
         this.btnRemove = new Button();
         this.btnUp = new Button();
         this.btnDown = new Button();
         this.cShadow = new ControlsShadow();
         this.cBlur = new ControlsBlur();
         this.cGlow = new ControlsGlow();
         this.cBevel = new ControlsBevel();
         this.cColorTransform = new ControlsColorTransform();
         var _loc1_:Shape = new Shape();
         IToolTip.setTarget(this.btnAdd,"Add a new color filter");
         IToolTip.setTarget(this.btnRemove,"Remove selected color filter");
         IToolTip.setTarget(this.btnUp,"Move up the selected color filter");
         IToolTip.setTarget(this.btnDown,"Move down the selected color filter");
         _loc1_.graphics.beginFill(16777215);
         _loc1_.graphics.lineStyle(0,9539985);
         _loc1_.graphics.drawRect(0,0,10,10);
         _loc1_.graphics.endFill();
         this.list.setStyle("skin",_loc1_);
         this.list.setSize(138,75);
         this.btnAdd.setSize(14,14);
         this.btnRemove.setSize(14,14);
         this.btnUp.setSize(14,14);
         this.btnDown.setSize(14,14);
         this.btnUp.label = "";
         this.btnDown.label = "";
         this.btnAdd.label = "";
         this.btnRemove.label = "";
         this.list.dataProvider = this.data;
         this.list.x = 5;
         this.list.y = 5;
         this.btnUp.x = this.list.x;
         this.btnUp.y = this.list.y + this.list.height + 2;
         this.btnDown.x = this.btnUp.x + this.btnUp.width + 2;
         this.btnDown.y = this.btnUp.y;
         this.btnRemove.x = this.list.x + this.list.width - this.btnAdd.width;
         this.btnRemove.y = this.btnUp.y;
         this.btnAdd.x = this.btnRemove.x - this.btnAdd.width - 2;
         this.btnAdd.y = this.btnRemove.y;
         this.cShadow.x = this.list.x + this.list.width + 5;
         this.cShadow.y = this.list.y;
         this.cBlur.x = this.cShadow.x;
         this.cBlur.y = this.cShadow.y;
         this.cGlow.x = this.cBlur.x;
         this.cGlow.y = this.cBlur.y;
         this.cBevel.x = this.cGlow.x;
         this.cBevel.y = this.cGlow.y;
         this.cColorTransform.x = this.cBevel.x;
         this.cColorTransform.y = this.cBevel.y;
         this.btnUp.setStyle("icon",InterfaceAssets.upArrow);
         this.btnDown.setStyle("icon",InterfaceAssets.downArrow);
         this.btnAdd.setStyle("icon",InterfaceAssets.plus);
         this.btnRemove.setStyle("icon",InterfaceAssets.minus);
         this.btnRemove.addEventListener(MouseEvent.CLICK,this.removeColorClick);
         this.btnAdd.addEventListener(MouseEvent.CLICK,this.addColorClick);
         this.list.addEventListener(Event.CHANGE,this.listClick);
         this.btnUp.addEventListener(MouseEvent.CLICK,this.colorUpClick);
         this.btnDown.addEventListener(MouseEvent.CLICK,this.colorDownClick);
         this.colorMenu.addEventListener(MenuEvent.ITEM_CLICK,this.colorMenuClick);
         this.cShadow.addEventListener(InterfaceEvent.FILTER_COLOR_UPDATE,this.filterColorUpdate);
         this.cBlur.addEventListener(InterfaceEvent.FILTER_COLOR_UPDATE,this.filterColorUpdate);
         this.cGlow.addEventListener(InterfaceEvent.FILTER_COLOR_UPDATE,this.filterColorUpdate);
         this.cBevel.addEventListener(InterfaceEvent.FILTER_COLOR_UPDATE,this.filterColorUpdate);
         this.cColorTransform.addEventListener(InterfaceEvent.FILTER_COLOR_UPDATE,this.filterColorUpdate);
         this.addChild(this.cColorTransform);
         this.addChild(this.cBevel);
         this.addChild(this.cGlow);
         this.addChild(this.cBlur);
         this.addChild(this.cShadow);
         this.addChild(this.list);
         this.addChild(this.btnAdd);
         this.addChild(this.btnRemove);
         this.addChild(this.btnUp);
         this.addChild(this.btnDown);
         this.addChild(this.colorMenu);
      }
      
      public function setTarget(param1:int, param2:*) : void
      {
         var _loc4_:* = undefined;
         this.assetType = param1;
         this.assetReference = param2;
         this.cColorTransform.colorMatrix = null;
         this.assetReference = param2;
         this.filterList = null;
         this.data.removeAll();
         this.list.enabled = false;
         this.btnAdd.enabled = false;
         this.btnDown.enabled = false;
         this.btnRemove.enabled = false;
         this.btnUp.enabled = false;
         this.listClick();
         if(param2 == null)
         {
            return;
         }
         this.list.enabled = true;
         this.btnAdd.enabled = true;
         this.btnDown.enabled = true;
         this.btnRemove.enabled = true;
         this.btnUp.enabled = true;
         this.cColorTransform.colorMatrix = param2.colorMatrix;
         this.filterList = this.assetReference.filters;
         this.withColorTransform = true;
         var _loc3_:int = int(this.filterList.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = this.filterList[_loc5_];
            if(_loc4_ is DropShadowFilter)
            {
               this.data.addItem({
                  "label":"Shadow",
                  "colorID":"shadow",
                  "filter":_loc4_
               });
            }
            else if(_loc4_ is BlurFilter)
            {
               this.data.addItem({
                  "label":"Blur",
                  "colorID":"blur",
                  "filter":_loc4_
               });
            }
            else if(_loc4_ is GlowFilter)
            {
               this.data.addItem({
                  "label":"Glow",
                  "colorID":"glow",
                  "filter":_loc4_
               });
            }
            else if(_loc4_ is BevelFilter)
            {
               this.data.addItem({
                  "label":"Bevel",
                  "colorID":"bevel",
                  "filter":_loc4_
               });
            }
            else if(_loc4_ is ColorMatrixFilter)
            {
               this.withColorTransform = false;
               this.data.addItem({
                  "label":"Color Transform",
                  "colorID":"colorTransform",
                  "filter":_loc4_
               });
            }
            _loc5_++;
         }
         if(_loc3_ > 0)
         {
            this.list.selectedIndex = 0;
         }
         this.listClick();
      }
      
      private function filterColorUpdate(param1:Event) : void
      {
         this.assetReference.filters = this.filterList;
      }
      
      private function colorMenuClick(param1:MenuEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:String = param1.item.colorID;
         var _loc3_:String = param1.label;
         if(_loc2_ == "shadow")
         {
            _loc4_ = new DropShadowFilter();
         }
         else if(_loc2_ == "blur")
         {
            _loc4_ = new BlurFilter();
         }
         else if(_loc2_ == "glow")
         {
            _loc4_ = new GlowFilter();
         }
         else if(_loc2_ == "bevel")
         {
            _loc4_ = new BevelFilter();
         }
         else
         {
            if(_loc2_ != "colorTransform")
            {
               return;
            }
            _loc4_ = new ColorMatrixFilter();
         }
         this.filterList.push(_loc4_);
         this.assetReference.filters = this.filterList;
         this.data.addItem({
            "label":_loc3_,
            "colorID":_loc2_,
            "filter":_loc4_
         });
         this.list.selectedIndex = this.data.length - 1;
         this.listClick();
      }
      
      private function removeColorClick(param1:MouseEvent) : void
      {
         if(this.data.length == 0 || this.list.selectedIndex == -1)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         var _loc3_:Object = this.data.removeItemAt(_loc2_);
         var _loc4_:int = int(this.filterList.length);
         if(_loc2_ + 1 > this.data.length)
         {
            this.list.selectedIndex = this.data.length - 1;
         }
         else
         {
            this.list.selectedIndex = _loc2_;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(this.filterList[_loc5_] == _loc3_.filter)
            {
               if(_loc3_.filter is ColorMatrixFilter)
               {
                  this.withColorTransform = true;
                  this.assetReference.colorMatrix.reset();
               }
               this.filterList.splice(_loc5_,1);
               break;
            }
            _loc5_++;
         }
         this.assetReference.filters = this.filterList;
         this.listClick();
      }
      
      private function addColorClick(param1:MouseEvent) : void
      {
         this.buildColorMenu();
         this.colorMenu.show();
         this.colorMenu.x = this.mouseX - this.colorMenu.width;
         this.colorMenu.y = this.mouseY - this.colorMenu.height;
      }
      
      private function listClick(param1:Event = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         this.cShadow.visible = false;
         this.cBlur.visible = false;
         this.cGlow.visible = false;
         this.cBevel.visible = false;
         this.cColorTransform.visible = false;
         if(this.list.selectedIndex >= 0)
         {
            _loc2_ = this.data.getItemAt(this.list.selectedIndex);
            _loc3_ = _loc2_.colorID;
            _loc4_ = _loc2_.filter;
            this.cShadow.visible = _loc3_ == "shadow";
            this.cBlur.visible = _loc3_ == "blur";
            this.cGlow.visible = _loc3_ == "glow";
            this.cBevel.visible = _loc3_ == "bevel";
            this.cColorTransform.visible = _loc3_ == "colorTransform";
            if(this.cShadow.visible)
            {
               this.cShadow.target = _loc4_;
            }
            if(this.cBlur.visible)
            {
               this.cBlur.target = _loc4_;
            }
            if(this.cGlow.visible)
            {
               this.cGlow.target = _loc4_;
            }
            if(this.cBevel.visible)
            {
               this.cBevel.target = _loc4_;
            }
            if(this.cColorTransform.visible)
            {
               this.withColorTransform = false;
               this.cColorTransform.target = _loc4_;
               this.cColorTransform.colorMatrix = this.assetReference.colorMatrix;
            }
         }
      }
      
      private function colorUpClick(param1:MouseEvent) : void
      {
         if(this.data.length < 2)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         var _loc3_:int = _loc2_ - 1;
         if(_loc3_ < 0)
         {
            return;
         }
         var _loc4_:Object = this.data.getItemAt(_loc3_);
         this.data.replaceItemAt(this.data.getItemAt(_loc2_),_loc3_);
         this.data.replaceItemAt(_loc4_,_loc2_);
         _loc4_ = this.filterList[_loc3_];
         this.filterList[_loc3_] = this.filterList[_loc2_];
         this.filterList[_loc2_] = _loc4_;
         this.list.selectedIndex = _loc3_;
         this.assetReference.filters = this.filterList;
      }
      
      private function colorDownClick(param1:MouseEvent) : void
      {
         if(this.data.length < 2)
         {
            return;
         }
         var _loc2_:int = this.list.selectedIndex;
         var _loc3_:int = _loc2_ + 1;
         if(_loc3_ >= this.data.length)
         {
            return;
         }
         var _loc4_:Object = this.data.getItemAt(_loc3_);
         this.data.replaceItemAt(this.data.getItemAt(_loc2_),_loc3_);
         this.data.replaceItemAt(_loc4_,_loc2_);
         _loc4_ = this.filterList[_loc3_];
         this.filterList[_loc3_] = this.filterList[_loc2_];
         this.filterList[_loc2_] = _loc4_;
         this.list.selectedIndex = _loc3_;
         this.assetReference.filters = this.filterList;
      }
      
      private function buildColorMenu() : void
      {
         var _loc1_:XML = null;
         if(this.withColorTransform)
         {
            _loc1_ = <root>
					<i label="Shadow" colorID="shadow"/>
					<i label="Blur" colorID="blur"/>
					<i label="Glow" colorID="glow"/>
					<i label="Bevel" colorID="bevel"/>
					<i label="Color Transform" colorID="colorTransform"/>
				</root>;
         }
         else
         {
            _loc1_ = <root>
					<i label="Shadow" colorID="shadow"/>
					<i label="Blur" colorID="blur"/>
					<i label="Glow" colorID="glow"/>
					<i label="Bevel" colorID="bevel"/>
				</root>;
         }
         this.colorMenu.removeAll();
         this.colorMenu.dataProvider = new XMLDataProvider(_loc1_);
      }
   }
}

