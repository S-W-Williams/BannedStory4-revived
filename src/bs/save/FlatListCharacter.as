package bs.save
{
   import bs.events.InterfaceEvent;
   import bs.gui.win.Alerts;
   import bs.manager.BSCommon;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import maplestory.display.maple.Char;
   
   public class FlatListCharacter extends EventDispatcher
   {
      private var currentDisplay:*;
      
      private var currentState:String;
      
      private var currentFrame:int;
      
      private var currentStateFace:String;
      
      private var currentFrameFace:int;
      
      private var stateList:Array;
      
      private var stateListMax:int;
      
      private var stTimer:Timer;
      
      public var allItems:Array;
      
      public function FlatListCharacter(param1:int)
      {
         super();
         this.stTimer = new Timer(param1);
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
      }
      
      public function start() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this.currentDisplay = BSCommon.canvas.selectedAssetDisplay;
         this.allItems = [];
         this.stateList = [];
         if(this.currentDisplay is Char)
         {
            this.currentState = this.currentDisplay.state;
            this.currentFrame = this.currentDisplay.frame;
            this.currentStateFace = this.currentDisplay.stateFace;
            this.currentFrameFace = this.currentDisplay.frameFace;
            _loc1_ = this.currentDisplay.statesFace;
            _loc2_ = this.currentDisplay.states;
            _loc3_ = _loc1_ == null ? 0 : int(_loc1_.length);
            _loc4_ = _loc2_ == null ? 0 : int(_loc2_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               this.currentDisplay.stateFace = _loc1_[_loc6_];
               _loc5_ = int(this.currentDisplay.maxFramesFace);
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc8_ = 0;
                  while(_loc8_ < _loc5_)
                  {
                     this.stateList.push({
                        "face":_loc1_[_loc6_],
                        "faceFrame":_loc8_,
                        "state":_loc2_[_loc7_]
                     });
                     _loc8_++;
                  }
                  _loc7_++;
               }
               _loc6_++;
            }
            this.stateListMax = this.stateList.length;
            Alerts.setMessage("Creating images... (Step 1 of 2)",0,["Cancel:flatlistcharacter_cancel"]);
            this.stTimer.addEventListener(TimerEvent.TIMER,this.stLoop);
            this.stTimer.start();
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
         if(_loc2_ == "flatlistcharacter_cancel")
         {
            Alerts.hideMessage();
            this.destroy();
         }
      }
      
      private function stLoop(param1:TimerEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.stTimer.stop();
         if(this.stateList.length == 0)
         {
            this.currentDisplay.state = this.currentState;
            this.currentDisplay.frame = this.currentFrame;
            this.currentDisplay.stateFace = this.currentStateFace;
            this.currentDisplay.frameFace = this.currentFrameFace;
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
               this.currentDisplay.state = _loc2_.state;
               this.currentDisplay.stateFace = _loc2_.face;
               this.currentDisplay.frameFace = _loc2_.faceFrame;
               _loc3_ = this.currentDisplay.getFrameImages();
               _loc4_ = _loc3_ == null ? 0 : int(_loc3_.length);
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  this.allItems.push({
                     "image":_loc3_[_loc6_].image,
                     "name":_loc2_.face + "/frame " + _loc2_.faceFrame + "/" + _loc2_.state + "_" + _loc6_ + ".png"
                  });
                  _loc6_++;
               }
               _loc5_++;
            }
            this.currentDisplay.state = this.currentState;
            this.currentDisplay.frame = this.currentFrame;
            this.currentDisplay.stateFace = this.currentStateFace;
            this.currentDisplay.frameFace = this.currentFrameFace;
            Alerts.setMessage("Creating images... (Step 1 of 2)",(this.stateListMax - this.stateList.length) / this.stateListMax,["Cancel:flatlistcharacter_cancel"]);
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

