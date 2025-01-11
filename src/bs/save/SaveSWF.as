package bs.save
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ion.utils.swf.SWFEncoder;
   
   public class SaveSWF
   {
      private const frameRate:int = 60;
      
      private var swf:SWFEncoder;
      
      private var swfArr:Array;
      
      private var swfArrMax:int;
      
      private var swfTimer:Timer;
      
      public var buildDelay:int = 100;
      
      public function SaveSWF()
      {
         super();
         this.swf = new SWFEncoder();
         this.swfTimer = new Timer(800);
         this.swf.setBackgroundColor(BSCommon.canvas.canvasColor);
         this.swf.setFrameRate(this.frameRate);
         this.swf.setCompressed(false);
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.swfTimer.addEventListener(TimerEvent.TIMER,this.swfLoop);
      }
      
      public function start() : void
      {
         var _loc1_:* = BSCommon.canvas.selectedAssetDisplay;
         if(_loc1_ == null)
         {
            return;
         }
         this.swfArr = _loc1_.getFrameImages();
         this.swfArrMax = this.swfArr == null ? 0 : int(this.swfArr.length);
         if(this.swfArrMax == 0)
         {
            Alerts.hideMessage();
            this.destroy();
            return;
         }
         this.swf.setSize(this.swfArr[0].image.width,this.swfArr[0].image.height);
         Alerts.setMessage("Creating SWF animation...",0);
         this.swfTimer.start();
      }
      
      private function swfLoop(param1:TimerEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         this.swfTimer.stop();
         if(this.swfTimer.currentCount == 1)
         {
            this.swfTimer.delay = this.buildDelay;
         }
         if(this.swfArr.length == 0)
         {
            Alerts.setMessage("Ready to <font color=\"#ff0000\">SAVE</font> the SWF animation.",-1,["Save:saveswf_save","Close:saveswf_close"]);
         }
         else
         {
            _loc2_ = this.swfArr.shift();
            _loc3_ = Math.ceil(_loc2_.delay / 1000 * this.frameRate);
            this.swf.addImage(_loc2_.image,_loc3_);
            _loc2_.image.dispose();
            Alerts.setMessage("Creating SWF animation...",(this.swfArrMax - this.swfArr.length) / this.swfArrMax);
            this.swfTimer.start();
         }
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc2_:String = Alerts.clickedButtonData;
         if(_loc2_ == "saveswf_save")
         {
            Alerts.hideMessage();
            FileSave.save(this.swf.serialize(),"BannedStory_animation.swf",this.destroy,this.destroy);
         }
         else if(_loc2_ == "saveswf_close")
         {
            Alerts.hideMessage();
            this.destroy();
         }
      }
      
      private function destroy() : void
      {
         this.swfTimer.stop();
         this.swfTimer.removeEventListener(TimerEvent.TIMER,this.swfLoop);
         Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.swf = null;
         this.swfArr = null;
         this.swfTimer = null;
      }
   }
}

