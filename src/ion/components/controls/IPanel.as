package ion.components.controls
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import ion.components.IComponentAlign;
   import ion.components.core.IComponentInteractive;
   import ion.components.skin.ISkinAssets;
   import ion.components.skin.ISkinSplit;
   
   public class IPanel extends IComponentInteractive
   {
      private static var defSkin:ISkinAssets;
      
      private static const SKIN_UP:int = 0;
      
      private var _label:ILabel;
      
      private var _target:DisplayObject;
      
      public function IPanel(param1:int = 100, param2:int = 100)
      {
         super(param1,param2);
         this._label = new ILabel();
         this._label.exactFit = true;
         _alignX = IComponentAlign.LEFT;
         _alignY = IComponentAlign.TOP;
         if(defSkin == null)
         {
            defSkin = ISkinSplit.getNoSkinAssets();
         }
         styleDefinition(defSkin,SKIN_UP);
         addChildAt(this._label,1);
      }
      
      public static function setDefaultSkin(param1:BitmapData) : void
      {
         var _loc2_:* = undefined;
         if(defSkin != null)
         {
            defSkin.destroy();
         }
         defSkin = ISkinSplit.getSkinAssets(param1);
         for(_loc2_ in _instances)
         {
            if(_loc2_ is IPanel)
            {
               _loc2_.styleDefinition(defSkin,_loc2_.skinBack.state);
            }
         }
      }
      
      override protected function updateContent() : void
      {
         this._label.x = skinBack.center.x;
         this._label.y = -this._label.height / 2;
         skinBack.clearArea(new Rectangle(this._label.x,this._label.y,this._label.width,this._label.height));
         super.updateContent();
      }
      
      private function targetAdded(param1:Event) : void
      {
         if(this._target.parent != _holderContent || this._target.stage == null)
         {
            this._target.removeEventListener(Event.ADDED,this.targetAdded);
            this._target.removeEventListener(Event.REMOVED_FROM_STAGE,this.targetAdded);
            this._target = null;
         }
      }
      
      public function set label(param1:*) : void
      {
         this._label.label = param1;
         skinBack.resize(_width,_height,skinBack.state);
         this.updateContent();
      }
      
      public function set content(param1:DisplayObject) : void
      {
         if(this._target != null)
         {
            this._target.removeEventListener(Event.ADDED,this.targetAdded);
            this._target.removeEventListener(Event.REMOVED_FROM_STAGE,this.targetAdded);
            _holderContent.removeChild(this._target);
         }
         this._target = param1;
         if(this._target != null)
         {
            _holderContent.addChild(this._target);
            this._target.x = 0;
            this._target.y = 0;
            this._target.addEventListener(Event.ADDED,this.targetAdded,false,0,true);
            this._target.addEventListener(Event.REMOVED_FROM_STAGE,this.targetAdded,false,0,true);
         }
      }
      
      public function get content() : DisplayObject
      {
         return this._target;
      }
   }
}

