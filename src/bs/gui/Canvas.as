package bs.gui
{
   import bs.events.InterfaceEvent;
   import bs.gui.item.SimpleScroll;
   import bs.utils.KeyboardHandler;
   import caurina.transitions.Tweener;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import ion.utils.RasterMaker;
   import maplestory.display.core.Asset;
   import maplestory.display.maple.AssetMapleMotion;
   import maplestory.display.maple.Char;
   import maplestory.display.maple.ChatBalloon;
   import maplestory.display.maple.NameTag;
   import maplestory.display.maple.Pet;
   import maplestory.events.AssetEvent;
   import maplestory.struct.Types;
   import transtool.tool.TransformTool;
   import transtool.utils.TransToolFlipH;
   import transtool.utils.TransToolFlipV;
   import transtool.utils.TransToolReset;
   
   public class Canvas extends BaseSprite
   {
      public static var NO_ASSET:int = -999;
      
      private var _selectedAsset:*;
      
      private var _selectedAssetOld:*;
      
      private var _canvasColor:int = 16777215;
      
      private var assetHolder:Sprite;
      
      private var bg:Sprite;
      
      private var scrollH:SimpleScroll;
      
      private var scrollV:SimpleScroll;
      
      private var scrollWasClicked:Boolean = false;
      
      private var _propertiesVisible:Boolean = true;
      
      private var tool:TransformTool;
      
      private var _useTransformTool:Boolean = true;
      
      private var itemCollection:Dictionary;
      
      private var itemCounter:int = 0;
      
      public var progress:Number = 0;
      
      public function Canvas()
      {
         super();
         this.itemCollection = new Dictionary(true);
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Shape = new Shape();
         this.bg = new Sprite();
         this.assetHolder = new Sprite();
         this.tool = new TransformTool();
         this.scrollH = new SimpleScroll();
         this.scrollV = new SimpleScroll();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,1,1);
         _loc2_.graphics.endFill();
         this.bg.graphics.beginFill(16777215);
         this.bg.graphics.drawRect(0,0,50,50);
         this.bg.graphics.endFill();
         this.scrollV.useVertical = true;
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.addEventListener(MouseEvent.MOUSE_UP,this.assetMouse);
         this.addEventListener(MouseEvent.MOUSE_WHEEL,this.assetMouse);
         this.assetHolder.addEventListener(MouseEvent.MOUSE_DOWN,this.assetMouse);
         this.bg.addEventListener(MouseEvent.MOUSE_DOWN,this.assetMouse);
         this.tool.addEventListener(MouseEvent.MOUSE_OVER,this.assetRoll);
         this.tool.addEventListener(MouseEvent.MOUSE_OUT,this.assetRoll);
         this.tool.addEventListener(MouseEvent.MOUSE_MOVE,this.assetRoll);
         this.scrollH.addEventListener(MouseEvent.MOUSE_DOWN,this.scrollClick);
         this.scrollV.addEventListener(MouseEvent.MOUSE_DOWN,this.scrollClick);
         this.buildToolOptions();
         this.assetHolder.addChild(_loc2_);
         _loc1_.addChild(this.assetHolder);
         _loc1_.addChild(this.tool);
         this.addChild(this.bg);
         this.addChild(_loc1_);
         this.addChild(this.scrollH);
         this.addChild(this.scrollV);
      }
      
      public function addAsset(param1:int, param2:* = null, param3:Boolean = true) : int
      {
         var _loc4_:* = undefined;
         ++this.itemCounter;
         if(param2 is DisplayObject)
         {
            _loc4_ = param2;
         }
         else
         {
            switch(param1)
            {
               case Types.ASSET_CHARACTER:
                  _loc4_ = new Char();
                  break;
               case Types.ASSET_CHAT_BALLOON:
                  _loc4_ = new ChatBalloon();
                  break;
               case Types.ASSET_NAME_TAG:
                  _loc4_ = new NameTag();
                  break;
               case Types.ASSET_PET:
                  _loc4_ = new Pet();
                  break;
               case Types.ASSET_NONE_MOTION:
               case Types.ASSET_EFFECT:
               case Types.ASSET_ETC:
               case Types.ASSET_ITEM:
               case Types.ASSET_MAP:
               case Types.ASSET_MOB:
               case Types.ASSET_MORPH:
               case Types.ASSET_NPC:
               case Types.ASSET_SKILL:
                  _loc4_ = new AssetMapleMotion();
                  break;
               case Types.ASSET_PICTURE:
                  break;
               default:
                  return NO_ASSET;
            }
         }
         if(param3)
         {
            if(param1 == Types.ASSET_CHAT_BALLOON || param1 == Types.ASSET_NAME_TAG)
            {
               _loc4_.x = 500;
               _loc4_.y = 380;
            }
            else
            {
               _loc4_.x = 560;
               _loc4_.y = 430;
            }
         }
         _loc4_.addEventListener(AssetEvent.ASSET_ITEM_LOADED,this.assetItemLoaded);
         _loc4_.addEventListener(ErrorEvent.ERROR,this.assetItemError);
         _loc4_.addEventListener(ProgressEvent.PROGRESS,this.assetItemProgress);
         this.itemCollection[_loc4_] = {
            "assetID":this.itemCounter,
            "assetType":param1
         };
         this.assetHolder.addChild(_loc4_);
         this.tool.target = null;
         this.tool.target = _loc4_;
         this._selectedAsset = _loc4_;
         this.updateScrolls();
         return this.itemCounter;
      }
      
      public function removeAsset(param1:int) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.itemCollection)
         {
            if(this.itemCollection[_loc2_].assetID == param1)
            {
               _loc2_.removeEventListener(ProgressEvent.PROGRESS,this.assetItemProgress);
               _loc2_.removeEventListener(Event.COMPLETE,this.assetItemLoaded);
               _loc2_.removeEventListener(ErrorEvent.ERROR,this.assetItemError);
               this.assetHolder.removeChild(_loc2_);
               delete this.itemCollection[_loc2_];
               if(this._selectedAsset == _loc2_)
               {
                  this._selectedAsset = null;
                  this.tool.target = null;
               }
               break;
            }
         }
         this.updateScrolls();
      }
      
      public function removeAssetItem(param1:int, param2:String) : void
      {
         var _loc3_:* = undefined;
         for(_loc3_ in this.itemCollection)
         {
            if(this.itemCollection[_loc3_].assetID == param1)
            {
               _loc3_.remove(param2);
               break;
            }
         }
         this.updateScrolls();
      }
      
      public function getAsset(param1:int) : *
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.itemCollection)
         {
            if(this.itemCollection[_loc2_].assetID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAssetID(param1:*) : int
      {
         if(this.itemCollection[param1] == undefined)
         {
            return NO_ASSET;
         }
         return this.itemCollection[param1].assetID;
      }
      
      public function getAssetType(param1:int) : int
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.itemCollection)
         {
            if(this.itemCollection[_loc2_].assetID == param1)
            {
               return this.itemCollection[_loc2_].assetType;
            }
         }
         return Types.ASSET_NONE;
      }
      
      public function sortAssets(param1:Array) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = int(param1.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.getAsset(param1[_loc3_]);
            if(_loc2_ != null)
            {
               this.assetHolder.addChildAt(_loc2_,0);
            }
            _loc3_--;
         }
      }
      
      public function removeAll() : void
      {
         var _loc1_:* = undefined;
         this._selectedAsset = null;
         this._selectedAssetOld = null;
         this.tool.target = null;
         this.itemCounter = 0;
         for(_loc1_ in this.itemCollection)
         {
            _loc1_.removeEventListener(ProgressEvent.PROGRESS,this.assetItemProgress);
            _loc1_.removeEventListener(Event.COMPLETE,this.assetItemLoaded);
            _loc1_.removeEventListener(ErrorEvent.ERROR,this.assetItemError);
            this.assetHolder.removeChild(_loc1_);
            delete this.itemCollection[_loc1_];
         }
         this.updateScrolls();
      }
      
      public function transformToolChange(param1:String) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Matrix = null;
         var _loc4_:Point = null;
         var _loc5_:Rectangle = null;
         this.tool.target = null;
         this.tool.target = this._selectedAsset;
         if(param1 == InterfaceEvent.TRANSFORMTOOL_RESET)
         {
            _loc2_ = this.tool.registration;
            this.tool.globalMatrix = new Matrix();
            _loc4_ = _loc2_.subtract(this.tool.registration);
            _loc3_ = this.tool.toolMatrix;
            _loc3_.tx += _loc4_.x;
            _loc3_.ty += _loc4_.y;
            this.tool.toolMatrix = _loc3_;
            this.tool.apply();
         }
         else if(param1 == InterfaceEvent.TRANSFORMTOOL_FLIP_H)
         {
            _loc2_ = this.tool.registration;
            _loc3_ = this.tool.toolMatrix;
            _loc3_.a *= -1;
            _loc3_.tx = 2 * _loc2_.x - _loc3_.tx;
            this.tool.toolMatrix = _loc3_;
            this.tool.apply();
         }
         else if(param1 == InterfaceEvent.TRANSFORMTOOL_FLIP_V)
         {
            _loc2_ = this.tool.registration;
            _loc3_ = this.tool.toolMatrix;
            _loc3_.d *= -1;
            _loc3_.ty = 2 * _loc2_.y - _loc3_.ty;
            this.tool.toolMatrix = _loc3_;
            this.tool.apply();
         }
         else if(param1 == InterfaceEvent.TRANSFORMTOOL_MOVE_CENTER && this._selectedAsset != null)
         {
            _loc5_ = this._selectedAsset.getBounds(this._selectedAsset.parent);
            this._selectedAsset.x = (stage.stageWidth - _loc5_.width) / 2 + this._selectedAsset.x - _loc5_.x;
            this._selectedAsset.y = (stage.stageHeight - this.y - 100 - _loc5_.height) / 2 + this._selectedAsset.y - _loc5_.y;
            if(this._useTransformTool)
            {
               this.tool.target = null;
               this.tool.target = this._selectedAsset;
            }
         }
         if(!this._useTransformTool)
         {
            this.tool.target = null;
         }
         if(this._selectedAsset != null)
         {
            this.dispatchEvent(new Event(InterfaceEvent.CANVAS_CLICK));
         }
      }
      
      public function translateAsset(param1:Object = null, param2:Object = null) : void
      {
         if(this._selectedAsset == null)
         {
            return;
         }
         if(param1 != null && param1 is Number)
         {
            this._selectedAsset.x += param1;
         }
         if(param2 != null && param2 is Number)
         {
            this._selectedAsset.y += param2;
         }
         if(this._useTransformTool)
         {
            this.tool.target = null;
            this.tool.target = this._selectedAsset;
         }
         this.updateScrolls();
      }
      
      public function fixScrolls(param1:Boolean) : void
      {
         this._propertiesVisible = param1;
         this.onStageResize();
      }
      
      public function setZoom(param1:Number) : void
      {
         this.assetHolder.scaleX = param1;
         this.assetHolder.scaleY = param1;
      }
      
      public function getImageCanvas(param1:int = -1) : BitmapData
      {
         if(stage == null)
         {
            return null;
         }
         if(this.length <= 0)
         {
            return null;
         }
         var _loc2_:* = param1 <= -1;
         var _loc3_:int = _loc2_ ? 0 : param1;
         var _loc4_:Number = this.assetHolder.scaleX;
         this.assetHolder.scaleX = 1;
         this.assetHolder.scaleY = 1;
         var _loc5_:BitmapData = RasterMaker.raster(this.assetHolder,_loc2_,_loc3_);
         this.assetHolder.scaleX = _loc4_;
         this.assetHolder.scaleY = _loc4_;
         return _loc5_;
      }
      
      private function assetItemError(param1:ErrorEvent) : void
      {
         this.dispatchEvent(new Event(AssetEvent.ASSET_ITEM_ERROR));
      }
      
      private function assetItemProgress(param1:ProgressEvent) : void
      {
         this.progress = param1.currentTarget.progress;
         this.dispatchEvent(new Event(AssetEvent.ASSET_ITEM_PROGRESS));
      }
      
      private function assetItemLoaded(param1:Event) : void
      {
         this.updateScrolls();
         if(this._selectedAsset == param1.currentTarget)
         {
            this.dispatchEvent(new Event(InterfaceEvent.CANVAS_CLICK));
         }
      }
      
      private function assetMouse(param1:MouseEvent) : void
      {
         var _loc2_:SimpleScroll = null;
         var _loc3_:Number = NaN;
         if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            this.tool.target = null;
            if(param1.target is Asset)
            {
               this._selectedAsset = param1.target;
               if(!this._useTransformTool)
               {
                  this._selectedAsset.startDrag();
               }
            }
            else
            {
               this._selectedAsset = null;
            }
         }
         else if(param1.type == MouseEvent.MOUSE_WHEEL)
         {
            _loc2_ = this.scrollV.visible ? this.scrollV : this.scrollH;
            _loc3_ = _loc2_.percent;
            _loc3_ += param1.delta < 0 ? 0.1 : -0.1;
            _loc3_ = Math.max(0,_loc3_);
            _loc3_ = Math.min(1,_loc3_);
            _loc2_.percent = _loc3_;
         }
         else
         {
            if(this._selectedAsset != null)
            {
               if(this._useTransformTool)
               {
                  this.tool.target = this._selectedAsset;
               }
            }
            if(this._selectedAsset != null)
            {
               this._selectedAsset.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
            }
            this.dispatchEvent(new Event(InterfaceEvent.CANVAS_CLICK));
         }
         stage.focus = null;
         KeyboardHandler.canContinue = true;
      }
      
      private function scrollClick(param1:MouseEvent) : void
      {
         this.scrollWasClicked = true;
      }
      
      private function loopScroll(param1:MouseEvent) : void
      {
         if(this.scrollWasClicked)
         {
            return;
         }
         this.updateScrolls();
      }
      
      private function updateScrolls() : void
      {
         this.scrollH.updateBar(this.assetHolder);
         this.scrollV.updateBar(this.assetHolder);
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.stageMouseUp);
         stage.addEventListener(Event.MOUSE_LEAVE,this.stageMouseUp);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.loopScroll);
      }
      
      private function stageMouseUp(param1:*) : void
      {
         this.scrollWasClicked = false;
         stopDrag();
      }
      
      override public function onStageResize() : void
      {
         this.bg.x = -this.x;
         this.bg.y = -this.y;
         this.bg.width = _stageWidth;
         this.bg.height = _stageHeight;
         this.scrollH.x = 0;
         this.scrollH.setSize(_stageWidth - 10,10);
         this.scrollV.x = _stageWidth - 10;
         this.scrollV.y = 0;
         if(this._propertiesVisible)
         {
            this.scrollH.y = _stageHeight - 155;
            this.scrollV.setSize(10,_stageHeight - 155);
         }
         else
         {
            this.scrollH.y = _stageHeight - 33;
            this.scrollV.setSize(10,_stageHeight - 33);
         }
         this.updateScrolls();
      }
      
      private function assetRoll(param1:MouseEvent) : void
      {
         if(!this._useTransformTool)
         {
            this.tool.target = null;
            return;
         }
         if(param1.type == MouseEvent.MOUSE_OVER || param1.type == MouseEvent.MOUSE_MOVE)
         {
            Tweener.removeTweens(this.tool);
            if(this.tool.alpha == 0)
            {
               this.tool.target = null;
               this.tool.target = this._selectedAsset;
            }
            Tweener.addTween(this.tool,{
               "alpha":1,
               "time":0.3
            });
         }
         else if(param1.type == MouseEvent.MOUSE_OUT)
         {
            Tweener.addTween(this.tool,{
               "alpha":0,
               "delay":1,
               "time":0.3
            });
         }
      }
      
      private function buildToolOptions() : void
      {
         this.tool.raiseNewTargets = false;
         this.tool.moveNewTargets = true;
         this.tool.moveUnderObjects = true;
         this.tool.registrationEnabled = true;
         this.tool.rememberRegistration = true;
         this.tool.rotationEnabled = true;
         this.tool.constrainScale = true;
         this.tool.maxScaleX = 10;
         this.tool.maxScaleY = 10;
         this.tool.alpha = 0;
         this.tool.skewEnabled = true;
         this.tool.addControl(new TransToolReset());
         this.tool.addControl(new TransToolFlipV());
         this.tool.addControl(new TransToolFlipH());
      }
      
      public function get length() : int
      {
         return this.assetHolder.numChildren - 1;
      }
      
      public function set canvasColor(param1:int) : void
      {
         this._canvasColor = param1;
         var _loc2_:int = this.bg.width;
         var _loc3_:int = this.bg.height;
         this.bg.graphics.clear();
         this.bg.graphics.beginFill(param1);
         this.bg.graphics.drawRect(0,0,50,50);
         this.bg.graphics.endFill();
         this.bg.width = _loc2_;
         this.bg.height = _loc3_;
      }
      
      public function get canvasColor() : int
      {
         return this._canvasColor;
      }
      
      public function get selectedAsset() : int
      {
         var _loc1_:* = undefined;
         if(this._selectedAsset != null)
         {
            for(_loc1_ in this.itemCollection)
            {
               if(_loc1_ == this._selectedAsset)
               {
                  return this.itemCollection[_loc1_].assetID;
               }
            }
         }
         return NO_ASSET;
      }
      
      public function set selectedAsset(param1:int) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.itemCollection)
         {
            if(this.itemCollection[_loc2_].assetID == param1)
            {
               this._selectedAsset = _loc2_;
               if(this._useTransformTool)
               {
                  this.tool.target = this._selectedAsset;
               }
               break;
            }
         }
      }
      
      public function get selectedAssetDisplay() : *
      {
         return this._selectedAsset;
      }
      
      public function get assetCollection() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = [];
         for(_loc2_ in this.itemCollection)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function set useTransformTool(param1:Boolean) : void
      {
         this._useTransformTool = param1;
         if(!param1)
         {
            this.tool.target = null;
         }
      }
      
      public function get useTransformTool() : Boolean
      {
         return this._useTransformTool;
      }
   }
}

