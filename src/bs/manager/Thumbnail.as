package bs.manager
{
   import bs.gui.InterfaceAssets;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import ion.net.AnyLoader;
   import ion.net.AnyLoaderItem;
   import maplestory.struct.Types;
   import maplestory.utils.ResourceCache;
   
   public class Thumbnail extends EventDispatcher
   {
      private static var rawCollection:Array;
      
      private static var rawIDs:Object = {};
      
      private static var thumbCache:Object = {};
      
      public var progress:Number = 0;
      
      public function Thumbnail()
      {
         super();
         rawCollection = [];
      }
      
      public static function getThumbnailSafeUrl(param1:String) : String
      {
         var _loc5_:* = null;
         var _loc2_:String = Types.getValidURL(param1);
         var _loc3_:int = Types.getType(_loc2_);
         var _loc4_:Array = _loc2_.split("/");
         if(_loc2_.indexOf("ui/") == 0)
         {
            _loc2_ = _loc2_.split("/normal/").join("/");
            _loc4_ = _loc2_.split("/");
         }
         else if(_loc3_ == Types.PET_EQUIP)
         {
            if(_loc4_[_loc4_.length - 3] == "PetEquip")
            {
               _loc4_.pop();
            }
         }
         else if(_loc3_ == Types.HAIR)
         {
            _loc5_ = _loc4_.pop();
            _loc5_ = _loc5_.substr(0,7) + "0";
            _loc4_.push(_loc5_);
         }
         else if(_loc3_ == Types.FACE)
         {
            _loc5_ = _loc4_.pop();
            _loc5_ = _loc5_.substr(0,5) + "0" + _loc5_.substr(6);
            _loc4_.push(_loc5_);
         }
         return _loc4_.join("/");
      }
      
      public static function getThumbnail(param1:String) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc2_:String = getThumbnailSafeUrl(param1);
         _loc3_ = searchThumbnail(_loc2_);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         return InterfaceAssets.warning;
      }
      
      public static function removeThumbnail(param1:String) : void
      {
         if(thumbCache[param1] != undefined)
         {
            --thumbCache[param1].count;
            if(thumbCache[param1].count <= 0)
            {
               thumbCache[param1].image.dispose();
               delete thumbCache[param1];
            }
         }
      }
      
      private static function searchThumbnail(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         if(thumbCache[param1] != undefined)
         {
            thumbCache[param1].count += 1;
            return thumbCache[param1].image;
         }
         if(Types.getType(param1) == Types.FACE_CUSTOM)
         {
            _loc5_ = ResourceCache.getXML(param1);
            _loc6_ = _loc5_.*[0];
            if(_loc6_ != null)
            {
               _loc2_ = ResourceCache.getBitmapData(param1,_loc6_.@image,_loc5_.@client);
               if(_loc2_ != null)
               {
                  thumbCache[param1] = {
                     "image":_loc2_.clone(),
                     "count":1
                  };
                  return _loc2_;
               }
            }
         }
         var _loc3_:Object = rawIDs[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeBytes(rawCollection[_loc3_.rawIndex],_loc3_.position,_loc3_.length);
         _loc4_.inflate();
         _loc2_ = image16To32(_loc4_,_loc3_.width,_loc3_.height);
         _loc4_.clear();
         _loc4_ = null;
         thumbCache[param1] = {
            "image":_loc2_,
            "count":1
         };
         return _loc2_;
      }
      
      private static function image16To32(param1:ByteArray, param2:int, param3:int) : BitmapData
      {
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:BitmapData = new BitmapData(param2,param3,true,0);
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:uint = param1.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc6_)
         {
            _loc7_ = uint(param1[_loc9_] & 0x0F);
            _loc8_ = uint(param1[_loc9_] & 0xF0);
            _loc5_.writeShort(_loc8_ << 8 | _loc8_ << 4 | _loc7_ << 4 | _loc7_);
            _loc9_++;
         }
         _loc5_.position = 0;
         _loc4_.setPixels(_loc4_.rect,_loc5_);
         _loc5_.clear();
         _loc5_ = null;
         return _loc4_;
      }
      
      public function start(param1:String = "") : void
      {
         var _loc5_:String = null;
         var _loc2_:AnyLoader = new AnyLoader();
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         if(BSCommon.start.character)
         {
            _loc4_.push("character");
         }
         if(BSCommon.start.pet)
         {
            _loc4_.push("pet");
         }
         if(BSCommon.start.effect)
         {
            _loc4_.push("effect");
         }
         if(BSCommon.start.etc)
         {
            _loc4_.push("etc");
         }
         if(BSCommon.start.item)
         {
            _loc4_.push("item");
         }
         if(BSCommon.start.map)
         {
            _loc4_.push("map");
         }
         if(BSCommon.start.mob)
         {
            _loc4_.push("mob");
         }
         if(BSCommon.start.morph)
         {
            _loc4_.push("morph");
         }
         if(BSCommon.start.npc)
         {
            _loc4_.push("npc");
         }
         if(BSCommon.start.skill)
         {
            _loc4_.push("skill");
         }
         if(BSCommon.start.chat)
         {
            _loc4_.push("chat");
         }
         while(_loc4_.length > 0)
         {
            _loc5_ = _loc4_.shift();
            _loc3_.push(param1 + _loc5_ + ".th");
         }
         _loc2_.autoDataFormat = false;
         _loc2_.addEventListener(Event.OPEN,this.thOpen);
         _loc2_.addEventListener(Event.COMPLETE,this.thComplete);
         _loc2_.addEventListener(ProgressEvent.PROGRESS,this.thProgress);
         _loc2_.load(_loc3_);
      }
      
      private function thOpen(param1:Event) : void
      {
         var _loc2_:AnyLoaderItem = param1.currentTarget.dataList[param1.currentTarget.dataList.length - 1];
         var _loc3_:ByteArray = _loc2_.data;
         var _loc4_:Array = _loc2_.url.split("/");
         _loc4_.pop();
         _loc3_.endian = Endian.BIG_ENDIAN;
         rawCollection.push(_loc3_);
         this.getTable(_loc3_,rawCollection.length - 1);
      }
      
      private function thProgress(param1:ProgressEvent) : void
      {
         this.progress = param1.currentTarget.progress;
         this.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
      }
      
      private function thComplete(param1:Event) : void
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function getTable(param1:ByteArray, param2:int) : void
      {
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         param1.position = param1.length - 4;
         var _loc3_:int = int(param1.readUnsignedInt());
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeBytes(param1,param1.length - 4 - _loc3_,_loc3_);
         _loc4_.uncompress();
         var _loc5_:String = _loc4_.readMultiByte(_loc4_.length,"us-ascii");
         var _loc6_:Array = _loc5_.split(";");
         while(_loc6_.length > 0)
         {
            _loc8_ = _loc6_.shift();
            _loc7_ = _loc8_.split("-");
            while(_loc7_.length > 1 && !isNaN(parseInt(_loc7_[_loc7_.length - 1])))
            {
               _loc7_.pop();
            }
            _loc8_ = _loc7_.join("-");
            _loc9_ = parseInt("0x" + _loc6_.shift());
            _loc10_ = parseInt("0x" + _loc6_.shift());
            _loc11_ = parseInt("0x" + _loc6_.shift());
            _loc12_ = parseInt("0x" + _loc6_.shift());
            rawIDs[_loc8_] = {
               "width":_loc9_,
               "height":_loc10_,
               "position":_loc11_,
               "length":_loc12_,
               "rawIndex":param2
            };
         }
      }
   }
}

