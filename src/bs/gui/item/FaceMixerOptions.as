package bs.gui.item
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import bs.gui.win.Alerts;
   import bs.utils.BSPaths;
   import bs.utils.StateNames;
   import fl.controls.ComboBox;
   import fl.controls.Label;
   import fl.controls.NumericStepper;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import ion.components.controls.IToolTip;
   import ion.geom.Cropper;
   import ion.utils.RasterMaker;
   import maplestory.display.maple.Char;
   import maplestory.events.AssetEvent;
   
   public class FaceMixerOptions extends Sprite
   {
      private const scaleFactor:int = 3;
      
      private var faceUrl:String;
      
      private var char:Char;
      
      private var coState:ComboBox;
      
      private var stFrame:NumericStepper;
      
      private var stCoordX:NumericStepper;
      
      private var stCoordY:NumericStepper;
      
      private var crop:Cropper;
      
      private var preview:Bitmap;
      
      private var refNode:XML;
      
      private var croppedBitmap:Bitmap;
      
      public var croppedImage:Sprite;
      
      public function FaceMixerOptions()
      {
         var _loc2_:Label = null;
         var _loc3_:Label = null;
         super();
         var _loc1_:Label = new Label();
         _loc2_ = new Label();
         _loc3_ = new Label();
         var _loc4_:Label = new Label();
         this.char = new Char();
         this.coState = new ComboBox();
         this.stFrame = new NumericStepper();
         this.stCoordX = new NumericStepper();
         this.stCoordY = new NumericStepper();
         this.crop = new Cropper(150,165);
         this.preview = new Bitmap();
         this.croppedBitmap = new Bitmap();
         this.croppedImage = new Sprite();
         _loc1_.text = "Face State";
         _loc2_.text = "Face Frame";
         _loc3_.text = "X";
         _loc4_.text = "Y";
         this.coState.setSize(150,22);
         _loc3_.setSize(40,20);
         _loc4_.setSize(40,20);
         this.stCoordX.setSize(60,20);
         this.stCoordY.setSize(60,20);
         IToolTip.setTarget(this.crop,"Crop the face by dragging the red lines.");
         this.coState.dropdown.setRendererStyle("upSkin",Shape);
         this.coState.dropdown.rowHeight = 30;
         this.crop.margins = new Rectangle(5,5,this.crop.width - 10,this.crop.height - 10);
         this.crop.setIcons(InterfaceAssets.scaleCursorVertical,InterfaceAssets.scaleCursorHorizontal,InterfaceAssets.scaleCursorVertical,InterfaceAssets.scaleCursorHorizontal,InterfaceAssets.moveCursor);
         this.stFrame.stepSize = 1;
         this.stFrame.value = 0;
         this.stFrame.minimum = 0;
         this.stCoordX.minimum = -100;
         this.stCoordX.maximum = 100;
         this.stCoordX.stepSize = 1;
         this.stCoordX.value = 0;
         this.stCoordY.minimum = -100;
         this.stCoordY.maximum = 100;
         this.stCoordY.stepSize = 1;
         this.stCoordY.value = 0;
         _loc1_.x = 0;
         _loc1_.y = 0;
         this.coState.x = _loc1_.x;
         this.coState.y = _loc1_.y + _loc1_.height;
         _loc2_.x = this.coState.x + this.coState.width + 5;
         _loc2_.y = _loc1_.y;
         this.stFrame.x = _loc2_.x;
         this.stFrame.y = this.coState.y;
         this.crop.x = this.stFrame.x + this.stFrame.width - this.crop.width;
         this.crop.y = this.stFrame.y + this.stFrame.height + 6;
         _loc3_.x = this.coState.x;
         _loc3_.y = this.crop.y + 30;
         _loc4_.x = _loc3_.x;
         _loc4_.y = _loc3_.y + _loc4_.height + 10;
         this.stCoordX.x = this.crop.x - this.stCoordX.width - 5;
         this.stCoordX.y = _loc3_.y;
         this.stCoordY.x = this.stCoordX.x;
         this.stCoordY.y = _loc4_.y;
         this.char.addEventListener(AssetEvent.ASSET_ITEM_LOADED,this.faceLoaded);
         this.char.addEventListener(ProgressEvent.PROGRESS,this.faceProgress);
         this.char.addEventListener(ErrorEvent.ERROR,this.faceError);
         this.coState.addEventListener(Event.CHANGE,this.stateFaceChange);
         this.stFrame.addEventListener(Event.CHANGE,this.frameFaceStepChange);
         this.crop.addEventListener(Event.CHANGE,this.optionsChange);
         this.stCoordX.addEventListener(Event.CHANGE,this.optionsChange);
         this.stCoordY.addEventListener(Event.CHANGE,this.optionsChange);
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.croppedImage.addChild(this.croppedBitmap);
         this.addChild(this.coState);
         this.addChild(this.stFrame);
         this.addChild(_loc3_);
         this.addChild(_loc4_);
         this.addChild(this.stCoordX);
         this.addChild(this.stCoordY);
         this.addChild(_loc2_);
         this.addChild(_loc1_);
         this.addChild(this.preview);
         this.addChild(this.crop);
      }
      
      public function load(param1:*) : void
      {
         if(param1 is String)
         {
            this.faceUrl = param1;
         }
         else if(param1 is XML)
         {
            this.refNode = param1;
            this.faceUrl = param1.@url;
         }
         Alerts.setMessage("Retrieving Face...");
         this.char.load(BSPaths.bannedStoryPath + "pak/" + this.faceUrl + ".pak");
      }
      
      public function destroy() : void
      {
         this.addChild(this.char);
         this.removeChild(this.char);
         this.coState.removeAll();
         this.crop.reset();
         if(this.preview.bitmapData != null)
         {
            this.preview.bitmapData.dispose();
         }
         if(this.croppedBitmap.bitmapData != null)
         {
            this.croppedBitmap.bitmapData.dispose();
         }
         this.char.removeEventListener(AssetEvent.ASSET_ITEM_LOADED,this.faceLoaded);
         this.char.removeEventListener(ProgressEvent.PROGRESS,this.faceProgress);
         this.char.removeEventListener(ErrorEvent.ERROR,this.faceError);
         this.coState.removeEventListener(Event.CHANGE,this.stateFaceChange);
         this.stFrame.removeEventListener(Event.CHANGE,this.frameFaceStepChange);
         this.crop.removeEventListener(Event.CHANGE,this.optionsChange);
         this.stCoordX.removeEventListener(Event.CHANGE,this.optionsChange);
         this.stCoordY.removeEventListener(Event.CHANGE,this.optionsChange);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.refNode = null;
         this.char = null;
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
      }
      
      private function mouseUp(param1:MouseEvent) : void
      {
         this.stCoordX.value = this.croppedImage.x;
         this.stCoordY.value = this.croppedImage.y;
         this.croppedImage.x = this.stCoordX.value;
         this.croppedImage.y = this.stCoordY.value;
      }
      
      private function optionsChange(param1:Event = null) : void
      {
         if(this.croppedBitmap.bitmapData != null)
         {
            this.croppedBitmap.bitmapData.dispose();
         }
         var _loc2_:Number = 1 / this.scaleFactor;
         var _loc3_:Rectangle = this.crop.selection;
         var _loc4_:Matrix = new Matrix(_loc2_,0,0,_loc2_,-_loc3_.x * _loc2_,-_loc3_.y * _loc2_);
         if(_loc3_.width * _loc2_ < 1 || _loc3_.height * _loc2_ < 1)
         {
            return;
         }
         var _loc5_:BitmapData = new BitmapData(_loc3_.width * _loc2_,_loc3_.height * _loc2_,true,0);
         _loc5_.draw(this.preview.bitmapData,_loc4_,null,null);
         this.croppedBitmap.bitmapData = _loc5_;
         this.croppedImage.x = this.stCoordX.value;
         this.croppedImage.y = this.stCoordY.value;
      }
      
      private function frameFaceStepChange(param1:Event) : void
      {
         this.char.frameFace = this.stFrame.value;
         this.updatePreview();
         this.optionsChange();
      }
      
      private function stateFaceChange(param1:Event) : void
      {
         this.char.stateFace = this.coState.selectedItem.data;
         this.stFrame.value = 0;
         this.char.frameFace = 0;
         this.stFrame.maximum = Math.max(0,this.char.maxFramesFace - 1);
         this.updatePreview();
         this.optionsChange();
      }
      
      private function faceLoaded(param1:Event) : void
      {
         var _loc7_:Class = null;
         var _loc8_:int = 0;
         Alerts.hideMessage();
         if(this.refNode != null)
         {
            this.char.stateFace = this.refNode.@state;
            this.char.frameFace = parseInt(this.refNode.@frame);
            this.croppedImage.x = parseInt(this.refNode.@x);
            this.croppedImage.y = parseInt(this.refNode.@y);
            this.croppedImage.visible = String(this.refNode.@visible) == "1";
            this.crop.selection = new Rectangle(parseInt(this.refNode.@rx),parseInt(this.refNode.@ry),parseInt(this.refNode.@rw),parseInt(this.refNode.@rh));
         }
         else
         {
            this.crop.reset();
         }
         var _loc2_:Array = this.char.statesFace;
         var _loc3_:String = this.char.stateFace;
         var _loc4_:int = this.char.frameFace;
         var _loc5_:int = 0;
         var _loc6_:int = int(_loc2_.length);
         this.coState.removeAll();
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = InterfaceAssets["face" + _loc2_[_loc8_].charAt(0).toUpperCase() + _loc2_[_loc8_].substr(1)];
            if(_loc7_ == null)
            {
               this.coState.addItem({
                  "label":StateNames.regularStateName(_loc2_[_loc8_]),
                  "data":_loc2_[_loc8_]
               });
            }
            else
            {
               this.coState.addItem({
                  "label":StateNames.regularStateName(_loc2_[_loc8_]),
                  "data":_loc2_[_loc8_],
                  "icon":new _loc7_()
               });
            }
            if(_loc2_[_loc8_] == _loc3_)
            {
               _loc5_ = _loc8_;
            }
            _loc8_++;
         }
         if(_loc2_.length > 0)
         {
            this.stFrame.maximum = Math.max(0,this.char.maxFramesFace - 1);
            this.stFrame.value = _loc4_;
            this.coState.selectedIndex = _loc5_;
            this.char.stateFace = this.coState.selectedItem.data;
            this.char.frameFace = this.stFrame.value;
         }
         else
         {
            this.stFrame.maximum = 0;
            this.stFrame.value = 0;
            this.char.frameFace = 0;
         }
         this.stCoordX.value = this.croppedImage.x;
         this.stCoordY.value = this.croppedImage.y;
         this.updatePreview();
         this.optionsChange();
         this.dispatchEvent(new Event(InterfaceEvent.FACE_MIXER_ITEM_LOADED));
      }
      
      private function faceProgress(param1:ProgressEvent) : void
      {
         Alerts.setMessage("Loading Face...",this.char.progress);
      }
      
      private function faceError(param1:ErrorEvent) : void
      {
         Alerts.setMessage("The selected face could not be found.");
         Alerts.hideMessage(4);
      }
      
      private function updatePreview() : void
      {
         if(this.preview.bitmapData != null)
         {
            this.preview.bitmapData.dispose();
         }
         var _loc1_:BitmapData = new BitmapData(this.crop.width,this.crop.height,true,0);
         var _loc2_:BitmapData = RasterMaker.raster(this.char);
         var _loc3_:Matrix = new Matrix(this.scaleFactor,0,0,this.scaleFactor);
         _loc3_.tx = Math.floor((_loc1_.width - _loc2_.width * _loc3_.a) / 2);
         _loc3_.ty = Math.floor((_loc1_.height - _loc2_.height * _loc3_.d) / 2);
         _loc1_.draw(_loc2_,_loc3_);
         _loc2_.dispose();
         this.preview.bitmapData = _loc1_;
         this.preview.x = this.crop.x;
         this.preview.y = this.crop.y;
      }
      
      public function get data() : XML
      {
         var _loc1_:XML = <i/>;
         _loc1_.@url = this.faceUrl;
         _loc1_.@state = this.char.stateFace;
         _loc1_.@frame = this.char.frameFace;
         _loc1_.@x = this.croppedImage.x;
         _loc1_.@y = this.croppedImage.y;
         _loc1_.@rx = this.crop.selection.x;
         _loc1_.@ry = this.crop.selection.y;
         _loc1_.@rw = this.crop.selection.width;
         _loc1_.@rh = this.crop.selection.height;
         return _loc1_;
      }
      
      override public function get width() : Number
      {
         return this.stFrame.x + this.stFrame.width;
      }
      
      override public function get height() : Number
      {
         return this.crop.y + this.crop.height;
      }
   }
}

