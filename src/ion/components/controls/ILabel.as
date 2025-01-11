package ion.components.controls
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import ion.components.core.IComponentCore;
   
   public class ILabel extends IComponentCore
   {
      private static var _font:String;
      
      private static var _size:int = 10;
      
      private static var _color:int = 0;
      
      private static var _embedFonts:Boolean = false;
      
      private var _label:String = "";
      
      private var _exactFit:Boolean = false;
      
      private var _editable:Boolean = false;
      
      private var maskRectangle:Rectangle;
      
      private var txt:TextField;
      
      private var ownFormat:TextFormat;
      
      public function ILabel(param1:int = 100, param2:int = 22)
      {
         super(param1,param2);
         this.txt = new TextField();
         this.maskRectangle = new Rectangle();
         this.ownFormat = new TextFormat(_font,_size,_color);
         this.txt.embedFonts = _embedFonts;
         this.txt.mouseEnabled = false;
         this.txt.selectable = false;
         this.txt.autoSize = TextFieldAutoSize.LEFT;
         this.styleDefinition();
         addChild(this.txt);
      }
      
      public static function setDefaultStyle(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:* = undefined;
         _font = param1;
         _size = param2;
         _color = param3;
         _embedFonts = true;
         for(_loc4_ in _instances)
         {
            if(_loc4_ is ILabel)
            {
               _loc4_.ownFormat.font = _font;
               _loc4_.ownFormat.size = _size;
               _loc4_.ownFormat.color = _color;
               _loc4_.txt.embedFonts = _embedFonts;
               _loc4_.styleDefinition();
            }
         }
      }
      
      private function styleDefinition() : void
      {
         this.txt.text = this._label == "" ? " " : this._label;
         this.txt.setTextFormat(this.ownFormat);
         this.updateMask();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function updateMask() : void
      {
         this.maskRectangle.width = this.width;
         this.maskRectangle.height = this.height;
         this.txt.scrollRect = this.maskRectangle;
      }
      
      private function txtChange(param1:Event) : void
      {
         this.label = this.txt.text;
      }
      
      override public function set focus(param1:Boolean) : void
      {
         if(stage == null)
         {
            return;
         }
         if(param1)
         {
            stage.focus = this.txt;
         }
         else
         {
            stage.focus = null;
         }
      }
      
      override public function get focus() : Boolean
      {
         if(stage == null)
         {
            return false;
         }
         return stage.focus == this.txt;
      }
      
      public function set editable(param1:Boolean) : void
      {
         this._editable = param1;
         if(param1)
         {
            this.txt.type = TextFieldType.INPUT;
            this.txt.selectable = true;
            this.txt.mouseEnabled = true;
            this.txt.addEventListener(Event.CHANGE,this.txtChange);
         }
         else
         {
            this.txt.type = TextFieldType.DYNAMIC;
            this.txt.selectable = false;
            this.txt.mouseEnabled = false;
            this.txt.removeEventListener(Event.CHANGE,this.txtChange);
         }
      }
      
      public function get editable() : Boolean
      {
         return this._editable;
      }
      
      public function set font(param1:String) : void
      {
         this.ownFormat.font = param1;
         this.txt.embedFonts = _embedFonts;
         this.styleDefinition();
      }
      
      public function get font() : String
      {
         return this.ownFormat.font;
      }
      
      public function set size(param1:int) : void
      {
         this.ownFormat.size = param1;
         this.styleDefinition();
      }
      
      public function get size() : int
      {
         return this.ownFormat.size as int;
      }
      
      public function set color(param1:int) : void
      {
         this.ownFormat.color = param1;
         this.styleDefinition();
      }
      
      public function get color() : int
      {
         return this.ownFormat.color as int;
      }
      
      public function set label(param1:*) : void
      {
         if(param1 == null || param1 == undefined)
         {
            this._label = "";
         }
         else
         {
            this._label = param1.toString();
         }
         this.styleDefinition();
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this.txt.selectable = param1;
         this.txt.mouseEnabled = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this.txt.selectable;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         this.txt.multiline = this.txt.wordWrap = param1;
         this.updateMask();
      }
      
      public function get multiline() : Boolean
      {
         return this.txt.multiline;
      }
      
      public function set exactFit(param1:Boolean) : void
      {
         this._exactFit = param1;
         this.updateMask();
      }
      
      public function get exactFit() : Boolean
      {
         return this._exactFit;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this.txt.width = _width;
         this.updateMask();
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this.txt.height = _height;
         this.updateMask();
      }
      
      override public function get width() : Number
      {
         if(this._label == "")
         {
            return 0;
         }
         if(this._exactFit)
         {
            return Math.floor(this.txt.textWidth + 4);
         }
         return _width;
      }
      
      override public function get height() : Number
      {
         if(this._label == "")
         {
            return 0;
         }
         if(this._exactFit)
         {
            return Math.floor(this.txt.textHeight + 4);
         }
         return _height;
      }
   }
}

