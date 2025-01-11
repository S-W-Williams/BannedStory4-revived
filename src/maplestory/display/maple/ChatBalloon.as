package maplestory.display.maple
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import ion.utils.SingleList;
   import maplestory.events.AssetEvent;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.ResourceCache;
   
   public class ChatBalloon extends AssetMaple
   {
      private var _tileX:int;
      
      private var _tileY:int;
      
      private var _frame:int;
      
      private var _animate:Timer;
      
      private var arrowInit:int;
      
      private var arrowEnd:int;
      
      private var arrowPercent:Number;
      
      private var balloonX:Boolean;
      
      private var balloonY:Boolean;
      
      private var txt:TextField;
      
      private var format:TextFormat;
      
      private var bitmap:Bitmap;
      
      private var holdA:Sprite;
      
      private var holdB:Sprite;
      
      private var recCenter:Rectangle;
      
      public function ChatBalloon()
      {
         super();
         this.txt = new TextField();
         this.format = new TextFormat("Arial",12,0);
         this._animate = new Timer(1);
         this._tileX = 10;
         this._tileY = 5;
         this.arrowInit = 0;
         this.arrowEnd = 0;
         this.arrowPercent = 0;
         this.balloonX = false;
         this.balloonY = false;
         this.txt.mouseEnabled = false;
         this.txt.selectable = false;
         this.txt.multiline = true;
         this.txt.wordWrap = true;
         this.bitmap = new Bitmap();
         this.holdA = new Sprite();
         this.holdB = new Sprite();
         this._animate.addEventListener(TimerEvent.TIMER,this.loopAnimate);
         this.holdB.addChild(this.holdA);
         this.addChild(this.bitmap);
      }
      
      override public function remove(param1:String) : void
      {
         super.remove(param1);
         if(this.bitmap.bitmapData != null)
         {
            this.bitmap.bitmapData.dispose();
            this.bitmap.bitmapData = null;
         }
         if(structure.*[this._frame] == undefined)
         {
            this._frame = -1;
         }
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function getFrameImages(param1:int = -1) : Array
      {
         var _loc4_:int = 0;
         var _loc9_:Rectangle = null;
         var _loc10_:Rectangle = null;
         var _loc11_:BitmapData = null;
         var _loc12_:Matrix = null;
         var _loc2_:int = this.frame;
         var _loc3_:int = this.maxFrames;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 65535;
         var _loc8_:int = 65535;
         if(this.parent == null)
         {
            return null;
         }
         this.frame = 0;
         _loc9_ = this.getBounds(this.parent);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.frame = _loc4_;
            _loc10_ = this.getBounds(this.parent);
            _loc9_ = _loc9_.union(_loc10_);
            if(_loc9_.width > _loc5_)
            {
               _loc5_ = _loc9_.width;
            }
            if(_loc9_.height > _loc6_)
            {
               _loc6_ = _loc9_.height;
            }
            if(_loc10_.x < _loc7_)
            {
               _loc7_ = _loc10_.x;
            }
            if(_loc10_.y < _loc8_)
            {
               _loc8_ = _loc10_.y;
            }
            _loc4_++;
         }
         _loc7_ = this.x - _loc7_;
         _loc8_ = this.y - _loc8_;
         if(_loc5_ <= 0 || _loc6_ <= 0)
         {
            return null;
         }
         var _loc13_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.frame = _loc4_;
            _loc12_ = this.transform.matrix.clone();
            _loc11_ = new BitmapData(_loc5_,_loc6_,param1 <= -1,param1 <= -1 ? 0 : uint(param1));
            _loc12_.tx = _loc7_;
            _loc12_.ty = _loc8_;
            _loc11_.draw(this,_loc12_);
            _loc13_.push({
               "image":_loc11_,
               "delay":this.activeDelay
            });
            _loc4_++;
         }
         this.frame = _loc2_;
         return _loc13_;
      }
      
      public function clone() : *
      {
         var _loc1_:XML = structure.copy();
         var _loc2_:Array = SingleList.singleXMLList(_loc1_.*.*.*.@url);
         var _loc3_:ChatBalloon = new ChatBalloon();
         while(_loc2_.length > 0)
         {
            ResourceCache.updateResourceUsage(_loc2_.shift(),1);
         }
         _loc3_.structure = _loc1_;
         _loc3_.tileX = this.tileX;
         _loc3_.tileY = this.tileY;
         _loc3_.frame = this.frame;
         _loc3_.animate = this.animate;
         _loc3_.text = this.text;
         cloneCommonProperties(_loc3_);
         return _loc3_;
      }
      
      public function visibleItem(param1:String, param2:Boolean) : void
      {
         this.bitmap.visible = param2;
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function getRawData() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:Object = {};
         XML.prettyPrinting = false;
         _loc2_.structure = structure.toXMLString();
         XML.prettyPrinting = true;
         _loc2_.frame = this._frame;
         _loc2_.tileX = this._tileX;
         _loc2_.tileY = this._tileY;
         _loc2_.animate = this._animate.running;
         _loc2_.text = this.txt.text;
         _loc2_.balloonX = this.balloonX;
         _loc2_.balloonY = this.balloonY;
         _loc2_.arrowPercent = this.arrowPercent;
         cloneCommonProperties(_loc2_);
         _loc1_.writeObject(_loc2_);
         _loc1_.compress();
         return _loc1_;
      }
      
      override public function setProperties(param1:AssetProperties) : void
      {
         super.setProperties(param1);
         this._frame = param1.frame;
         this._tileX = param1.tileX;
         this._tileY = param1.tileY;
         this.txt.text = param1.text;
         this.balloonX = param1.balloonX;
         this.balloonY = param1.balloonY;
         this.arrowPercent = param1.arrowPercent;
         this.animate = param1.animate;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      private function loopAnimate(param1:TimerEvent = null) : void
      {
         this.moveFrame();
      }
      
      private function moveFrame() : void
      {
         var _loc1_:XML = structure.*[this._frame];
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:int = this._frame;
         if(structure.*[this._frame + 1] == undefined)
         {
            this._frame = 0;
         }
         else
         {
            this._frame += 1;
         }
         if(_loc2_ != this._frame)
         {
            this.draw();
         }
         this._animate.delay = Math.max(this.activeDelay,1);
         this.dispatchEvent(new Event(AssetEvent.FRAME_CHANGE));
      }
      
      override protected function draw() : void
      {
         var xnw:XML;
         var xfr:XML = null;
         var xne:XML = null;
         var xsw:XML = null;
         var xse:XML = null;
         var xn:XML = null;
         var xs:XML = null;
         var xw:XML = null;
         var xe:XML = null;
         var xc:XML = null;
         var xarrow:XML = null;
         var xhead:XML = null;
         var p:Point = null;
         var i:int = 0;
         var j:int = 0;
         var c:BitmapData = null;
         var n:BitmapData = null;
         var s:BitmapData = null;
         var e:BitmapData = null;
         var w:BitmapData = null;
         var nw:BitmapData = null;
         var ne:BitmapData = null;
         var sw:BitmapData = null;
         var se:BitmapData = null;
         var arrow:BitmapData = null;
         var head:BitmapData = null;
         var cc:BitmapData = null;
         var nn:BitmapData = null;
         var ss:BitmapData = null;
         var ee:BitmapData = null;
         var ww:BitmapData = null;
         var b00:Bitmap = null;
         var b10:Bitmap = null;
         var b20:Bitmap = null;
         var b01:Bitmap = null;
         var b11:Bitmap = null;
         var b21:Bitmap = null;
         var b02:Bitmap = null;
         var b12:Bitmap = null;
         var b22:Bitmap = null;
         var bar:Bitmap = null;
         var bhe:Bitmap = null;
         var rec:Rectangle = null;
         var dx:int = 0;
         var dy:int = 0;
         var result:BitmapData = null;
         var resultCopy:BitmapData = null;
         var resultMat:Matrix = null;
         var ch:Bitmap = null;
         xfr = structure.*[this._frame];
         if(xfr == null)
         {
            return;
         }
         xnw = xfr.*.(@name == "nw").*[0];
         xne = xfr.*.(@name == "ne").*[0];
         xsw = xfr.*.(@name == "sw").*[0];
         xse = xfr.*.(@name == "se").*[0];
         xn = xfr.*.(@name == "n").*[0];
         xs = xfr.*.(@name == "s").*[0];
         xw = xfr.*.(@name == "w").*[0];
         xe = xfr.*.(@name == "e").*[0];
         xc = xfr.*.(@name == "c").*[0];
         xarrow = xfr.*.(@name == "arrow").*[0];
         xhead = xfr.*.(@name == "head").*[0];
         p = new Point();
         if(xc != null)
         {
            c = ResourceCache.getBitmapData(xc.@url,xc.@image,xc.@c);
         }
         if(xn != null)
         {
            n = ResourceCache.getBitmapData(xn.@url,xn.@image,xn.@c);
         }
         if(xs != null)
         {
            s = ResourceCache.getBitmapData(xs.@url,xs.@image,xs.@c);
         }
         if(xe != null)
         {
            e = ResourceCache.getBitmapData(xe.@url,xe.@image,xe.@c);
         }
         if(xw != null)
         {
            w = ResourceCache.getBitmapData(xw.@url,xw.@image,xw.@c);
         }
         if(xnw != null)
         {
            nw = ResourceCache.getBitmapData(xnw.@url,xnw.@image,xnw.@c);
         }
         if(xne != null)
         {
            ne = ResourceCache.getBitmapData(xne.@url,xne.@image,xne.@c);
         }
         if(xsw != null)
         {
            sw = ResourceCache.getBitmapData(xsw.@url,xsw.@image,xsw.@c);
         }
         if(xse != null)
         {
            se = ResourceCache.getBitmapData(xse.@url,xse.@image,xse.@c);
         }
         if(xarrow != null)
         {
            arrow = ResourceCache.getBitmapData(xarrow.@url,xarrow.@image,xarrow.@c);
         }
         if(xhead != null)
         {
            head = ResourceCache.getBitmapData(xhead.@url,xhead.@image,xhead.@c);
         }
         if(c != null)
         {
            cc = new BitmapData(this._tileX * c.width,this._tileY * c.height,true,0);
         }
         if(n != null)
         {
            nn = new BitmapData(this._tileX * c.width,n.height,true,0);
         }
         if(s != null)
         {
            ss = new BitmapData(this._tileX * c.width,s.height,true,0);
         }
         if(e != null)
         {
            ee = new BitmapData(e.width,this._tileY * c.height,true,0);
         }
         if(w != null)
         {
            ww = new BitmapData(w.width,this._tileY * c.height,true,0);
         }
         i = 0;
         while(i < cc.width)
         {
            j = 0;
            while(j < cc.height)
            {
               p.x = i;
               p.y = j;
               cc.copyPixels(c,c.rect,p);
               j += c.height;
            }
            i += c.width;
         }
         i = 0;
         while(i < nn.width)
         {
            p.x = i;
            p.y = 0;
            nn.copyPixels(n,n.rect,p);
            i += n.width;
         }
         i = 0;
         while(i < ss.width)
         {
            p.x = i;
            p.y = 0;
            ss.copyPixels(s,s.rect,p);
            i += s.width;
         }
         i = 0;
         while(i < ee.height)
         {
            p.x = 0;
            p.y = i;
            ee.copyPixels(e,e.rect,p);
            i += e.height;
         }
         i = 0;
         while(i < ww.height)
         {
            p.x = 0;
            p.y = i;
            ww.copyPixels(w,w.rect,p);
            i += w.height;
         }
         b00 = new Bitmap(nw);
         b10 = new Bitmap(nn);
         b20 = new Bitmap(ne);
         b01 = new Bitmap(ww);
         b11 = new Bitmap(cc);
         b21 = new Bitmap(ee);
         b02 = new Bitmap(sw);
         b12 = new Bitmap(ss);
         b22 = new Bitmap(se);
         bar = new Bitmap(arrow);
         bhe = new Bitmap(head);
         if(xnw != null)
         {
            b00.x = parseInt(xnw.@x);
            b00.y = parseInt(xnw.@y);
         }
         if(xn != null)
         {
            b10.x = parseInt(xn.@x);
            b10.y = parseInt(xn.@y);
         }
         if(xne != null)
         {
            b20.x = b11.width + parseInt(xne.@x);
            b20.y = parseInt(xne.@y);
         }
         if(xw != null)
         {
            b01.x = parseInt(xw.@x);
            b01.y = parseInt(xw.@y);
         }
         if(xe != null)
         {
            b21.x = b11.width + parseInt(xe.@x);
            b21.y = parseInt(xe.@y);
         }
         if(xsw != null)
         {
            b02.x = parseInt(xsw.@x);
            b02.y = b11.height + parseInt(xsw.@y);
         }
         if(xs != null)
         {
            b12.x = parseInt(xs.@x);
            b12.y = b11.height + parseInt(xs.@y);
         }
         if(xse != null)
         {
            b22.x = b11.width + parseInt(xse.@x);
            b22.y = b11.height + parseInt(xse.@y);
            this.arrowEnd = b22.x;
         }
         if(xarrow != null)
         {
            this.arrowInit = parseInt(xarrow.@x);
            bar.x = Math.floor(this.arrowInit + this.arrowPercent * (this.arrowEnd - bar.width - this.arrowInit));
            bar.y = b11.height + parseInt(xarrow.@y);
         }
         if(xhead != null)
         {
            bhe.x = Math.floor((b11.width - bhe.width) / 2);
            bhe.y = parseInt(xhead.@y);
         }
         this.holdA.addChild(b11);
         this.holdA.addChild(b10);
         this.holdA.addChild(b01);
         this.holdA.addChild(b21);
         this.holdA.addChild(b12);
         this.holdA.addChild(b00);
         this.holdA.addChild(b20);
         this.holdA.addChild(b02);
         this.holdA.addChild(b22);
         this.holdA.addChild(bhe);
         this.holdA.addChild(bar);
         rec = this.holdA.getBounds(this.holdB);
         dx = rec.x < 0 ? int(-rec.x) : int(rec.x);
         dy = rec.y < 0 ? int(-rec.y) : int(rec.y);
         result = new BitmapData(rec.width,rec.height,true,0);
         resultCopy = new BitmapData(rec.width,rec.height,true,0);
         resultMat = new Matrix();
         while(this.holdA.numChildren > 0)
         {
            ch = this.holdA.removeChildAt(0) as Bitmap;
            this.drawPiece(ch.bitmapData,resultCopy,ch.x + dx,ch.y + dy);
         }
         resultMat.a = this.balloonX ? -1 : 1;
         resultMat.d = this.balloonY ? -1 : 1;
         resultMat.tx = this.balloonX ? rec.width : 0;
         resultMat.ty = this.balloonY ? rec.height : 0;
         result.draw(resultCopy,resultMat);
         if(this.bitmap.bitmapData != null)
         {
            this.bitmap.bitmapData.dispose();
         }
         this.bitmap.bitmapData = result;
         this.bitmap.smoothing = !_pixelated;
         this.recCenter = new Rectangle(dx,dy,b11.width,b11.height);
         this.updateText(this.txt.text);
         result.draw(this.txt,new Matrix(1,0,0,1,this.txt.x,this.txt.y));
         if(itemColorMatrixCache[xnw.@url] != undefined)
         {
            this.bitmap.filters = [new ColorMatrixFilter(itemColorMatrixCache[xnw.@url].matrix)];
         }
      }
      
      private function drawPiece(param1:BitmapData, param2:BitmapData, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc8_:int = param1.width;
         var _loc9_:int = param1.height;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               _loc7_ = param1.getPixel32(_loc5_,_loc6_);
               if(_loc7_ != 0)
               {
                  param2.setPixel32(param3 + _loc5_,param4 + _loc6_,_loc7_);
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      private function updateText(param1:String) : void
      {
         if(this.recCenter == null)
         {
            this.recCenter = new Rectangle(0,0,100,75);
         }
         var _loc2_:XML = structure.*[this._frame];
         var _loc3_:int = _loc2_ == null ? 16777215 : int(parseInt(_loc2_.@color));
         _loc3_ = isNaN(_loc3_) ? 16777215 : _loc3_;
         _loc3_ = _loc3_ == 0 ? 16777215 : _loc3_;
         this.txt.x = this.recCenter.x;
         this.txt.y = this.recCenter.y;
         this.txt.width = this.recCenter.width;
         this.txt.height = this.recCenter.height;
         this.txt.text = param1;
         this.format.color = _loc3_;
         this.txt.setTextFormat(this.format);
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
         var color:String = null;
         var image:String = null;
         var xx:String = null;
         var yy:String = null;
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
            if(this._frame < 0)
            {
               this._frame = 0;
            }
            color = String(node.@color);
            image = String(node.@image);
            xx = String(node.@x);
            yy = String(node.@y);
            xst = structure.*.(@name == st)[0];
            if(xst == null)
            {
               xst = <i name={st} color={color} delay="100"/>;
               structure.appendChild(xst);
            }
            xfr = xst.*.(@name == fr)[0];
            if(xfr == null)
            {
               xfr = <i name={fr}/>;
               xst.appendChild(xfr);
            }
            xno = xfr.*.(@image == image && @url == url)[0];
            if(xno == null)
            {
               xno = <i url={urlID} image={image} v="1" x={xx} y={yy} c={cc}/>;
               xfr.appendChild(xno);
            }
            i++;
         }
      }
      
      override protected function destroy() : void
      {
         if(this.bitmap.bitmapData != null)
         {
            this.bitmap.bitmapData.dispose();
         }
         this._animate.stop();
         this._animate.removeEventListener(TimerEvent.TIMER,this.loopAnimate);
         this.txt = null;
         this.format = null;
         this.holdA = null;
         this.holdB = null;
         this.bitmap = null;
         this.recCenter = null;
         this._animate = null;
         super.destroy();
      }
      
      public function get maxFrames() : int
      {
         if(structure != null)
         {
            return structure.*.length();
         }
         return 0;
      }
      
      public function get activeDelay() : int
      {
         var _loc1_:XML = structure.*[this._frame];
         if(_loc1_ == null)
         {
            return 0;
         }
         return parseInt(_loc1_.@delay);
      }
      
      public function set flipBalloonX(param1:Boolean) : void
      {
         this.balloonX = param1;
         this.draw();
      }
      
      public function get flipBalloonX() : Boolean
      {
         return this.balloonX;
      }
      
      public function set flipBalloonY(param1:Boolean) : void
      {
         this.balloonY = param1;
         this.draw();
      }
      
      public function get flipBalloonY() : Boolean
      {
         return this.balloonY;
      }
      
      public function set arrowMove(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         this.arrowPercent = param1;
         this.draw();
      }
      
      public function get arrowMove() : Number
      {
         return this.arrowPercent;
      }
      
      public function set text(param1:String) : void
      {
         this.updateText(param1);
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function get text() : String
      {
         return this.txt.text;
      }
      
      public function set tileX(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         this._tileX = param1;
         this.frame = this._frame;
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function get tileX() : int
      {
         return this._tileX;
      }
      
      public function set tileY(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         this._tileY = param1;
         this.frame = this._frame;
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function get tileY() : int
      {
         return this._tileY;
      }
      
      public function set frame(param1:*) : void
      {
         var xfr:XML = null;
         var num:* = param1;
         if(num is String)
         {
            xfr = structure.*.(@name == num)[0];
            if(xfr == null)
            {
               return;
            }
            this._frame = xfr.childIndex();
         }
         else if(num is Number)
         {
            xfr = structure.*[num];
            if(xfr == null)
            {
               return;
            }
            this._frame = num;
         }
         this.draw();
         this._animate.delay = Math.max(this.activeDelay,1);
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

