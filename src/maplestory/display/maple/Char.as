package maplestory.display.maple
{
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import ion.utils.SingleList;
   import maplestory.events.AssetEvent;
   import maplestory.struct.CharStructure;
   import maplestory.struct.DepthList;
   import maplestory.struct.Types;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.Deletion;
   import maplestory.utils.ResourceCache;
   
   public class Char extends AssetMapleMotion
   {
      private var structureFace:XML;
      
      private var _stateFace:String;
      
      private var _frameFace:int;
      
      private var _animateFace:Timer;
      
      private var _flatHair:Boolean;
      
      private var _pointedEars:Boolean;
      
      private var hatExists:Boolean;
      
      private var headID:int;
      
      public function Char()
      {
         super();
         structure = CharStructure.getBodyXML();
         this.structureFace = CharStructure.getFaceXML();
         this._animateFace = new Timer(1);
         _state = "stand1";
         _frame = 0;
         this._stateFace = "blink";
         this._frameFace = 0;
         this._pointedEars = false;
         this._flatHair = true;
         this.hatExists = false;
         this.headID = 0;
         this._animateFace.addEventListener(TimerEvent.TIMER,this.loopTimerFace);
      }
      
      override public function remove(param1:String) : void
      {
         var removeType:int = 0;
         var li:XMLList = null;
         var len:int = 0;
         var i:int = 0;
         var urlID:String = param1;
         removeType = Types.getType(urlID);
         li = Types.isFaceRelated(urlID) ? this.structureFace.*.*.*.(@url == urlID) : structure.*.*.*.(@url == urlID);
         len = int(li.length());
         i = 0;
         while(i < len)
         {
            delete li[i].parent().*[li[i].childIndex()];
            i++;
         }
         if(structure.*.(@name == _state).*[_frame] == undefined)
         {
            _frame = 0;
         }
         if(structure.*.(@name == _state)[0] == undefined)
         {
            _state = "stand1";
         }
         if(this.structureFace.*.(@name == _stateFace).*[this._frameFace] == undefined)
         {
            this._frameFace = 0;
         }
         if(this.structureFace.*.(@name == _stateFace)[0] == undefined)
         {
            this._stateFace = "blink";
         }
         if(removeType == Types.CAP)
         {
            this.hatExists = false;
         }
         if(len > 0)
         {
            ResourceCache.updateResourceUsage(urlID,-1);
         }
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      override public function extractStates() : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         var _loc8_:Char = null;
         var _loc1_:Array = [];
         var _loc4_:XMLList = structure.*;
         var _loc5_:int = int(_loc4_.length());
         var _loc9_:int = 0;
         while(_loc9_ < _loc5_)
         {
            _loc6_ = <i/>;
            _loc7_ = this.structureFace.copy();
            _loc6_.appendChild(_loc4_[_loc9_].copy());
            _loc2_ = SingleList.singleXMLList(_loc6_.*.*.*.@url);
            _loc3_ = SingleList.singleXMLList(_loc7_.*.*.*.@url);
            while(_loc2_.length > 0)
            {
               ResourceCache.updateResourceUsage(_loc2_.shift(),1);
            }
            while(_loc3_.length > 0)
            {
               ResourceCache.updateResourceUsage(_loc3_.shift(),1);
            }
            _loc8_ = new Char();
            _loc8_.structure = _loc6_;
            _loc8_.structureFace = _loc7_;
            _loc8_.state = _loc6_.*[0].@name;
            _loc8_.frame = 0;
            _loc8_.stateFace = _loc7_.*[0].@name;
            _loc8_.frameFace = 0;
            _loc8_.animate = this.animate;
            _loc8_.animateFace = this.animateFace;
            _loc8_.hatExists = this.hatExists;
            _loc8_.headID = this.headID;
            _loc8_.flatHair = this.flatHair;
            cloneCommonProperties(_loc8_);
            _loc1_.push(_loc8_);
            _loc9_++;
         }
         return _loc1_;
      }
      
      override public function extractFrames() : Array
      {
         var ret:Array = null;
         var arr:Array = null;
         var arrFace:Array = null;
         var li:XMLList = null;
         var len:int = 0;
         var xst:XML = null;
         var xml:XML = null;
         var xmlFace:XML = null;
         var ch:Char = null;
         var i:int = 0;
         ret = [];
         li = structure.*.(@name == _state).*;
         len = int(li.length());
         i = 0;
         while(i < len)
         {
            xml = <i/>;
            xst = <i/>;
            copyAttributes(li[i].parent(),xst);
            xst.appendChild(li[i].copy());
            xml.appendChild(xst);
            xmlFace = this.structureFace.copy();
            arr = SingleList.singleXMLList(xml.*.*.*.@url);
            arrFace = SingleList.singleXMLList(xmlFace.*.*.*.@url);
            while(arr.length > 0)
            {
               ResourceCache.updateResourceUsage(arr.shift(),1);
            }
            while(arrFace.length > 0)
            {
               ResourceCache.updateResourceUsage(arrFace.shift(),1);
            }
            ch = new Char();
            ch.structure = xml;
            ch.structureFace = xmlFace;
            ch.state = xml.*[0].@name;
            ch.frame = 0;
            ch.stateFace = xmlFace.*[0].@name;
            ch.frameFace = 0;
            ch.animate = this.animate;
            ch.animateFace = this.animateFace;
            ch.hatExists = this.hatExists;
            ch.headID = this.headID;
            ch.flatHair = this.flatHair;
            cloneCommonProperties(ch);
            ret.push(ch);
            i++;
         }
         return ret;
      }
      
      override public function clone() : *
      {
         var _loc1_:XML = structure.copy();
         var _loc2_:XML = this.structureFace.copy();
         var _loc3_:Array = SingleList.singleXMLList(_loc1_.*.*.*.@url + _loc2_.*.*.*.@url);
         var _loc4_:Char = new Char();
         while(_loc3_.length > 0)
         {
            ResourceCache.updateResourceUsage(_loc3_.shift(),1);
         }
         _loc4_.structure = _loc1_;
         _loc4_.structureFace = _loc2_;
         _loc4_.state = this.state;
         _loc4_.frame = this.frame;
         _loc4_.stateFace = this.stateFace;
         _loc4_.frameFace = this.frameFace;
         _loc4_.animate = this.animate;
         _loc4_.animateFace = this.animateFace;
         _loc4_.hatExists = this.hatExists;
         _loc4_.headID = this.headID;
         _loc4_.flatHair = this.flatHair;
         _loc4_.pointedEars = this.pointedEars;
         cloneCommonProperties(_loc4_);
         return _loc4_;
      }
      
      override public function visibleItem(param1:String, param2:Boolean) : void
      {
         var refXML:XML = null;
         var li:XMLList = null;
         var len:int = 0;
         var i:int = 0;
         var urlID:String = param1;
         var value:Boolean = param2;
         if(Types.isFaceRelated(urlID))
         {
            refXML = this.structureFace;
         }
         else
         {
            refXML = structure;
         }
         li = refXML.*.*.*.(@url == urlID);
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
      
      override public function getRawData() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:Object = {};
         XML.prettyPrinting = false;
         _loc2_.structure = structure.toXMLString();
         _loc2_.structureFace = this.structureFace.toXMLString();
         XML.prettyPrinting = true;
         _loc2_.frame = _frame;
         _loc2_.state = _state;
         _loc2_.animate = _animate.running;
         _loc2_.frameFace = this._frameFace;
         _loc2_.stateFace = this._stateFace;
         _loc2_.animateFace = this._animateFace.running;
         _loc2_.flatHair = this._flatHair;
         _loc2_.pointedEars = this._pointedEars;
         _loc2_.hatExists = this.hatExists;
         _loc2_.headID = this.headID;
         cloneCommonProperties(_loc2_);
         _loc1_.writeObject(_loc2_);
         _loc1_.compress();
         return _loc1_;
      }
      
      override public function setProperties(param1:AssetProperties) : void
      {
         this._frameFace = param1.frameFace;
         this._stateFace = param1.stateFace;
         this._pointedEars = param1.pointedEars;
         this._flatHair = param1.flatHair;
         this.hatExists = param1.hatExists;
         this.headID = param1.headID;
         this.structureFace = param1.structureFace;
         this.animateFace = param1.animateFace;
         super.setProperties(param1);
      }
      
      private function loopTimerFace(param1:TimerEvent = null) : void
      {
         this.moveFrameFace();
      }
      
      private function moveFrameFace(param1:int = 0) : void
      {
         var xst:XML = null;
         var val:int = param1;
         xst = this.structureFace.*.(@name == _stateFace)[0];
         if(xst == null)
         {
            return;
         }
         if(val >= 0)
         {
            if(xst.*[this._frameFace + 1] == undefined)
            {
               this._frameFace = 0;
            }
            else
            {
               this._frameFace += 1;
            }
         }
         else if(xst.*[this._frameFace - 1] == undefined)
         {
            this._frameFace = xst.*.length() - 1;
         }
         else
         {
            --this._frameFace;
         }
         this.draw();
         this._animateFace.delay = Math.max(this.activeDelayFace,1);
         this.dispatchEvent(new Event(AssetEvent.FACE_FRAME_CHANGE));
      }
      
      override protected function draw() : void
      {
         var xbfr:XMLList = null;
         var xffr:XMLList = null;
         var node:XML = null;
         var charObj:Object = null;
         var type:int = 0;
         var len:int = 0;
         var sortArr:Array = null;
         var nam:String = null;
         var ch:Bitmap = null;
         var i:int = 0;
         xbfr = structure.*.(@name == _state).*[_frame].*;
         xffr = this.structureFace.*.(@name == _stateFace).*[this._frameFace].*;
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         len = int(xbfr.length());
         sortArr = [];
         i = 0;
         for(; i < len; i++)
         {
            node = xbfr[i];
            nam = String(node.@image);
            type = Types.getType(node.@url);
            if(type == Types.HAIR)
            {
               if((this.checkFlatHair(nam,".backHair") || this.checkFlatHair(nam,".backHairBelowCapWide")) && this.hatExists && this._flatHair)
               {
                  continue;
               }
               if(nam.indexOf(".hairShade.") != -1 && nam.indexOf(".hairShade." + this.headID) == -1)
               {
                  continue;
               }
            }
            if(type == Types.HEAD)
            {
               if(nam.indexOf(".ear") == nam.length - 4 && !this._pointedEars)
               {
                  continue;
               }
            }
            ch = new Bitmap(ResourceCache.getBitmapData(node.@url,node.@image,node.@c));
            ch.x = parseInt(node.@x);
            ch.y = parseInt(node.@y);
            ch.visible = String(node.@v) == "1";
            ch.name = nam;
            ch.smoothing = !_pixelated;
            if(itemColorMatrixCache[node.@url] != undefined)
            {
               ch.filters = [new ColorMatrixFilter(itemColorMatrixCache[node.@url].matrix)];
            }
            sortArr.push({
               "image":ch,
               "z":parseInt(node.@z)
            });
         }
         len = int(xffr.length());
         i = 0;
         while(i < len)
         {
            node = xffr[i];
            charObj = CharStructure.getBody(_state,_frame);
            if(charObj.face)
            {
               ch = new Bitmap(ResourceCache.getBitmapData(node.@url,node.@image,node.@c));
               ch.x = parseInt(node.@x) + charObj.x;
               ch.y = parseInt(node.@y) + charObj.y;
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
            }
            i++;
         }
         len = int(sortArr.length);
         sortArr.sortOn("z",Array.NUMERIC);
         i = 0;
         while(i < len)
         {
            this.addChildAt(sortArr[i].image,0);
            i++;
         }
      }
      
      private function checkFlatHair(param1:String, param2:String) : Boolean
      {
         if(param1.indexOf(param2) == param1.length - param2.length)
         {
            return true;
         }
         return false;
      }
      
      override protected function checkRemoval(param1:String) : void
      {
         var _loc2_:Array = null;
         if(Types.isFaceRelated(param1))
         {
            _loc2_ = Deletion.check(param1,SingleList.singleXMLList(this.structureFace.*.*.*.@url));
         }
         else
         {
            _loc2_ = Deletion.check(param1,SingleList.singleXMLList(structure.*.*.*.@url));
         }
         while(_loc2_.length > 0)
         {
            this.remove(_loc2_.shift());
         }
      }
      
      override protected function processPak(param1:String, param2:String) : void
      {
         var arrPath:Array = null;
         var fr:String = null;
         var st:String = null;
         var bp:Bitmap = null;
         var node:XML = null;
         var i:int = 0;
         var xst:XML = null;
         var xfr:XML = null;
         var xno:XML = null;
         var image:String = null;
         var xx:String = null;
         var yy:String = null;
         var zz:String = null;
         var urlID:String = param1;
         var urlClient:String = param2;
         var data:XML = ResourceCache.getXML(urlID,urlClient);
         var list:XMLList = data.*;
         var len:int = int(list.length());
         var source:XML = Types.isFaceRelated(urlID) ? this.structureFace : structure;
         var urlType:int = Types.getType(urlID);
         var isWeapon:Boolean = Types.isWeapon(urlID);
         var cc:String = data.@client;
         if(urlType == Types.CAP)
         {
            this.hatExists = true;
         }
         else if(urlType == Types.HEAD)
         {
            this.headID = parseInt(urlID.substr(urlID.length - 6,2));
         }
         i = 0;
         while(i < len)
         {
            node = list[i];
            arrPath = String(node.@path).split(".");
            if(isWeapon)
            {
               while(!isNaN(parseInt(arrPath[0])) && arrPath.length > 0)
               {
                  arrPath.shift();
               }
            }
            fr = arrPath.pop();
            st = arrPath.join(".");
            image = String(node.@image);
            xx = String(node.@x);
            yy = String(node.@y);
            zz = String(DepthList.getValue(node.@z));
            xst = source.*.(@name == st)[0];
            if(xst != null)
            {
               xfr = xst.*.(@name == fr)[0];
               if(xfr != null)
               {
                  xno = xfr.*.(@image == image && @url == urlID)[0];
                  if(xno == null)
                  {
                     xno = <i url={urlID} image={image} v="1" x={xx} y={yy} z={zz} c={cc}/>;
                     xfr.appendChild(xno);
                  }
               }
            }
            i++;
         }
      }
      
      override protected function destroy() : void
      {
         var _loc1_:Array = SingleList.singleXMLList(this.structureFace.*.*.*.@url);
         while(_loc1_.length > 0)
         {
            ResourceCache.updateResourceUsage(_loc1_.shift(),-1);
         }
         this._animateFace.stop();
         this._animateFace.removeEventListener(TimerEvent.TIMER,this.loopTimerFace);
         this.structureFace = null;
         this._animateFace = null;
         super.destroy();
      }
      
      public function get maxFramesFace() : int
      {
         var node:XML = null;
         node = this.structureFace.*.(@name == _stateFace)[0];
         if(node != null)
         {
            return node.*.length();
         }
         return 0;
      }
      
      public function get activeDelayFace() : int
      {
         var xfr:XML = null;
         xfr = this.structureFace.*.(@name == _stateFace).*[this._frameFace];
         if(xfr == null)
         {
            return 0;
         }
         return parseInt(xfr.@delay);
      }
      
      public function get pointedEars() : Boolean
      {
         return this._pointedEars;
      }
      
      public function set pointedEars(param1:Boolean) : void
      {
         this._pointedEars = param1;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function get flatHair() : Boolean
      {
         return this._flatHair;
      }
      
      public function set flatHair(param1:Boolean) : void
      {
         this._flatHair = param1;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      override public function get states() : Array
      {
         var weaponShield:XMLList = null;
         var len:int = 0;
         var arr:Array = null;
         var i:int = 0;
         weaponShield = structure.*.*.*.(String(@url).indexOf("/Weapon/") != -1 || String(@url).indexOf("/Shield/") != -1);
         len = int(weaponShield.length());
         if(len == 0)
         {
            return SingleList.singleXMLList(structure.*.@name);
         }
         arr = [];
         i = 0;
         while(i < len)
         {
            arr.push(String(weaponShield[i].parent().parent().@name));
            i++;
         }
         arr.push("sit","ladder","rope");
         return SingleList.singleArray(arr);
      }
      
      public function get statesFace() : Array
      {
         var _loc1_:XMLList = this.structureFace.*;
         var _loc2_:int = int(_loc1_.length());
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc1_[_loc4_].*.length() > 0 && _loc1_[_loc4_].*.*.length() > 0)
            {
               _loc3_.push(String(_loc1_[_loc4_].@name));
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function set stateFace(param1:String) : void
      {
         var xfr:XML = null;
         var val:String = param1;
         xfr = this.structureFace.*.(@name == val)[0];
         if(xfr == null)
         {
            return;
         }
         this._stateFace = val;
         this._frameFace = 0;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.FACE_STATE_CHANGE));
      }
      
      public function get stateFace() : String
      {
         return this._stateFace;
      }
      
      public function set frameFace(param1:*) : void
      {
         var xffr:XML = null;
         var num:* = param1;
         if(num is String)
         {
            xffr = this.structureFace.*.(@name == _stateFace).*.(@name == num)[0];
            if(xffr == null)
            {
               return;
            }
            this._frameFace = xffr.childIndex();
         }
         else
         {
            if(!(num is Number))
            {
               return;
            }
            xffr = this.structureFace.*.(@name == _stateFace).*[num];
            if(xffr == null)
            {
               return;
            }
            this._frameFace = num;
         }
         this.draw();
         this._animateFace.delay = Math.max(this.activeDelayFace,1);
      }
      
      public function get frameFace() : int
      {
         return this._frameFace;
      }
      
      public function set animateFace(param1:Boolean) : void
      {
         if(param1 && this._animateFace.running)
         {
            return;
         }
         this._animateFace.reset();
         this._animateFace.stop();
         if(param1)
         {
            this._animateFace.delay = Math.max(this.activeDelayFace,1);
            this._animateFace.start();
            this.loopTimerFace();
         }
      }
      
      public function get animateFace() : Boolean
      {
         return this._animateFace.running;
      }
      
      override public function get urlIDs() : XMLList
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc7_:int = 0;
         var _loc1_:XMLList = structure.*.*.* + this.structureFace.*.*.*;
         var _loc2_:int = int(_loc1_.length());
         var _loc5_:XMLList = new XMLList();
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = int(_loc5_.length());
            _loc4_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               if(_loc5_[_loc7_].@url == _loc1_[_loc6_].@url)
               {
                  _loc4_ = true;
                  break;
               }
               _loc7_++;
            }
            if(!_loc4_)
            {
               _loc5_ += _loc1_[_loc6_];
            }
            _loc6_++;
         }
         return _loc5_;
      }
   }
}

