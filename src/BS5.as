package
{
   import bs.events.InterfaceEvent;
   import bs.gui.BaseSprite;
   import bs.gui.Interface;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import bs.manager.Data;
   import bs.manager.Thumbnail;
   import bs.utils.BSPaths;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import ion.components.controls.IToolTip;
   
   public class BS5 extends Sprite
   {
      private var gui:Interface;
      
      private var firstTime:Boolean;
      
      public function BS5()
      {
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
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
            Alerts.setMessage("Retrieving Thumbnails...",0);
            _loc2_.start(BSPaths.thumbnailsPath);
         }
         else if(this.firstTime)
         {
            this.gui.startInterface();
            this.firstTime = false;
         }
         else
         {
            Alerts.hideMessage();
            this.gui.updateInterface();
         }
      }
      
      private function dataError(param1:ErrorEvent) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.dataDone);
         param1.currentTarget.removeEventListener(ErrorEvent.ERROR,this.dataError);
         param1.currentTarget.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         Alerts.setMessage("BannedStory was unable to find the item list.");
      }
      
      private function dataProgress(param1:ProgressEvent) : void
      {
         Alerts.setMessage("Downloading Items List...",param1.currentTarget.progress);
      }
      
      private function thumbDone(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.thumbDone);
         param1.currentTarget.removeEventListener(ProgressEvent.PROGRESS,this.thumbProgress);
         if(this.firstTime)
         {
            this.gui.startInterface();
            this.firstTime = false;
         }
         else
         {
            Alerts.hideMessage();
            this.gui.updateInterface();
         }
      }
      
      private function thumbProgress(param1:ProgressEvent) : void
      {
         Alerts.setMessage("Downloading Thumbnails...",param1.currentTarget.progress);
      }
      
      private function init(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         BSPaths.setCurrentDomain(root.loaderInfo.url);
         if(!BSPaths.domainAllowed)
         {
            return;
         }
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.showDefaultContextMenu = false;
         var _loc2_:IToolTip = new IToolTip();
         var _loc3_:Alerts = new Alerts();
         this.gui = new Interface();
         this.firstTime = true;
         stage.addEventListener(Event.RESIZE,this.stageResize);
         this.gui.addEventListener(InterfaceEvent.STARTUP_DONE,this.startupDone);
         this.stageResize();
         this.gui.startUp();
         this.addChild(this.gui);
         this.addChild(_loc2_);
         this.addChild(_loc3_);
      }
      
      private function stageResize(param1:Event = null) : void
      {
         BaseSprite.updateResize(stage.stageWidth,stage.stageHeight);
      }
      
      private function startupDone(param1:Event) : void
      {
         var _loc2_:Data = new Data();
         _loc2_.addEventListener(Event.COMPLETE,this.dataDone);
         _loc2_.addEventListener(ErrorEvent.ERROR,this.dataError);
         _loc2_.addEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         Alerts.setMessage("Retrieving Items List...",0);
         _loc2_.start(BSPaths.dataPath);
      }
   }
}

