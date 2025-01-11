package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.gui.BaseSprite;
   import bs.utils.KeyboardHandler;
   import caurina.transitions.Tweener;
   import fl.controls.Button;
   import fl.controls.Label;
   import fl.controls.ProgressBar;
   import fl.controls.ProgressBarMode;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public class Alerts extends BaseSprite
   {
      private static var bg:Shape;
      
      private static var holder:Sprite;
      
      private static var buttonHolder:Sprite;
      
      private static var bar:ProgressBar;
      
      private static var message:Label;
      
      private static var firstTime:Boolean;
      
      private static var _clickedButtonLabel:String;
      
      private static var _clickedButtonData:String;
      
      public static var thisAlert:Sprite;
      
      private static const blockW:int = 350;
      
      private static const blockH:int = 80;
      
      private static var oldMessage:String = null;
      
      private static var objPercent:Object = {"p":0};
      
      public function Alerts()
      {
         super();
         bg = new Shape();
         holder = new Sprite();
         buttonHolder = new Sprite();
         bar = new ProgressBar();
         message = new Label();
         thisAlert = this;
         bg.graphics.beginFill(0,0.2);
         bg.graphics.drawRect(0,0,200,200);
         bg.graphics.endFill();
         var _loc1_:Matrix = new Matrix();
         _loc1_.createGradientBox(blockW,blockH,Math.PI / 2);
         holder.graphics.lineStyle(2,0,1,true);
         holder.graphics.lineGradientStyle(GradientType.LINEAR,[4022168,3031122],[1,1],[0,255],_loc1_);
         holder.graphics.beginGradientFill(GradientType.LINEAR,[15792383,14807039],[1,1],[0,255],_loc1_);
         holder.graphics.drawRoundRect(0,0,blockW,blockH,14,14);
         holder.graphics.endFill();
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(0,34816,1,true);
         _loc2_.graphics.beginGradientFill(GradientType.LINEAR,[39168,14155461,39168],[1,1,1],[0,40,220],_loc1_);
         _loc2_.graphics.drawRect(0,0,50,50);
         _loc2_.graphics.endFill();
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(0,8421504);
         _loc3_.graphics.beginFill(12632256);
         _loc3_.graphics.drawRect(0,0,50,50);
         _loc3_.graphics.endFill();
         bar.minimum = 0;
         bar.maximum = 1;
         bar.indeterminate = false;
         bar.mode = ProgressBarMode.MANUAL;
         bar.width = Math.floor(blockW * 0.9);
         bar.setStyle("barSkin",_loc2_);
         bar.setStyle("trackSkin",_loc3_);
         message.setSize(bar.width,45);
         message.wordWrap = true;
         holder.filters = [new GlowFilter(0,0.6,12,12,1,2),new GlowFilter(3035493,0.5,10,10,1,2,true)];
         bg.visible = false;
         holder.visible = false;
         firstTime = true;
         holder.addChild(message);
         holder.addChild(bar);
         holder.addChild(buttonHolder);
         this.addChild(bg);
         this.addChild(holder);
      }
      
      public static function setMessage(param1:String, param2:Number = -1, param3:Array = null) : void
      {
         var _loc4_:Button = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         KeyboardHandler.canContinue = false;
         if(firstTime)
         {
            bg.alpha = 0;
            holder.alpha = 0;
            bg.visible = true;
            holder.visible = true;
            Tweener.addTween(bg,{
               "alpha":1,
               "time":1
            });
            Tweener.addTween(holder,{
               "alpha":1,
               "time":1
            });
            firstTime = false;
         }
         if(param3 == null || param1 != oldMessage)
         {
            _clickedButtonData = "";
            _clickedButtonLabel = "";
            while(buttonHolder.numChildren > 0)
            {
               _loc4_ = buttonHolder.removeChildAt(0) as Button;
               _loc4_.removeEventListener(MouseEvent.CLICK,buttonClick);
            }
         }
         if(param3 != null && buttonHolder.numChildren == 0)
         {
            _loc6_ = int(param3.length);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc4_ = new Button();
               _loc5_ = param3[_loc7_].split(":");
               _loc4_.label = _loc5_[0];
               _loc4_.name = _loc5_.length > 1 ? _loc5_[1] : "0";
               _loc4_.setSize(50,20);
               _loc4_.x = bar.width - (_loc7_ + 1) * 52;
               _loc4_.addEventListener(MouseEvent.CLICK,buttonClick);
               buttonHolder.addChild(_loc4_);
               _loc7_++;
            }
         }
         bar.visible = param2 >= 0;
         if(bar.visible)
         {
            if(param2 < objPercent.p)
            {
               objPercent.p = 0;
            }
            Tweener.addTween(objPercent,{
               "p":param2,
               "time":0.5,
               "onUpdate":changePercentBar
            });
         }
         oldMessage = param1;
         message.htmlText = param1;
         arrangeComponents();
      }
      
      public static function hideMessage(param1:int = 0) : void
      {
         Tweener.addTween(bg,{
            "alpha":0,
            "time":0.8,
            "delay":param1,
            "onComplete":hideMessageDone
         });
         Tweener.addTween(holder,{
            "alpha":0,
            "time":0.8,
            "delay":param1
         });
      }
      
      public static function get clickedButtonLabel() : String
      {
         return _clickedButtonLabel;
      }
      
      public static function get clickedButtonData() : String
      {
         return _clickedButtonData;
      }
      
      private static function buttonClick(param1:MouseEvent) : void
      {
         _clickedButtonLabel = param1.currentTarget.label;
         _clickedButtonData = param1.currentTarget.name;
         thisAlert.dispatchEvent(new Event(InterfaceEvent.ALERT_CLICK));
      }
      
      private static function changePercentBar() : void
      {
         bar.setProgress(objPercent.p,1);
      }
      
      private static function arrangeComponents() : void
      {
         bar.x = Math.floor((blockW - bar.width) / 2);
         message.y = 10;
         message.x = bar.x;
         bar.y = message.y + 30;
         buttonHolder.x = bar.x;
         buttonHolder.y = blockH - 30;
      }
      
      private static function hideMessageDone() : void
      {
         var _loc1_:Button = null;
         KeyboardHandler.canContinue = true;
         bg.visible = false;
         holder.visible = false;
         firstTime = true;
         _clickedButtonData = "";
         _clickedButtonLabel = "";
         oldMessage = null;
         while(buttonHolder.numChildren > 0)
         {
            _loc1_ = buttonHolder.removeChildAt(0) as Button;
            _loc1_.removeEventListener(MouseEvent.CLICK,buttonClick);
         }
         Tweener.removeTweens(bg);
         Tweener.removeTweens(holder);
      }
      
      override public function onStageResize() : void
      {
         bg.width = _stageWidth;
         bg.height = _stageHeight;
         holder.x = Math.floor((_stageWidth - blockW) / 2);
         holder.y = Math.floor((_stageHeight - blockH) / 2);
      }
   }
}

