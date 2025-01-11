package bs.manager
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import ion.net.AnyLoader;
   import maplestory.struct.*;
   
   public class Data extends EventDispatcher
   {
      private static var _data:XML;
      
      private static var searchName:String;
      
      private static var searchNameFound:Boolean;
      
      private static var nameCache:Object = {};
      
      public var progress:Number = 0;
      
      public function Data()
      {
         super();
         _data = <i/>;
         searchName = "";
         searchNameFound = false;
      }
      
      public static function getChildsByTrackPath(param1:String) : XMLList
      {
         var arrPath:Array = null;
         var id:String = null;
         var node:XML = null;
         var path:String = param1;
         arrPath = path.split(".");
         id = arrPath.shift();
         node = _data.*.(@trackID == id)[0];
         while(arrPath.length > 0)
         {
            id = arrPath.shift();
            node = node.*.(@trackID == id)[0];
         }
         return node.*;
      }
      
      public static function getFaceChilds() : XMLList
      {
         var node:XML = null;
         node = _data.*.(String(@type) == String(Types.ASSET_CHARACTER))[0];
         if(node == null)
         {
            return null;
         }
         return node.*.*.(@data == "character/Face/").*;
      }
      
      public static function getName(param1:String) : String
      {
         var urlArr:Array;
         var id:String;
         var assetType:int;
         var xml:XML;
         var type:int = 0;
         var url:String = param1;
         url = Types.getValidURL(url);
         type = Types.getType(url);
         if(type == Types.FACE_CUSTOM)
         {
            return "Custom Face";
         }
         if(nameCache[url] != undefined)
         {
            return nameCache[url];
         }
         if(type == Types.HAIR || type == Types.FACE)
         {
            url = Thumbnail.getThumbnailSafeUrl(url);
         }
         urlArr = url.split("/");
         id = urlArr.pop();
         assetType = Types.getAssetType(url);
         xml = _data.*.(@type == String(assetType))[0];
         if(type == Types.PET_EQUIP)
         {
            id = urlArr.pop();
         }
         searchName = "";
         searchNameFound = false;
         if(xml != null)
         {
            recursiveGetName(url,xml.*);
         }
         if(searchName != "")
         {
            id = searchName;
         }
         nameCache[url] = id;
         return id;
      }
      
      private static function recursiveGetName(param1:String, param2:XMLList) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(searchNameFound)
         {
            return;
         }
         var _loc3_:int = int(param2.length());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2[_loc4_].@id != undefined && param2[_loc4_].*.length() == 0)
            {
               if(String(param2[_loc4_].@id) == param1)
               {
                  searchName = String(param2[_loc4_].@n);
                  searchNameFound = true;
                  return;
               }
            }
            else if(param2[_loc4_].@data == undefined)
            {
               recursiveGetName(param1,param2[_loc4_].*);
            }
            else
            {
               _loc5_ = String(param2[_loc4_].@data);
               if(_loc5_ != null)
               {
                  _loc6_ = param1.split(_loc5_)[1];
                  if(_loc6_ != null)
                  {
                     recursiveGetName(_loc6_,param2[_loc4_].*);
                  }
               }
            }
            _loc4_++;
         }
      }
      
      public static function get data() : XML
      {
         return _data;
      }
      
      public function start(param1:String = "") : void
      {
         var _loc2_:AnyLoader = new AnyLoader();
         var _loc3_:Array = [param1 + "data.dat"];
         _loc2_.autoDataFormat = false;
         _loc2_.addEventListener(Event.COMPLETE,this.dataDone);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.dataError);
         _loc2_.addEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         _loc2_.load(_loc3_);
      }
      
      private function dataError(param1:IOErrorEvent) : void
      {
         param1.currentTarget.close();
         var _loc2_:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
         this.dispatchEvent(_loc2_);
      }
      
      private function dataProgress(param1:ProgressEvent) : void
      {
         this.progress = param1.currentTarget.progress;
         this.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
      }
      
      private function dataDone(param1:Event) : void
      {
         var i:int;
         var xml:XML = null;
         var ret:XML = null;
         var raw:ByteArray = null;
         var len:int = 0;
         var str:String = null;
         var e:Event = param1;
         var ur:AnyLoader = e.currentTarget as AnyLoader;
         var listLen:int = int(ur.dataList.length);
         ur.removeEventListener(Event.COMPLETE,this.dataDone);
         ur.removeEventListener(IOErrorEvent.IO_ERROR,this.dataError);
         ur.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         i = 0;
         while(i < listLen)
         {
            ret = <i/>;
            raw = ur.dataList[i].data;
            raw.endian = Endian.BIG_ENDIAN;
            raw.uncompress();
            len = int(raw.readUnsignedInt());
            str = raw.readMultiByte(len,"us-ascii");
            try
            {
               xml = XML(str);
               ret.@label = xml.@label;
               ret.@data = xml.@id + "/";
               if(BSCommon.start.character)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_CHARACTER))[0].copy());
               }
               if(BSCommon.start.chat)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_CHAT_BALLOON))[0].copy());
               }
               if(BSCommon.start.effect)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_EFFECT))[0].copy());
               }
               if(BSCommon.start.etc)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_ETC))[0].copy());
               }
               if(BSCommon.start.item)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_ITEM))[0].copy());
               }
               if(BSCommon.start.map)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_MAP))[0].copy());
               }
               if(BSCommon.start.mob)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_MOB))[0].copy());
               }
               if(BSCommon.start.morph)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_MORPH))[0].copy());
               }
               if(BSCommon.start.npc)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_NPC))[0].copy());
               }
               if(BSCommon.start.pet)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_PET))[0].copy());
               }
               if(BSCommon.start.skill)
               {
                  ret.appendChild(xml.*.(String(@type) == String(Types.ASSET_SKILL))[0].copy());
               }
               _data = ret;
            }
            catch(err:*)
            {
            }
            raw.clear();
            i++;
         }
         this.recursivePutTrackID(_data);
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function recursivePutTrackID(param1:XML, param2:int = 0) : int
      {
         var _loc3_:XMLList = param1.*;
         var _loc4_:int = int(_loc3_.length());
         param1.@trackID = param2;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_[_loc5_].*.length() > 0)
            {
               param2 = this.recursivePutTrackID(_loc3_[_loc5_],param2 + 1);
            }
            _loc5_++;
         }
         return param2;
      }
   }
}

