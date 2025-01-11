package bs.save
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import ion.utils.SingleList;
   import maplestory.display.maple.AssetMaple;
   import maplestory.utils.ResourceCache;
   
   public class SaveBSProj
   {
      private var projTimer:Timer;
      
      private var canvasColor:int;
      
      private var arrLayers:Array;
      
      private var arrLayersMax:int;
      
      private var raw:ByteArray;
      
      private var mainSectionList:Array;
      
      public var buildDelay:int = 100;
      
      public function SaveBSProj()
      {
         super();
         this.projTimer = new Timer(1);
         this.arrLayers = BSCommon.layer.layersInfo;
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.projTimer.addEventListener(TimerEvent.TIMER,this.projLoop);
      }
      
      public function start() : void
      {
         this.raw = new ByteArray();
         this.arrLayersMax = this.arrLayers.length;
         this.canvasColor = BSCommon.canvas.canvasColor;
         this.mainSectionList = [];
         if(this.arrLayersMax > 0)
         {
            Alerts.setMessage("Creating BannedStory project...",0);
            this.projTimer.start();
         }
         else
         {
            this.destroy();
         }
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc3_:ByteArray = null;
         var _loc2_:String = Alerts.clickedButtonData;
         if(_loc2_ == "savebsproj_save")
         {
            _loc3_ = new ByteArray();
            _loc3_.writeUTFBytes("BS5");
            _loc3_.writeObject(this.getProgramSettings());
            _loc3_.writeObject(ResourceCache.getCustomResources());
            _loc3_.writeBytes(this.raw);
            Alerts.hideMessage();
            FileSave.save(_loc3_,"BannedStory_Project.bsproj",this.destroy,this.destroy);
         }
         else if(_loc2_ == "savebsproj_close")
         {
            Alerts.hideMessage();
            this.destroy();
         }
      }
      
      private function projLoop(param1:TimerEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         var _loc4_:ByteArray = null;
         var _loc5_:Object = null;
         var _loc6_:XMLList = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         this.projTimer.stop();
         this.projTimer.delay = this.buildDelay;
         if(this.arrLayers.length == 0)
         {
            Alerts.setMessage("Ready to <font color=\"#ff0000\">SAVE</font> the BannedStory Project.",-1,["Save:savebsproj_save","Close:savebsproj_close"]);
         }
         else
         {
            _loc2_ = this.arrLayers.pop();
            _loc3_ = BSCommon.canvas.getAsset(_loc2_.assetID);
            _loc4_ = _loc3_.getRawData();
            _loc5_ = {};
            if(_loc3_ is AssetMaple)
            {
               _loc6_ = _loc3_.urlIDs.@url;
               _loc7_ = int(_loc6_.length());
               _loc8_ = [];
               _loc9_ = 0;
               while(_loc9_ < _loc7_)
               {
                  _loc8_ = String(_loc6_[_loc9_]).split("/");
                  this.mainSectionList.push(_loc8_.shift());
                  _loc9_++;
               }
            }
            _loc5_.layerName = _loc2_.layerName;
            _loc5_.assetType = _loc2_.assetType;
            _loc5_.assetID = _loc2_.assetID;
            _loc5_.layerVisible = _loc2_.layerVisible;
            _loc5_.data = _loc4_;
            this.raw.writeObject(_loc5_);
            Alerts.setMessage("Creating BannedStory project...",(this.arrLayersMax - this.arrLayers.length) / this.arrLayersMax);
            this.projTimer.start();
         }
      }
      
      private function getProgramSettings() : Object
      {
         var _loc2_:String = null;
         var _loc1_:Object = {};
         _loc1_.canvasColor = this.canvasColor;
         _loc1_.useCharacter = false;
         _loc1_.useChat = false;
         _loc1_.useEffect = false;
         _loc1_.useEtc = false;
         _loc1_.useItem = false;
         _loc1_.useMap = false;
         _loc1_.useMob = false;
         _loc1_.useMorph = false;
         _loc1_.useNPC = false;
         _loc1_.usePet = false;
         _loc1_.useSkill = false;
         this.mainSectionList = SingleList.singleArray(this.mainSectionList);
         while(this.mainSectionList.length > 0)
         {
            _loc2_ = this.mainSectionList.pop();
            switch(_loc2_)
            {
               case "character":
                  _loc1_.useCharacter = true;
                  break;
               case "effect":
                  _loc1_.useEffect = true;
                  break;
               case "etc":
                  _loc1_.useEtc = true;
                  break;
               case "item":
                  _loc1_.useItem = true;
                  break;
               case "map":
                  _loc1_.useMap = true;
                  break;
               case "morph":
                  _loc1_.useMorph = true;
                  break;
               case "npc":
                  _loc1_.useNPC = true;
                  break;
               case "reactor":
                  _loc1_.useMap = true;
                  break;
               case "skill":
                  _loc1_.useSkill = true;
                  break;
               case "ui":
                  _loc1_.useChat = true;
            }
            if(_loc2_.indexOf("mob") == 0)
            {
               _loc1_.useMob = true;
            }
         }
         return _loc1_;
      }
      
      private function destroy() : void
      {
         this.projTimer.stop();
         this.projTimer.removeEventListener(TimerEvent.TIMER,this.projLoop);
         Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         if(this.raw != null)
         {
            this.raw.clear();
         }
         this.mainSectionList = null;
         this.projTimer = null;
         this.arrLayers = null;
         this.raw = null;
      }
   }
}

