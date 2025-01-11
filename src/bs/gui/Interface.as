package bs.gui
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.About;
   import bs.gui.win.Alerts;
   import bs.gui.win.FaceMixer;
   import bs.gui.win.Inventory;
   import bs.gui.win.Layer;
   import bs.gui.win.Properties;
   import bs.gui.win.RandomGenerator;
   import bs.gui.win.StartUp;
   import bs.gui.win.ThumbnailGallery;
   import bs.gui.win.WindowBase;
   import bs.manager.BSCommon;
   import bs.save.FileSave;
   import bs.save.SaveBSProj;
   import bs.save.SaveGIF;
   import bs.save.SaveJSX;
   import bs.save.SaveSS;
   import bs.save.SaveSWF;
   import bs.utils.BSPaths;
   import bs.utils.KeyboardHandler;
   import bs.utils.ProjectLoader;
   import fl.managers.StyleManager;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import ion.components.controls.ILabel;
   import ion.components.controls.IPanel;
   import ion.components.controls.IToolTip;
   import ion.utils.RasterMaker;
   import ion.utils.SingleList;
   import ion.utils.optimized.JPGEncoder;
   import ion.utils.optimized.PNGEncoder;
   import maplestory.display.core.Picture;
   import maplestory.display.maple.AssetMaple;
   import maplestory.display.maple.AssetMapleMotion;
   import maplestory.display.maple.Char;
   import maplestory.display.maple.Pet;
   import maplestory.events.AssetEvent;
   import maplestory.struct.Types;
   import maplestory.utils.ResourceCache;
   
   public class Interface extends Sprite
   {
      private var winHolder:Sprite;
      
      private var winThumbs:ThumbnailGallery;
      
      private var winRandom:RandomGenerator;
      
      private var winProperties:Properties;
      
      private var winInventory:Inventory;
      
      private var winFaceMixer:FaceMixer;
      
      private var menuBar:TopMenuBar;
      
      private var winStartUp:StartUp;
      
      private var winCanvas:Canvas;
      
      private var winLayer:Layer;
      
      private var winAbout:About;
      
      private var itemLoadingErrors:int;
      
      private var keyboard:KeyboardHandler;
      
      public function Interface()
      {
         super();
         var _loc1_:TextFormat = new TextFormat(InterfaceAssets.pfRondaSeven,8);
         StyleManager.setStyle("embedFonts",true);
         StyleManager.setStyle("textFormat",_loc1_);
         StyleManager.setStyle("disabledTextFormat",_loc1_);
         ILabel.setDefaultStyle(InterfaceAssets.pfRondaSeven,8,0);
         IToolTip.setDefaultStyle(InterfaceAssets.pfRondaSeven,8,16777215,0);
         IPanel.setDefaultSkin(InterfaceAssets.skinPanel);
         WindowBase.setPadding(25,0,0,0);
      }
      
      public function startUp() : void
      {
         this.winStartUp = new StartUp();
         BSCommon.start = this.winStartUp;
         this.addChild(this.winStartUp);
      }
      
      public function updateInterface() : void
      {
         this.winThumbs.rebuild();
         this.winRandom.rebuild();
      }
      
      public function startInterface() : void
      {
         this.winHolder = new Sprite();
         this.keyboard = new KeyboardHandler(this.stage);
         var _loc1_:Timer = new Timer(80);
         _loc1_.addEventListener(TimerEvent.TIMER,this.loopStartInterface);
         _loc1_.start();
         Alerts.setMessage("Starting Interface...",0);
      }
      
      private function loopStartInterface(param1:TimerEvent) : void
      {
         var _loc2_:int = int(param1.currentTarget.currentCount);
         Alerts.setMessage("Starting Interface...",_loc2_ / 10);
         param1.currentTarget.stop();
         switch(_loc2_)
         {
            case 1:
               this.winCanvas = new Canvas();
               break;
            case 2:
               this.winLayer = new Layer();
               break;
            case 3:
               this.winInventory = new Inventory();
               break;
            case 4:
               this.winThumbs = new ThumbnailGallery();
               break;
            case 5:
               this.winProperties = new Properties();
               break;
            case 6:
               this.winAbout = new About();
               break;
            case 7:
               this.winRandom = new RandomGenerator();
               break;
            case 8:
               this.menuBar = new TopMenuBar();
               break;
            case 9:
               this.winFaceMixer = new FaceMixer(this);
         }
         if(_loc2_ >= 10)
         {
            BSCommon.layer = this.winLayer;
            BSCommon.canvas = this.winCanvas;
            BSCommon.inventory = this.winInventory;
            BSCommon.properties = this.winProperties;
            BSCommon.thumbs = this.winThumbs;
            BSCommon.faceMixer = this.winFaceMixer;
            this.winThumbs.label = "Thumbnail Gallery";
            this.winLayer.label = "Layer Panel";
            this.winInventory.label = "Inventory Panel";
            this.winRandom.label = "Random Generator";
            this.winFaceMixer.label = "Face Mixer";
            this.winFaceMixer.modal = true;
            this.winFaceMixer.modalTransparency = 0.2;
            this.winCanvas.y = this.menuBar.y + this.menuBar.height;
            this.winRandom.close();
            this.winThumbs.close();
            this.winFaceMixer.close();
            this.keyboard.addEventListener(InterfaceEvent.KEYBOARD_PRESS,this.keyboardPress);
            this.winCanvas.addEventListener(InterfaceEvent.CANVAS_CLICK,this.canvasClick);
            this.winCanvas.addEventListener(AssetEvent.ASSET_ITEM_LOADED,this.canvasItemDone);
            this.winCanvas.addEventListener(AssetEvent.ASSET_ITEM_ERROR,this.canvasItemError);
            this.winCanvas.addEventListener(AssetEvent.ASSET_ITEM_PROGRESS,this.canvasItemProgress);
            this.winCanvas.addEventListener(AssetEvent.ASSET_UPDATE,this.canvasAssetUpdate);
            this.winLayer.addEventListener(InterfaceEvent.LAYER_REMOVED,this.layerRemoved);
            this.winLayer.addEventListener(InterfaceEvent.LAYER_CREATED,this.layerCreated);
            this.winLayer.addEventListener(InterfaceEvent.LAYER_SORT,this.layerSort);
            this.winLayer.addEventListener(InterfaceEvent.LAYER_VISIBLE,this.layerVisible);
            this.winLayer.addEventListener(InterfaceEvent.LAYER_CHANGE,this.layerChange);
            this.winInventory.addEventListener(InterfaceEvent.ITEM_REMOVED,this.inventoryItemRemoved);
            this.winInventory.addEventListener(InterfaceEvent.ITEM_VISIBLE,this.inventoryItemVisible);
            this.winInventory.addEventListener(InterfaceEvent.ITEM_COLOR,this.inventoryItemColor);
            this.winInventory.addEventListener(InterfaceEvent.ITEM_CLIENT_CHANGE,this.inventoryItemClientChange);
            this.winProperties.addEventListener(InterfaceEvent.CANVAS_ZOOM,this.propertiesCanvasZoom);
            this.winProperties.addEventListener(InterfaceEvent.CANVAS_COLOR,this.propertiesCanvasColor);
            this.winProperties.addEventListener(InterfaceEvent.TRANSFORMTOOL_RESET,this.transformToolChange);
            this.winProperties.addEventListener(InterfaceEvent.TRANSFORMTOOL_FLIP_H,this.transformToolChange);
            this.winProperties.addEventListener(InterfaceEvent.TRANSFORMTOOL_FLIP_V,this.transformToolChange);
            this.winProperties.addEventListener(InterfaceEvent.TRANSFORMTOOL_MOVE_CENTER,this.transformToolChange);
            this.winProperties.addEventListener(InterfaceEvent.PROPERTIES_SHOW_FACE_MIXER,this.showFaceMixer);
            this.winFaceMixer.addEventListener(InterfaceEvent.FACE_MIXER_DONE,this.faceMixerDone);
            this.winRandom.addEventListener(InterfaceEvent.RANDOM_GENERATE,this.randomGenerate);
            this.winThumbs.addEventListener(InterfaceEvent.THUMBNAIL_CLICK,this.thumbnailClick);
            this.menuBar.addEventListener(Event.CHANGE,this.menuClick);
            Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
            this.winHolder.addChild(this.winProperties);
            this.winHolder.addChild(this.winLayer);
            this.winHolder.addChild(this.winInventory);
            this.winHolder.addChild(this.winThumbs);
            this.winHolder.addChild(this.winRandom);
            this.winHolder.addChild(this.winFaceMixer);
            this.arrangeWindows();
            this.addChildAt(this.winAbout,0);
            this.addChildAt(this.menuBar,0);
            this.addChildAt(this.winHolder,0);
            this.addChildAt(this.winCanvas,0);
            param1.currentTarget.removeEventListener(TimerEvent.TIMER,this.loopStartInterface);
            Alerts.hideMessage();
         }
         else
         {
            param1.currentTarget.start();
         }
      }
      
      private function keyboardPress(param1:Event) : void
      {
         switch(this.keyboard.keyCode)
         {
            case KeyboardHandler.KEY_CTR_B:
               this.menuClickFunc("fileAddCategory");
               break;
            case KeyboardHandler.KEY_CTR_C:
               this.menuClickFunc("editDuplicateImage");
               break;
            case KeyboardHandler.KEY_CTR_D:
               this.menuClickFunc("fileSavePhotoshopCode");
               break;
            case KeyboardHandler.KEY_CTR_F:
               this.menuClickFunc("viewFullScreen");
               break;
            case KeyboardHandler.KEY_CTR_G:
               this.menuClickFunc("fileSaveNormalSpriteSheet");
               break;
            case KeyboardHandler.KEY_CTR_H:
               this.menuClickFunc("helpGuide");
               break;
            case KeyboardHandler.KEY_CTR_L:
               this.menuClickFunc("layersCreateLayer");
               break;
            case KeyboardHandler.KEY_CTR_N:
               this.menuClickFunc("fileNewProject");
               break;
            case KeyboardHandler.KEY_CTR_O:
               this.menuClickFunc("fileLoadProject");
               break;
            case KeyboardHandler.KEY_CTR_R:
               this.menuClickFunc("editRasterizeImage");
               break;
            case KeyboardHandler.KEY_CTR_S:
               this.menuClickFunc("fileSaveProject");
               break;
            case KeyboardHandler.KEY_CTR_T:
               this.menuClickFunc("editExplodeImage");
               break;
            case KeyboardHandler.KEY_0:
               this.menuClickFunc("windowThumb");
               break;
            case KeyboardHandler.KEY_1:
               this.menuClickFunc("windowLayer");
               break;
            case KeyboardHandler.KEY_2:
               this.menuClickFunc("windowInventory");
               break;
            case KeyboardHandler.KEY_3:
               this.menuClickFunc("windowProperty");
               break;
            case KeyboardHandler.KEY_4:
               this.menuClickFunc("windowRandom");
               break;
            case KeyboardHandler.KEY_B:
               this.menuClickFunc("editToolsTransform");
               break;
            case KeyboardHandler.KEY_V:
               this.menuClickFunc("editToolsNormalSelect");
               break;
            case KeyboardHandler.KEY_DELETE:
               this.menuClickFunc("layersDeleteLayer");
               break;
            case KeyboardHandler.KEY_SPACEBAR:
               this.menuClickFunc("windowArrangeWindows");
               break;
            case KeyboardHandler.KEY_UP:
               this.winCanvas.translateAsset(null,-1);
               this.winProperties.refreshCoordinates();
               break;
            case KeyboardHandler.KEY_DOWN:
               this.winCanvas.translateAsset(null,1);
               this.winProperties.refreshCoordinates();
               break;
            case KeyboardHandler.KEY_LEFT:
               this.winCanvas.translateAsset(-1);
               this.winProperties.refreshCoordinates();
               break;
            case KeyboardHandler.KEY_RIGHT:
               this.winCanvas.translateAsset(1);
               this.winProperties.refreshCoordinates();
               break;
            case KeyboardHandler.KEY_SHIFT_UP:
               this.winCanvas.translateAsset(null,-10);
               this.winProperties.refreshCoordinates();
               break;
            case KeyboardHandler.KEY_SHIFT_DOWN:
               this.winCanvas.translateAsset(null,10);
               this.winProperties.refreshCoordinates();
               break;
            case KeyboardHandler.KEY_SHIFT_LEFT:
               this.winCanvas.translateAsset(-10);
               this.winProperties.refreshCoordinates();
               break;
            case KeyboardHandler.KEY_SHIFT_RIGHT:
               this.winCanvas.translateAsset(10);
               this.winProperties.refreshCoordinates();
         }
      }
      
      private function transformToolChange(param1:Event) : void
      {
         this.winCanvas.transformToolChange(param1.type);
      }
      
      private function menuClick(param1:Event) : void
      {
         this.menuClickFunc(this.menuBar.code);
      }
      
      private function menuClickFunc(param1:String) : void
      {
         switch(param1)
         {
            case "windowThumb":
               this.winThumbs.visible = !this.winThumbs.visible;
               break;
            case "windowLayer":
               this.winLayer.visible = !this.winLayer.visible;
               break;
            case "windowInventory":
               this.winInventory.visible = !this.winInventory.visible;
               break;
            case "windowProperty":
               this.winProperties.visible = !this.winProperties.visible;
               this.winCanvas.fixScrolls(this.winProperties.visible);
               break;
            case "windowRandom":
               this.winRandom.visible = !this.winRandom.visible;
               break;
            case "windowArrangeWindows":
               this.arrangeWindows();
               break;
            case "helpGuide":
               navigateToURL(new URLRequest("http://maplesimulator.com/manual"),"_blank");
               break;
            case "helpAbout":
               this.winAbout.visible = true;
               break;
            case "viewFullScreen":
               if(stage.displayState == StageDisplayState.NORMAL)
               {
                  stage.displayState = StageDisplayState.FULL_SCREEN;
                  break;
               }
               stage.displayState = StageDisplayState.NORMAL;
               break;
            case "fileLoadImage":
               this.createPictureClick();
               break;
            case "fileNewProject":
               this.newProjectClick();
               break;
            case "fileLoadProject":
               this.loadProjectClick(true);
               break;
            case "importBSProject":
               this.loadProjectClick(false);
               break;
            case "fileSaveProject":
               this.saveProject();
               break;
            case "fileSavePhotoshopCode":
               this.savePhotoshopCode();
               break;
            case "fileSavePNGScene":
               this.savePNGScene();
               break;
            case "fileSavePNGSelected":
               this.savePNGSelected();
               break;
            case "fileSaveJPGScene":
               this.saveJPGScene();
               break;
            case "fileSaveJPGSelected":
               this.saveJPGSelected();
               break;
            case "fileSaveGIF":
               this.saveGIFSelected();
               break;
            case "fileSaveNormalSpriteSheet":
               this.saveSpriteSheet();
               break;
            case "fileSaveSpriteSheetFace":
               this.saveSpriteSheetFace();
               break;
            case "fileSaveSWF":
               this.saveSWFSelected();
               break;
            case "layersCreateLayer":
               this.winLayer.addLayer();
               break;
            case "layersDeleteLayer":
               this.winLayer.removeSelected();
               break;
            case "editDuplicateImage":
               this.cloneImage();
               break;
            case "editCloneStates":
               this.cloneStates();
               break;
            case "editCloneFrames":
               this.cloneFrames();
               break;
            case "editRasterizeImage":
               this.rasterizeImage();
               break;
            case "editExplodeImage":
               this.explodeImage();
               break;
            case "editToolsNormalSelect":
               this.winCanvas.useTransformTool = false;
               break;
            case "editToolsTransform":
               this.winCanvas.useTransformTool = true;
               break;
            case "fileAddCategory":
               this.winStartUp.open();
         }
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:String = Alerts.clickedButtonLabel;
         var _loc3_:String = Alerts.clickedButtonData;
         if(_loc3_ == "item_loading_cancel")
         {
            _loc4_ = this.winCanvas.selectedAssetDisplay;
            if(!(_loc4_ is AssetMaple))
            {
               return;
            }
            _loc4_.close();
            Alerts.hideMessage();
         }
         else if(_loc3_ == "project_ok")
         {
            Alerts.hideMessage();
            this.loadProjectClickFunc(true);
         }
         else if(_loc3_ == "project_new_ok")
         {
            Alerts.hideMessage();
            this.newProjectClickFunc();
         }
         else if(_loc3_ == "fast_alert_close")
         {
            Alerts.hideMessage();
         }
      }
      
      private function showFaceMixer(param1:Event = null) : void
      {
         var _loc4_:String = null;
         var _loc2_:* = this.winCanvas.selectedAssetDisplay;
         if(!(_loc2_ is Char))
         {
            return;
         }
         var _loc3_:Array = SingleList.singleXMLList(_loc2_.urlIDs.@url);
         while(_loc3_.length > 0)
         {
            _loc4_ = _loc3_.pop();
            if(Types.getType(_loc4_) == Types.FACE_CUSTOM)
            {
               break;
            }
         }
         if(_loc4_ != null)
         {
            this.winFaceMixer.load(ResourceCache.getFaceMixerXML(_loc4_));
            this.winFaceMixer.visible = true;
         }
      }
      
      private function faceMixerDone(param1:Event) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:String = null;
         var _loc2_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc2_ is Char)
         {
            _loc3_ = new ByteArray();
            _loc4_ = this.winFaceMixer.customFaceUrl;
            _loc3_.writeBytes(this.winFaceMixer.customFacePak);
            _loc3_.position = 0;
            this.winFaceMixer.close();
            this.winFaceMixer.reset();
            _loc2_.loadBytes(_loc4_,_loc3_);
         }
      }
      
      private function thumbnailClick(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc2_:String = this.winThumbs.currentURL;
         var _loc3_:int = this.winThumbs.currentType;
         var _loc4_:Object = this.winLayer.selectedLayer;
         Alerts.setMessage("Retrieving Item...",0,["Stop:item_loading_cancel"]);
         this.itemLoadingErrors = 0;
         if(_loc4_ == null)
         {
            _loc5_ = this.winCanvas.addAsset(_loc3_);
            this.winLayer.addLayer(null,null,null,_loc5_,_loc3_);
         }
         else if(_loc4_.type == Types.ASSET_NONE)
         {
            _loc5_ = this.winCanvas.addAsset(_loc3_);
            this.winLayer.setLayer(_loc4_.layerID,null,null,null,_loc5_,_loc3_);
         }
         else if(_loc4_.type != _loc3_)
         {
            _loc5_ = this.winCanvas.addAsset(_loc3_);
            this.winLayer.addLayer(null,null,null,_loc5_,_loc3_);
         }
         else
         {
            _loc5_ = int(_loc4_.assetID);
         }
         _loc6_ = this.winCanvas.getAsset(_loc5_);
         _loc6_.load(_loc2_);
      }
      
      private function randomGenerate(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc2_:Array = this.winRandom.urlList;
         var _loc3_:int = this.winRandom.currentType;
         var _loc4_:Object = this.winLayer.selectedLayer;
         Alerts.setMessage("Retrieving Item...",0,["Stop:item_loading_cancel"]);
         this.itemLoadingErrors = 0;
         _loc5_ = this.winCanvas.addAsset(_loc3_);
         _loc6_ = this.winCanvas.getAsset(_loc5_);
         if(_loc4_ == null)
         {
            this.winLayer.addLayer(null,null,null,_loc5_,_loc3_);
         }
         else if(_loc4_.type == Types.ASSET_NONE)
         {
            this.winLayer.setLayer(_loc4_.layerID,null,null,null,_loc5_,_loc3_);
         }
         else
         {
            this.winLayer.addLayer(null,null,null,_loc5_,_loc3_);
         }
         _loc6_.load(_loc2_);
      }
      
      private function canvasAssetUpdate(param1:Event) : void
      {
         var _loc2_:int = this.winCanvas.getAssetID(param1.target);
         var _loc3_:Object = this.winLayer.getLayerByAssetID(_loc2_);
         if(_loc3_ == null)
         {
            return;
         }
         this.winLayer.setLayer(_loc3_.layerID,null,null,param1.target);
      }
      
      private function canvasItemError(param1:Event) : void
      {
         ++this.itemLoadingErrors;
      }
      
      private function canvasItemDone(param1:Event) : void
      {
         if(this.itemLoadingErrors == 0)
         {
            Alerts.hideMessage();
         }
         else if(this.itemLoadingErrors == 1)
         {
            Alerts.setMessage("One item could not be loaded.",-1,["Close:fast_alert_close"]);
            Alerts.hideMessage(4);
         }
         else
         {
            Alerts.setMessage("There were " + this.itemLoadingErrors + " items that could not be loaded.",-1,["Close:fast_alert_close"]);
            Alerts.hideMessage(4);
         }
         this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
      }
      
      private function canvasItemProgress(param1:Event) : void
      {
         Alerts.setMessage("Loading Item...",this.winCanvas.progress,["Cancel:item_loading_cancel"]);
      }
      
      private function canvasClick(param1:Event) : void
      {
         var _loc2_:* = this.winCanvas.selectedAssetDisplay;
         var _loc3_:int = this.winCanvas.selectedAsset;
         var _loc4_:int = this.winCanvas.getAssetType(_loc3_);
         this.winLayer.setSelectedLayerByAssetID(_loc3_);
         this.winProperties.updateProperties(_loc4_,_loc2_);
         this.winInventory.updateInventory(_loc2_);
         if(_loc2_ is Pet)
         {
            this.winThumbs.updatePetItems(_loc2_.petID);
         }
         else
         {
            this.winThumbs.updatePetItems(null);
         }
         if(_loc2_ is Char)
         {
            if(this.winFaceMixer.visible)
            {
               this.showFaceMixer();
            }
         }
         else
         {
            this.winFaceMixer.visible = false;
            this.winFaceMixer.reset();
         }
      }
      
      private function propertiesCanvasColor(param1:Event) : void
      {
         this.winCanvas.canvasColor = param1.target.canvasColor;
      }
      
      private function propertiesCanvasZoom(param1:Event) : void
      {
         this.winCanvas.setZoom(param1.target.canvasZoom);
      }
      
      private function layerSort(param1:Event) : void
      {
         this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
      }
      
      private function layerRemoved(param1:Event) : void
      {
         var _loc2_:Object = this.winLayer.removedLayer;
         if(_loc2_ == null)
         {
            return;
         }
         this.winCanvas.removeAsset(_loc2_.assetID);
         _loc2_ = this.winLayer.selectedLayer;
         if(_loc2_ == null)
         {
            this.winProperties.updateProperties(Types.ASSET_NONE,null);
            this.winInventory.updateInventory(null);
         }
         else
         {
            this.winCanvas.selectedAsset = _loc2_.assetID;
            this.winProperties.updateProperties(_loc2_.type,this.winCanvas.selectedAssetDisplay);
            this.winInventory.updateInventory(this.winCanvas.selectedAssetDisplay);
         }
         if(this.winCanvas.selectedAssetDisplay is Pet)
         {
            this.winThumbs.updatePetItems(this.winCanvas.selectedAssetDisplay.petID);
         }
         else if(this.winCanvas.selectedAssetDisplay is Char)
         {
            if(this.winFaceMixer.visible)
            {
               this.showFaceMixer();
            }
         }
         else
         {
            this.winFaceMixer.visible = false;
            this.winFaceMixer.reset();
            this.winThumbs.updatePetItems(null);
         }
      }
      
      private function layerCreated(param1:Event = null) : void
      {
         this.winProperties.updateProperties(Types.ASSET_NONE,null);
         this.winInventory.updateInventory(null);
         this.winThumbs.updatePetItems(null);
      }
      
      private function layerChange(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Object = this.winLayer.selectedLayer;
         if(_loc2_ == null)
         {
            this.winProperties.updateProperties(Types.ASSET_NONE,null);
            this.winInventory.updateInventory(null);
         }
         else
         {
            this.winCanvas.selectedAsset = _loc2_.assetID;
            _loc3_ = this.winCanvas.selectedAssetDisplay;
            this.winProperties.updateProperties(_loc2_.type,_loc3_);
            this.winInventory.updateInventory(_loc3_);
         }
         if(_loc3_ is Pet)
         {
            this.winThumbs.updatePetItems(_loc3_.petID);
         }
         else
         {
            this.winThumbs.updatePetItems(null);
         }
      }
      
      private function layerVisible(param1:Event) : void
      {
         var _loc2_:Object = this.winLayer.selectedLayer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:* = this.winCanvas.getAsset(_loc2_.assetID);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = _loc2_.layerVisible;
      }
      
      private function inventoryItemVisible(param1:Event) : void
      {
         var _loc2_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visibleItem(this.winInventory.selectedItemID,this.winInventory.selectedLayerVisible);
      }
      
      private function inventoryItemRemoved(param1:Event) : void
      {
         var _loc2_:Object = this.winLayer.selectedLayer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:* = this.winCanvas.getAsset(_loc2_.assetID);
         this.winCanvas.removeAssetItem(_loc2_.assetID,this.winInventory.removedItemID);
         this.winProperties.updateProperties(_loc2_.type,_loc3_);
         if(_loc3_ is Pet)
         {
            this.winThumbs.updatePetItems(_loc3_.petID);
            this.winInventory.updateInventory(_loc3_);
         }
         else
         {
            this.winThumbs.updatePetItems(null);
         }
      }
      
      private function inventoryItemColor(param1:Event) : void
      {
         var _loc2_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.setItemColorMatrix(this.winInventory.selectedItemID,this.winInventory.colorMatrix);
      }
      
      private function inventoryItemClientChange(param1:Event) : void
      {
         this.winCanvas.selectedAssetDisplay.load({
            "url":BSPaths.bannedStoryPath + "pak/" + this.winInventory.selectedItemID + ".pak",
            "client":this.winInventory.selectedGameClient
         });
      }
      
      private function newProjectClick() : void
      {
         if(this.winCanvas.length > 0 || this.winLayer.length > 0)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nCreating a new project will erase all layers and images.\nDo you want to proceed?",-1,["OK:project_new_ok","Cancel:fast_alert_close"]);
         }
         else
         {
            this.winCanvas.canvasColor = 16777215;
            this.winProperties.canvasColor = 16777215;
         }
      }
      
      private function newProjectClickFunc() : void
      {
         this.winCanvas.removeAll();
         this.winLayer.removeAll();
         this.winInventory.updateInventory(null);
         this.winProperties.updateProperties(Types.ASSET_NONE,null);
         this.winThumbs.updatePetItems(null);
         this.winCanvas.canvasColor = 16777215;
         this.winProperties.canvasColor = 16777215;
      }
      
      private function loadProjectClick(param1:Boolean) : void
      {
         if((this.winCanvas.length > 0 || this.winLayer.length > 0) && param1)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nLoading a project will erase all layers and images.\nDo you want to proceed?",-1,["OK:project_ok","Cancel:fast_alert_close"]);
         }
         else
         {
            this.loadProjectClickFunc(param1);
         }
      }
      
      private function loadProjectClickFunc(param1:Boolean) : void
      {
         var _loc2_:ProjectLoader = new ProjectLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.externalProjectLoaded);
         _loc2_.addEventListener(InterfaceEvent.PROJECT_UPDATE,this.externalProjectUpdate);
         _loc2_.addEventListener(ErrorEvent.ERROR,this.externalProjError);
         _loc2_.load(param1);
      }
      
      private function externalProjectUpdate(param1:Event) : void
      {
         this.updateInterface();
      }
      
      private function externalProjError(param1:ErrorEvent) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.externalProjectLoaded);
         param1.currentTarget.removeEventListener(InterfaceEvent.PROJECT_UPDATE,this.externalProjectUpdate);
         param1.currentTarget.removeEventListener(ErrorEvent.ERROR,this.externalProjError);
         Alerts.setMessage(param1.text);
         Alerts.hideMessage(3);
      }
      
      private function externalProjectLoaded(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.externalProjectLoaded);
         param1.currentTarget.removeEventListener(InterfaceEvent.PROJECT_UPDATE,this.externalProjectUpdate);
         param1.currentTarget.removeEventListener(ErrorEvent.ERROR,this.externalProjError);
         var _loc2_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc2_ is Pet)
         {
            this.winThumbs.updatePetItems(_loc2_.petID);
         }
         else
         {
            this.winThumbs.updatePetItems(null);
         }
      }
      
      private function createPictureClick() : void
      {
         var _loc1_:Picture = new Picture();
         _loc1_.addEventListener(AssetEvent.ASSET_ITEM_LOADED,this.externalPictureLoaded);
         _loc1_.load();
      }
      
      private function externalPictureLoaded(param1:Event) : void
      {
         var _loc2_:* = param1.currentTarget;
         var _loc3_:int = Types.ASSET_PICTURE;
         var _loc4_:int = this.winCanvas.addAsset(_loc3_,_loc2_,false);
         var _loc5_:Object = this.winLayer.addLayer(null,null,null,_loc4_,_loc3_);
         _loc2_.x = Math.floor((stage.stageWidth - _loc2_.width) / 2);
         _loc2_.y = Math.floor((stage.stageHeight - this.winProperties.height - _loc2_.height + this.menuBar.height) / 2) - this.menuBar.height;
         this.winProperties.updateProperties(_loc3_,_loc2_);
         this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
         this.winLayer.setLayer(_loc5_.layerID,null,null,_loc2_);
         this.winInventory.updateInventory(null);
         this.winThumbs.updatePetItems(null);
         _loc2_.removeEventListener(AssetEvent.ASSET_ITEM_LOADED,this.externalPictureLoaded);
      }
      
      private function arrangeWindows() : void
      {
         this.winThumbs.x = 0;
         this.winThumbs.y = 25;
         this.winLayer.x = stage.stageWidth - this.winLayer.width - 15;
         this.winLayer.y = this.winThumbs.y;
         this.winInventory.x = stage.stageWidth - this.winInventory.width - 15;
         this.winInventory.y = 240;
         this.winRandom.x = Math.floor((stage.stageWidth - this.winRandom.width) / 2);
         this.winRandom.y = Math.floor((stage.stageHeight - this.winRandom.height) / 2);
      }
      
      private function savePNGScene() : void
      {
         var _loc1_:BitmapData = this.winCanvas.getImageCanvas();
         if(_loc1_ == null)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe canvas seems to be empty!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:ByteArray = PNGEncoder.encode(_loc1_);
         _loc1_.dispose();
         FileSave.save(_loc2_,"BannedStory_canvas.png");
      }
      
      private function savePNGSelected() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:BitmapData = RasterMaker.raster(_loc1_);
         if(_loc2_ == null)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe image seems to be empty!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc3_:ByteArray = PNGEncoder.encode(_loc2_);
         _loc2_.dispose();
         FileSave.save(_loc3_,"BannedStory_image.png");
      }
      
      private function saveJPGScene() : void
      {
         var _loc1_:JPGEncoder = new JPGEncoder(100);
         var _loc2_:BitmapData = this.winCanvas.getImageCanvas(this.winCanvas.canvasColor);
         if(_loc2_ == null)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe canvas seems to be empty!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc3_:ByteArray = _loc1_.encode(_loc2_);
         _loc2_.dispose();
         FileSave.save(_loc3_,"BannedStory_canvas.jpg");
      }
      
      private function saveJPGSelected() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:JPGEncoder = new JPGEncoder(100);
         var _loc3_:BitmapData = RasterMaker.raster(_loc1_,false,this.winCanvas.canvasColor);
         if(_loc3_ == null)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe image seems to be empty!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc4_:ByteArray = _loc2_.encode(_loc3_);
         _loc3_.dispose();
         FileSave.save(_loc4_,"BannedStory_image.jpg");
      }
      
      private function saveGIFSelected() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:SaveGIF = new SaveGIF();
         _loc2_.buildDelay = 20;
         _loc2_.start();
      }
      
      private function saveSWFSelected() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:SaveSWF = new SaveSWF();
         _loc2_.buildDelay = 20;
         _loc2_.start();
      }
      
      private function saveSpriteSheet() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:SaveSS = new SaveSS(SaveSS.NORMAL);
         _loc2_.buildDelay = 20;
         _loc2_.start();
      }
      
      private function saveSpriteSheetFace() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         if(!(_loc1_ is Char))
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe image must be a character!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         if(_loc1_.statesFace.length == 0)
         {
            Alerts.setMessage("This character does not have any face.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:SaveSS = new SaveSS(SaveSS.CHARACTER);
         _loc2_.buildDelay = 2;
         _loc2_.start();
      }
      
      private function savePhotoshopCode() : void
      {
         if(BSCommon.canvas.length <= 0)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe canvas can\'t be empty!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc1_:SaveJSX = new SaveJSX();
         _loc1_.buildDelay = 20;
         _loc1_.start();
      }
      
      private function saveProject() : void
      {
         if(BSCommon.canvas.length <= 0)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe canvas can\'t be empty!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc1_:SaveBSProj = new SaveBSProj();
         _loc1_.buildDelay = 20;
         _loc1_.start();
      }
      
      private function explodeImage(param1:String = "Exploded Piece") : void
      {
         var _loc7_:Picture = null;
         var _loc8_:int = 0;
         var _loc2_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc2_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc3_:Array = _loc2_.getImagePieces();
         var _loc4_:int = Types.ASSET_PICTURE;
         var _loc5_:Object = this.winLayer.selectedLayer;
         var _loc6_:String = _loc5_.label;
         var _loc9_:int = int(_loc3_.length);
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            _loc7_ = new Picture();
            _loc7_.load(_loc3_[_loc10_].image);
            _loc8_ = this.winCanvas.addAsset(_loc4_,_loc7_,false);
            _loc5_ = this.winLayer.addLayer(param1 + " #" + (_loc10_ + 1) + " (" + _loc6_ + ")",null,null,_loc8_,_loc4_);
            _loc7_.x = _loc2_.x + _loc3_[_loc10_].x + 5;
            _loc7_.y = _loc2_.y + _loc3_[_loc10_].y + 5;
            this.winProperties.updateProperties(_loc4_,_loc7_);
            this.winLayer.setLayer(_loc5_.layerID,null,null,_loc7_);
            _loc10_++;
         }
         this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
         this.winInventory.updateInventory(null);
         this.winThumbs.updatePetItems(null);
      }
      
      private function rasterizeImage() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:Picture = new Picture();
         var _loc3_:int = Types.ASSET_PICTURE;
         var _loc4_:Object = this.winLayer.selectedLayer;
         var _loc5_:String = _loc4_.label;
         _loc2_.load(RasterMaker.raster(_loc1_));
         var _loc6_:int = this.winCanvas.addAsset(_loc3_,_loc2_,false);
         _loc4_ = this.winLayer.addLayer("Raster Layer (" + _loc5_ + ")",null,null,_loc6_,_loc3_);
         _loc2_.x = _loc1_.x + 5;
         _loc2_.y = _loc1_.y + 5;
         this.winProperties.updateProperties(_loc3_,_loc2_);
         this.winLayer.setLayer(_loc4_.layerID,null,null,_loc2_);
         this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
         this.winInventory.updateInventory(null);
         this.winThumbs.updatePetItems(null);
      }
      
      private function cloneImage() : void
      {
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         var _loc2_:* = _loc1_.clone();
         var _loc3_:int = this.winCanvas.getAssetType(this.winCanvas.selectedAsset);
         var _loc4_:Object = this.winLayer.selectedLayer;
         var _loc5_:String = _loc4_.label;
         var _loc6_:int = this.winCanvas.addAsset(_loc3_,_loc2_,false);
         _loc4_ = this.winLayer.addLayer("Cloned Image (" + _loc5_ + ")",null,null,_loc6_,_loc3_);
         _loc2_.x = _loc1_.x + 5;
         _loc2_.y = _loc1_.y + 5;
         this.winProperties.updateProperties(_loc3_,_loc2_);
         this.winLayer.setLayer(_loc4_.layerID,null,null,_loc2_);
         this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
         this.winInventory.updateInventory(_loc2_);
         if(_loc2_ is Pet)
         {
            this.winThumbs.updatePetItems(_loc2_.petID);
         }
         else
         {
            this.winThumbs.updatePetItems(null);
         }
      }
      
      private function cloneStates() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         if(_loc1_ is AssetMapleMotion)
         {
            _loc2_ = _loc1_.extractStates();
            _loc3_ = this.winCanvas.getAssetType(this.winCanvas.selectedAsset);
            _loc4_ = this.winLayer.selectedLayer;
            _loc5_ = _loc4_.label;
            _loc8_ = int(_loc2_.length);
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc7_ = _loc2_[_loc9_];
               _loc6_ = this.winCanvas.addAsset(_loc3_,_loc7_,false);
               _loc4_ = this.winLayer.addLayer("Cloned State #" + (_loc9_ + 1) + " (" + _loc5_ + ")",null,null,_loc6_,_loc3_);
               _loc7_.x = _loc1_.x + 5;
               _loc7_.y = _loc1_.y + 5;
               this.winProperties.updateProperties(_loc3_,_loc7_);
               this.winLayer.setLayer(_loc4_.layerID,null,null,_loc7_);
               _loc9_++;
            }
            this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
            this.winInventory.updateInventory(_loc7_);
            if(_loc7_ is Pet)
            {
               this.winThumbs.updatePetItems(_loc7_.petID);
            }
            else
            {
               this.winThumbs.updatePetItems(null);
            }
         }
         else
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe selected image doesn\'t have states!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
         }
      }
      
      private function cloneFrames() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:* = this.winCanvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            Alerts.setMessage("Please, first select an image from the stage.",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
            return;
         }
         if(_loc1_ is Picture && _loc1_.maxFrames > 1)
         {
            this.explodeImage("Cloned Frame");
         }
         else if(_loc1_ is AssetMapleMotion)
         {
            _loc2_ = _loc1_.extractFrames();
            _loc3_ = this.winCanvas.getAssetType(this.winCanvas.selectedAsset);
            _loc4_ = this.winLayer.selectedLayer;
            _loc5_ = _loc4_.label;
            _loc8_ = int(_loc2_.length);
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc7_ = _loc2_[_loc9_];
               _loc6_ = this.winCanvas.addAsset(_loc3_,_loc7_,false);
               _loc4_ = this.winLayer.addLayer("Cloned Frame #" + (_loc9_ + 1) + " (" + _loc5_ + ")",null,null,_loc6_,_loc3_);
               _loc7_.x = _loc1_.x + 5;
               _loc7_.y = _loc1_.y + 5;
               this.winProperties.updateProperties(_loc3_,_loc7_);
               this.winLayer.setLayer(_loc4_.layerID,null,null,_loc7_);
               _loc9_++;
            }
            this.winCanvas.sortAssets(this.winLayer.orderedAssetIDs);
            this.winInventory.updateInventory(_loc7_);
            if(_loc7_ is Pet)
            {
               this.winThumbs.updatePetItems(_loc7_.petID);
            }
            else
            {
               this.winThumbs.updatePetItems(null);
            }
         }
         else
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe selected image doesn\'t have frames!",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(4);
         }
      }
   }
}

