package transtool.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.Dictionary;
   
   public class TransformTool extends Sprite
   {
      public static const NEW_TARGET:String = "newTarget";
      
      public static const TRANSFORM_TARGET:String = "transformTarget";
      
      public static const TRANSFORM_TOOL:String = "transformTool";
      
      public static const CONTROL_INIT:String = "controlInit";
      
      public static const CONTROL_TRANSFORM_TOOL:String = "controlTransformTool";
      
      public static const CONTROL_DOWN:String = "controlDown";
      
      public static const CONTROL_MOVE:String = "controlMove";
      
      public static const CONTROL_UP:String = "controlUp";
      
      public static const CONTROL_PREFERENCE:String = "controlPreference";
      
      public static const REGISTRATION:String = "registration";
      
      public static const SCALE_TOP_LEFT:String = "scaleTopLeft";
      
      public static const SCALE_TOP:String = "scaleTop";
      
      public static const SCALE_TOP_RIGHT:String = "scaleTopRight";
      
      public static const SCALE_RIGHT:String = "scaleRight";
      
      public static const SCALE_BOTTOM_RIGHT:String = "scaleBottomRight";
      
      public static const SCALE_BOTTOM:String = "scaleBottom";
      
      public static const SCALE_BOTTOM_LEFT:String = "scaleBottomLeft";
      
      public static const SCALE_LEFT:String = "scaleLeft";
      
      public static const ROTATION_TOP_LEFT:String = "rotationTopLeft";
      
      public static const ROTATION_TOP_RIGHT:String = "rotationTopRight";
      
      public static const ROTATION_BOTTOM_RIGHT:String = "rotationBottomRight";
      
      public static const ROTATION_BOTTOM_LEFT:String = "rotationBottomLeft";
      
      public static const SKEW_TOP:String = "skewTop";
      
      public static const SKEW_RIGHT:String = "skewRight";
      
      public static const SKEW_BOTTOM:String = "skewBottom";
      
      public static const SKEW_LEFT:String = "skewLeft";
      
      public static const CURSOR_REGISTRATION:String = "cursorRegistration";
      
      public static const CURSOR_MOVE:String = "cursorMove";
      
      public static const CURSOR_SCALE:String = "cursorScale";
      
      public static const CURSOR_ROTATION:String = "cursorRotate";
      
      public static const CURSOR_SKEW:String = "cursorSkew";
      
      private var toolInvertedMatrix:Matrix = new Matrix();
      
      private var innerRegistration:Point = new Point();
      
      private var registrationLog:Dictionary = new Dictionary(true);
      
      private var targetBounds:Rectangle = new Rectangle();
      
      private var mouseLoc:Point = new Point();
      
      private var mouseOffset:Point = new Point();
      
      private var innerMouseLoc:Point = new Point();
      
      private var interactionStart:Point = new Point();
      
      private var innerInteractionStart:Point = new Point();
      
      private var interactionStartAngle:Number = 0;
      
      private var interactionStartMatrix:Matrix = new Matrix();
      
      private var toolSprites:Sprite = new Sprite();
      
      private var lines:Sprite = new Sprite();
      
      private var moveControls:Sprite = new Sprite();
      
      private var registrationControls:Sprite = new Sprite();
      
      private var rotateControls:Sprite = new Sprite();
      
      private var scaleControls:Sprite = new Sprite();
      
      private var skewControls:Sprite = new Sprite();
      
      private var cursors:Sprite = new Sprite();
      
      private var customControls:Sprite = new Sprite();
      
      private var customCursors:Sprite = new Sprite();
      
      private var _target:DisplayObject;
      
      private var _toolMatrix:Matrix = new Matrix();
      
      private var _globalMatrix:Matrix = new Matrix();
      
      private var _registration:Point = new Point();
      
      private var _livePreview:Boolean = true;
      
      private var _raiseNewTargets:Boolean = true;
      
      private var _moveNewTargets:Boolean = false;
      
      private var _moveEnabled:Boolean = true;
      
      private var _registrationEnabled:Boolean = true;
      
      private var _rotationEnabled:Boolean = true;
      
      private var _scaleEnabled:Boolean = true;
      
      private var _skewEnabled:Boolean = true;
      
      private var _outlineEnabled:Boolean = true;
      
      private var _customControlsEnabled:Boolean = true;
      
      private var _customCursorsEnabled:Boolean = true;
      
      private var _cursorsEnabled:Boolean = true;
      
      private var _rememberRegistration:Boolean = true;
      
      private var _constrainScale:Boolean = false;
      
      private var _constrainRotationAngle:Number = 0.7853981633974483;
      
      private var _constrainRotation:Boolean = false;
      
      private var _moveUnderObjects:Boolean = true;
      
      private var _maintainControlForm:Boolean = true;
      
      private var _controlSize:Number = 8;
      
      private var _maxScaleX:Number = Infinity;
      
      private var _maxScaleY:Number = Infinity;
      
      private var _boundsTopLeft:Point = new Point();
      
      private var _boundsTop:Point = new Point();
      
      private var _boundsTopRight:Point = new Point();
      
      private var _boundsRight:Point = new Point();
      
      private var _boundsBottomRight:Point = new Point();
      
      private var _boundsBottom:Point = new Point();
      
      private var _boundsBottomLeft:Point = new Point();
      
      private var _boundsLeft:Point = new Point();
      
      private var _boundsCenter:Point = new Point();
      
      private var _currentControl:TransformToolControl;
      
      private var _moveControl:TransformToolControl;
      
      private var _registrationControl:TransformToolControl;
      
      private var _outlineControl:TransformToolControl;
      
      private var _scaleTopLeftControl:TransformToolControl;
      
      private var _scaleTopControl:TransformToolControl;
      
      private var _scaleTopRightControl:TransformToolControl;
      
      private var _scaleRightControl:TransformToolControl;
      
      private var _scaleBottomRightControl:TransformToolControl;
      
      private var _scaleBottomControl:TransformToolControl;
      
      private var _scaleBottomLeftControl:TransformToolControl;
      
      private var _scaleLeftControl:TransformToolControl;
      
      private var _rotationTopLeftControl:TransformToolControl;
      
      private var _rotationTopRightControl:TransformToolControl;
      
      private var _rotationBottomRightControl:TransformToolControl;
      
      private var _rotationBottomLeftControl:TransformToolControl;
      
      private var _skewTopControl:TransformToolControl;
      
      private var _skewRightControl:TransformToolControl;
      
      private var _skewBottomControl:TransformToolControl;
      
      private var _skewLeftControl:TransformToolControl;
      
      private var _moveCursor:TransformToolCursor;
      
      private var _registrationCursor:TransformToolCursor;
      
      private var _rotationCursor:TransformToolCursor;
      
      private var _scaleCursor:TransformToolCursor;
      
      private var _skewCursor:TransformToolCursor;
      
      public function TransformTool()
      {
         super();
         this.createControls();
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(param1:DisplayObject) : void
      {
         if(!param1)
         {
            if(this._target)
            {
               this._target = null;
               this.updateControlsVisible();
               dispatchEvent(new Event(NEW_TARGET));
            }
            return;
         }
         if(param1 == this._target || param1 == this || contains(param1) || param1 is DisplayObjectContainer && (param1 as DisplayObjectContainer).contains(this))
         {
            return;
         }
         this._target = param1;
         this.updateMatrix();
         this.setNewRegistation();
         this.updateControlsVisible();
         if(this._raiseNewTargets)
         {
            this.raiseTarget();
         }
         if(!this._moveNewTargets)
         {
            this.apply();
         }
         dispatchEvent(new Event(NEW_TARGET));
         if(this._moveNewTargets && this._moveEnabled && Boolean(this._moveControl))
         {
            this._currentControl = this._moveControl;
         }
      }
      
      public function get raiseNewTargets() : Boolean
      {
         return this._raiseNewTargets;
      }
      
      public function set raiseNewTargets(param1:Boolean) : void
      {
         this._raiseNewTargets = param1;
      }
      
      public function get moveNewTargets() : Boolean
      {
         return this._moveNewTargets;
      }
      
      public function set moveNewTargets(param1:Boolean) : void
      {
         this._moveNewTargets = param1;
      }
      
      public function get livePreview() : Boolean
      {
         return this._livePreview;
      }
      
      public function set livePreview(param1:Boolean) : void
      {
         this._livePreview = param1;
      }
      
      public function get controlSize() : Number
      {
         return this._controlSize;
      }
      
      public function set controlSize(param1:Number) : void
      {
         if(this._controlSize != param1)
         {
            this._controlSize = param1;
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get maintainControlForm() : Boolean
      {
         return this._maintainControlForm;
      }
      
      public function set maintainControlForm(param1:Boolean) : void
      {
         if(this._maintainControlForm != param1)
         {
            this._maintainControlForm = param1;
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get moveUnderObjects() : Boolean
      {
         return this._moveUnderObjects;
      }
      
      public function set moveUnderObjects(param1:Boolean) : void
      {
         if(this._moveUnderObjects != param1)
         {
            this._moveUnderObjects = param1;
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get toolMatrix() : Matrix
      {
         return this._toolMatrix.clone();
      }
      
      public function set toolMatrix(param1:Matrix) : void
      {
         this.updateMatrix(param1,false);
         this.updateRegistration();
         dispatchEvent(new Event(TRANSFORM_TOOL));
      }
      
      public function get globalMatrix() : Matrix
      {
         var _loc1_:Matrix = this._toolMatrix.clone();
         _loc1_.concat(transform.concatenatedMatrix);
         return _loc1_;
      }
      
      public function set globalMatrix(param1:Matrix) : void
      {
         this.updateMatrix(param1);
         this.updateRegistration();
         dispatchEvent(new Event(TRANSFORM_TOOL));
      }
      
      public function get registration() : Point
      {
         return this._registration.clone();
      }
      
      public function set registration(param1:Point) : void
      {
         this._registration = param1.clone();
         this.innerRegistration = this.toolInvertedMatrix.transformPoint(this._registration);
         if(this._rememberRegistration)
         {
            this.registrationLog[this._target] = this.innerRegistration;
         }
         dispatchEvent(new Event(TRANSFORM_TOOL));
      }
      
      public function get currentControl() : TransformToolControl
      {
         return this._currentControl;
      }
      
      public function get moveEnabled() : Boolean
      {
         return this._moveEnabled;
      }
      
      public function set moveEnabled(param1:Boolean) : void
      {
         if(this._moveEnabled != param1)
         {
            this._moveEnabled = param1;
            this.updateControlsEnabled();
         }
      }
      
      public function get registrationEnabled() : Boolean
      {
         return this._registrationEnabled;
      }
      
      public function set registrationEnabled(param1:Boolean) : void
      {
         if(this._registrationEnabled != param1)
         {
            this._registrationEnabled = param1;
            this.updateControlsEnabled();
         }
      }
      
      public function get rotationEnabled() : Boolean
      {
         return this._rotationEnabled;
      }
      
      public function set rotationEnabled(param1:Boolean) : void
      {
         if(this._rotationEnabled != param1)
         {
            this._rotationEnabled = param1;
            this.updateControlsEnabled();
         }
      }
      
      public function get scaleEnabled() : Boolean
      {
         return this._scaleEnabled;
      }
      
      public function set scaleEnabled(param1:Boolean) : void
      {
         if(this._scaleEnabled != param1)
         {
            this._scaleEnabled = param1;
            this.updateControlsEnabled();
         }
      }
      
      public function get skewEnabled() : Boolean
      {
         return this._skewEnabled;
      }
      
      public function set skewEnabled(param1:Boolean) : void
      {
         if(this._skewEnabled != param1)
         {
            this._skewEnabled = param1;
            this.updateControlsEnabled();
         }
      }
      
      public function get outlineEnabled() : Boolean
      {
         return this._outlineEnabled;
      }
      
      public function set outlineEnabled(param1:Boolean) : void
      {
         if(this._outlineEnabled != param1)
         {
            this._outlineEnabled = param1;
            this.updateControlsEnabled();
         }
      }
      
      public function get cursorsEnabled() : Boolean
      {
         return this._cursorsEnabled;
      }
      
      public function set cursorsEnabled(param1:Boolean) : void
      {
         if(this._cursorsEnabled != param1)
         {
            this._cursorsEnabled = param1;
            this.updateControlsEnabled();
         }
      }
      
      public function get customControlsEnabled() : Boolean
      {
         return this._customControlsEnabled;
      }
      
      public function set customControlsEnabled(param1:Boolean) : void
      {
         if(this._customControlsEnabled != param1)
         {
            this._customControlsEnabled = param1;
            this.updateControlsEnabled();
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get customCursorsEnabled() : Boolean
      {
         return this._customCursorsEnabled;
      }
      
      public function set customCursorsEnabled(param1:Boolean) : void
      {
         if(this._customCursorsEnabled != param1)
         {
            this._customCursorsEnabled = param1;
            this.updateControlsEnabled();
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get rememberRegistration() : Boolean
      {
         return this._rememberRegistration;
      }
      
      public function set rememberRegistration(param1:Boolean) : void
      {
         this._rememberRegistration = param1;
         if(!this._rememberRegistration)
         {
            this.registrationLog = new Dictionary(true);
         }
      }
      
      public function get constrainScale() : Boolean
      {
         return this._constrainScale;
      }
      
      public function set constrainScale(param1:Boolean) : void
      {
         if(this._constrainScale != param1)
         {
            this._constrainScale = param1;
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get constrainRotation() : Boolean
      {
         return this._constrainRotation;
      }
      
      public function set constrainRotation(param1:Boolean) : void
      {
         if(this._constrainRotation != param1)
         {
            this._constrainRotation = param1;
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get constrainRotationAngle() : Number
      {
         return this._constrainRotationAngle * 180 / Math.PI;
      }
      
      public function set constrainRotationAngle(param1:Number) : void
      {
         var _loc2_:Number = param1 * Math.PI / 180;
         if(this._constrainRotationAngle != _loc2_)
         {
            this._constrainRotationAngle = _loc2_;
            dispatchEvent(new Event(CONTROL_PREFERENCE));
         }
      }
      
      public function get maxScaleX() : Number
      {
         return this._maxScaleX;
      }
      
      public function set maxScaleX(param1:Number) : void
      {
         this._maxScaleX = param1;
      }
      
      public function get maxScaleY() : Number
      {
         return this._maxScaleY;
      }
      
      public function set maxScaleY(param1:Number) : void
      {
         this._maxScaleY = param1;
      }
      
      public function get boundsTopLeft() : Point
      {
         return this._boundsTopLeft.clone();
      }
      
      public function get boundsTop() : Point
      {
         return this._boundsTop.clone();
      }
      
      public function get boundsTopRight() : Point
      {
         return this._boundsTopRight.clone();
      }
      
      public function get boundsRight() : Point
      {
         return this._boundsRight.clone();
      }
      
      public function get boundsBottomRight() : Point
      {
         return this._boundsBottomRight.clone();
      }
      
      public function get boundsBottom() : Point
      {
         return this._boundsBottom.clone();
      }
      
      public function get boundsBottomLeft() : Point
      {
         return this._boundsBottomLeft.clone();
      }
      
      public function get boundsLeft() : Point
      {
         return this._boundsLeft.clone();
      }
      
      public function get boundsCenter() : Point
      {
         return this._boundsCenter.clone();
      }
      
      public function get mouse() : Point
      {
         return new Point(mouseX,mouseY);
      }
      
      public function get moveControl() : TransformToolControl
      {
         return this._moveControl;
      }
      
      public function get registrationControl() : TransformToolControl
      {
         return this._registrationControl;
      }
      
      public function get outlineControl() : TransformToolControl
      {
         return this._outlineControl;
      }
      
      public function get scaleTopLeftControl() : TransformToolControl
      {
         return this._scaleTopLeftControl;
      }
      
      public function get scaleTopControl() : TransformToolControl
      {
         return this._scaleTopControl;
      }
      
      public function get scaleTopRightControl() : TransformToolControl
      {
         return this._scaleTopRightControl;
      }
      
      public function get scaleRightControl() : TransformToolControl
      {
         return this._scaleRightControl;
      }
      
      public function get scaleBottomRightControl() : TransformToolControl
      {
         return this._scaleBottomRightControl;
      }
      
      public function get scaleBottomControl() : TransformToolControl
      {
         return this._scaleBottomControl;
      }
      
      public function get scaleBottomLeftControl() : TransformToolControl
      {
         return this._scaleBottomLeftControl;
      }
      
      public function get scaleLeftControl() : TransformToolControl
      {
         return this._scaleLeftControl;
      }
      
      public function get rotationTopLeftControl() : TransformToolControl
      {
         return this._rotationTopLeftControl;
      }
      
      public function get rotationTopRightControl() : TransformToolControl
      {
         return this._rotationTopRightControl;
      }
      
      public function get rotationBottomRightControl() : TransformToolControl
      {
         return this._rotationBottomRightControl;
      }
      
      public function get rotationBottomLeftControl() : TransformToolControl
      {
         return this._rotationBottomLeftControl;
      }
      
      public function get skewTopControl() : TransformToolControl
      {
         return this._skewTopControl;
      }
      
      public function get skewRightControl() : TransformToolControl
      {
         return this._skewRightControl;
      }
      
      public function get skewBottomControl() : TransformToolControl
      {
         return this._skewBottomControl;
      }
      
      public function get skewLeftControl() : TransformToolControl
      {
         return this._skewLeftControl;
      }
      
      public function get moveCursor() : TransformToolCursor
      {
         return this._moveCursor;
      }
      
      public function get registrationCursor() : TransformToolCursor
      {
         return this._registrationCursor;
      }
      
      public function get rotationCursor() : TransformToolCursor
      {
         return this._rotationCursor;
      }
      
      public function get scaleCursor() : TransformToolCursor
      {
         return this._scaleCursor;
      }
      
      public function get skewCursor() : TransformToolCursor
      {
         return this._skewCursor;
      }
      
      override public function toString() : String
      {
         return "[Transform Tool: target=" + String(this._target) + "]";
      }
      
      private function createControls() : void
      {
         this._moveControl = new TransformToolMoveShape("move",this.moveInteraction);
         this._registrationControl = new TransformToolRegistrationControl(REGISTRATION,this.registrationInteraction,"registration");
         this._rotationTopLeftControl = new TransformToolRotateControl(ROTATION_TOP_LEFT,this.rotationInteraction,"boundsTopLeft");
         this._rotationTopRightControl = new TransformToolRotateControl(ROTATION_TOP_RIGHT,this.rotationInteraction,"boundsTopRight");
         this._rotationBottomRightControl = new TransformToolRotateControl(ROTATION_BOTTOM_RIGHT,this.rotationInteraction,"boundsBottomRight");
         this._rotationBottomLeftControl = new TransformToolRotateControl(ROTATION_BOTTOM_LEFT,this.rotationInteraction,"boundsBottomLeft");
         this._scaleTopLeftControl = new TransformToolScaleControl(SCALE_TOP_LEFT,this.scaleBothInteraction,"boundsTopLeft");
         this._scaleTopControl = new TransformToolScaleControl(SCALE_TOP,this.scaleYInteraction,"boundsTop");
         this._scaleTopRightControl = new TransformToolScaleControl(SCALE_TOP_RIGHT,this.scaleBothInteraction,"boundsTopRight");
         this._scaleRightControl = new TransformToolScaleControl(SCALE_RIGHT,this.scaleXInteraction,"boundsRight");
         this._scaleBottomRightControl = new TransformToolScaleControl(SCALE_BOTTOM_RIGHT,this.scaleBothInteraction,"boundsBottomRight");
         this._scaleBottomControl = new TransformToolScaleControl(SCALE_BOTTOM,this.scaleYInteraction,"boundsBottom");
         this._scaleBottomLeftControl = new TransformToolScaleControl(SCALE_BOTTOM_LEFT,this.scaleBothInteraction,"boundsBottomLeft");
         this._scaleLeftControl = new TransformToolScaleControl(SCALE_LEFT,this.scaleXInteraction,"boundsLeft");
         this._skewTopControl = new TransformToolSkewBar(SKEW_TOP,this.skewXInteraction,"boundsTopRight","boundsTopLeft","boundsTopRight");
         this._skewRightControl = new TransformToolSkewBar(SKEW_RIGHT,this.skewYInteraction,"boundsBottomRight","boundsTopRight","boundsBottomRight");
         this._skewBottomControl = new TransformToolSkewBar(SKEW_BOTTOM,this.skewXInteraction,"boundsBottomLeft","boundsBottomRight","boundsBottomLeft");
         this._skewLeftControl = new TransformToolSkewBar(SKEW_LEFT,this.skewYInteraction,"boundsTopLeft","boundsBottomLeft","boundsTopLeft");
         this._moveCursor = new TransformToolMoveCursor();
         this._moveCursor.addReference(this._moveControl);
         this._registrationCursor = new TransformToolRegistrationCursor();
         this._registrationCursor.addReference(this._registrationControl);
         this._rotationCursor = new TransformToolRotateCursor();
         this._rotationCursor.addReference(this._rotationTopLeftControl);
         this._rotationCursor.addReference(this._rotationTopRightControl);
         this._rotationCursor.addReference(this._rotationBottomRightControl);
         this._rotationCursor.addReference(this._rotationBottomLeftControl);
         this._scaleCursor = new TransformToolScaleCursor();
         this._scaleCursor.addReference(this._scaleTopLeftControl);
         this._scaleCursor.addReference(this._scaleTopControl);
         this._scaleCursor.addReference(this._scaleTopRightControl);
         this._scaleCursor.addReference(this._scaleRightControl);
         this._scaleCursor.addReference(this._scaleBottomRightControl);
         this._scaleCursor.addReference(this._scaleBottomControl);
         this._scaleCursor.addReference(this._scaleBottomLeftControl);
         this._scaleCursor.addReference(this._scaleLeftControl);
         this._skewCursor = new TransformToolSkewCursor();
         this._skewCursor.addReference(this._skewTopControl);
         this._skewCursor.addReference(this._skewRightControl);
         this._skewCursor.addReference(this._skewBottomControl);
         this._skewCursor.addReference(this._skewLeftControl);
         this.addToolControl(this.moveControls,this._moveControl);
         this.addToolControl(this.registrationControls,this._registrationControl);
         this.addToolControl(this.rotateControls,this._rotationTopLeftControl);
         this.addToolControl(this.rotateControls,this._rotationTopRightControl);
         this.addToolControl(this.rotateControls,this._rotationBottomRightControl);
         this.addToolControl(this.rotateControls,this._rotationBottomLeftControl);
         this.addToolControl(this.scaleControls,this._scaleTopControl);
         this.addToolControl(this.scaleControls,this._scaleRightControl);
         this.addToolControl(this.scaleControls,this._scaleBottomControl);
         this.addToolControl(this.scaleControls,this._scaleLeftControl);
         this.addToolControl(this.scaleControls,this._scaleTopLeftControl);
         this.addToolControl(this.scaleControls,this._scaleTopRightControl);
         this.addToolControl(this.scaleControls,this._scaleBottomRightControl);
         this.addToolControl(this.scaleControls,this._scaleBottomLeftControl);
         this.addToolControl(this.skewControls,this._skewTopControl);
         this.addToolControl(this.skewControls,this._skewRightControl);
         this.addToolControl(this.skewControls,this._skewBottomControl);
         this.addToolControl(this.skewControls,this._skewLeftControl);
         this.addToolControl(this.lines,new TransformToolOutline("outline"),false);
         this.addToolControl(this.cursors,this._moveCursor,false);
         this.addToolControl(this.cursors,this._registrationCursor,false);
         this.addToolControl(this.cursors,this._rotationCursor,false);
         this.addToolControl(this.cursors,this._scaleCursor,false);
         this.addToolControl(this.cursors,this._skewCursor,false);
         this.updateControlsEnabled();
      }
      
      private function addToolControl(param1:Sprite, param2:TransformToolControl, param3:Boolean = true) : void
      {
         param2.transformTool = this;
         if(param3)
         {
            param2.addEventListener(MouseEvent.MOUSE_DOWN,this.startInteractionHandler);
         }
         param1.addChild(param2);
         param2.dispatchEvent(new Event(CONTROL_INIT));
      }
      
      public function addControl(param1:TransformToolControl) : void
      {
         this.addToolControl(this.customControls,param1);
      }
      
      public function removeControl(param1:TransformToolControl) : TransformToolControl
      {
         if(this.customControls.contains(param1))
         {
            this.customControls.removeChild(param1);
            return param1;
         }
         return null;
      }
      
      public function addCursor(param1:TransformToolCursor) : void
      {
         this.addToolControl(this.customCursors,param1);
      }
      
      public function removeCursor(param1:TransformToolCursor) : TransformToolCursor
      {
         if(this.customCursors.contains(param1))
         {
            this.customCursors.removeChild(param1);
            return param1;
         }
         return null;
      }
      
      public function setSkin(param1:String, param2:DisplayObject) : void
      {
         var _loc3_:TransformToolInternalControl = this.getControlByName(param1);
         if(_loc3_)
         {
            _loc3_.skin = param2;
         }
      }
      
      public function getSkin(param1:String) : DisplayObject
      {
         var _loc2_:TransformToolInternalControl = this.getControlByName(param1);
         return _loc2_.skin;
      }
      
      private function getControlByName(param1:String) : TransformToolInternalControl
      {
         var _loc2_:TransformToolInternalControl = null;
         var _loc3_:Array = new Array(this.skewControls,this.registrationControls,this.cursors,this.rotateControls,this.scaleControls);
         var _loc4_:int = int(_loc3_.length);
         while(Boolean(_loc4_--) && _loc2_ == null)
         {
            _loc2_ = _loc3_[_loc4_].getChildByName(param1) as TransformToolInternalControl;
         }
         return _loc2_;
      }
      
      private function startInteractionHandler(param1:MouseEvent) : void
      {
         this._currentControl = param1.currentTarget as TransformToolControl;
         if(this._currentControl)
         {
            this.setupInteraction();
         }
      }
      
      private function setupInteraction() : void
      {
         this.updateMatrix();
         this.apply();
         dispatchEvent(new Event(CONTROL_DOWN));
         this.mouseOffset = Boolean(this._currentControl) && Boolean(this._currentControl.referencePoint) ? this._currentControl.referencePoint.subtract(new Point(mouseX,mouseY)) : new Point(0,0);
         this.updateMouse();
         this.interactionStart = this.mouseLoc.clone();
         this.innerInteractionStart = this.innerMouseLoc.clone();
         this.interactionStartMatrix = this._toolMatrix.clone();
         this.interactionStartAngle = this.distortAngle();
         if(stage)
         {
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this.interactionHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP,this.endInteractionHandler,false);
            stage.addEventListener(MouseEvent.MOUSE_UP,this.endInteractionHandler,true);
         }
      }
      
      private function interactionHandler(param1:MouseEvent) : void
      {
         this.updateMouse();
         this._toolMatrix = this.interactionStartMatrix.clone();
         dispatchEvent(new Event(CONTROL_MOVE));
         dispatchEvent(new Event(CONTROL_TRANSFORM_TOOL));
         if(this._livePreview)
         {
            this.apply();
         }
         param1.updateAfterEvent();
      }
      
      private function endInteractionHandler(param1:MouseEvent) : void
      {
         if(param1.eventPhase == EventPhase.BUBBLING_PHASE || !(param1.currentTarget is Stage))
         {
            return;
         }
         if(!this._livePreview)
         {
            this.apply();
         }
         var _loc2_:Stage = param1.currentTarget as Stage;
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,this.interactionHandler);
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,this.endInteractionHandler,false);
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,this.endInteractionHandler,true);
         dispatchEvent(new Event(CONTROL_UP));
         this._currentControl = null;
      }
      
      public function moveInteraction() : void
      {
         var _loc1_:Point = this.mouseLoc.subtract(this.interactionStart);
         this._toolMatrix.tx += _loc1_.x;
         this._toolMatrix.ty += _loc1_.y;
         this.updateRegistration();
         this.completeInteraction();
      }
      
      public function registrationInteraction() : void
      {
         this._registration.x = this.mouseLoc.x;
         this._registration.y = this.mouseLoc.y;
         this.innerRegistration = this.toolInvertedMatrix.transformPoint(this._registration);
         if(this._rememberRegistration)
         {
            this.registrationLog[this._target] = this.innerRegistration;
         }
         this.completeInteraction();
      }
      
      public function rotationInteraction() : void
      {
         var _loc1_:Matrix = transform.concatenatedMatrix;
         var _loc2_:Matrix = _loc1_.clone();
         _loc2_.invert();
         this._toolMatrix.concat(_loc1_);
         var _loc3_:Number = this.distortAngle() - this.interactionStartAngle;
         if(this._constrainRotation)
         {
            if(_loc3_ > Math.PI)
            {
               _loc3_ -= Math.PI * 2;
            }
            else if(_loc3_ < -Math.PI)
            {
               _loc3_ += Math.PI * 2;
            }
            _loc3_ = Math.round(_loc3_ / this._constrainRotationAngle) * this._constrainRotationAngle;
         }
         this._toolMatrix.rotate(_loc3_);
         this._toolMatrix.concat(_loc2_);
         this.completeInteraction(true);
      }
      
      public function scaleXInteraction() : void
      {
         var _loc1_:Point = this.distortOffset(new Point(this.innerMouseLoc.x,this.innerInteractionStart.y),this.innerInteractionStart.x - this.innerRegistration.x);
         this._toolMatrix.a += _loc1_.x;
         this._toolMatrix.b += _loc1_.y;
         this.completeInteraction(true);
      }
      
      public function scaleYInteraction() : void
      {
         var _loc1_:Point = this.distortOffset(new Point(this.innerInteractionStart.x,this.innerMouseLoc.y),this.innerInteractionStart.y - this.innerRegistration.y);
         this._toolMatrix.c += _loc1_.x;
         this._toolMatrix.d += _loc1_.y;
         this.completeInteraction(true);
      }
      
      public function scaleBothInteraction() : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc1_:Point = this.innerMouseLoc.clone();
         if(this._constrainScale)
         {
            _loc4_ = this.innerMouseLoc.subtract(this.innerInteractionStart);
            _loc5_ = this.innerInteractionStart.subtract(this.innerRegistration);
            _loc6_ = !!_loc5_.x ? _loc4_.x / _loc5_.x : 0;
            _loc7_ = !!_loc5_.y ? _loc4_.y / _loc5_.y : 0;
            if(_loc6_ > _loc7_)
            {
               _loc1_.x = this.innerInteractionStart.x + _loc5_.x * _loc7_;
            }
            else
            {
               _loc1_.y = this.innerInteractionStart.y + _loc5_.y * _loc6_;
            }
         }
         var _loc2_:Point = this.distortOffset(new Point(_loc1_.x,this.innerInteractionStart.y),this.innerInteractionStart.x - this.innerRegistration.x);
         var _loc3_:Point = this.distortOffset(new Point(this.innerInteractionStart.x,_loc1_.y),this.innerInteractionStart.y - this.innerRegistration.y);
         this._toolMatrix.a += _loc2_.x;
         this._toolMatrix.b += _loc2_.y;
         this._toolMatrix.c += _loc3_.x;
         this._toolMatrix.d += _loc3_.y;
         this.completeInteraction(true);
      }
      
      public function skewXInteraction() : void
      {
         var _loc1_:Point = this.distortOffset(new Point(this.innerMouseLoc.x,this.innerInteractionStart.y),this.innerInteractionStart.y - this.innerRegistration.y);
         this._toolMatrix.c += _loc1_.x;
         this._toolMatrix.d += _loc1_.y;
         this.completeInteraction(true);
      }
      
      public function skewYInteraction() : void
      {
         var _loc1_:Point = this.distortOffset(new Point(this.innerInteractionStart.x,this.innerMouseLoc.y),this.innerInteractionStart.x - this.innerRegistration.x);
         this._toolMatrix.a += _loc1_.x;
         this._toolMatrix.b += _loc1_.y;
         this.completeInteraction(true);
      }
      
      private function distortOffset(param1:Point, param2:Number) : Point
      {
         var _loc3_:Number = !!param2 ? this.targetBounds.width / param2 : 0;
         var _loc4_:Number = !!param2 ? this.targetBounds.height / param2 : 0;
         param1 = this.interactionStartMatrix.transformPoint(param1).subtract(this.interactionStart);
         param1.x *= !!this.targetBounds.width ? _loc3_ / this.targetBounds.width : 0;
         param1.y *= !!this.targetBounds.height ? _loc4_ / this.targetBounds.height : 0;
         return param1;
      }
      
      private function completeInteraction(param1:Boolean = false) : void
      {
         var _loc2_:Point = null;
         this.enforceLimits();
         if(param1)
         {
            _loc2_ = this._registration.subtract(this._toolMatrix.transformPoint(this.innerRegistration));
            this._toolMatrix.tx += _loc2_.x;
            this._toolMatrix.ty += _loc2_.y;
         }
         this.updateBounds();
      }
      
      private function distortAngle() : Number
      {
         var _loc1_:Matrix = transform.concatenatedMatrix;
         var _loc2_:Point = _loc1_.transformPoint(this.mouseLoc);
         var _loc3_:Point = _loc1_.transformPoint(this._registration);
         var _loc4_:Point = _loc2_.subtract(_loc3_);
         return Math.atan2(_loc4_.y,_loc4_.x);
      }
      
      private function updateMouse() : void
      {
         this.mouseLoc = new Point(mouseX,mouseY).add(this.mouseOffset);
         this.innerMouseLoc = this.toolInvertedMatrix.transformPoint(this.mouseLoc);
      }
      
      private function updateMatrix(param1:Matrix = null, param2:Boolean = true) : void
      {
         var _loc3_:Matrix = null;
         if(this._target)
         {
            this._toolMatrix = !!param1 ? param1.clone() : this._target.transform.concatenatedMatrix.clone();
            if(param2)
            {
               _loc3_ = transform.concatenatedMatrix;
               _loc3_.invert();
               this._toolMatrix.concat(_loc3_);
            }
            this.enforceLimits();
            this.toolInvertedMatrix = this._toolMatrix.clone();
            this.toolInvertedMatrix.invert();
            this.updateBounds();
         }
      }
      
      private function updateBounds() : void
      {
         if(this._target)
         {
            this.targetBounds = this._target.getBounds(this._target);
            this._boundsTopLeft = this._toolMatrix.transformPoint(new Point(this.targetBounds.left,this.targetBounds.top));
            this._boundsTopRight = this._toolMatrix.transformPoint(new Point(this.targetBounds.right,this.targetBounds.top));
            this._boundsBottomRight = this._toolMatrix.transformPoint(new Point(this.targetBounds.right,this.targetBounds.bottom));
            this._boundsBottomLeft = this._toolMatrix.transformPoint(new Point(this.targetBounds.left,this.targetBounds.bottom));
            this._boundsTop = Point.interpolate(this._boundsTopLeft,this._boundsTopRight,0.5);
            this._boundsRight = Point.interpolate(this._boundsTopRight,this._boundsBottomRight,0.5);
            this._boundsBottom = Point.interpolate(this._boundsBottomRight,this._boundsBottomLeft,0.5);
            this._boundsLeft = Point.interpolate(this._boundsBottomLeft,this._boundsTopLeft,0.5);
            this._boundsCenter = Point.interpolate(this._boundsTopLeft,this._boundsBottomRight,0.5);
         }
      }
      
      private function updateControlsVisible() : void
      {
         var _loc1_:Boolean = contains(this.toolSprites);
         if(this._target)
         {
            if(!_loc1_)
            {
               addChild(this.toolSprites);
            }
         }
         else if(_loc1_)
         {
            removeChild(this.toolSprites);
         }
      }
      
      private function updateControlsEnabled() : void
      {
         this.updateControlContainer(this.customCursors,this._customCursorsEnabled);
         this.updateControlContainer(this.cursors,this._cursorsEnabled);
         this.updateControlContainer(this.customControls,this._customControlsEnabled);
         this.updateControlContainer(this.registrationControls,this._registrationEnabled);
         this.updateControlContainer(this.scaleControls,this._scaleEnabled);
         this.updateControlContainer(this.skewControls,this._skewEnabled);
         this.updateControlContainer(this.moveControls,this._moveEnabled);
         this.updateControlContainer(this.rotateControls,this._rotationEnabled);
         this.updateControlContainer(this.lines,this._outlineEnabled);
      }
      
      private function updateControlContainer(param1:Sprite, param2:Boolean) : void
      {
         var _loc3_:Boolean = this.toolSprites.contains(param1);
         if(param2)
         {
            if(_loc3_)
            {
               this.toolSprites.setChildIndex(param1,0);
            }
            else
            {
               this.toolSprites.addChildAt(param1,0);
            }
         }
         else if(_loc3_)
         {
            this.toolSprites.removeChild(param1);
         }
      }
      
      private function updateRegistration() : void
      {
         this._registration = this._toolMatrix.transformPoint(this.innerRegistration);
      }
      
      private function enforceLimits() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:Matrix = null;
         var _loc3_:Boolean = false;
         var _loc4_:Matrix = this._toolMatrix.clone();
         _loc4_.concat(transform.concatenatedMatrix);
         _loc1_ = Math.sqrt(_loc4_.a * _loc4_.a + _loc4_.b * _loc4_.b);
         if(_loc1_ > this._maxScaleX)
         {
            _loc2_ = Math.atan2(_loc4_.b,_loc4_.a);
            _loc4_.a = Math.cos(_loc2_) * this._maxScaleX;
            _loc4_.b = Math.sin(_loc2_) * this._maxScaleX;
            _loc3_ = true;
         }
         _loc1_ = Math.sqrt(_loc4_.c * _loc4_.c + _loc4_.d * _loc4_.d);
         if(_loc1_ > this._maxScaleY)
         {
            _loc2_ = Math.atan2(_loc4_.c,_loc4_.d);
            _loc4_.d = Math.cos(_loc2_) * this._maxScaleY;
            _loc4_.c = Math.sin(_loc2_) * this._maxScaleY;
            _loc3_ = true;
         }
         if(_loc3_)
         {
            this._toolMatrix = _loc4_;
            _loc5_ = transform.concatenatedMatrix;
            _loc5_.invert();
            this._toolMatrix.concat(_loc5_);
         }
      }
      
      private function setNewRegistation() : void
      {
         var _loc1_:Point = null;
         if(this._rememberRegistration && this._target in this.registrationLog)
         {
            _loc1_ = this.registrationLog[this._target];
            this.innerRegistration = this.registrationLog[this._target];
         }
         else
         {
            this.innerRegistration = new Point(0,0);
         }
         this.updateRegistration();
      }
      
      private function raiseTarget() : void
      {
         var _loc1_:int = this._target.parent.numChildren - 1;
         this._target.parent.setChildIndex(this._target,_loc1_);
         if(this._target.parent == parent)
         {
            parent.setChildIndex(this,_loc1_);
         }
      }
      
      public function draw() : void
      {
         this.updateMatrix();
         dispatchEvent(new Event(TRANSFORM_TOOL));
      }
      
      public function apply() : void
      {
         var _loc1_:Matrix = null;
         var _loc2_:Matrix = null;
         if(this._target)
         {
            _loc1_ = this._toolMatrix.clone();
            _loc1_.concat(transform.concatenatedMatrix);
            if(this._target.parent)
            {
               _loc2_ = this.target.parent.transform.concatenatedMatrix;
               _loc2_.invert();
               _loc1_.concat(_loc2_);
            }
            this._target.transform.matrix = _loc1_;
            dispatchEvent(new Event(TRANSFORM_TARGET));
         }
      }
   }
}

