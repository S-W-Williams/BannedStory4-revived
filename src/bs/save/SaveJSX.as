package bs.save
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import bs.utils.JSXCode;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import fzip.FZip;
   import ion.utils.optimized.PNGEncoder;
   
   public class SaveJSX
   {
      private var jsxTimer:Timer;
      
      private var assets:Array;
      
      private var assetsMax:int;
      
      private var assetsCounter:int;
      
      private var imageCounter:int;
      
      private var strAcum:String;
      
      private var zipAcum:FZip;
      
      private var _width:int;
      
      private var _height:int;
      
      public var buildDelay:int = 100;
      
      public function SaveJSX()
      {
         super();
         this.jsxTimer = new Timer(1);
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.jsxTimer.addEventListener(TimerEvent.TIMER,this.jsxLoop);
      }
      
      public function start() : void
      {
         this.assets = BSCommon.canvas.assetCollection;
         this.assetsMax = this.assets.length;
         if(this.assetsMax > 0)
         {
            this._width = BSCommon.canvas.width;
            this._height = BSCommon.canvas.height;
            this.assetsCounter = 0;
            this.imageCounter = 0;
            this.strAcum = "";
            this.zipAcum = new FZip();
            Alerts.setMessage("Creating Photoshop code...",0);
            this.jsxTimer.start();
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
         if(_loc2_ == "savejsx_save")
         {
            _loc3_ = new ByteArray();
            this.zipAcum.serialize(_loc3_,true);
            Alerts.hideMessage();
            FileSave.save(_loc3_,"BannedStory_Photoshop_code.zip",this.destroy,this.destroy);
         }
         else if(_loc2_ == "savejsx_close")
         {
            Alerts.hideMessage();
            this.destroy();
         }
      }
      
      private function jsxLoop(param1:TimerEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         this.jsxTimer.stop();
         this.jsxTimer.delay = this.buildDelay;
         if(this.assets.length == 0)
         {
            this.strAcum = this.strAcum.substr(0,-2);
            this.strAcum = JSXCode.build(this.strAcum,this._width,this._height);
            this.zipAcum.addFileFromString("jsx_code.jsx",this.strAcum);
            Alerts.setMessage("Ready to <font color=\"#ff0000\">SAVE</font> the Photoshop code.",-1,["Save:savejsx_save","Close:savejsx_close"]);
         }
         else
         {
            _loc2_ = this.assets.shift();
            _loc3_ = _loc2_.getImagePieces();
            _loc6_ = "Layer " + this.assetsCounter;
            _loc7_ = int(_loc3_.length - 1);
            while(_loc7_ >= 0)
            {
               _loc4_ = _loc3_[_loc7_];
               _loc5_ = "Image_" + this.imageCounter + ".png";
               this.zipAcum.addFile(_loc5_,PNGEncoder.encode(_loc4_.image));
               _loc4_.image.dispose();
               this.strAcum += "{image: \"" + _loc5_ + "\", x: " + (_loc2_.x + _loc3_[_loc7_].x) + ", y: " + (_loc2_.y + _loc3_[_loc7_].y) + "},\n";
               ++this.imageCounter;
               _loc7_--;
            }
            this.strAcum += "{name: \"" + _loc6_ + "\", maxImages: " + _loc3_.length + "},\n";
            ++this.assetsCounter;
            Alerts.setMessage("Creating Photoshop code...",(this.assetsMax - this.assets.length) / this.assetsMax);
            this.jsxTimer.start();
         }
      }
      
      private function destroy() : void
      {
         this.jsxTimer.stop();
         this.jsxTimer.removeEventListener(TimerEvent.TIMER,this.jsxLoop);
         Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.jsxTimer = null;
         this.assets = null;
         this.zipAcum = null;
      }
   }
}

