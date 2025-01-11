package bs.save
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ion.utils.RasterMaker;
   import maplestory.display.core.Picture;
   import maplestory.display.maple.AssetMapleMotion;
   import maplestory.display.maple.ChatBalloon;
   import maplestory.display.maple.NameTag;
   
   public class FlatListNormal extends EventDispatcher
   {
      private var currentDisplay:*;
      
      private var currentState:String;
      
      private var currentFrame:int;
      
      private var stateList:Array;
      
      private var stateListMax:int;
      
      private var stTimer:Timer;
      
      public var allItems:Array;
      
      public function FlatListNormal(param1:int)
      {
         super();
         this.stTimer = new Timer(param1);
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
      }
      
      public function start() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BitmapData = null;
         this.currentDisplay = BSCommon.canvas.selectedAssetDisplay;
         this.allItems = [];
         if(this.currentDisplay is AssetMapleMotion)
         {
            this.stateList = this.currentDisplay.states;
            this.stateListMax = this.stateList.length;
            this.currentState = this.currentDisplay.state;
            this.currentFrame = this.currentDisplay.frame;
            Alerts.setMessage("Creating images... (Step 1 of 2)",0,["Cancel:flatlistnormal_cancel"]);
            this.stTimer.addEventListener(TimerEvent.TIMER,this.stLoop);
            this.stTimer.start();
         }
         else if(this.currentDisplay is ChatBalloon || this.currentDisplay is Picture)
         {
            this.currentFrame = this.currentDisplay.frame;
            _loc1_ = this.currentDisplay.getFrameImages();
            _loc2_ = _loc1_ == null ? 0 : int(_loc1_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.allItems.push({
                  "image":_loc1_[_loc3_].image,
                  "delay":_loc1_[_loc3_].delay,
                  "x":0,
                  "y":0,
                  "name":_loc3_ + ".png"
               });
               _loc3_++;
            }
            this.currentDisplay.frame = this.currentFrame;
            this.destroy();
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else if(this.currentDisplay is NameTag)
         {
            _loc4_ = RasterMaker.raster(this.currentDisplay);
            if(_loc4_ != null)
            {
               this.allItems.push({
                  "image":_loc4_,
                  "delay":100,
                  "x":0,
                  "y":0,
                  "name":"0.png"
               });
            }
            this.destroy();
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.destroy();
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc2_:String = Alerts.clickedButtonData;
         if(_loc2_ == "flatlistnormal_cancel")
         {
            Alerts.hideMessage();
            this.destroy();
         }
      }
      
      private function stLoop(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.stTimer.stop();
         if(this.stateList.length == 0)
         {
            this.currentDisplay.state = this.currentState;
            this.currentDisplay.frame = this.currentFrame;
            this.destroy();
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < 10)
            {
               if(this.stateList.length == 0)
               {
                  break;
               }
               _loc2_ = this.stateList.shift();
               this.currentDisplay.state = _loc2_;
               _loc3_ = this.currentDisplay.getFrameImages();
               _loc4_ = _loc3_ == null ? 0 : int(_loc3_.length);
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  this.allItems.push({
                     "image":_loc3_[_loc6_].image,
                     "delay":_loc3_[_loc6_].delay,
                     "x":_loc3_[_loc6_].x,
                     "y":_loc3_[_loc6_].y,
                     "name":_loc2_ + "_" + _loc6_ + ".png"
                  });
                  _loc6_++;
               }
               _loc5_++;
            }
            this.currentDisplay.state = this.currentState;
            this.currentDisplay.frame = this.currentFrame;
            Alerts.setMessage("Creating images... (Step 1 of 2)",(this.stateListMax - this.stateList.length) / this.stateListMax,["Cancel:flatlistnormal_cancel"]);
            this.stTimer.start();
         }
      }
      
      private function destroy() : void
      {
         this.stTimer.stop();
         this.stTimer.removeEventListener(TimerEvent.TIMER,this.stLoop);
         Alerts.thisAlert.removeEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.stTimer = null;
         this.stateList = null;
         this.currentDisplay = null;
      }
   }
}

