package ion.components.core
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class IComponentCore extends Sprite
   {
      protected static var _instances:Dictionary = new Dictionary(true);
      
      private const minWidth:int = 12;
      
      private const minHeight:int = 12;
      
      private const waitBeforeDestroy:int = 100;
      
      private var countBeforeDestroy:int = 0;
      
      protected var _enabled:Boolean = true;
      
      protected var _width:int = 12;
      
      protected var _height:int = 12;
      
      public function IComponentCore(param1:int = 0, param2:int = 0)
      {
         super();
         _instances[this] = [];
         this._width = Math.max(this.minWidth,param1);
         this._height = Math.max(this.minHeight,param2);
         this.focusRect = false;
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.wasRemovedFromStage);
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         this.updateEvents();
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.loopBeforeDestroy);
      }
      
      private function wasRemovedFromStage(param1:Event) : void
      {
         this.countBeforeDestroy = 0;
         this.addEventListener(Event.ENTER_FRAME,this.loopBeforeDestroy);
      }
      
      private function loopBeforeDestroy(param1:Event) : void
      {
         if(this.countBeforeDestroy++ > this.waitBeforeDestroy)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.loopBeforeDestroy);
            this.destroy();
         }
      }
      
      private function updateEvents() : void
      {
         var _loc1_:Array = _instances[this];
         var _loc2_:int = int(_loc1_.length);
         if(this._enabled)
         {
            while(--_loc2_ >= 0)
            {
               super.addEventListener(_loc1_[_loc2_].t,_loc1_[_loc2_].f,_loc1_[_loc2_].c,_loc1_[_loc2_].p,_loc1_[_loc2_].w);
            }
         }
         else
         {
            while(--_loc2_ >= 0)
            {
               super.removeEventListener(_loc1_[_loc2_].t,_loc1_[_loc2_].f);
            }
         }
      }
      
      protected function destroy() : void
      {
         this._enabled = false;
         this.updateEvents();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         _instances[this] = null;
         delete _instances[this];
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         var _loc6_:Array = _instances[this];
         var _loc7_:int = int(_loc6_.length);
         var _loc8_:Boolean = false;
         while(--_loc7_ >= 0)
         {
            if(_loc6_[_loc7_].t == param1 && _loc6_[_loc7_].f == param2)
            {
               _loc8_ = true;
               break;
            }
         }
         if(!_loc8_)
         {
            _loc6_.push({
               "t":param1,
               "f":param2,
               "c":false,
               "p":0,
               "w":true
            });
         }
         this.updateEvents();
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         var _loc4_:Array = _instances[this];
         var _loc5_:int = int(_loc4_.length);
         while(--_loc5_ >= 0)
         {
            if(_loc4_[_loc5_].t == param1 && _loc4_[_loc5_].f == param2)
            {
               super.removeEventListener(param1,param2);
               _loc4_.splice(_loc5_,1);
               break;
            }
         }
      }
      
      public function set focus(param1:Boolean) : void
      {
         if(stage == null)
         {
            return;
         }
         if(param1)
         {
            stage.focus = this;
         }
         else
         {
            stage.focus = null;
         }
      }
      
      public function get focus() : Boolean
      {
         if(stage == null)
         {
            return false;
         }
         return stage.focus == this;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = Math.floor(param1);
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = Math.floor(param1);
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = Math.max(param1,this.minWidth);
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = Math.max(param1,this.minHeight);
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
   }
}

