package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import bs.gui.item.CustomColorMenuCell;
   import bs.gui.item.CustomTreeCell;
   import bs.gui.item.ThumbnailGalleryItem;
   import bs.manager.Data;
   import bs.utils.BSPaths;
   import bs.utils.KeyboardHandler;
   import com.yahoo.astra.fl.controls.Menu;
   import com.yahoo.astra.fl.controls.Tree;
   import com.yahoo.astra.fl.controls.menuClasses.MenuCellRenderer;
   import com.yahoo.astra.fl.controls.treeClasses.LeafNode;
   import com.yahoo.astra.fl.controls.treeClasses.RootNode;
   import com.yahoo.astra.fl.controls.treeClasses.TNode;
   import com.yahoo.astra.fl.controls.treeClasses.TreeDataProvider;
   import com.yahoo.astra.fl.data.XMLDataProvider;
   import com.yahoo.astra.fl.events.MenuEvent;
   import fl.controls.BaseButton;
   import fl.controls.Button;
   import fl.controls.CheckBox;
   import fl.controls.Label;
   import fl.controls.ScrollBar;
   import fl.controls.TextInput;
   import fl.events.ListEvent;
   import fl.events.ScrollEvent;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import ion.components.controls.IPanel;
   import ion.components.controls.IToolTip;
   import maplestory.struct.Types;
   
   public class ThumbnailGallery extends WindowBase
   {
      private var bitmapHolder:Sprite;
      
      private var centerMessage:TextField;
      
      private var list:Tree;
      
      private var listMask:Shape;
      
      private var bar:ScrollBar;
      
      private var statusBar:Label;
      
      private var ckMale:CheckBox;
      
      private var ckFemale:CheckBox;
      
      private var ckNoGender:CheckBox;
      
      private var btnJobBeginner:Button;
      
      private var btnJobBowman:Button;
      
      private var btnJobMage:Button;
      
      private var btnJobNX:Button;
      
      private var btnJobPirate:Button;
      
      private var btnJobThief:Button;
      
      private var btnJobWarrior:Button;
      
      private var btnSearchClear:Button;
      
      private var panelGender:IPanel;
      
      private var panelJobs:IPanel;
      
      private var colorMenu:Menu;
      
      private var searchField:TextInput;
      
      private var currentPath:String;
      
      private var currentURLThumbs:String;
      
      private var currentPetID:String;
      
      private var currentTrackIDPath:String;
      
      private var statusBarDefaultText:String;
      
      private var searchFieldDefaultText:String;
      
      private var searchTimeout:Timer;
      
      private var searchMade:Boolean;
      
      private var jobSelectedGlow:GlowFilter;
      
      public var currentType:int;
      
      public var currentURL:String;
      
      public function ThumbnailGallery()
      {
         super();
         resizeWindow(510,378 + 16);
         this.jobSelectedGlow = new GlowFilter(427007,1,4,4,8,1);
         this.list = new Tree();
         this.bar = new ScrollBar();
         this.bitmapHolder = new Sprite();
         this.centerMessage = new TextField();
         this.panelGender = new IPanel(150,50);
         this.panelJobs = new IPanel(354,50);
         this.colorMenu = new Menu();
         this.statusBar = new Label();
         this.searchField = new TextInput();
         this.btnSearchClear = new Button();
         this.colorMenu.iconField = "icon";
         this.statusBarDefaultText = "";
         var _loc1_:Label = new Label();
         var _loc2_:Shape = new Shape();
         var _loc3_:Shape = new Shape();
         this.listMask = new Shape();
         this.searchTimeout = new Timer(1000);
         this.panelGender.content = this.buildGenders();
         this.panelJobs.content = this.buildJobs();
         this.panelGender.masking = false;
         this.panelJobs.masking = false;
         this.panelGender.label = "Gender Options";
         this.panelJobs.label = "Jobs";
         this.panelGender.visible = false;
         this.panelJobs.visible = false;
         _loc2_.graphics.beginFill(16777215);
         _loc2_.graphics.lineStyle(0,13224393);
         _loc2_.graphics.drawRect(0,0,5,5);
         _loc2_.graphics.endFill();
         this.list.setSize(150,_height - 30);
         this.list.rowHeight = 28;
         this.list.setRendererStyle("closedBranchIcon",InterfaceAssets.bulletPlus);
         this.list.setRendererStyle("openBranchIcon",InterfaceAssets.bulletMinus);
         this.list.setRendererStyle("leafIcon",InterfaceAssets.bulletArrow);
         this.list.setStyle("skin",_loc2_);
         this.list.setStyle("cellRenderer",CustomTreeCell);
         this.colorMenu.setStyle("cellRenderer",CustomColorMenuCell);
         _loc1_.text = "Search";
         _loc1_.setSize(45,22);
         this.btnSearchClear.label = "Reset";
         this.btnSearchClear.setSize(40,22);
         this.searchFieldDefaultText = "< search by name or id >";
         this.searchField.text = this.searchFieldDefaultText;
         this.searchField.setSize(_width - _loc1_.width - this.btnSearchClear.width - 5,22);
         _loc1_.x = 0;
         _loc1_.y = 0;
         this.searchField.x = _loc1_.x + _loc1_.width;
         this.searchField.y = 0;
         this.btnSearchClear.x = this.searchField.x + this.searchField.width + 5;
         this.btnSearchClear.y = this.searchField.y;
         this.list.x = 0;
         this.list.y = this.searchField.y + this.searchField.height + 8;
         this.bitmapHolder.x = this.list.x + this.list.width + 6;
         this.bitmapHolder.y = this.list.y;
         this.bar.width = 15;
         this.bar.height = this.list.height - 16 - 2;
         this.bar.x = _width - this.bar.width;
         this.bar.y = this.bitmapHolder.y;
         this.listMask.graphics.beginFill(0);
         this.listMask.graphics.drawRect(0,0,10,10);
         this.listMask.graphics.endFill();
         this.listMask.x = this.bitmapHolder.x;
         this.listMask.y = this.bitmapHolder.y;
         this.listMask.width = this.bar.x - this.list.x - this.list.width;
         this.listMask.height = this.bar.height;
         this.bitmapHolder.mask = this.listMask;
         this.buildList();
         this.centerMessage.antiAliasType = AntiAliasType.ADVANCED;
         this.centerMessage.selectable = false;
         this.centerMessage.mouseEnabled = false;
         this.centerMessage.autoSize = TextFieldAutoSize.LEFT;
         this.centerMessage.alpha = 0.25;
         this.setCenterMessage();
         this.statusBar.text = this.statusBarDefaultText;
         this.statusBar.setSize(this.bar.x + this.bar.width - this.listMask.x,16);
         this.statusBar.x = this.listMask.x;
         this.statusBar.y = this.listMask.y + this.listMask.height + 2;
         this.statusBar.alpha = 0.4;
         _loc3_.x = this.statusBar.x;
         _loc3_.y = this.statusBar.y;
         _loc3_.graphics.beginFill(15000804);
         _loc3_.graphics.drawRect(0,0,this.statusBar.width,this.statusBar.height);
         _loc3_.graphics.endFill();
         this.panelGender.x = this.list.x;
         this.panelGender.y = this.list.y + this.list.height - this.panelGender.height;
         this.panelJobs.x = this.bitmapHolder.x;
         this.panelJobs.y = this.statusBar.y - this.panelJobs.height - 2;
         this.list.addEventListener(ListEvent.ITEM_CLICK,this.listChange);
         this.bitmapHolder.addEventListener(MouseEvent.CLICK,this.thumbnailClick);
         this.bitmapHolder.addEventListener(MouseEvent.MOUSE_OVER,this.thumbnailRoll);
         this.bitmapHolder.addEventListener(MouseEvent.MOUSE_OUT,this.thumbnailRoll);
         this.bar.addEventListener(ScrollEvent.SCROLL,this.scrollItems);
         this.bitmapHolder.addEventListener(MouseEvent.MOUSE_WHEEL,this.wheelItems);
         this.colorMenu.addEventListener(MenuEvent.ITEM_CLICK,this.colorMenuClick);
         this.searchField.addEventListener(Event.CHANGE,this.searchTextChange);
         this.searchField.addEventListener(FocusEvent.FOCUS_IN,this.searchFieldFocus);
         this.searchField.addEventListener(FocusEvent.FOCUS_OUT,this.searchFieldFocus);
         this.searchField.addEventListener(KeyboardEvent.KEY_DOWN,this.validateText);
         this.btnSearchClear.addEventListener(MouseEvent.CLICK,this.resetSearchClick);
         this.searchTimeout.addEventListener(TimerEvent.TIMER,this.searchLoop);
         this.addEventListener(MouseEvent.MOUSE_UP,this.removeFocus);
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.addChild(this.centerMessage);
         this.addChild(_loc1_);
         this.addChild(this.searchField);
         this.addChild(this.btnSearchClear);
         this.addChild(this.list);
         this.addChild(this.bitmapHolder);
         this.addChild(this.listMask);
         this.addChild(_loc3_);
         this.addChild(this.statusBar);
         this.addChild(this.bar);
         this.addChild(this.panelGender);
         this.addChild(this.panelJobs);
         this.addChild(this.colorMenu);
      }
      
      public function updatePetItems(param1:String) : void
      {
         if(this.currentPath == null)
         {
            return;
         }
         this.currentPetID = param1;
         this.setCenterMessage();
         if(this.currentPetID == null || this.currentPath.indexOf("/PetEquip/") == -1)
         {
            if(this.currentPath.indexOf("/PetEquip/") != -1)
            {
               this.cleanThumbnails();
               this.setCenterMessage("No pet selected");
            }
            return;
         }
         this.cleanThumbnails();
         this.filterThumbnails();
      }
      
      public function rebuild() : void
      {
         this.cleanThumbnails();
         this.buildList();
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
      
      private function validateText(param1:KeyboardEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1.keyCode == 13)
         {
            _loc2_ = false;
            _loc3_ = this.searchField.text;
            _loc4_ = _loc3_ == null ? 0 : _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_loc3_.charAt(_loc5_) != " ")
               {
                  _loc2_ = true;
                  break;
               }
               _loc5_++;
            }
            this.searchTimeout.reset();
            this.searchTimeout.stop();
            stage.focus = null;
            if(_loc2_)
            {
               this.searchLoop();
            }
            else
            {
               this.searchField.text = this.searchFieldDefaultText;
               this.statusBarDefaultText = "";
               this.statusBar.text = this.statusBarDefaultText;
            }
         }
      }
      
      private function resetSearchClick(param1:Event) : void
      {
         if(this.searchField.text == this.searchFieldDefaultText)
         {
            return;
         }
         this.searchField.text = this.searchFieldDefaultText;
         this.searchTimeout.reset();
         this.searchTimeout.stop();
         this.statusBarDefaultText = "";
         this.statusBar.text = this.statusBarDefaultText;
         this.cleanThumbnails();
         this.panelJobs.visible = false;
         this.panelGender.visible = false;
         this.list.height = _height - this.list.y;
         this.bar.height = this.list.height - this.statusBar.height - 2;
         this.listMask.height = this.bar.height;
         this.colorMenu.visible = false;
         this.buildList();
      }
      
      private function colorMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:Array = this.currentURL.split("/");
         var _loc3_:String = _loc2_.pop().split(".pak")[0];
         if(this.currentURL.indexOf("/Hair/") != -1)
         {
            _loc3_ = _loc3_.substr(0,7) + param1.item.colorID;
         }
         else if(this.currentURL.indexOf("/Face/") != -1)
         {
            _loc3_ = _loc3_.substr(0,5) + param1.item.colorID + _loc3_.substr(6);
         }
         this.currentURL = _loc2_.join("/") + "/" + _loc3_ + ".pak";
         this.dispatchEvent(new Event(InterfaceEvent.THUMBNAIL_CLICK));
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.hideColorMenu);
      }
      
      private function hideColorMenu(param1:MouseEvent) : void
      {
         if(!(param1.target is MenuCellRenderer || param1.target is ThumbnailGalleryItem))
         {
            this.colorMenu.hide();
         }
      }
      
      private function listChange(param1:ListEvent) : void
      {
         if(!(param1.item is LeafNode))
         {
            return;
         }
         var _loc2_:* = param1.item;
         this.currentTrackIDPath = "";
         this.currentURLThumbs = "";
         this.currentPath = _loc2_.data;
         do
         {
            if(_loc2_.trackID != undefined && _loc2_.trackID != null)
            {
               this.currentTrackIDPath = _loc2_.trackID + "." + this.currentTrackIDPath;
            }
            if(_loc2_.data != undefined && _loc2_.data != null)
            {
               this.currentURLThumbs = _loc2_.data + this.currentURLThumbs;
            }
            if(!isNaN(parseInt(_loc2_.type)))
            {
               this.currentType = parseInt(_loc2_.type);
            }
            _loc2_ = _loc2_.parentNode;
         }
         while(!(_loc2_ is RootNode));
         
         if(this.currentURLThumbs.indexOf("ui/NameTag/") != -1)
         {
            this.currentType = Types.ASSET_NAME_TAG;
         }
         if(this.currentURLThumbs.indexOf("ui/GuildMark/") != -1)
         {
            this.currentType = Types.ASSET_NONE_MOTION;
         }
         if(this.currentURLThumbs.indexOf("ui/Sboating/") != -1)
         {
            this.currentType = Types.ASSET_NONE_MOTION;
         }
         this.currentTrackIDPath = this.currentTrackIDPath.substr(0,-1);
         this.filterThumbnails();
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
         this.bitmapHolder.y = Math.floor(this.list.y - this.bar.scrollPosition);
      }
      
      private function thumbnailClick(param1:MouseEvent) : void
      {
         if(param1.target is ThumbnailGalleryItem)
         {
            this.currentURL = BSPaths.bannedStoryPath + "pak/" + param1.target.id + ".pak";
            this.currentType = param1.target.currentType;
            if(this.currentURL.indexOf("/Hair/") != -1)
            {
               this.buildHairColors(param1.target.colors);
               this.colorMenu.show(param1.stageX - this.x - 4,param1.stageY - this.y - 10);
            }
            else if(this.currentURL.indexOf("/Face/") != -1)
            {
               this.buildFaceColors(param1.target.colors);
               this.colorMenu.show(param1.stageX - this.x - 4,param1.stageY - this.y - 10);
            }
            else
            {
               this.dispatchEvent(new Event(InterfaceEvent.THUMBNAIL_CLICK));
            }
         }
      }
      
      private function thumbnailRoll(param1:MouseEvent) : void
      {
         if(param1.target is ThumbnailGalleryItem)
         {
            if(param1.type == MouseEvent.MOUSE_OVER)
            {
               this.statusBar.text = param1.target.itemName;
            }
            else
            {
               this.statusBar.text = this.statusBarDefaultText;
            }
         }
      }
      
      private function filterOptionClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget is Button)
         {
            this.btnJobBeginner.filters = [];
            this.btnJobBowman.filters = [];
            this.btnJobMage.filters = [];
            this.btnJobNX.filters = [];
            this.btnJobPirate.filters = [];
            this.btnJobThief.filters = [];
            this.btnJobWarrior.filters = [];
            this.btnJobBeginner.selected = param1.currentTarget == this.btnJobBeginner;
            this.btnJobBowman.selected = param1.currentTarget == this.btnJobBowman;
            this.btnJobMage.selected = param1.currentTarget == this.btnJobMage;
            this.btnJobNX.selected = param1.currentTarget == this.btnJobNX;
            this.btnJobPirate.selected = param1.currentTarget == this.btnJobPirate;
            this.btnJobThief.selected = param1.currentTarget == this.btnJobThief;
            this.btnJobWarrior.selected = param1.currentTarget == this.btnJobWarrior;
            if(this.btnJobBeginner.selected)
            {
               this.btnJobBeginner.filters = [this.jobSelectedGlow];
            }
            if(this.btnJobBowman.selected)
            {
               this.btnJobBowman.filters = [this.jobSelectedGlow];
            }
            if(this.btnJobMage.selected)
            {
               this.btnJobMage.filters = [this.jobSelectedGlow];
            }
            if(this.btnJobNX.selected)
            {
               this.btnJobNX.filters = [this.jobSelectedGlow];
            }
            if(this.btnJobPirate.selected)
            {
               this.btnJobPirate.filters = [this.jobSelectedGlow];
            }
            if(this.btnJobThief.selected)
            {
               this.btnJobThief.filters = [this.jobSelectedGlow];
            }
            if(this.btnJobWarrior.selected)
            {
               this.btnJobWarrior.filters = [this.jobSelectedGlow];
            }
         }
         this.filterThumbnails();
      }
      
      private function searchLoop(param1:TimerEvent = null) : void
      {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         this.searchTimeout.stop();
         this.cleanThumbnails();
         this.searchMade = true;
         this.panelJobs.visible = false;
         this.panelGender.visible = false;
         this.list.height = _height - this.list.y;
         this.bar.height = this.list.height - this.statusBar.height - 2;
         this.listMask.height = this.bar.height;
         this.colorMenu.visible = false;
         this.list.selectedIndex = -1;
         var _loc2_:Array = this.recursiveSearch(Data.data.*,[]);
         var _loc3_:int = int(_loc2_.length);
         while(_loc2_.length > 0)
         {
            _loc7_ = _loc2_.shift();
            _loc7_ = _loc7_.parent();
            _loc6_ = null;
            do
            {
               _loc5_ = this.simpleNodeCopy(_loc7_);
               if(_loc6_ != null)
               {
                  _loc5_.appendChild(_loc6_);
               }
               _loc6_ = _loc5_;
            }
            while(_loc7_ = _loc7_.parent(), _loc7_ != null);
            
            if(_loc4_ == null)
            {
               _loc4_ = <i/>;
               _loc4_.appendChild(_loc6_);
            }
            else
            {
               this.recursiveSearchMerge(_loc4_,_loc6_);
            }
         }
         _loc4_ = _loc4_ == null ? <i/> : _loc4_.*[0];
         this.buildList(_loc4_);
         this.statusBarDefaultText = "Found " + _loc3_ + " items with \"" + this.searchField.text + "\"";
         this.statusBar.text = this.statusBarDefaultText;
      }
      
      private function searchFieldFocus(param1:FocusEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1.type == FocusEvent.FOCUS_IN)
         {
            KeyboardHandler.canContinue = false;
            if(this.searchField.text == this.searchFieldDefaultText)
            {
               this.searchField.text = "";
            }
         }
         else
         {
            KeyboardHandler.canContinue = true;
            _loc2_ = false;
            _loc3_ = this.searchField.text;
            _loc4_ = _loc3_ == null ? 0 : _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_loc3_.charAt(_loc5_) != " ")
               {
                  _loc2_ = true;
                  break;
               }
               _loc5_++;
            }
            if(_loc3_ == "" || !_loc2_)
            {
               this.searchField.text = this.searchFieldDefaultText;
               if(this.searchMade)
               {
                  this.buildList();
               }
            }
         }
      }
      
      private function searchTextChange(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = this.searchField.text;
         var _loc4_:int = _loc3_ == null ? 0 : _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_.charAt(_loc5_) != " ")
            {
               _loc2_ = true;
               break;
            }
            _loc5_++;
         }
         this.searchTimeout.reset();
         if(_loc2_)
         {
            this.searchTimeout.start();
         }
      }
      
      private function recursiveSearchMerge(param1:XML, param2:XML) : void
      {
         var trackID:String;
         var target:XML = param1;
         var source:XML = param2;
         if(source == null)
         {
            return;
         }
         trackID = source.@trackID;
         if(target.*.(@trackID == trackID).length() == 0)
         {
            target.appendChild(source.copy());
         }
         else
         {
            this.recursiveSearchMerge(target.*.(@trackID == trackID)[0],source.*[0]);
         }
      }
      
      private function recursiveSearch(param1:XMLList, param2:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc3_:int = int(param1.length());
         _loc4_ = 0;
         for(; _loc4_ < _loc3_; _loc4_++)
         {
            if(param1[_loc4_].*.length() > 0)
            {
               param2 = this.recursiveSearch(param1[_loc4_].*,param2);
            }
            else
            {
               _loc5_ = String(param1[_loc4_].@id);
               _loc6_ = String(param1[_loc4_].@n);
               _loc8_ = String(param1[_loc4_].parent().@data);
               _loc7_ = this.searchField.text.toLowerCase();
               if(_loc5_ != null)
               {
                  if(_loc8_ != null && _loc8_.charAt(_loc8_.length - 1) != "/")
                  {
                     _loc5_ = _loc8_.split("/").pop() + _loc5_;
                  }
                  if(_loc5_.toLowerCase().indexOf(_loc7_) != -1)
                  {
                     param2.push(param1[_loc4_]);
                     continue;
                  }
               }
               if(_loc6_ != null)
               {
                  if(_loc6_.toLowerCase().indexOf(_loc7_) != -1)
                  {
                     param2.push(param1[_loc4_]);
                  }
               }
            }
         }
         return param2;
      }
      
      private function setCenterMessage(param1:String = "") : void
      {
         this.centerMessage.visible = param1 != "";
         this.centerMessage.text = param1;
         this.centerMessage.setTextFormat(new TextFormat("Arial",16,0,true));
         this.centerMessage.x = this.listMask.x + Math.floor((this.listMask.width - this.centerMessage.width) / 2);
         this.centerMessage.y = this.listMask.y + Math.floor((this.listMask.height - this.centerMessage.height) / 2);
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
      
      private function buildHairColors(param1:Array) : void
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
                  _loc3_ = <i label="Red" color="0xff0000"/>;
                  break;
               case "2":
                  _loc3_ = <i label="Orange" color="0xff9900"/>;
                  break;
               case "3":
                  _loc3_ = <i label="Yellow" color="0xffff00"/>;
                  break;
               case "4":
                  _loc3_ = <i label="Green" color="0x00dd00"/>;
                  break;
               case "5":
                  _loc3_ = <i label="Blue" color="0x0000aa"/>;
                  break;
               case "6":
                  _loc3_ = <i label="Purple" color="0x990099"/>;
                  break;
               case "7":
                  _loc3_ = <i label="Brown" color="0x7E4001"/>;
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
         var len:int;
         var hAcum:int;
         var i:int = 0;
         var sp:ThumbnailGalleryItem = null;
         var checkStr:String = null;
         var liLen:int = 0;
         var liParentData:String = null;
         var liID:String = null;
         var liName:String = null;
         var li:XMLList = Data.getChildsByTrackPath(this.currentTrackIDPath);
         var le:XMLList = new XMLList();
         if(li == null)
         {
            return;
         }
         if(this.searchField.text != this.searchFieldDefaultText)
         {
            checkStr = this.searchField.text.toLowerCase();
            liLen = int(li.length());
            i = 0;
            while(i < liLen)
            {
               liID = li[i].@id;
               liName = li[i].@n;
               liParentData = li[i].parent().@data;
               if(liParentData.charAt(liParentData.length - 1) != "/")
               {
                  liID = liParentData.split("/").pop() + liID;
               }
               if(liID.toLowerCase().indexOf(checkStr) != -1 || liName.toLowerCase().indexOf(checkStr) != -1)
               {
                  le += li[i];
               }
               i++;
            }
            li = le;
         }
         genderIndex = 4;
         genderMale = "03";
         genderFemale = "14";
         genderNoGender = "2";
         this.cleanThumbnails();
         this.panelGender.visible = this.panelJobs.visible = false;
         this.list.height = _height - this.list.y;
         this.bar.height = this.list.height - this.statusBar.height - 2;
         this.listMask.height = this.bar.height;
         this.colorMenu.visible = false;
         if(this.currentPath.indexOf("/PetEquip/") != -1)
         {
            if(this.currentPetID == null)
            {
               this.setCenterMessage("No pet selected");
               return;
            }
            li = li.(String(@id).indexOf(currentPetID) != -1);
         }
         else
         {
            this.setCenterMessage();
         }
         if(this.currentURLThumbs.indexOf("character/") == 0 && this.currentURLThumbs.indexOf("/PetEquip/") == -1 && this.currentURLThumbs.indexOf("/Afterimage/") == -1 && this.currentURLThumbs.indexOf("/TamingMob/") == -1 && this.currentURLThumbs.substr(0,-1).split("/").pop() != "character")
         {
            this.panelGender.visible = true;
            this.list.height -= this.panelGender.height + 5;
            if(this.currentURLThumbs.indexOf("/Hair/") == -1 && this.currentURLThumbs.indexOf("/Face/") == -1)
            {
               this.panelJobs.visible = true;
               this.bar.height = this.listMask.height = this.list.height - this.statusBar.height - 2;
               this.btnJobBeginner.alpha = li.(@j == "0").length() > 0 ? 1 : 0.1;
               this.btnJobNX.alpha = li.(@j == "7").length() > 0 ? 1 : 0.1;
               this.btnJobWarrior.alpha = li.(@j == "1").length() > 0 ? 1 : 0.1;
               this.btnJobMage.alpha = li.(@j == "2").length() > 0 ? 1 : 0.1;
               this.btnJobBowman.alpha = li.(@j == "4").length() > 0 ? 1 : 0.1;
               this.btnJobThief.alpha = li.(@j == "8").length() > 0 ? 1 : 0.1;
               this.btnJobPirate.alpha = li.(@j == "16").length() > 0 ? 1 : 0.1;
               this.btnJobBeginner.enabled = this.btnJobBeginner.alpha == 1;
               this.btnJobNX.enabled = this.btnJobNX.alpha == 1;
               this.btnJobWarrior.enabled = this.btnJobWarrior.alpha == 1;
               this.btnJobMage.enabled = this.btnJobMage.alpha == 1;
               this.btnJobBowman.enabled = this.btnJobBowman.alpha == 1;
               this.btnJobThief.enabled = this.btnJobThief.alpha == 1;
               this.btnJobPirate.enabled = this.btnJobPirate.alpha == 1;
               if(!this.btnJobBeginner.enabled)
               {
                  this.btnJobBeginner.filters = [];
               }
               else if(this.btnJobBeginner.selected)
               {
                  this.btnJobBeginner.filters = [this.jobSelectedGlow];
               }
               if(!this.btnJobBowman.enabled)
               {
                  this.btnJobBowman.filters = [];
               }
               else if(this.btnJobBowman.selected)
               {
                  this.btnJobBowman.filters = [this.jobSelectedGlow];
               }
               if(!this.btnJobMage.enabled)
               {
                  this.btnJobMage.filters = [];
               }
               else if(this.btnJobMage.selected)
               {
                  this.btnJobMage.filters = [this.jobSelectedGlow];
               }
               if(!this.btnJobNX.enabled)
               {
                  this.btnJobNX.filters = [];
               }
               else if(this.btnJobNX.selected)
               {
                  this.btnJobNX.filters = [this.jobSelectedGlow];
               }
               if(!this.btnJobPirate.enabled)
               {
                  this.btnJobPirate.filters = [];
               }
               else if(this.btnJobPirate.selected)
               {
                  this.btnJobPirate.filters = [this.jobSelectedGlow];
               }
               if(!this.btnJobThief.enabled)
               {
                  this.btnJobThief.filters = [];
               }
               else if(this.btnJobThief.selected)
               {
                  this.btnJobThief.filters = [this.jobSelectedGlow];
               }
               if(!this.btnJobWarrior.enabled)
               {
                  this.btnJobWarrior.filters = [];
               }
               else if(this.btnJobWarrior.selected)
               {
                  this.btnJobWarrior.filters = [this.jobSelectedGlow];
               }
               if(this.btnJobBeginner.selected)
               {
                  li = li.(@j == "0");
               }
               if(this.btnJobNX.selected)
               {
                  li = li.(@j == "7");
               }
               if(this.btnJobWarrior.selected)
               {
                  li = li.(@j == "1");
               }
               if(this.btnJobMage.selected)
               {
                  li = li.(@j == "2");
               }
               if(this.btnJobBowman.selected)
               {
                  li = li.(@j == "4");
               }
               if(this.btnJobThief.selected)
               {
                  li = li.(@j == "8");
               }
               if(this.btnJobPirate.selected)
               {
                  li = li.(@j == "16");
               }
            }
            if(this.currentURLThumbs.indexOf("/Accessory/") != -1 || this.currentURLThumbs.indexOf("/Weapon/") != -1)
            {
               genderIndex = 0;
            }
            if(this.currentURLThumbs.indexOf("/Weapon/") != -1)
            {
               genderFemale += "0";
            }
            li = li.(Boolean(isValidGender(genderMale,String(@id).split("/").pop().charAt(genderIndex))) && Boolean(ckMale.selected) || Boolean(isValidGender(genderFemale,String(@id).split("/").pop().charAt(genderIndex))) && Boolean(ckFemale.selected) || (genderFemale + genderMale).indexOf(String(@id).split("/").pop().charAt(genderIndex)) == -1 && ckNoGender.selected);
         }
         len = int(li.length());
         i = 0;
         while(i < len)
         {
            sp = new ThumbnailGalleryItem(this.currentURLThumbs,li[i],this.currentType);
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
      
      private function buildJobs() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         this.btnJobBeginner = new Button();
         this.btnJobBowman = new Button();
         this.btnJobMage = new Button();
         this.btnJobNX = new Button();
         this.btnJobPirate = new Button();
         this.btnJobThief = new Button();
         this.btnJobWarrior = new Button();
         IToolTip.setTarget(this.btnJobBeginner,"Beginner Job");
         IToolTip.setTarget(this.btnJobBowman,"Bowman Job");
         IToolTip.setTarget(this.btnJobMage,"Mage Job");
         IToolTip.setTarget(this.btnJobNX,"NX Cash");
         IToolTip.setTarget(this.btnJobPirate,"Pirate Job");
         IToolTip.setTarget(this.btnJobThief,"Thief Job");
         IToolTip.setTarget(this.btnJobWarrior,"Warrior Job");
         this.btnJobBeginner.setSize(36,26);
         this.btnJobBowman.setSize(36,26);
         this.btnJobMage.setSize(36,26);
         this.btnJobNX.setSize(36,26);
         this.btnJobPirate.setSize(36,26);
         this.btnJobThief.setSize(36,26);
         this.btnJobWarrior.setSize(36,26);
         this.btnJobBeginner.setStyle("icon",InterfaceAssets.jobBeginner);
         this.btnJobBowman.setStyle("icon",InterfaceAssets.jobBowman);
         this.btnJobMage.setStyle("icon",InterfaceAssets.jobMage);
         this.btnJobNX.setStyle("icon",InterfaceAssets.jobNX);
         this.btnJobPirate.setStyle("icon",InterfaceAssets.jobPirate);
         this.btnJobThief.setStyle("icon",InterfaceAssets.jobThief);
         this.btnJobWarrior.setStyle("icon",InterfaceAssets.jobWarrior);
         this.btnJobBeginner.label = "";
         this.btnJobBowman.label = "";
         this.btnJobMage.label = "";
         this.btnJobNX.label = "";
         this.btnJobPirate.label = "";
         this.btnJobThief.label = "";
         this.btnJobWarrior.label = "";
         this.btnJobBeginner.toggle = true;
         this.btnJobBowman.toggle = true;
         this.btnJobMage.toggle = true;
         this.btnJobNX.toggle = true;
         this.btnJobPirate.toggle = true;
         this.btnJobThief.toggle = true;
         this.btnJobWarrior.toggle = true;
         this.btnJobBeginner.x = 0;
         this.btnJobBeginner.y = 8;
         this.btnJobNX.x = this.btnJobBeginner.x + this.btnJobBeginner.width + 14;
         this.btnJobNX.y = this.btnJobBeginner.y;
         this.btnJobWarrior.x = this.btnJobNX.x + this.btnJobNX.width + 14;
         this.btnJobWarrior.y = this.btnJobBeginner.y;
         this.btnJobMage.x = this.btnJobWarrior.x + this.btnJobWarrior.width + 14;
         this.btnJobMage.y = this.btnJobBeginner.y;
         this.btnJobBowman.x = this.btnJobMage.x + this.btnJobMage.width + 14;
         this.btnJobBowman.y = this.btnJobBeginner.y;
         this.btnJobThief.x = this.btnJobBowman.x + this.btnJobBowman.width + 14;
         this.btnJobThief.y = this.btnJobBeginner.y;
         this.btnJobPirate.x = this.btnJobThief.x + this.btnJobThief.width + 14;
         this.btnJobPirate.y = this.btnJobBeginner.y;
         this.btnJobBeginner.selected = true;
         this.btnJobBeginner.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.btnJobBowman.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.btnJobMage.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.btnJobNX.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.btnJobPirate.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.btnJobThief.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         this.btnJobWarrior.addEventListener(MouseEvent.CLICK,this.filterOptionClick);
         _loc1_.addChild(this.btnJobBeginner);
         _loc1_.addChild(this.btnJobBowman);
         _loc1_.addChild(this.btnJobMage);
         _loc1_.addChild(this.btnJobNX);
         _loc1_.addChild(this.btnJobPirate);
         _loc1_.addChild(this.btnJobThief);
         _loc1_.addChild(this.btnJobWarrior);
         return _loc1_;
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
         this.ckFemale.x = this.ckMale.x;
         this.ckFemale.y = this.ckMale.y + this.ckMale.height;
         this.ckNoGender.x = this.ckMale.x + this.ckMale.width;
         this.ckNoGender.y = this.ckMale.y;
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
            if((_loc3_ + 2) * (_loc1_.width + 8) > this.bar.x - this.bitmapHolder.x)
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
      
      private function buildList(param1:XML = null) : void
      {
         var _loc5_:TNode = null;
         if(param1 == null)
         {
            param1 = Data.data.copy();
            this.deleteChildNodes(param1);
            this.searchMade = false;
         }
         this.list.removeAll();
         this.list.dataProvider = new TreeDataProvider(param1);
         var _loc2_:XMLList = param1.*.*;
         var _loc3_:int = int(_loc2_.length());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.list.findNode("type",_loc2_[_loc4_].@type);
            this.list.showNode(_loc5_);
            _loc4_++;
         }
      }
      
      private function deleteChildNodes(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc2_:XMLList = param1.*;
         var _loc3_:int = int(_loc2_.length());
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            if(_loc4_.*.length() > 0)
            {
               this.deleteChildNodes(_loc4_);
            }
            else
            {
               delete _loc4_.parent().*[_loc4_.childIndex()];
            }
            _loc5_++;
         }
      }
      
      private function simpleNodeCopy(param1:XML) : XML
      {
         var _loc5_:XML = null;
         var _loc2_:XML = new XML("<" + param1.name() + "/>");
         var _loc3_:XMLList = param1.attributes();
         var _loc4_:int = int(_loc3_.length());
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc3_[_loc6_];
            _loc2_[_loc5_.name()] = _loc5_;
            _loc6_++;
         }
         return _loc2_;
      }
   }
}

