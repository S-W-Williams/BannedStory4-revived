package maplestory.display.maple
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import ion.utils.SingleList;
   import maplestory.events.AssetEvent;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.ResourceCache;
   
   public class NameTag extends AssetMaple
   {
      private var txt:TextField;
      
      private var format:TextFormat;
      
      private var bitmap:Bitmap;
      
      private var holdA:Sprite;
      
      private var holdB:Sprite;
      
      public function NameTag()
      {
         super();
         this.txt = new TextField();
         this.format = new TextFormat("Arial",12,0);
         this.bitmap = new Bitmap();
         this.holdA = new Sprite();
         this.holdB = new Sprite();
         this.txt.selectable = false;
         this.txt.autoSize = TextFieldAutoSize.LEFT;
         this.txt.mouseEnabled = false;
         this.txt.text = " ";
         this.txt.setTextFormat(this.format);
         this.holdB.addChild(this.holdA);
         this.addChild(this.bitmap);
      }
      
      public function getFrameImages(param1:int = -1) : Array
      {
         var _loc6_:Rectangle = null;
         var _loc7_:BitmapData = null;
         var _loc8_:Matrix = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 65535;
         var _loc5_:int = 65535;
         if(this.parent == null)
         {
            return null;
         }
         _loc6_ = this.getBounds(this.parent);
         _loc2_ = _loc6_.width;
         _loc3_ = _loc6_.height;
         _loc4_ = this.x - _loc6_.x;
         _loc5_ = this.y - _loc6_.y;
         if(_loc2_ <= 0 || _loc3_ <= 0)
         {
            return null;
         }
         var _loc9_:Array = [];
         _loc8_ = this.transform.matrix.clone();
         _loc7_ = new BitmapData(_loc2_,_loc3_,param1 <= -1,param1 <= -1 ? 0 : uint(param1));
         _loc8_.tx = _loc4_;
         _loc8_.ty = _loc5_;
         _loc7_.draw(this,_loc8_);
         _loc9_.push({
            "image":_loc7_,
            "delay":100
         });
         return _loc9_;
      }
      
      override public function remove(param1:String) : void
      {
         super.remove(param1);
         if(this.bitmap.bitmapData != null)
         {
            this.bitmap.bitmapData.dispose();
            this.bitmap.bitmapData = null;
         }
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function clone() : *
      {
         var _loc1_:XML = structure.copy();
         var _loc2_:Array = SingleList.singleXMLList(_loc1_.*.*.*.@url);
         var _loc3_:NameTag = new NameTag();
         while(_loc2_.length > 0)
         {
            ResourceCache.updateResourceUsage(_loc2_.shift(),1);
         }
         _loc3_.structure = _loc1_;
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
         _loc2_.text = this.txt.text;
         cloneCommonProperties(_loc2_);
         _loc1_.writeObject(_loc2_);
         _loc1_.compress();
         return _loc1_;
      }
      
      override public function setProperties(param1:AssetProperties) : void
      {
         super.setProperties(param1);
         this.txt.text = param1.text;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      override protected function draw() : void
      {
         var xw:XML;
         var xfr:XML = null;
         var xc:XML = null;
         var xe:XML = null;
         var w:BitmapData = null;
         var c:BitmapData = null;
         var e:BitmapData = null;
         var cc:BitmapData = null;
         var p:Point = null;
         var i:int = 0;
         var j:int = 0;
         var b00:Bitmap = null;
         var b10:Bitmap = null;
         var b20:Bitmap = null;
         var rec:Rectangle = null;
         var dx:int = 0;
         var dy:int = 0;
         var result:BitmapData = null;
         var ch:Bitmap = null;
         xfr = structure.*[0];
         if(xfr == null)
         {
            return;
         }
         xw = xfr.*.(@name == "w").*[0];
         xc = xfr.*.(@name == "c").*[0];
         xe = xfr.*.(@name == "e").*[0];
         p = new Point();
         if(xw != null)
         {
            w = ResourceCache.getBitmapData(xw.@url,xw.@image,xw.@c);
         }
         if(xc != null)
         {
            c = ResourceCache.getBitmapData(xc.@url,xc.@image,xc.@c);
         }
         if(xe != null)
         {
            e = ResourceCache.getBitmapData(xe.@url,xe.@image,xe.@c);
         }
         if(c != null)
         {
            cc = new BitmapData(Math.ceil(this.txt.width / c.width) * c.width,c.height,true,0);
         }
         i = 0;
         while(i < cc.width)
         {
            p.x = i;
            p.y = 0;
            cc.copyPixels(c,c.rect,p);
            i += c.width;
         }
         b00 = new Bitmap(w);
         b10 = new Bitmap(cc);
         b20 = new Bitmap(e);
         if(xw != null)
         {
            b00.x = parseInt(xw.@x);
            b00.y = parseInt(xw.@y);
         }
         if(xc != null)
         {
            b10.x = 0;
            b10.y = parseInt(xc.@y);
         }
         if(xe != null)
         {
            b20.x = b10.width + parseInt(xe.@x);
            b20.y = parseInt(xe.@y);
         }
         this.holdA.addChild(b00);
         this.holdA.addChild(b10);
         this.holdA.addChild(b20);
         rec = this.holdA.getBounds(this.holdB);
         dx = rec.x < 0 ? int(-rec.x) : int(rec.x);
         dy = rec.y < 0 ? int(-rec.y) : int(rec.y);
         result = new BitmapData(rec.width,rec.height,true,0);
         this.txt.x = b00.width + Math.floor((b10.width - this.txt.width) / 2);
         this.txt.y = b10.y - rec.y + Math.floor((b10.height - this.txt.height) / 2);
         while(this.holdA.numChildren > 0)
         {
            ch = this.holdA.removeChildAt(0) as Bitmap;
            this.drawPiece(ch.bitmapData,result,ch.x + dx,ch.y + dy);
         }
         if(this.bitmap.bitmapData != null)
         {
            this.bitmap.bitmapData.dispose();
         }
         this.bitmap.bitmapData = result;
         this.bitmap.smoothing = !_pixelated;
         this.updateText(this.txt.text);
         result.draw(this.txt,new Matrix(1,0,0,1,this.txt.x,this.txt.y));
         if(itemColorMatrixCache[xw.@url] != undefined)
         {
            this.bitmap.filters = [new ColorMatrixFilter(itemColorMatrixCache[xw.@url].matrix)];
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
         _loc5_ = 0;
         while(_loc5_ < param1.width)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.height)
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
         var _loc2_:XML = structure.*[0];
         var _loc3_:int = _loc2_ == null ? 16777215 : int(parseInt(_loc2_.@color));
         _loc3_ = isNaN(_loc3_) ? 16777215 : _loc3_;
         this.format.color = _loc3_;
         this.txt.text = param1;
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
            color = String(node.@color);
            image = String(node.@image);
            xx = String(node.@x);
            yy = String(node.@y);
            xst = structure.*.(@name == st)[0];
            if(xst == null)
            {
               xst = <i name={st} color={color}/>;
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
         this.txt = null;
         this.format = null;
         this.holdA = null;
         this.holdB = null;
         this.bitmap = null;
         super.destroy();
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
   }
}

