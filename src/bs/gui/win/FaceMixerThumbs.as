package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.gui.item.CustomColorMenuCell;
   import bs.gui.item.ThumbnailGalleryItem;
   import bs.manager.Data;
   import bs.utils.KeyboardHandler;
   import com.yahoo.astra.fl.controls.Menu;
   import com.yahoo.astra.fl.controls.menuClasses.MenuCellRenderer;
   import com.yahoo.astra.fl.data.XMLDataProvider;
   import com.yahoo.astra.fl.events.MenuEvent;
   import fl.controls.BaseButton;
   import fl.controls.Button;
   import fl.controls.CheckBox;
   import fl.controls.Label;
   import fl.controls.ScrollBar;
   import fl.events.ScrollEvent;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ion.components.controls.IPanel;
   import maplestory.struct.Types;
   
   public class FaceMixerThumbs extends WindowBase
   {
      private var bitmapHolder:Sprite;
      
      private var bitmapHolderMask:Shape;
      
      private var bar:ScrollBar;
      
      private var statusBar:Label;
      
      private var ckMale:CheckBox;
      
      private var ckFemale:CheckBox;
      
      private var ckNoGender:CheckBox;
      
      private var panelGender:IPanel;
      
      private var colorMenu:Menu;
      
      private var statusBarDefaultText:String;
      
      public var currentURL:String;
      
      public function FaceMixerThumbs()
      {
         super();
         resizeWindow(400,360);
         var _loc1_:Shape = new Shape();
         var _loc2_:Button = new Button();
         this.panelGender = new IPanel(_width,40);
         this.bitmapHolderMask = new Shape();
         this.bitmapHolder = new Sprite();
         this.statusBar = new Label();
         this.colorMenu = new Menu();
         this.bar = new ScrollBar();
         this.colorMenu.iconField = "icon";
         this.statusBarDefaultText = "";
         _loc2_.label = "Close";
         this.panelGender.content = this.buildGenders();
         this.panelGender.masking = false;
         this.panelGender.label = "Gender Options";
         this.colorMenu.setStyle("cellRenderer",CustomColorMenuCell);
         _loc2_.setSize(40,20);
         this.bar.setSize(15,_height - 105);
         this.bitmapHolderMask.graphics.beginFill(0);
         this.bitmapHolderMask.graphics.drawRect(0,0,_width,this.bar.height);
         this.bitmapHolderMask.graphics.endFill();
         this.bitmapHolder.mask = this.bitmapHolderMask;
         this.statusBar.text = this.statusBarDefaultText;
         this.statusBar.setSize(this.bitmapHolderMask.width,16);
         this.statusBar.alpha = 0.4;
         _loc1_.graphics.beginFill(15000804);
         _loc1_.graphics.drawRect(0,0,this.statusBar.width,this.statusBar.height);
         _loc1_.graphics.endFill();
         this.panelGender.x = 0;
         this.panelGender.y = 10;
         this.bar.x = _width - this.bar.width;
         this.bar.y = this.panelGender.y + this.panelGender.height + 10;
         this.bitmapHolder.x = 0;
         this.bitmapHolder.y = this.bar.y;
         this.bitmapHolderMask.x = this.bitmapHolder.x;
         this.bitmapHolderMask.y = this.bitmapHolder.y;
         this.statusBar.x = this.bitmapHolderMask.x;
         this.statusBar.y = this.bitmapHolderMask.y + this.bitmapHolderMask.height + 2;
         _loc1_.x = this.statusBar.x;
         _loc1_.y = this.statusBar.y;
         _loc2_.x = _width - _loc2_.width;
         _loc2_.y = _height - _loc2_.height;
         _loc2_.addEventListener(MouseEvent.CLICK,this.btnCloseClick);
         this.bitmapHolder.addEventListener(MouseEvent.CLICK,this.thumbnailClick);
         this.bitmapHolder.addEventListener(MouseEvent.MOUSE_OVER,this.thumbnailRoll);
         this.bitmapHolder.addEventListener(MouseEvent.MOUSE_OUT,this.thumbnailRoll);
         this.bar.addEventListener(ScrollEvent.SCROLL,this.scrollItems);
         this.bitmapHolder.addEventListener(MouseEvent.MOUSE_WHEEL,this.wheelItems);
         this.colorMenu.addEventListener(MenuEvent.ITEM_CLICK,this.colorMenuClick);
         this.addEventListener(MouseEvent.MOUSE_UP,this.removeFocus);
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.addChild(this.bitmapHolder);
         this.addChild(this.bitmapHolderMask);
         this.addChild(_loc1_);
         this.addChild(this.statusBar);
         this.addChild(this.bar);
         this.addChild(this.panelGender);
         this.addChild(this.colorMenu);
         this.addChild(_loc2_);
      }
      
      private function btnCloseClick(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function colorMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:Array = this.currentURL.split("/");
         var _loc3_:String = _loc2_.pop();
         _loc3_ = _loc3_.substr(0,5) + param1.item.colorID + _loc3_.substr(6);
         _loc2_.push(_loc3_);
         this.currentURL = _loc2_.join("/");
         this.dispatchEvent(new Event(InterfaceEvent.THUMBNAIL_CLICK));
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.hideColorMenu);
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
      
      private function hideColorMenu(param1:MouseEvent) : void
      {
         if(!(param1.target is MenuCellRenderer || param1.target is ThumbnailGalleryItem))
         {
            this.colorMenu.hide();
         }
      }
      
      private function wheelItems(param1:MouseEvent) : void
      {
         if(this.bitmapHolder.height < this.bar.height)
         {
            return;
         }
         if(param1.delta > 0)
         {
            if(this.bitmapHolder.y + 40 > this.bar.y)
            {
               this.bitmapHolder.y = this.bar.y;
            }
            else
            {
               this.bitmapHolder.y += 40;
            }
         }
         else if(this.bitmapHolder.y + this.bitmapHolder.height - 40 < this.bar.y + this.bar.height)
         {
            this.bitmapHolder.y = this.bar.y + this.bar.height - this.bitmapHolder.height;
         }
         else
         {
            this.bitmapHolder.y -= 40;
         }
         var _loc3_:Number = (this.bar.y - this.bitmapHolder.y) / (this.bitmapHolder.height - this.bar.height);
         this.bar.scrollPosition = _loc3_ * this.bar.maxScrollPosition;
      }
      
      private function scrollItems(param1:ScrollEvent = null) : void
      {
         this.bitmapHolder.y = Math.floor(this.bitmapHolderMask.y - this.bar.scrollPosition);
      }
      
      private function thumbnailClick(param1:MouseEvent) : void
      {
         if(param1.target is ThumbnailGalleryItem)
         {
            this.currentURL = param1.target.id;
            this.buildFaceColors(param1.target.colors);
            this.colorMenu.show(param1.stageX - this.x - 4,param1.stageY - this.y - 10);
         }
      }
      
      private function thumbnailRoll(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.target is ThumbnailGalleryItem)
         {
            if(param1.type == MouseEvent.MOUSE_OVER)
            {
               _loc2_ = param1.target.id.split("/");
               _loc3_ = _loc2_.pop();
               _loc4_ = param1.target.itemName;
               _loc4_ = _loc4_ == "" ? _loc3_ : _loc4_;
               if(_loc3_ == _loc4_)
               {
                  this.statusBar.text = "ID: " + _loc3_ + "  -  Name: <no name>";
               }
               else
               {
                  this.statusBar.text = "ID: " + _loc3_ + "  -  Name: " + _loc4_;
               }
            }
            else
            {
               this.statusBar.text = this.statusBarDefaultText;
            }
         }
      }
      
      private function filterOptionClick(param1:MouseEvent) : void
      {
         this.filterThumbnails();
      }
      
      private function buildFaceColors(param1:Array) : void
      {
         var _loc3_:XML = null;
         this.colorMenu.removeAll();
         var _loc2_:XML = <root/>;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         for(; _loc5_ < _loc4_; _loc5_++)
         {
            switch(param1[_loc5_])
            {
               case "0":
                  _loc3_ = <i label="Black" color="0x000000"/>;
                  break;
               case "1":
                  _loc3_ = <i label="Blue" color="0x0000aa"/>;
                  break;
               case "2":
                  _loc3_ = <i label="Red" color="0xff0000"/>;
                  break;
               case "3":
                  _loc3_ = <i label="Green" color="0x00dd00"/>;
                  break;
               case "4":
                  _loc3_ = <i label="Yellow" color="0xffff00"/>;
                  break;
               case "5":
                  _loc3_ = <i label="Cyan" color="0x00ffff"/>;
                  break;
               case "6":
                  _loc3_ = <i label="Purple" color="0x990099"/>;
                  break;
               case "7":
                  _loc3_ = <i label="Magenta" color="0xff00ff"/>;
                  break;
               case "8":
                  _loc3_ = <i label="White" color="0xffffff"/>;
                  break;
               default:
                  continue;
            }
            _loc3_.@colorID = param1[_loc5_];
            _loc2_.appendChild(_loc3_);
         }
         this.colorMenu.dataProvider = new XMLDataProvider(_loc2_);
      }
      
      private function filterThumbnails() : void
      {
         var genderIndex:int;
         var genderMale:String;
         var genderFemale:String;
         var genderNoGender:String;
         var hAcum:int;
         var i:int = 0;
         var len:int = 0;
         var sp:ThumbnailGalleryItem = null;
         var li:XMLList = Data.getFaceChilds();
         var le:XMLList = new XMLList();
         if(li == null)
         {
            return;
         }
         genderIndex = 4;
         genderMale = "03";
         genderFemale = "14";
         genderNoGender = "2";
         this.cleanThumbnails();
         this.colorMenu.visible = false;
         li = li.(Boolean(isValidGender(genderMale,String(@id).split("/").pop().charAt(genderIndex))) && Boolean(ckMale.selected) || Boolean(isValidGender(genderFemale,String(@id).split("/").pop().charAt(genderIndex))) && Boolean(ckFemale.selected) || (genderFemale + genderMale).indexOf(String(@id).split("/").pop().charAt(genderIndex)) == -1 && ckNoGender.selected);
         len = int(li.length());
         i = 0;
         while(i < len)
         {
            sp = new ThumbnailGalleryItem("character/Face/",li[i],Types.ASSET_CHARACTER);
            this.bitmapHolder.addChild(sp);
            i++;
         }
         hAcum = this.sortThumbnails();
         this.bitmapHolder.graphics.clear();
         this.bitmapHolder.graphics.beginFill(0,0);
         this.bitmapHolder.graphics.drawRect(0,0,this.bitmapHolder.width,hAcum);
         this.bitmapHolder.graphics.endFill();
         this.bar.setScrollProperties(this.bar.height,0,hAcum - this.bar.height);
         this.bar.scrollPosition = 0;
         this.scrollItems();
      }
      
      private function isValidGender(param1:String, param2:String) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1.charAt(_loc3_) == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function buildGenders() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         this.ckMale = new CheckBox();
         this.ckFemale = new CheckBox();
         this.ckNoGender = new CheckBox();
         this.ckMale.setSize(65,22);
         this.ckFemale.setSize(65,22);
         this.ckNoGender.setSize(80,22);
         this.ckFemale.label = "Female";
         this.ckMale.label = "Male";
         this.ckNoGender.label = "No Gender";
         this.ckFemale.selected = true;
         this.ckMale.selected = true;
         this.ckNoGender.selected = true;
         this.ckMale.x = 0;
         this.ckMale.y = 0;
         this.ckFemale.x = this.ckMale.x + this.ckMale.width + 50;
         this.ckFemale.y = this.ckMale.y;
         this.ckNoGender.x = this.ckFemale.x + this.ckFemale.width + 50;
         this.ckNoGender.y = this.ckFemale.y;
         this.ckMale.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.ckFemale.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.ckNoGender.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         _loc1_.addChild(this.ckMale);
         _loc1_.addChild(this.ckFemale);
         _loc1_.addChild(this.ckNoGender);
         return _loc1_;
      }
      
      private function cleanThumbnails() : void
      {
         var _loc1_:ThumbnailGalleryItem = null;
         while(this.bitmapHolder.numChildren > 0)
         {
            _loc1_ = this.bitmapHolder.removeChildAt(0) as ThumbnailGalleryItem;
            _loc1_.destroy();
         }
         this.bitmapHolder.graphics.clear();
         this.bar.setScrollProperties(0,0,0);
         this.bar.scrollPosition = 0;
      }
      
      private function sortThumbnails() : int
      {
         var _loc1_:ThumbnailGalleryItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = this.bitmapHolder.numChildren;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc1_ = this.bitmapHolder.getChildAt(_loc6_) as ThumbnailGalleryItem;
            _loc1_.x = _loc3_ * (_loc1_.width + 8);
            _loc1_.y = _loc2_ * (_loc1_.height + 8);
            if((_loc3_ + 2) * (_loc1_.width + 8) > _width)
            {
               _loc3_ = 0;
               _loc2_++;
            }
            else
            {
               _loc3_++;
            }
            _loc6_++;
         }
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.y + _loc1_.height;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1)
         {
            this.filterThumbnails();
         }
         else
         {
            this.cleanThumbnails();
         }
         super.visible = param1;
      }
   }
}

