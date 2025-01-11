package maplestory.display.maple
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import ion.utils.SingleList;
   import maplestory.events.AssetEvent;
   import maplestory.struct.DepthList;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.ResourceCache;
   
   public class AssetMapleMotion extends AssetMaple
   {
      protected var _state:String;
      
      protected var _frame:int;
      
      protected var _animate:Timer;
      
      protected var zigzagMult:int;
      
      public function AssetMapleMotion()
      {
         super();
         this._animate = new Timer(1);
         this.zigzagMult = 1;
         this._animate.addEventListener(TimerEvent.TIMER,this.loopAnimate);
      }
      
      override public function remove(param1:String) : void
      {
         var urlID:String = param1;
         super.remove(urlID);
         if(structure.*.(@name == _state).*[this._frame] == undefined)
         {
            this._frame = -1;
         }
         if(structure.*.(@name == _state)[0] == undefined)
         {
            this._state = null;
         }
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function extractStates() : Array
      {
         var _loc5_:Array = null;
         var _loc6_:XML = null;
         var _loc7_:* = undefined;
         var _loc1_:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         var _loc2_:XMLList = structure.*;
         var _loc3_:int = int(_loc2_.length());
         var _loc4_:Array = [];
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc6_ = <i/>;
            _loc6_.appendChild(_loc2_[_loc8_].copy());
            _loc5_ = SingleList.singleXMLList(_loc6_.*.*.*.@url);
            while(_loc5_.length > 0)
            {
               ResourceCache.updateResourceUsage(_loc5_.shift(),1);
            }
            _loc7_ = new _loc1_();
            this.cloneCommonProperties(_loc7_);
            _loc7_.structure = _loc6_;
            _loc7_.state = _loc6_.*[0].@name;
            _loc7_.frame = 0;
            _loc7_.draw();
            _loc4_.push(_loc7_);
            _loc8_++;
         }
         return _loc4_;
      }
      
      public function extractFrames() : Array
      {
         var thisClass:Class = null;
         var li:XMLList = null;
         var len:int = 0;
         var ret:Array = null;
         var arr:Array = null;
         var xst:XML = null;
         var xml:XML = null;
         var ch:* = undefined;
         var i:int = 0;
         thisClass = getDefinitionByName(getQualifiedClassName(this)) as Class;
         li = structure.*.(@name == _state).*;
         len = int(li.length());
         ret = [];
         i = 0;
         while(i < len)
         {
            xml = <i/>;
            xst = <i/>;
            copyAttributes(li[i].parent(),xst);
            xst.appendChild(li[i].copy());
            xml.appendChild(xst);
            arr = SingleList.singleXMLList(xml.*.*.*.@url);
            while(arr.length > 0)
            {
               ResourceCache.updateResourceUsage(arr.shift(),1);
            }
            ch = new thisClass();
            this.cloneCommonProperties(ch);
            ch.structure = xml;
            ch.state = xml.*[0].@name;
            ch.frame = 0;
            ch.draw();
            ret.push(ch);
            i++;
         }
         return ret;
      }
      
      public function clone() : *
      {
         var _loc1_:XML = structure.copy();
         var _loc2_:Array = SingleList.singleXMLList(_loc1_.*.*.*.@url);
         var _loc3_:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         var _loc4_:* = new _loc3_();
         while(_loc2_.length > 0)
         {
            ResourceCache.updateResourceUsage(_loc2_.shift(),1);
         }
         this.cloneCommonProperties(_loc4_);
         _loc4_.structure = _loc1_;
         _loc4_.draw();
         return _loc4_;
      }
      
      public function getFrameImages(param1:int = -1) : Array
      {
         var previousFrame:int = 0;
         var maxFrames:int = 0;
         var i:int = 0;
         var maxW:int = 0;
         var maxH:int = 0;
         var dx:int = 0;
         var dy:int = 0;
         var union:Rectangle = null;
         var rec:Rectangle = null;
         var xst:XML = null;
         var isZigZag:Boolean = false;
         var bd:BitmapData = null;
         var mat:Matrix = null;
         var arr:Array = null;
         var bgColor:int = param1;
         previousFrame = this.frame;
         maxFrames = this.maxFrames;
         maxW = 0;
         maxH = 0;
         dx = 65535;
         dy = 65535;
         xst = structure.*.(@name == _state)[0];
         if(xst == null)
         {
            return null;
         }
         if(this.parent == null)
         {
            return null;
         }
         isZigZag = String(xst.@zigzag) == "1" || this._state == "stand1" || this._state == "stand2" || this._state == "alert";
         this.frame = 0;
         union = this.getBounds(this.parent);
         i = 0;
         while(i < maxFrames)
         {
            this.frame = i;
            rec = this.getBounds(this.parent);
            union = union.union(rec);
            if(union.width > maxW)
            {
               maxW = union.width;
            }
            if(union.height > maxH)
            {
               maxH = union.height;
            }
            if(rec.x < dx)
            {
               dx = rec.x;
            }
            if(rec.y < dy)
            {
               dy = rec.y;
            }
            i++;
         }
         dx = this.x - dx;
         dy = this.y - dy;
         if(maxW <= 0 || maxH <= 0)
         {
            return null;
         }
         arr = [];
         i = 0;
         while(i < maxFrames)
         {
            this.frame = i;
            mat = this.transform.matrix.clone();
            bd = new BitmapData(maxW,maxH,bgColor <= -1,bgColor <= -1 ? 0 : uint(bgColor));
            mat.tx = dx;
            mat.ty = dy;
            bd.draw(this,mat);
            arr.push({
               "image":bd,
               "delay":this.activeDelay,
               "x":-dx,
               "y":-dy
            });
            i++;
         }
         if(isZigZag && maxFrames - 2 > 0)
         {
            i = maxFrames - 2;
            while(i >= 0)
            {
               arr.push({
                  "image":arr[i].image.clone(),
                  "delay":arr[i].delay,
                  "x":arr[i].x,
                  "y":arr[i].y
               });
               i--;
            }
         }
         this.frame = previousFrame;
         return arr;
      }
      
      public function visibleItem(param1:String, param2:Boolean) : void
      {
         var li:XMLList = null;
         var len:int = 0;
         var i:int = 0;
         var urlID:String = param1;
         var value:Boolean = param2;
         li = structure.*.*.*.(@url == urlID);
         len = int(li.length());
         i = 0;
         while(i < len)
         {
            li[i].@v = value ? "1" : "0";
            i++;
         }
         if(len > 0)
         {
            this.draw();
            this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
         }
      }
      
      public function getRawData() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:Object = {};
         XML.prettyPrinting = false;
         _loc2_.structure = structure.toXMLString();
         XML.prettyPrinting = true;
         this.cloneCommonProperties(_loc2_);
         _loc1_.writeObject(_loc2_);
         _loc1_.compress();
         return _loc1_;
      }
      
      override public function setProperties(param1:AssetProperties) : void
      {
         super.setProperties(param1);
         this._state = param1.state;
         this._frame = param1.frame;
         this.animate = param1.animate;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      protected function loopAnimate(param1:TimerEvent = null) : void
      {
         this.moveFrame();
      }
      
      protected function moveFrame() : void
      {
         var xst:XML = null;
         var zigzag:Boolean = false;
         xst = structure.*.(@name == _state)[0];
         if(xst == null || this._frame < 0)
         {
            return;
         }
         zigzag = String(xst.@zigzag) == "1";
         if(zigzag)
         {
            if(xst.*[this._frame + this.zigzagMult] == undefined)
            {
               this.zigzagMult *= -1;
            }
            this._frame += this.zigzagMult;
         }
         else if(xst.*[this._frame + 1] == undefined)
         {
            this._frame = 0;
         }
         else
         {
            this._frame += 1;
         }
         this.draw();
         this._animate.delay = Math.max(this.activeDelay,1);
         this.dispatchEvent(new Event(AssetEvent.FRAME_CHANGE));
      }
      
      override protected function draw() : void
      {
         var xfr:XML = null;
         var li:XMLList = null;
         var len:int = 0;
         var sortArr:Array = null;
         var ch:Bitmap = null;
         var node:XML = null;
         var i:int = 0;
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         if(this.frame < 0)
         {
            return;
         }
         xfr = structure.*.(@name == _state).*[this._frame];
         if(xfr == null)
         {
            return;
         }
         li = xfr.*;
         len = int(li.length());
         sortArr = [];
         if(len <= 0)
         {
            return;
         }
         i = 0;
         while(i < len)
         {
            node = li[i];
            ch = new Bitmap(ResourceCache.getBitmapData(node.@url,node.@image,node.@c));
            ch.x = parseInt(node.@x);
            ch.y = parseInt(node.@y);
            ch.visible = String(node.@v) == "1";
            ch.name = String(node.@image);
            ch.smoothing = !_pixelated;
            if(itemColorMatrixCache[node.@url] != undefined)
            {
               ch.filters = [new ColorMatrixFilter(itemColorMatrixCache[node.@url].matrix)];
            }
            sortArr.push({
               "image":ch,
               "z":parseInt(node.@z)
            });
            i++;
         }
         sortArr.sortOn("z",Array.NUMERIC);
         i = 0;
         while(i < len)
         {
            this.addChildAt(sortArr[i].image,0);
            i++;
         }
      }
      
      protected function calculateDelay(param1:XMLList) : String
      {
         var _loc2_:int = parseInt(param1[0]);
         if(isNaN(_loc2_) || _loc2_ < 1)
         {
            return "100";
         }
         return String(param1);
      }
      
      override protected function cloneCommonProperties(param1:*) : void
      {
         super.cloneCommonProperties(param1);
         param1.animate = this.animate;
         param1.state = this.state;
         param1.frame = this.frame;
      }
      
      override protected function processPak(param1:String, param2:String) : void
      {
         var arrPath:Array = null;
         var fr:String = null;
         var st:String = null;
         var node:XML = null;
         var i:int = 0;
         var xst:XML = null;
         var xfr:XML = null;
         var xno:XML = null;
         var zigzag:String = null;
         var delay:String = null;
         var image:String = null;
         var xx:String = null;
         var yy:String = null;
         var zz:String = null;
         var urlID:String = param1;
         var urlClient:String = param2;
         var data:XML = ResourceCache.getXML(urlID,urlClient);
         var list:XMLList = data.*;
         var len:int = int(list.length());
         var cc:String = data.@client;
         i = 0;
         while(i < len)
         {
            node = list[i];
            arrPath = String(node.@path).split(".");
            fr = arrPath.pop();
            st = arrPath.join(".");
            this._state = this._state == null ? st : this._state;
            this._frame = this._frame < 0 ? 0 : this._frame;
            zigzag = String(node.@zigzag) == "1" ? "1" : "0";
            delay = this.calculateDelay(node.@delay);
            image = String(node.@image);
            xx = String(node.@x);
            yy = String(node.@y);
            zz = String(DepthList.getValue(node.@z));
            xst = structure.*.(@name == st)[0];
            if(xst == null)
            {
               xst = <i name={st} zigzag={zigzag}/>;
               structure.appendChild(xst);
            }
            xfr = xst.*.(@name == fr)[0];
            if(xfr == null)
            {
               xfr = <i name={fr} delay={delay}/>;
               xst.appendChild(xfr);
            }
            xno = xfr.*.(@image == image && @url == urlID)[0];
            if(xno == null)
            {
               xno = <i url={urlID} image={image} v="1" x={xx} y={yy} z={zz} c={cc}/>;
               xfr.appendChild(xno);
            }
            i++;
         }
      }
      
      override protected function destroy() : void
      {
         this._animate.stop();
         this._animate.removeEventListener(TimerEvent.TIMER,this.loopAnimate);
         this._animate = null;
         this._state = null;
         this._frame = -1;
         super.destroy();
      }
      
      public function get maxFrames() : int
      {
         var node:XML = null;
         node = structure.*.(@name == _state)[0];
         if(node != null)
         {
            return node.*.length();
         }
         return 0;
      }
      
      public function get activeDelay() : int
      {
         var xfr:XML = null;
         xfr = structure.*.(@name == _state).*[this._frame];
         if(xfr == null)
         {
            return 0;
         }
         return parseInt(xfr.@delay);
      }
      
      public function get states() : Array
      {
         var _loc1_:XMLList = structure.*;
         var _loc2_:int = int(_loc1_.length());
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc1_[_loc4_].*.length() > 0)
            {
               _loc3_.push(String(_loc1_[_loc4_].@name));
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function set state(param1:String) : void
      {
         var xfr:XML = null;
         var val:String = param1;
         xfr = structure.*.(@name == val)[0];
         if(xfr == null)
         {
            return;
         }
         this._state = val;
         this.frame = 0;
         this.dispatchEvent(new Event(AssetEvent.STATE_CHANGE));
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set frame(param1:*) : void
      {
         var xfr:XML = null;
         var num:* = param1;
         if(num is String)
         {
            xfr = structure.*.(@name == _state).*.(@name == num)[0];
            if(xfr == null)
            {
               return;
            }
            this._frame = xfr.childIndex();
         }
         else
         {
            if(!(num is Number))
            {
               return;
            }
            xfr = structure.*.(@name == _state).*[num];
            if(xfr == null)
            {
               return;
            }
            this._frame = num;
         }
         this.draw();
         this.animate = this._animate.running;
      }
      
      public function get frame() : int
      {
         return this._frame;
      }
      
      public function set animate(param1:Boolean) : void
      {
         if(param1 && this._animate.running)
         {
            return;
         }
         this._animate.reset();
         this._animate.stop();
         if(param1)
         {
            this._animate.delay = Math.max(this.activeDelay,1);
            this._animate.start();
            this.loopAnimate();
         }
      }
      
      public function get animate() : Boolean
      {
         return this._animate.running;
      }
   }
}

