package bs.utils
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import bs.manager.Data;
   import bs.manager.Thumbnail;
   import bs.save.FileSave;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.net.FileFilter;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import maplestory.display.core.Picture;
   import maplestory.display.maple.AssetMapleMotion;
   import maplestory.display.maple.Char;
   import maplestory.display.maple.ChatBalloon;
   import maplestory.display.maple.NameTag;
   import maplestory.display.maple.Pet;
   import maplestory.events.AssetEvent;
   import maplestory.struct.Types;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.ResourceCache;
   
   public class ProjectLoader extends EventDispatcher
   {
      private var raw:ByteArray;
      
      private var timer:Timer;
      
      private const itemsTimerMax:int = 10;
      
      private var itemsTimerCount:int;
      
      private var data:Array;
      
      private var dataMax:int;
      
      private var currentItem:AssetProperties;
      
      private var currentDisp:*;
      
      public function ProjectLoader()
      {
         super();
      }
      
      public function load(param1:Boolean) : void
      {
         if(param1)
         {
            FileSave.browse(new FileFilter("BannedStory Project","*.bsproj"),this.externalProjSelect,null,this.externalProjDone);
         }
         else
         {
            FileSave.browse(new FileFilter("BannedStory Project","*.bsproj"),null,null,this.externalProjDone);
         }
      }
      
      private function externalProjSelect() : void
      {
         BSCommon.canvas.removeAll();
         BSCommon.layer.removeAll();
         BSCommon.inventory.updateInventory(null);
         BSCommon.properties.updateProperties(Types.ASSET_NONE,null);
      }
      
      private function externalProjDone(param1:ByteArray, param2:String, param3:String) : void
      {
         var addCategories:Boolean;
         var signature:String = null;
         var programSettings:Object = null;
         var customResources:Object = null;
         var dat:Data = null;
         var refData:ByteArray = param1;
         var refName:String = param2;
         var refType:String = param3;
         this.timer = new Timer(1);
         this.raw = refData;
         this.data = [];
         this.itemsTimerCount = 0;
         addCategories = false;
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.timer.addEventListener(TimerEvent.TIMER,this.startProcess);
         try
         {
            signature = this.raw.readUTFBytes(3);
            switch(signature)
            {
               case "BS4":
               case "BS5":
                  programSettings = this.raw.readObject();
                  if(signature == "BS5")
                  {
                     customResources = this.raw.readObject();
                     this.loadCustomResources(customResources as Array);
                  }
                  break;
               default:
                  this.badFile();
                  return;
            }
         }
         catch(err:*)
         {
            badFile();
            return;
         }
         BSCommon.canvas.canvasColor = programSettings.canvasColor;
         BSCommon.properties.canvasColor = programSettings.canvasColor;
         BSCommon.faceMixer.visible = false;
         if(!BSCommon.start.character && Boolean(programSettings.useCharacter))
         {
            addCategories = true;
            BSCommon.start.character = programSettings.useCharacter;
         }
         if(!BSCommon.start.chat && Boolean(programSettings.useChat))
         {
            addCategories = true;
            BSCommon.start.chat = programSettings.useChat;
         }
         if(!BSCommon.start.effect && Boolean(programSettings.useEffect))
         {
            addCategories = true;
            BSCommon.start.effect = programSettings.useEffect;
         }
         if(!BSCommon.start.etc && Boolean(programSettings.useEtc))
         {
            addCategories = true;
            BSCommon.start.etc = programSettings.useEtc;
         }
         if(!BSCommon.start.item && Boolean(programSettings.useItem))
         {
            addCategories = true;
            BSCommon.start.item = programSettings.useItem;
         }
         if(!BSCommon.start.map && Boolean(programSettings.useMap))
         {
            addCategories = true;
            BSCommon.start.map = programSettings.useMap;
         }
         if(!BSCommon.start.mob && Boolean(programSettings.useMob))
         {
            addCategories = true;
            BSCommon.start.mob = programSettings.useMob;
         }
         if(!BSCommon.start.morph && Boolean(programSettings.useMorph))
         {
            addCategories = true;
            BSCommon.start.morph = programSettings.useMorph;
         }
         if(!BSCommon.start.npc && Boolean(programSettings.useNPC))
         {
            addCategories = true;
            BSCommon.start.npc = programSettings.useNPC;
         }
         if(!BSCommon.start.pet && Boolean(programSettings.usePet))
         {
            addCategories = true;
            BSCommon.start.pet = programSettings.usePet;
         }
         if(!BSCommon.start.skill && Boolean(programSettings.useSkill))
         {
            addCategories = true;
            BSCommon.start.skill = programSettings.useSkill;
         }
         if(addCategories)
         {
            dat = new Data();
            dat.addEventListener(Event.COMPLETE,this.dataDone);
            dat.addEventListener(ErrorEvent.ERROR,this.dataError);
            dat.addEventListener(ProgressEvent.PROGRESS,this.dataProgress);
            Alerts.setMessage("Retrieving Added Items List...",0);
            dat.start(BSPaths.dataPath);
         }
         else
         {
            this.startReadingData();
         }
      }
      
      private function assetProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = (this.dataMax - (this.data.length + 1)) / this.dataMax;
         var _loc3_:Number = 1 / this.dataMax * param1.currentTarget.progress;
         if(isNaN(_loc2_))
         {
            _loc2_ = 0;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         Alerts.setMessage("Loading project...",_loc2_ + _loc3_,["Cancel:project_cancel"]);
      }
      
      private function assetComplete(param1:Event) : void
      {
         this.currentDisp.removeEventListener(AssetEvent.ASSET_ITEM_LOADED,this.assetComplete);
         this.currentDisp.removeEventListener(ErrorEvent.ERROR,this.assetError);
         this.currentDisp.setProperties(this.currentItem);
         this.assetCompleteFunc();
         var _loc2_:XMLList = this.currentDisp.urlIDs;
         if(_loc2_.length() == 1)
         {
            if(ResourceCache.resourceExists(_loc2_[0].@url) && this.itemsTimerCount < this.itemsTimerMax)
            {
               ++this.itemsTimerCount;
               this.timer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
            }
            else
            {
               this.itemsTimerCount = 0;
            }
         }
      }
      
      private function assetError(param1:ErrorEvent) : void
      {
      }
      
      private function assetCompleteFunc() : void
      {
         if(this.currentDisp == null)
         {
            return;
         }
         var _loc1_:int = BSCommon.canvas.addAsset(this.currentItem.assetType,this.currentDisp,false);
         var _loc2_:Object = BSCommon.layer.addLayer(this.currentItem.layerName,this.currentItem.layerVisible,null,_loc1_,this.currentItem.assetType);
         BSCommon.properties.updateProperties(this.currentItem.assetType,this.currentDisp);
         BSCommon.canvas.sortAssets(BSCommon.layer.orderedAssetIDs);
         BSCommon.layer.setLayer(_loc2_.layerID,null,null,this.currentDisp);
         BSCommon.inventory.updateInventory(this.currentDisp);
         if(this.currentDisp is Pet)
         {
            BSCommon.thumbs.updatePetItems(this.currentDisp.petID);
         }
         else
         {
            BSCommon.thumbs.updatePetItems(null);
         }
         this.timer.start();
      }
      
      private function dataDone(param1:Event) : void
      {
         var _loc2_:Thumbnail = null;
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.dataDone);
         param1.currentTarget.removeEventListener(ErrorEvent.ERROR,this.dataError);
         param1.currentTarget.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         if(BSCommon.start.thumbnails)
         {
            _loc2_ = new Thumbnail();
            _loc2_.addEventListener(Event.COMPLETE,this.thumbDone);
            _loc2_.addEventListener(ProgressEvent.PROGRESS,this.thumbProgress);
            Alerts.setMessage("Retrieving Added Thumbnails...",0);
            _loc2_.start(BSPaths.thumbnailsPath);
         }
         else
         {
            this.dispatchEvent(new Event(InterfaceEvent.PROJECT_UPDATE));
            this.startReadingData();
         }
      }
      
      private function dataError(param1:ErrorEvent) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.dataDone);
         param1.currentTarget.removeEventListener(ErrorEvent.ERROR,this.dataError);
         param1.currentTarget.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         this.startReadingData();
      }
      
      private function dataProgress(param1:ProgressEvent) : void
      {
         Alerts.setMessage("Downloading Added Items List...",param1.currentTarget.progress);
      }
      
      private function thumbDone(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.thumbDone);
         param1.currentTarget.removeEventListener(ProgressEvent.PROGRESS,this.thumbProgress);
         this.dispatchEvent(new Event(InterfaceEvent.PROJECT_UPDATE));
         this.startReadingData();
      }
      
      private function thumbProgress(param1:ProgressEvent) : void
      {
         Alerts.setMessage("Downloading Added Thumbnails...",param1.currentTarget.progress);
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc2_:String = Alerts.clickedButtonData;
         if(_loc2_ == "project_cancel")
         {
            if(this.currentDisp != null)
            {
               this.currentDisp.removeEventListener(AssetEvent.ASSET_ITEM_LOADED,this.assetComplete);
               this.currentDisp.close();
            }
            Alerts.hideMessage();
            Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
            this.raw = null;
            this.data = null;
            this.currentItem = null;
            this.currentDisp = null;
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function loadCustomResources(param1:Array) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:Object = null;
         var _loc2_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1[_loc5_];
            _loc3_.position = 0;
            _loc4_ = _loc3_.readObject();
            ResourceCache.setResource(_loc4_.id,_loc4_.data,true);
            _loc5_++;
         }
      }
      
      private function startReadingData() : void
      {
         var ret:AssetProperties = null;
         var ba:ByteArray = null;
         var obj:Object = null;
         while(this.raw.bytesAvailable)
         {
            try
            {
               obj = this.raw.readObject();
            }
            catch(err:*)
            {
               break;
            }
            ba = obj.data as ByteArray;
            ret = new AssetProperties();
            ret.layerName = obj.layerName;
            ret.layerVisible = obj.layerVisible;
            ret.assetType = obj.assetType;
            ret.assetID = obj.assetID;
            if(ba != null)
            {
               try
               {
                  ba.uncompress();
                  obj = ba.readObject();
                  ret.structure = obj.structure;
                  ret.structureFace = obj.structureFace;
                  ret.frame = obj.frame;
                  ret.frameFace = obj.frameFace;
                  ret.state = obj.state;
                  ret.stateFace = obj.stateFace;
                  ret.animate = obj.animate;
                  ret.animateFace = obj.animateFace;
                  ret.pointedEars = obj.pointedEars;
                  ret.flatHair = obj.flatHair;
                  ret.hatExists = obj.hatExists;
                  ret.headID = obj.headID;
                  ret.pixelated = obj.pixelated;
                  ret.text = obj.text;
                  ret.tileX = obj.tileX;
                  ret.tileY = obj.tileY;
                  ret.balloonX = obj.balloonX;
                  ret.balloonY = obj.balloonY;
                  ret.arrowPercent = obj.arrowPercent;
                  ret.blendMode = obj.blendMode;
                  ret.petID = obj.petID;
                  ret.transformMatrix = obj.transformMatrix;
                  ret.itemColorMatrixCache = obj.itemColorMatrixCache;
                  ret.colorMatrix = obj.colorMatrix;
                  ret.filters = obj.filters;
                  ret.images = obj.images;
               }
               catch(err:*)
               {
               }
            }
            this.data.push(ret);
         }
         this.dataMax = this.data.length;
         this.timer.start();
      }
      
      private function startProcess(param1:TimerEvent) : void
      {
         this.timer.stop();
         if(this.data.length == 0)
         {
            Alerts.hideMessage();
            Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
            this.currentDisp = null;
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            Alerts.setMessage("Loading project...",(this.dataMax - this.data.length) / this.dataMax,["Cancel:project_cancel"]);
            this.currentItem = this.data.shift();
            switch(this.currentItem.assetType)
            {
               case Types.ASSET_CHARACTER:
                  this.currentDisp = new Char();
                  break;
               case Types.ASSET_CHAT_BALLOON:
                  this.currentDisp = new ChatBalloon();
                  break;
               case Types.ASSET_NAME_TAG:
                  this.currentDisp = new NameTag();
                  break;
               case Types.ASSET_PET:
                  this.currentDisp = new Pet();
                  break;
               case Types.ASSET_NONE_MOTION:
               case Types.ASSET_EFFECT:
               case Types.ASSET_ETC:
               case Types.ASSET_ITEM:
               case Types.ASSET_MAP:
               case Types.ASSET_MOB:
               case Types.ASSET_MORPH:
               case Types.ASSET_NPC:
               case Types.ASSET_SKILL:
                  this.currentDisp = new AssetMapleMotion();
                  break;
               case Types.ASSET_PICTURE:
                  this.currentDisp = new Picture();
                  break;
               default:
                  this.timer.start();
                  return;
            }
            if(this.currentItem.assetType == Types.ASSET_PICTURE)
            {
               this.currentDisp.setProperties(this.currentItem);
               this.assetCompleteFunc();
            }
            else
            {
               this.currentDisp.addEventListener(AssetEvent.ASSET_ITEM_LOADED,this.assetComplete);
               this.currentDisp.addEventListener(ProgressEvent.PROGRESS,this.assetProgress);
               this.currentDisp.addEventListener(ErrorEvent.ERROR,this.assetError);
               this.currentDisp.load(this.prepareUrlIDs(this.currentItem.items));
            }
         }
      }
      
      private function prepareUrlIDs(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(BSPaths.bannedStoryPath + "pak/" + param1[_loc3_] + ".pak");
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function badFile() : void
      {
         var _loc1_:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
         _loc1_.text = "<font color=\"#ff0000\">WARNING!!</font>\nThis BannedStory project file seems to be corrupted!";
         this.dispatchEvent(_loc1_);
      }
   }
}

