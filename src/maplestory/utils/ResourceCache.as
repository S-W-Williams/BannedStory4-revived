package maplestory.utils
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import ion.utils.SingleList;
   
   public class ResourceCache
   {
      private static var collection:Object = {};
      
      public function ResourceCache()
      {
         super();
      }
      
      public static function setResource(param1:String, param2:ByteArray, param3:Boolean = false) : Boolean
      {
         var xmlLen:uint;
         var xmlBa:ByteArray;
         var fMixer:XML;
         var xml:XML = null;
         var anim:XML = null;
         var imag:XML = null;
         var li:XMLList = null;
         var len:int = 0;
         var clientsArr:Array = null;
         var objIndex:String = null;
         var bdClients:Object = null;
         var obj:Object = null;
         var i:int = 0;
         var url:String = param1;
         var data:ByteArray = param2;
         var isCustomData:Boolean = param3;
         if(data == null)
         {
            return false;
         }
         xmlLen = data.readUnsignedInt();
         xmlBa = new ByteArray();
         data.readBytes(xmlBa,0,xmlLen);
         try
         {
            xmlBa.uncompress();
            xml = XML(xmlBa.toString());
         }
         catch(err:*)
         {
            return false;
         }
         xmlBa.clear();
         xmlBa = null;
         fMixer = xml.*.(@name == "face_mixer")[0];
         anim = xml.*.(@name == "animation")[0];
         imag = xml.*.(@name == "images")[0];
         if(anim == null || imag == null)
         {
            return false;
         }
         li = imag.*.*;
         len = int(li.length());
         bdClients = {};
         i = 0;
         while(i < len)
         {
            clientsArr = String(li[i].@client).split(".");
            obj = {
               "width":parseInt(li[i].@width),
               "height":parseInt(li[i].@height),
               "length":parseInt(li[i].@length),
               "position":parseInt(li[i].@position) + xmlLen + 4,
               "image":null
            };
            while(clientsArr.length > 0)
            {
               objIndex = li[i].parent().@name + "_" + clientsArr.pop();
               bdClients[objIndex] = obj;
            }
            i++;
         }
         collection[url] = {
            "isCustomData":isCustomData,
            "dataFaceMixer":fMixer,
            "dataAnimation":anim.*,
            "data":data,
            "usageCount":0,
            "bdClients":bdClients
         };
         return true;
      }
      
      public static function getCustomResources() : Array
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:Array = [];
         for(_loc4_ in collection)
         {
            if(collection[_loc4_].isCustomData)
            {
               _loc3_ = {
                  "id":_loc4_,
                  "data":collection[_loc4_].data
               };
               _loc2_ = new ByteArray();
               _loc2_.writeObject(_loc3_);
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public static function getBitmapData(param1:String, param2:String, param3:String) : BitmapData
      {
         var _loc6_:Object = null;
         var _loc7_:BitmapData = null;
         var _loc8_:ByteArray = null;
         var _loc4_:Object = collection[param1];
         var _loc5_:String = param2 + "_" + param3;
         if(_loc4_ == null)
         {
            return null;
         }
         if(_loc4_.bdClients[_loc5_] == undefined)
         {
            return null;
         }
         if(_loc4_.bdClients[_loc5_].image == null)
         {
            _loc6_ = _loc4_.bdClients[_loc5_];
            _loc7_ = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            _loc8_ = new ByteArray();
            _loc4_.data.position = _loc6_.position;
            _loc4_.data.readBytes(_loc8_,0,_loc6_.length);
            _loc8_.uncompress();
            _loc7_.setPixels(_loc7_.rect,_loc8_);
            _loc6_.image = _loc7_;
            _loc8_.clear();
            _loc8_ = null;
         }
         return _loc4_.bdClients[_loc5_].image;
      }
      
      public static function getFaceMixerXML(param1:String) : XML
      {
         var _loc2_:Object = collection[param1];
         if(_loc2_ == null)
         {
            return null;
         }
         if(_loc2_.dataFaceMixer == null)
         {
            return null;
         }
         return _loc2_.dataFaceMixer.*[0];
      }
      
      public static function getXML(param1:String, param2:String = null) : XML
      {
         var url:String = param1;
         var client:String = param2;
         var obj:Object = collection[url];
         if(obj == null)
         {
            return null;
         }
         if(client == null)
         {
            return obj.dataAnimation[0];
         }
         return obj.dataAnimation.(@client == client)[0];
      }
      
      public static function resourceExists(param1:String) : Boolean
      {
         return collection[param1] != undefined;
      }
      
      public static function getClients(param1:String) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc2_:Array = [];
         if(resourceExists(param1))
         {
            _loc3_ = SingleList.singleXMLList(collection[param1].dataAnimation.@client);
            while(_loc3_.length > 0)
            {
               _loc4_ = _loc3_.pop();
               switch(_loc4_)
               {
                  case "0":
                     _loc2_.push({
                        "label":"Japan MapleStory",
                        "client":_loc4_
                     });
                     break;
                  case "1":
                     _loc2_.push({
                        "label":"China MapleStory",
                        "client":_loc4_
                     });
                     break;
                  case "2":
                     _loc2_.push({
                        "label":"Global MapleStory",
                        "client":_loc4_
                     });
                     break;
                  case "3":
                     _loc2_.push({
                        "label":"MapleStory S.E.A.",
                        "client":_loc4_
                     });
                     break;
                  case "4":
                     _loc2_.push({
                        "label":"Taiwan MapleStory",
                        "client":_loc4_
                     });
                     break;
                  case "5":
                     _loc2_.push({
                        "label":"Thailand MapleStory",
                        "client":_loc4_
                     });
                     break;
                  case "6":
                     _loc2_.push({
                        "label":"Europe MapleStory",
                        "client":_loc4_
                     });
                     break;
                  case "7":
                     _loc2_.push({
                        "label":"Korea MapleStory",
                        "client":_loc4_
                     });
                     break;
                  default:
                     _loc2_.push({
                        "label":"Other",
                        "client":_loc4_
                     });
                     break;
               }
            }
         }
         return _loc2_;
      }
      
      public static function updateResourceUsage(param1:String, param2:int) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         param2 = param2 < 0 ? -1 : 1;
         if(resourceExists(param1))
         {
            _loc3_ = collection[param1];
            _loc4_ = _loc3_.bdClients;
            _loc3_.usageCount += param2;
            if(_loc3_.usageCount <= 0)
            {
               for(_loc5_ in _loc4_)
               {
                  if(_loc4_[_loc5_].image != null)
                  {
                     _loc4_[_loc5_].image.dispose();
                  }
               }
               _loc3_.data.clear();
               _loc3_.data = null;
               _loc3_.xml = null;
               _loc3_.images = null;
               _loc3_.bdClients = null;
               delete collection[param1];
            }
         }
      }
   }
}

