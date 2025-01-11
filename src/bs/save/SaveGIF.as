package bs.save
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import org.gif.encoder.GIFEncoder;
   
   public class SaveGIF
   {
      private var gif:GIFEncoder;
      
      private var gifArr:Array;
      
      private var gifArrMax:int;
      
      private var gifTimer:Timer;
      
      public var buildDelay:int = 100;
      
      public function SaveGIF()
      {
         super();
         this.gif = new GIFEncoder();
         this.gifTimer = new Timer(800);
         this.gif.start();
         this.gif.setQuality(20);
         this.gif.setRepeat(0);
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.gifTimer.addEventListener(TimerEvent.TIMER,this.gifLoop);
      }
      
      public function start() : void
      {
         Alerts.setMessage("Do you want a GIF with transparency? The background color will be considered the transparent color.",-1,["Yes:savegif_yes_trans","No:savegif_no_trans","Cancel:savegif_cancel"]);
      }
      
      private function gifLoop(param1:TimerEvent) : void
      {
         var _loc2_:Object = null;
         this.gifTimer.stop();
         if(this.gifTimer.currentCount == 1)
         {
            this.gifTimer.delay = this.buildDelay;
         }
         if(this.gifArr.length == 0)
         {
            this.gif.finish();
            Alerts.setMessage("Ready to <font color=\"#ff0000\">SAVE</font> the GIF image.",-1,["Save:savegif_save","Close:savegif_cancel"]);
         }
         else
         {
            _loc2_ = this.gifArr.shift();
            this.gif.addFrame(_loc2_.image);
            this.gif.setDelay(_loc2_.delay);
            _loc2_.image.dispose();
            Alerts.setMessage("Creating GIF image...",(this.gifArrMax - this.gifArr.length) / this.gifArrMax);
            this.gifTimer.start();
         }
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:String = Alerts.clickedButtonData;
         if(_loc2_ == "savegif_yes_trans" || _loc2_ == "savegif_no_trans")
         {
            if(_loc2_ == "savegif_yes_trans")
            {
               this.gif.setTransparent(BSCommon.canvas.canvasColor);
            }
            _loc3_ = BSCommon.canvas.selectedAssetDisplay;
            if(_loc3_ == null)
            {
               return;
            }
            this.gifArr = _loc3_.getFrameImages(BSCommon.canvas.canvasColor);
            this.gifArrMax = this.gifArr == null ? 0 : int(this.gifArr.length);
            if(this.gifArrMax == 0)
            {
               Alerts.hideMessage();
               this.destroy();
               return;
            }
            Alerts.setMessage("Creating GIF image...",0);
            this.gifTimer.start();
            return;
         }
         if(_loc2_ == "savegif_save")
         {
            Alerts.hideMessage();
            FileSave.save(this.gif.stream,"BannedStory_image.gif",this.destroy,this.destroy);
         }
         else if(_loc2_ == "savegif_cancel")
         {
            Alerts.hideMessage();
            this.destroy();
         }
      }
      
      private function destroy() : void
      {
         this.gifTimer.stop();
         this.gifTimer.removeEventListener(TimerEvent.TIMER,this.gifLoop);
         Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.gif = null;
         this.gifArr = null;
         this.gifTimer = null;
      }
   }
}

