package bs.gui
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BaseSprite extends Sprite
   {
      private static var items:Array = [];
      
      protected static var _stageWidth:int = 0;
      
      protected static var _stageHeight:int = 0;
      
      public function BaseSprite()
      {
         super();
         items.push(this);
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
      }
      
      public static function updateResize(param1:int, param2:int) : void
      {
         _stageWidth = param1;
         _stageHeight = param2;
         var _loc3_:int = 0;
         while(_loc3_ < items.length)
         {
            items[_loc3_].onStageResize();
            _loc3_++;
         }
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.onStageResize();
      }
      
      public function onStageResize() : void
      {
      }
   }
}

