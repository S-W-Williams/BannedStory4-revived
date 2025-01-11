package ion.components.controls
{
   import caurina.transitions.Tweener;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import ion.components.core.IComponentCore;
   
   public class IToolTip extends IComponentCore
   {
      private static var _label:ILabel;
      
      private static var _bg:Shape;
      
      private static var holder:Sprite;
      
      private static var currentMessage:String;
      
      private static var waitBeforeShow:int = 80;
      
      private static var waitBeforeHide:int = 500;
      
      private static var countBeforeShow:int = 0;
      
      private static var countBeforeHide:int = 0;
      
      private static var isClickDown:Boolean = false;
      
      private static var _bgColor:int = 0;
      
      private static var _targets:Dictionary = new Dictionary(true);
      
      public function IToolTip()
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         holder = new Sprite();
         _label = new ILabel();
         _bg = new Shape();
         _label.exactFit = true;
         holder.visible = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         holder.addChild(_bg);
         holder.addChild(_label);
         this.addChild(holder);
      }
      
      public static function setTarget(param1:DisplayObject, param2:*) : void
      {
         if(param1 == null || holder == null)
         {
            return;
         }
         _targets[param1] = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,targetOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,targetOut);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,targetOut);
      }
      
      public static function removeTarget(param1:DisplayObject) : void
      {
         if(param1 == null || _targets[param1] == undefined)
         {
            return;
         }
         param1.removeEventListener(MouseEvent.MOUSE_OVER,targetOver);
         param1.removeEventListener(MouseEvent.MOUSE_OUT,targetOut);
         param1.removeEventListener(MouseEvent.MOUSE_DOWN,targetOut);
         delete _targets[param1];
         targetOut();
      }
      
      private static function targetOut(param1:MouseEvent = null) : void
      {
         Tweener.addTween(holder,{
            "y":holder.y - 20,
            "alpha":0,
            "time":0.2,
            "onComplete":hideContent,
            "transition":"easeInCubic"
         });
         if(param1 != null && param1.type == MouseEvent.MOUSE_DOWN)
         {
            isClickDown = true;
         }
         holder.removeEventListener(Event.ENTER_FRAME,loopBeforeShow);
      }
      
      private static function targetOver(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = true;
         try
         {
            _loc2_ = Boolean(param1.currentTarget.enabled);
         }
         catch(err:*)
         {
         }
         if(holder.stage == null || holder == null)
         {
            return;
         }
         if(isClickDown)
         {
            return;
         }
         if(!_loc2_)
         {
            return;
         }
         countBeforeShow = 0;
         currentMessage = _targets[param1.currentTarget];
         holder.addEventListener(Event.ENTER_FRAME,loopBeforeShow);
      }
      
      private static function loopBeforeShow(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(countBeforeShow++ > waitBeforeShow)
         {
            holder.removeEventListener(Event.ENTER_FRAME,loopBeforeShow);
            _label.label = currentMessage;
            _bg.graphics.clear();
            _bg.graphics.beginFill(_bgColor);
            _bg.graphics.drawRoundRect(0,0,_label.width + 4,_label.height + 4,6);
            _bg.graphics.endFill();
            _label.x = (_bg.width - _label.width) / 2;
            _label.y = (_bg.height - _label.height) / 2;
            holder.x = holder.stage.mouseX - 40;
            holder.y = holder.stage.mouseY - 20;
            _loc2_ = holder.stage.mouseX + 10;
            _loc3_ = holder.y;
            if(_loc2_ + _bg.width > holder.stage.stageWidth)
            {
               _loc2_ = holder.stage.stageWidth - _bg.width;
            }
            else if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            if(_loc3_ + _bg.height > holder.stage.stageHeight)
            {
               _loc3_ = holder.stage.stageHeight - _bg.height;
            }
            else if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            holder.alpha = 0;
            Tweener.addTween(holder,{
               "x":_loc2_,
               "y":_loc3_,
               "alpha":1,
               "time":0.2,
               "transition":"easeOutCubic"
            });
            holder.visible = true;
            countBeforeHide = 0;
            holder.addEventListener(Event.ENTER_FRAME,loopBeforeHide);
         }
      }
      
      private static function loopBeforeHide(param1:Event) : void
      {
         if(countBeforeHide++ > waitBeforeHide)
         {
            holder.removeEventListener(Event.ENTER_FRAME,loopBeforeHide);
            targetOut();
         }
      }
      
      private static function hideContent() : void
      {
         holder.visible = false;
         holder.alpha = 1;
      }
      
      public static function set delay(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         waitBeforeShow = param1;
      }
      
      public static function setDefaultStyle(param1:String, param2:int, param3:int, param4:int) : void
      {
         _label.font = param1;
         _label.color = param3;
         _label.size = param2;
         _bgColor = param4;
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.releaseMouse);
         stage.addEventListener(Event.MOUSE_LEAVE,this.releaseMouse);
      }
      
      private function releaseMouse(param1:*) : void
      {
         isClickDown = false;
      }
   }
}

