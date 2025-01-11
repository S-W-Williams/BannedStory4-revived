package maplestory.display.maple
{
   import flash.display.DisplayObject;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import ion.geom.ColorMatrix;
   import ion.utils.SingleList;
   import maplestory.display.core.Asset;
   import maplestory.events.AssetEvent;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.Deletion;
   import maplestory.utils.PAK;
   import maplestory.utils.ResourceCache;
   
   public class AssetMaple extends Asset
   {
      private var currentPAK:PAK;
      
      private var loadingQueue:Array;
      
      private var loadingQueueMax:int;
      
      private var loadingQueueWorking:Boolean;
      
      protected var structure:XML;
      
      public var itemColorMatrixCache:Object;
      
      public function AssetMaple()
      {
         super();
         this.currentPAK = new PAK();
         this.loadingQueue = [];
         this.structure = <i/>;
         this.itemColorMatrixCache = {};
         this.loadingQueueWorking = false;
         this.currentPAK.addEventListener(Event.COMPLETE,this.pakLoaded);
         this.currentPAK.addEventListener(ErrorEvent.ERROR,this.pakError);
         this.currentPAK.addEventListener(ProgressEvent.PROGRESS,this.pakProgress);
      }
      
      public function load(... rest) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:String = null;
         while(rest.length > 0)
         {
            _loc2_ = rest.pop();
            if(_loc2_ is String)
            {
               this.loadingQueue.push({
                  "url":_loc2_,
                  "client":null
               });
            }
            else if(_loc2_ is Array)
            {
               rest = rest.concat(_loc2_);
            }
            else if(_loc2_ is Object)
            {
               _loc3_ = _loc2_.url;
               _loc4_ = _loc2_.client;
               if(_loc3_ != null)
               {
                  this.loadingQueue.push({
                     "url":_loc3_,
                     "client":_loc4_
                  });
               }
            }
         }
         this.loadingQueueMax = this.loadingQueue.length;
         if(!this.loadingQueueWorking)
         {
            this.loadingQueueWorking = true;
            this.queueProcess();
         }
      }
      
      public function loadBytes(param1:String, param2:ByteArray) : void
      {
         if(this.loadingQueueWorking)
         {
            return;
         }
         this.currentPAK.loadBytes(param1,param2);
      }
      
      public function remove(param1:String) : void
      {
         var li:XMLList = null;
         var len:int = 0;
         var node:XML = null;
         var xst:XML = null;
         var xfr:XML = null;
         var i:int = 0;
         var urlID:String = param1;
         li = this.structure.*.*.*.(@url == urlID);
         len = int(li.length());
         i = 0;
         while(i < len)
         {
            node = li[i];
            xfr = node.parent();
            xst = xfr.parent();
            delete xfr.*[node.childIndex()];
            if(xfr.*.length() == 0)
            {
               delete xst.*[xfr.childIndex()];
            }
            if(xst.*.length() == 0)
            {
               delete this.structure.*[xst.childIndex()];
            }
            i++;
         }
         if(len > 0)
         {
            ResourceCache.updateResourceUsage(urlID,-1);
            delete this.itemColorMatrixCache[urlID];
         }
      }
      
      public function setItemColorMatrix(param1:String, param2:ColorMatrix) : void
      {
         this.itemColorMatrixCache[param1] = param2;
         draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      override public function setProperties(param1:AssetProperties) : void
      {
         super.setProperties(param1);
         this.structure = param1.structure;
         this.itemColorMatrixCache = param1.itemColorMatrixCache;
      }
      
      override public function close() : void
      {
         if(this.currentPAK != null)
         {
            this.loadingQueue = [];
            this.currentPAK.close();
            this.queueProcess();
         }
      }
      
      private function pakProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = (this.loadingQueueMax - (this.loadingQueue.length + 1)) / this.loadingQueueMax;
         var _loc3_:Number = 1 / this.loadingQueueMax * param1.bytesLoaded / param1.bytesTotal;
         if(isNaN(_loc2_))
         {
            _loc2_ = 0;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         progress = _loc2_ + _loc3_;
         this.dispatchEvent(param1);
      }
      
      private function pakLoaded(param1:Event) : void
      {
         ResourceCache.updateResourceUsage(this.currentPAK.urlID,1);
         this.checkRemoval(this.currentPAK.urlID);
         this.processPak(this.currentPAK.urlID,this.currentPAK.client);
         this.queueProcess();
      }
      
      private function pakError(param1:ErrorEvent) : void
      {
         this.dispatchEvent(param1);
         this.queueProcess();
      }
      
      protected function copyAttributes(param1:XML, param2:XML) : void
      {
         var _loc3_:XMLList = param1.attributes();
         var _loc4_:int = int(_loc3_.length());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            param2[_loc3_[_loc5_].name()] = _loc3_[_loc5_];
            _loc5_++;
         }
      }
      
      private function queueProcess() : void
      {
         if(this.loadingQueue.length > 0)
         {
            this.currentPAK.load(this.loadingQueue.shift());
         }
         else
         {
            this.loadingQueueWorking = false;
            draw();
            this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
            this.dispatchEvent(new Event(AssetEvent.ASSET_ITEM_LOADED,true));
         }
      }
      
      protected function checkRemoval(param1:String) : void
      {
         var _loc2_:Array = Deletion.check(param1,SingleList.singleXMLList(this.structure.*.*.*.@url));
         while(_loc2_.length > 0)
         {
            this.remove(_loc2_.shift());
         }
      }
      
      protected function processPak(param1:String, param2:String) : void
      {
      }
      
      override protected function destroy() : void
      {
         var _loc1_:Array = SingleList.singleXMLList(this.structure.*.*.*.@url);
         while(_loc1_.length > 0)
         {
            ResourceCache.updateResourceUsage(_loc1_.shift(),-1);
         }
         this.currentPAK.destroy();
         this.structure = null;
         this.loadingQueue = null;
         this.currentPAK = null;
         super.destroy();
      }
      
      override protected function cloneCommonProperties(param1:*) : void
      {
         var _loc2_:String = null;
         super.cloneCommonProperties(param1);
         if(param1 is DisplayObject)
         {
            param1.itemColorMatrixCache = {};
            for(_loc2_ in this.itemColorMatrixCache)
            {
               param1.itemColorMatrixCache[_loc2_] = this.itemColorMatrixCache[_loc2_].clone();
            }
         }
         else
         {
            param1.itemColorMatrixCache = {};
            for(_loc2_ in this.itemColorMatrixCache)
            {
               param1.itemColorMatrixCache[_loc2_] = this.itemColorMatrixCache[_loc2_].serialize();
            }
         }
      }
      
      public function get urlIDs() : XMLList
      {
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:XMLList = this.structure.*.*.*;
         var _loc3_:XMLList = new XMLList();
         var _loc4_:int = int(_loc2_.length());
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = int(_loc3_.length());
            _loc1_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               if(_loc3_[_loc7_].@url == _loc2_[_loc6_].@url)
               {
                  _loc1_ = true;
                  break;
               }
               _loc7_++;
            }
            if(!_loc1_)
            {
               _loc3_ += _loc2_[_loc6_];
            }
            _loc6_++;
         }
         return _loc3_;
      }
   }
}

