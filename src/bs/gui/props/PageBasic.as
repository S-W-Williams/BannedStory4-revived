package bs.gui.props
{
   import bs.events.InterfaceEvent;
   import bs.gui.InterfaceAssets;
   import bs.utils.StateNames;
   import fl.controls.Button;
   import fl.controls.CheckBox;
   import fl.controls.ColorPicker;
   import fl.controls.ComboBox;
   import fl.controls.Label;
   import fl.controls.NumericStepper;
   import fl.controls.Slider;
   import fl.controls.TextArea;
   import fl.events.ColorPickerEvent;
   import fl.events.SliderEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import ion.components.controls.IToolTip;
   import maplestory.display.core.Picture;
   import maplestory.display.maple.AssetMapleMotion;
   import maplestory.display.maple.Char;
   import maplestory.display.maple.ChatBalloon;
   import maplestory.display.maple.NameTag;
   import maplestory.events.AssetEvent;
   import maplestory.struct.Types;
   
   public class PageBasic extends Sprite
   {
      private var assetReference:*;
      
      private var assetType:int = -2;
      
      private var cbState:ComboBox;
      
      private var cbStateFace:ComboBox;
      
      private var ckAnimate:CheckBox;
      
      private var ckAnimateFace:CheckBox;
      
      private var ckFlatHair:CheckBox;
      
      private var ckPointedEars:CheckBox;
      
      private var ckBalloonX:CheckBox;
      
      private var ckBalloonY:CheckBox;
      
      private var stCoordX:NumericStepper;
      
      private var stCoordY:NumericStepper;
      
      private var stFrame:NumericStepper;
      
      private var stFrameFace:NumericStepper;
      
      private var stTextDimW:NumericStepper;
      
      private var stTextDimH:NumericStepper;
      
      private var cpCanvasColor:ColorPicker;
      
      private var slZoom:Slider;
      
      private var txChatText:TextArea;
      
      private var sldChatArrow:Slider;
      
      private var btnRestore:Button;
      
      private var btnFlipH:Button;
      
      private var btnFlipV:Button;
      
      private var btnCenter:Button;
      
      private var btnFaceMixer:Button;
      
      private var lbCanvasColor:Label;
      
      private var lbCoordX:Label;
      
      private var lbCoordY:Label;
      
      private var lbBody:Label;
      
      private var lbFace:Label;
      
      private var lbFrame:Label;
      
      private var lbTileX:Label;
      
      private var lbTileY:Label;
      
      private var lbText:Label;
      
      private var lbChatSlide:Label;
      
      private var lbZoom:Label;
      
      private var _canvasColor:int;
      
      public function PageBasic()
      {
         super();
         this.stTextDimH = new NumericStepper();
         this.stTextDimW = new NumericStepper();
         this.txChatText = new TextArea();
         this.sldChatArrow = new Slider();
         this.cbStateFace = new ComboBox();
         this.cbState = new ComboBox();
         this.ckAnimate = new CheckBox();
         this.ckAnimateFace = new CheckBox();
         this.ckFlatHair = new CheckBox();
         this.ckPointedEars = new CheckBox();
         this.ckBalloonX = new CheckBox();
         this.ckBalloonY = new CheckBox();
         this.stCoordX = new NumericStepper();
         this.stCoordY = new NumericStepper();
         this.stFrame = new NumericStepper();
         this.stFrameFace = new NumericStepper();
         this.cpCanvasColor = new ColorPicker();
         this.slZoom = new Slider();
         this.lbCanvasColor = new Label();
         this.lbCoordX = new Label();
         this.lbCoordY = new Label();
         this.lbBody = new Label();
         this.lbFace = new Label();
         this.lbFrame = new Label();
         this.lbTileX = new Label();
         this.lbTileY = new Label();
         this.lbText = new Label();
         this.lbChatSlide = new Label();
         this.lbZoom = new Label();
         this.btnRestore = new Button();
         this.btnFlipH = new Button();
         this.btnFlipV = new Button();
         this.btnCenter = new Button();
         this.btnFaceMixer = new Button();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = InterfaceAssets.pfRondaSeven;
         _loc1_.align = TextFormatAlign.RIGHT;
         _loc1_.size = 8;
         IToolTip.setTarget(this.btnRestore,"Restore Image");
         IToolTip.setTarget(this.btnFlipV,"Flip Vertical");
         IToolTip.setTarget(this.btnFlipH,"Flip Horizontal");
         IToolTip.setTarget(this.btnCenter,"Align to center of Stage");
         this.stCoordX.minimum = this.stCoordY.minimum = -65535;
         this.stCoordX.maximum = this.stCoordY.maximum = 65535;
         this.stCoordX.stepSize = this.stCoordY.stepSize = 1;
         this.stCoordX.value = this.stCoordY.value = 0;
         this.btnFaceMixer.setSize(135,26);
         this.btnCenter.setSize(18,18);
         this.btnFlipH.setSize(18,18);
         this.btnFlipV.setSize(18,18);
         this.btnRestore.setSize(18,18);
         this.stCoordX.setSize(70,22);
         this.stCoordY.setSize(70,22);
         this.lbCanvasColor.setSize(80,22);
         this.slZoom.setSize(150,22);
         this.lbCoordX.setSize(15,22);
         this.lbCoordY.setSize(15,22);
         this.lbBody.setSize(60,22);
         this.lbFace.setSize(60,22);
         this.lbFrame.setSize(40,22);
         this.lbTileX.setSize(40,22);
         this.lbTileY.setSize(40,22);
         this.lbText.setSize(80,22);
         this.lbChatSlide.setSize(80,22);
         this.lbZoom.setSize(90,22);
         this.cbState.setSize(200,22);
         this.cbStateFace.setSize(200,22);
         this.ckAnimate.setSize(100,22);
         this.ckAnimateFace.setSize(100,22);
         this.ckFlatHair.setSize(100,22);
         this.ckPointedEars.setSize(120,22);
         this.ckBalloonX.setSize(100,22);
         this.ckBalloonY.setSize(100,22);
         this.txChatText.setSize(200,70);
         this.btnFaceMixer.label = "Create Custom Face";
         this.btnCenter.label = "";
         this.btnRestore.label = "";
         this.btnFlipV.label = "";
         this.btnFlipH.label = "";
         this.lbCanvasColor.text = "Background Color";
         this.lbCoordX.text = "X";
         this.lbCoordY.text = "Y";
         this.lbBody.text = "State";
         this.lbFace.text = "Face State";
         this.lbFrame.text = "Frame";
         this.lbTileX.text = "Tile X";
         this.lbTileY.text = "Tile Y";
         this.ckAnimate.label = "Animate";
         this.ckAnimateFace.label = "Animate Face";
         this.ckFlatHair.label = "Auto Flat Hair";
         this.ckPointedEars.label = "Show Pointed Ears";
         this.ckBalloonX.label = "Flip Balloon X";
         this.ckBalloonY.label = "Flip Balloon Y";
         this.lbChatSlide.text = "Arrow Position";
         this.lbZoom.text = "Canvas Zoom 100%";
         this.lbBody.setStyle("textFormat",_loc1_);
         this.lbFace.setStyle("textFormat",_loc1_);
         this.cbState.dropdown.setRendererStyle("upSkin",Shape);
         this.cbStateFace.dropdown.setRendererStyle("upSkin",Shape);
         this.btnRestore.setStyle("icon",new Bitmap(InterfaceAssets.refreshSmall));
         this.btnFlipH.setStyle("icon",new Bitmap(InterfaceAssets.shapeFlipHorizontal));
         this.btnFlipV.setStyle("icon",new Bitmap(InterfaceAssets.shapeFlipVertical));
         this.btnCenter.setStyle("icon",new Bitmap(InterfaceAssets.moveCenter));
         this.btnFaceMixer.setStyle("icon",new InterfaceAssets.faceCustomFace());
         this.stFrame.stepSize = 1;
         this.stFrameFace.stepSize = 1;
         this.stTextDimH.stepSize = 1;
         this.stTextDimW.stepSize = 1;
         this.stFrame.value = 0;
         this.stFrameFace.value = 0;
         this.stTextDimH.value = 5;
         this.stTextDimW.value = 10;
         this.stFrame.minimum = 0;
         this.stFrameFace.minimum = 0;
         this.stTextDimH.minimum = 1;
         this.stTextDimW.minimum = 1;
         this.stTextDimH.maximum = 30;
         this.stTextDimW.maximum = 30;
         this.sldChatArrow.minimum = 0;
         this.sldChatArrow.maximum = 1;
         this.sldChatArrow.value = 0;
         this.sldChatArrow.snapInterval = 0.05;
         this.slZoom.minimum = 0.2;
         this.slZoom.maximum = 4.2;
         this.slZoom.snapInterval = 0.1;
         this.slZoom.tickInterval = 0.8;
         this.slZoom.value = 1;
         this.ckFlatHair.selected = true;
         this.ckPointedEars.selected = false;
         this.cpCanvasColor.selectedColor = 16777215;
         this.cbStateFace.dropdown.rowHeight = 30;
         this.cbState.addEventListener(Event.CHANGE,this.stateChange);
         this.cbStateFace.addEventListener(Event.CHANGE,this.stateFaceChange);
         this.ckAnimate.addEventListener(MouseEvent.CLICK,this.animateClick);
         this.ckAnimateFace.addEventListener(MouseEvent.CLICK,this.animateFaceClick);
         this.ckFlatHair.addEventListener(MouseEvent.CLICK,this.flatHairClick);
         this.ckPointedEars.addEventListener(MouseEvent.CLICK,this.pointedEarsClick);
         this.ckBalloonX.addEventListener(MouseEvent.CLICK,this.balloonFlipClick);
         this.ckBalloonY.addEventListener(MouseEvent.CLICK,this.balloonFlipClick);
         this.btnRestore.addEventListener(MouseEvent.CLICK,this.btnToolClick);
         this.btnFlipH.addEventListener(MouseEvent.CLICK,this.btnToolClick);
         this.btnFlipV.addEventListener(MouseEvent.CLICK,this.btnToolClick);
         this.btnCenter.addEventListener(MouseEvent.CLICK,this.btnToolClick);
         this.btnFaceMixer.addEventListener(MouseEvent.CLICK,this.btnFaceMixerClick);
         this.stCoordX.addEventListener(Event.CHANGE,this.coordStepChange);
         this.stCoordY.addEventListener(Event.CHANGE,this.coordStepChange);
         this.stFrame.addEventListener(Event.CHANGE,this.frameStepChange);
         this.stFrameFace.addEventListener(Event.CHANGE,this.frameFaceStepChange);
         this.stTextDimH.addEventListener(Event.CHANGE,this.textStepChange);
         this.stTextDimW.addEventListener(Event.CHANGE,this.textStepChange);
         this.txChatText.addEventListener(Event.CHANGE,this.chatTextChange);
         this.cpCanvasColor.addEventListener(ColorPickerEvent.CHANGE,this.canvasColorChange);
         this.sldChatArrow.addEventListener(SliderEvent.THUMB_DRAG,this.chatSlideChange);
         this.slZoom.addEventListener(SliderEvent.THUMB_DRAG,this.zoomChange);
         this.arrangeComponents();
         this.addChild(this.stCoordX);
         this.addChild(this.stCoordY);
         this.addChild(this.lbCoordX);
         this.addChild(this.lbCoordY);
         this.addChild(this.lbBody);
         this.addChild(this.lbFace);
         this.addChild(this.lbCanvasColor);
         this.addChild(this.lbFrame);
         this.addChild(this.lbTileX);
         this.addChild(this.lbTileY);
         this.addChild(this.lbText);
         this.addChild(this.lbChatSlide);
         this.addChild(this.lbZoom);
         this.addChild(this.cpCanvasColor);
         this.addChild(this.slZoom);
         this.addChild(this.cbState);
         this.addChild(this.cbStateFace);
         this.addChild(this.stFrame);
         this.addChild(this.stFrameFace);
         this.addChild(this.ckAnimate);
         this.addChild(this.ckAnimateFace);
         this.addChild(this.ckFlatHair);
         this.addChild(this.ckPointedEars);
         this.addChild(this.txChatText);
         this.addChild(this.stTextDimH);
         this.addChild(this.stTextDimW);
         this.addChild(this.btnFlipH);
         this.addChild(this.btnFlipV);
         this.addChild(this.btnRestore);
         this.addChild(this.btnCenter);
         this.addChild(this.btnFaceMixer);
         this.addChild(this.sldChatArrow);
         this.addChild(this.ckBalloonX);
         this.addChild(this.ckBalloonY);
      }
      
      public function setTarget(param1:int, param2:*) : void
      {
         if(this.assetReference != null)
         {
            this.assetReference.removeEventListener(AssetEvent.FACE_FRAME_CHANGE,this.frameFaceChange);
            this.assetReference.removeEventListener(AssetEvent.FRAME_CHANGE,this.frameChange);
         }
         this.assetType = param1;
         this.assetReference = param2;
         this.arrangeComponents();
         if(this.assetReference is DisplayObject)
         {
            this.assetReference.addEventListener(AssetEvent.FACE_FRAME_CHANGE,this.frameFaceChange);
            this.assetReference.addEventListener(AssetEvent.FRAME_CHANGE,this.frameChange);
            this.assetComplete();
         }
      }
      
      public function refreshCoordinates() : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.stCoordX.value = this.assetReference.x;
         this.stCoordY.value = this.assetReference.y;
      }
      
      private function btnFaceMixerClick(param1:MouseEvent) : void
      {
         this.dispatchEvent(new Event(InterfaceEvent.PROPERTIES_SHOW_FACE_MIXER,true));
      }
      
      private function zoomChange(param1:Event) : void
      {
         if(this.slZoom.value >= 0.9 && this.slZoom.value <= 1.1)
         {
            this.slZoom.value = 1;
         }
         if(this.slZoom.value >= 1.9 && this.slZoom.value <= 2.1)
         {
            this.slZoom.value = 2;
         }
         if(this.slZoom.value >= 2.9 && this.slZoom.value <= 3.1)
         {
            this.slZoom.value = 3;
         }
         if(this.slZoom.value >= 3.9 && this.slZoom.value <= 4.1)
         {
            this.slZoom.value = 4;
         }
         this.lbZoom.text = "Canvas Zoom " + Math.floor(this.slZoom.value * 100) + "%";
         this.dispatchEvent(new Event(InterfaceEvent.CANVAS_ZOOM,true));
      }
      
      private function balloonFlipClick(param1:MouseEvent) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         if(param1.currentTarget == this.ckBalloonX)
         {
            this.assetReference.flipBalloonX = param1.currentTarget.selected;
         }
         else if(param1.currentTarget == this.ckBalloonY)
         {
            this.assetReference.flipBalloonY = param1.currentTarget.selected;
         }
      }
      
      private function chatSlideChange(param1:SliderEvent) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.arrowMove = this.sldChatArrow.value;
      }
      
      private function btnToolClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget == this.btnRestore)
         {
            this.dispatchEvent(new Event(InterfaceEvent.TRANSFORMTOOL_RESET,true));
         }
         else if(param1.currentTarget == this.btnFlipH)
         {
            this.dispatchEvent(new Event(InterfaceEvent.TRANSFORMTOOL_FLIP_H,true));
         }
         else if(param1.currentTarget == this.btnFlipV)
         {
            this.dispatchEvent(new Event(InterfaceEvent.TRANSFORMTOOL_FLIP_V,true));
         }
         else if(param1.currentTarget == this.btnCenter)
         {
            this.dispatchEvent(new Event(InterfaceEvent.TRANSFORMTOOL_MOVE_CENTER,true));
         }
      }
      
      private function pointedEarsClick(param1:MouseEvent) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.pointedEars = this.ckPointedEars.selected;
      }
      
      private function flatHairClick(param1:MouseEvent) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.flatHair = this.ckFlatHair.selected;
      }
      
      private function textStepChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.tileX = this.stTextDimW.value;
         this.assetReference.tileY = this.stTextDimH.value;
      }
      
      private function chatTextChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         if(this.assetReference is NameTag)
         {
            this.txChatText.text = this.txChatText.text.split(String.fromCharCode(13)).join(" ");
         }
         this.assetReference.text = this.txChatText.text;
      }
      
      private function frameFaceChange(param1:Event) : void
      {
         this.stFrameFace.value = param1.currentTarget.frameFace;
      }
      
      private function frameChange(param1:Event) : void
      {
         this.stFrame.value = param1.currentTarget.frame;
      }
      
      private function canvasColorChange(param1:ColorPickerEvent) : void
      {
         this._canvasColor = this.cpCanvasColor.selectedColor;
         this.dispatchEvent(new Event(InterfaceEvent.CANVAS_COLOR,true));
      }
      
      private function frameStepChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            this.stFrame.value = 0;
            return;
         }
         this.assetReference.frame = this.stFrame.value;
      }
      
      private function frameFaceStepChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            this.stFrameFace.value = 0;
            return;
         }
         this.assetReference.frameFace = this.stFrameFace.value;
      }
      
      private function coordStepChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.x = this.stCoordX.value;
         this.assetReference.y = this.stCoordY.value;
      }
      
      private function animateFaceClick(param1:MouseEvent) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.animateFace = this.ckAnimateFace.selected;
      }
      
      private function animateClick(param1:MouseEvent) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.animate = this.ckAnimate.selected;
      }
      
      private function stateChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.state = this.cbState.selectedItem.data;
         this.stFrame.value = 0;
         this.assetReference.frame = 0;
         this.stFrame.maximum = Math.max(0,this.assetReference.maxFrames - 1);
      }
      
      private function stateFaceChange(param1:Event) : void
      {
         if(this.assetReference == null)
         {
            return;
         }
         this.assetReference.stateFace = this.cbStateFace.selectedItem.data;
         this.stFrameFace.value = 0;
         this.assetReference.frameFace = 0;
         this.stFrameFace.maximum = Math.max(0,this.assetReference.maxFramesFace - 1);
      }
      
      private function arrangeComponents() : void
      {
         this.lbCanvasColor.x = 10;
         this.lbCanvasColor.y = 30;
         this.cpCanvasColor.x = this.lbCanvasColor.x + this.lbCanvasColor.width;
         this.cpCanvasColor.y = this.lbCanvasColor.y;
         this.lbZoom.x = this.cpCanvasColor.x + this.cpCanvasColor.width + 50;
         this.lbZoom.y = this.lbCanvasColor.y;
         this.slZoom.x = this.lbZoom.x + this.lbZoom.width;
         this.slZoom.y = this.lbZoom.y;
         this.lbCoordX.x = 0;
         this.lbCoordX.y = 5;
         this.lbCoordY.x = this.lbCoordX.x;
         this.lbCoordY.y = this.lbCoordX.y + this.lbCoordX.height;
         this.stCoordX.x = this.lbCoordX.x + this.lbCoordX.width;
         this.stCoordX.y = this.lbCoordX.y;
         this.stCoordY.x = this.stCoordX.x;
         this.stCoordY.y = this.lbCoordY.y;
         this.btnFlipH.x = this.lbCoordY.x + 8;
         this.btnFlipH.y = this.lbCoordY.y + this.lbCoordY.height + 5;
         this.btnFlipV.x = this.btnFlipH.x + this.btnFlipH.width + 1;
         this.btnFlipV.y = this.btnFlipH.y;
         this.btnRestore.x = this.btnFlipV.x + this.btnFlipV.width + 1;
         this.btnRestore.y = this.btnFlipV.y;
         this.btnCenter.x = this.btnRestore.x + this.btnRestore.width + 1;
         this.btnCenter.y = this.btnRestore.y;
         this.btnFaceMixer.x = this.cbStateFace.x;
         this.btnFaceMixer.y = this.cbStateFace.y + this.cbStateFace.height + 2;
         this.lbBody.x = 130;
         this.lbBody.y = 5;
         this.lbFace.x = this.lbBody.x;
         this.lbFace.y = this.lbBody.y + this.lbBody.height + 3;
         this.cbState.x = this.lbBody.x + this.lbBody.width + 3;
         this.cbState.y = this.lbBody.y;
         this.cbStateFace.x = this.cbState.x;
         this.cbStateFace.y = this.lbFace.y;
         this.stFrame.x = this.cbState.x + this.cbState.width + 3;
         this.stFrame.y = this.cbState.y;
         this.stFrameFace.x = this.stFrame.x;
         this.stFrameFace.y = this.cbStateFace.y;
         this.ckAnimate.x = this.stFrame.x + this.stFrame.width + 10;
         this.ckAnimate.y = this.stFrame.y - 8;
         this.ckAnimateFace.x = this.ckAnimate.x;
         this.ckAnimateFace.y = this.ckAnimate.y + this.ckAnimate.height - 3;
         this.ckFlatHair.x = this.ckAnimateFace.x;
         this.ckFlatHair.y = this.ckAnimateFace.y + this.ckAnimateFace.height + 6;
         this.ckPointedEars.x = this.ckFlatHair.x;
         this.ckPointedEars.y = this.ckFlatHair.y + this.ckFlatHair.height - 3;
         this.cbState.visible = false;
         this.cbStateFace.visible = false;
         this.stFrame.visible = false;
         this.stFrameFace.visible = false;
         this.ckAnimate.visible = false;
         this.ckAnimateFace.visible = false;
         this.ckFlatHair.visible = false;
         this.ckPointedEars.visible = false;
         this.stCoordX.visible = false;
         this.stCoordY.visible = false;
         this.lbCoordX.visible = false;
         this.lbCoordY.visible = false;
         this.lbBody.visible = false;
         this.lbFace.visible = false;
         this.lbFrame.visible = false;
         this.lbTileX.visible = false;
         this.lbTileY.visible = false;
         this.lbText.visible = false;
         this.lbChatSlide.visible = false;
         this.txChatText.visible = false;
         this.stTextDimH.visible = false;
         this.stTextDimW.visible = false;
         this.btnRestore.visible = false;
         this.btnFlipV.visible = false;
         this.btnFlipH.visible = false;
         this.btnCenter.visible = false;
         this.btnFaceMixer.visible = false;
         this.sldChatArrow.visible = false;
         this.ckBalloonX.visible = false;
         this.ckBalloonY.visible = false;
         this.cpCanvasColor.visible = true;
         this.lbCanvasColor.visible = true;
         this.slZoom.visible = true;
         this.lbZoom.visible = true;
         switch(this.assetType)
         {
            case Types.ASSET_CHARACTER:
            case Types.ASSET_EFFECT:
            case Types.ASSET_ETC:
            case Types.ASSET_ITEM:
            case Types.ASSET_MAP:
            case Types.ASSET_MOB:
            case Types.ASSET_MORPH:
            case Types.ASSET_NPC:
            case Types.ASSET_PET:
            case Types.ASSET_SKILL:
            case Types.ASSET_NONE_MOTION:
            case Types.ASSET_CHAT_BALLOON:
            case Types.ASSET_NAME_TAG:
            case Types.ASSET_PICTURE:
               this.cbState.visible = true;
               this.stFrame.visible = true;
               this.ckAnimate.visible = true;
               this.stCoordX.visible = true;
               this.stCoordY.visible = true;
               this.lbCoordX.visible = true;
               this.lbCoordY.visible = true;
               this.btnFlipH.visible = true;
               this.btnFlipV.visible = true;
               this.btnRestore.visible = true;
               this.btnCenter.visible = true;
               this.cpCanvasColor.visible = false;
               this.lbCanvasColor.visible = false;
               this.lbBody.visible = true;
               this.slZoom.visible = false;
               this.lbZoom.visible = false;
         }
         if(this.assetType == Types.ASSET_CHARACTER)
         {
            this.cbStateFace.visible = true;
            this.stFrameFace.visible = true;
            this.ckAnimateFace.visible = true;
            this.lbFace.visible = true;
            this.ckFlatHair.visible = true;
            this.ckPointedEars.visible = true;
            this.btnFaceMixer.visible = true;
         }
         if(this.assetType == Types.ASSET_CHAT_BALLOON)
         {
            this.txChatText.visible = true;
            this.cbState.visible = false;
            this.stTextDimH.visible = true;
            this.stTextDimW.visible = true;
            this.lbBody.visible = false;
            this.lbChatSlide.visible = true;
            this.sldChatArrow.visible = true;
            this.ckBalloonX.visible = true;
            this.ckBalloonY.visible = true;
            this.lbFrame.visible = this.assetReference.maxFrames > 1;
            this.stFrame.visible = this.lbFrame.visible;
            this.ckAnimate.visible = this.stFrame.visible;
            this.lbTileX.visible = true;
            this.lbTileY.visible = true;
            this.lbText.visible = true;
            this.lbText.text = "Chat Balloon Text";
            this.lbFrame.x = this.lbBody.x;
            this.lbFrame.y = -5;
            this.lbTileX.x = this.lbFrame.x;
            this.lbTileX.y = this.lbFrame.y + this.lbFrame.height + 2;
            this.lbTileY.x = this.lbTileX.x;
            this.lbTileY.y = this.lbTileX.y + this.lbTileX.height + 2;
            this.stFrame.x = this.lbFrame.x + this.lbFrame.width;
            this.stFrame.y = this.lbFrame.y;
            this.stTextDimW.x = this.lbTileX.x + this.lbTileX.width;
            this.stTextDimW.y = this.lbTileX.y;
            this.stTextDimH.x = this.lbTileY.x + this.lbTileY.width;
            this.stTextDimH.y = this.lbTileY.y;
            this.lbText.x = this.stTextDimH.x + this.stTextDimH.width + 25;
            this.lbText.y = this.lbFrame.y;
            this.txChatText.x = this.lbText.x;
            this.txChatText.y = this.lbText.y + this.lbText.height - 5;
            this.lbChatSlide.x = this.txChatText.x + this.txChatText.width + 10;
            this.lbChatSlide.y = this.lbText.y;
            this.sldChatArrow.x = this.lbChatSlide.x;
            this.sldChatArrow.y = this.txChatText.y;
            this.ckBalloonX.x = this.lbChatSlide.x;
            this.ckBalloonX.y = this.sldChatArrow.y + this.sldChatArrow.height + 15;
            this.ckBalloonY.x = this.ckBalloonX.x;
            this.ckBalloonY.y = this.ckBalloonX.y + this.ckBalloonX.height + 2;
            this.ckAnimate.x = this.sldChatArrow.x + this.sldChatArrow.width + 4;
            this.ckAnimate.y = this.lbFrame.y;
         }
         if(this.assetType == Types.ASSET_NAME_TAG)
         {
            this.txChatText.visible = true;
            this.cbState.visible = false;
            this.lbText.visible = true;
            this.lbBody.visible = false;
            this.lbText.text = "Name Tag Text";
            this.stTextDimH.visible = false;
            this.stTextDimW.visible = false;
            this.stFrame.visible = false;
            this.ckAnimate.visible = false;
            this.lbText.x = 275;
            this.lbText.y = -5;
            this.txChatText.x = this.lbText.x;
            this.txChatText.y = this.lbText.y + this.lbText.height - 5;
         }
         if(this.assetType == Types.ASSET_PICTURE)
         {
            this.cbState.visible = false;
            this.lbBody.visible = false;
            this.ckAnimate.y = this.stFrame.y;
         }
      }
      
      private function assetComplete() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Class = null;
         if(this.assetReference == null)
         {
            return;
         }
         if(this.assetReference is AssetMapleMotion)
         {
            _loc1_ = this.assetReference.states;
            _loc3_ = this.assetReference.state;
            _loc4_ = int(this.assetReference.frame);
            _loc2_ = int(_loc1_.length);
            _loc6_ = 0;
            this.cbState.removeAll();
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               if(this.assetReference is Char)
               {
                  this.cbState.addItem({
                     "label":StateNames.charStateName(_loc1_[_loc5_]),
                     "data":_loc1_[_loc5_]
                  });
               }
               else
               {
                  this.cbState.addItem({
                     "label":StateNames.regularStateName(_loc1_[_loc5_]),
                     "data":_loc1_[_loc5_]
                  });
               }
               if(_loc1_[_loc5_] == _loc3_)
               {
                  _loc6_ = _loc5_;
               }
               _loc5_++;
            }
            if(_loc1_.length > 0)
            {
               this.stFrame.maximum = Math.max(0,this.assetReference.maxFrames - 1);
               this.stFrame.value = _loc4_;
               this.cbState.selectedIndex = _loc6_;
               this.assetReference.state = this.cbState.selectedItem.data;
               this.assetReference.frame = this.stFrame.value;
            }
            else
            {
               this.stFrame.maximum = 0;
               this.stFrame.value = 0;
               this.assetReference.frame = 0;
            }
            this.ckAnimate.selected = this.assetReference.animate;
         }
         if(this.assetReference is Char)
         {
            _loc1_ = this.assetReference.statesFace;
            _loc3_ = this.assetReference.stateFace;
            _loc4_ = int(this.assetReference.frameFace);
            _loc2_ = int(_loc1_.length);
            _loc6_ = 0;
            this.cbStateFace.removeAll();
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc7_ = InterfaceAssets["face" + _loc1_[_loc5_].charAt(0).toUpperCase() + _loc1_[_loc5_].substr(1)];
               if(_loc7_ == null)
               {
                  this.cbStateFace.addItem({
                     "label":StateNames.regularStateName(_loc1_[_loc5_]),
                     "data":_loc1_[_loc5_]
                  });
               }
               else
               {
                  this.cbStateFace.addItem({
                     "label":StateNames.regularStateName(_loc1_[_loc5_]),
                     "data":_loc1_[_loc5_],
                     "icon":new _loc7_()
                  });
               }
               if(_loc1_[_loc5_] == _loc3_)
               {
                  _loc6_ = _loc5_;
               }
               _loc5_++;
            }
            if(_loc1_.length > 0)
            {
               this.stFrameFace.maximum = Math.max(0,this.assetReference.maxFramesFace - 1);
               this.stFrameFace.value = _loc4_;
               this.cbStateFace.selectedIndex = _loc6_;
               this.assetReference.stateFace = this.cbStateFace.selectedItem.data;
               this.assetReference.frameFace = this.stFrameFace.value;
            }
            else
            {
               this.stFrameFace.maximum = 0;
               this.stFrameFace.value = 0;
               this.assetReference.frameFace = 0;
            }
            this.ckAnimateFace.selected = this.assetReference.animateFace;
            this.ckFlatHair.selected = this.assetReference.flatHair;
            this.ckPointedEars.selected = this.assetReference.pointedEars;
         }
         if(this.assetReference is ChatBalloon || this.assetReference is Picture)
         {
            _loc4_ = int(this.assetReference.frame);
            this.stFrame.maximum = Math.max(0,this.assetReference.maxFrames - 1);
            this.stFrame.value = _loc4_;
            this.ckAnimate.selected = this.assetReference.animate;
            this.assetReference.frame = this.stFrame.value;
            if(this.assetReference.maxFrames <= 1)
            {
               this.stFrame.visible = false;
               this.ckAnimate.visible = false;
            }
         }
         if(this.assetReference is ChatBalloon || this.assetReference is NameTag)
         {
            this.txChatText.text = this.assetReference.text;
         }
         if(this.assetReference is ChatBalloon)
         {
            this.sldChatArrow.value = this.assetReference.arrowMove;
            this.ckBalloonX.selected = this.assetReference.flipBalloonX;
            this.ckBalloonY.selected = this.assetReference.flipBalloonY;
         }
         this.stCoordX.value = this.assetReference.x;
         this.stCoordY.value = this.assetReference.y;
      }
      
      public function get canvasZoom() : Number
      {
         return this.slZoom.value;
      }
      
      public function get canvasColor() : int
      {
         return this._canvasColor;
      }
      
      public function set canvasColor(param1:int) : void
      {
         this._canvasColor = param1;
         this.cpCanvasColor.selectedColor = param1;
      }
   }
}

