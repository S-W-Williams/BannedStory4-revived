package bs.save
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import fzip.FZip;
   import ion.utils.optimized.PNGEncoder;
   
   public class SaveSS
   {
      public static const NORMAL:int = 0;
      
      public static const CHARACTER:int = 1;
      
      private var ssMode:int;
      
      private var zip:FZip;
      
      private var allItems:Array;
      
      private var allItemsMax:int;
      
      private var ssTimer:Timer;
      
      private var xmlData:XML;
      
      public var buildDelay:int = 100;
      
      public function SaveSS(param1:int)
      {
         super();
         this.ssMode = param1;
         this.xmlData = <i/>;
         this.ssTimer = new Timer(1000);
         this.zip = new FZip();
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.ssTimer.addEventListener(TimerEvent.TIMER,this.ssLoop);
      }
      
      public function start() : void
      {
         var _loc1_:FlatListNormal = null;
         var _loc2_:FlatListCharacter = null;
         if(this.ssMode == NORMAL)
         {
            _loc1_ = new FlatListNormal(this.buildDelay);
            _loc1_.addEventListener(Event.COMPLETE,this.listComplete);
            _loc1_.start();
         }
         else if(this.ssMode == CHARACTER)
         {
            _loc2_ = new FlatListCharacter(this.buildDelay);
            _loc2_.addEventListener(Event.COMPLETE,this.listComplete);
            _loc2_.start();
         }
      }
      
      private function listComplete(param1:Event) : void
      {
         this.allItems = param1.currentTarget.allItems;
         this.allItemsMax = this.allItems.length;
         if(this.allItemsMax == 0)
         {
            Alerts.hideMessage();
            this.destroy();
         }
         else
         {
            Alerts.setMessage("Creating Sprite Sheet... (Step 2 of 2)",0,["Cancel:savess_close"]);
            this.ssTimer.start();
         }
      }
      
      private function ssLoop(param1:TimerEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         this.ssTimer.stop();
         if(this.ssTimer.currentCount == 1)
         {
            this.ssTimer.delay = this.buildDelay;
         }
         if(this.allItems.length == 0)
         {
            Alerts.setMessage("Ready to <font color=\"#ff0000\">SAVE</font> the Sprite Sheet.",-1,["Save:savess_save","Close:savess_close"]);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < 10)
            {
               if(this.allItems.length == 0)
               {
                  break;
               }
               _loc2_ = this.allItems.shift();
               _loc3_ = PNGEncoder.encode(_loc2_.image);
               if(this.ssMode == NORMAL)
               {
                  this.xmlData.appendChild(<i image={_loc2_.name} delay={_loc2_.delay} x={_loc2_.x} y={_loc2_.y}/>);
               }
               this.zip.addFile(_loc2_.name,_loc3_);
               _loc2_.image.dispose();
               _loc4_++;
            }
            Alerts.setMessage("Creating Sprite Sheet... (Step 2 of 2)",(this.allItemsMax - this.allItems.length) / this.allItemsMax,["Cancel:savess_close"]);
            this.ssTimer.start();
         }
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:String = null;
         var _loc2_:String = Alerts.clickedButtonData;
         if(_loc2_ == "savess_save")
         {
            _loc3_ = new ByteArray();
            if(this.ssMode == NORMAL)
            {
               _loc4_ = this.xmlData.toXMLString();
               this.zip.addFileFromString("data.xml",_loc4_);
            }
            this.zip.serialize(_loc3_,true);
            _loc3_.position = 0;
            Alerts.hideMessage();
            FileSave.save(_loc3_,"BannedStory_SpriteSheet.zip",this.destroy,this.destroy);
         }
         else if(_loc2_ == "savess_close")
         {
            Alerts.hideMessage();
            this.destroy();
         }
      }
      
      private function destroy() : void
      {
         this.ssTimer.stop();
         this.ssTimer.removeEventListener(TimerEvent.TIMER,this.ssLoop);
         Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.zip = null;
         this.allItems = null;
         this.ssTimer = null;
      }
   }
}

