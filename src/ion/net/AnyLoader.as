package ion.net
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   
   public class AnyLoader extends EventDispatcher
   {
      private var items:Array = new Array();
      
      private var itemsCounter:int = 0;
      
      private var itemsOpened:int = 0;
      
      public var dataList:Array = new Array();
      
      public var progress:Number = 0;
      
      public var autoDataFormat:Boolean = true;
      
      public function AnyLoader()
      {
         super();
      }
      
      public function load(... rest) : void
      {
         var _loc4_:URLLoader = null;
         this.recursivePaths(rest);
         var _loc2_:int = int(this.items.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new URLLoader();
            _loc4_.dataFormat = URLLoaderDataFormat.BINARY;
            _loc4_.addEventListener(Event.OPEN,this.dataOpen);
            _loc4_.addEventListener(Event.COMPLETE,this.dataLoaded);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.dataError);
            _loc4_.addEventListener(ProgressEvent.PROGRESS,this.dataProgress);
            this.items[_loc3_].loader = _loc4_;
            _loc4_.load(new URLRequest(this.items[_loc3_].url));
            _loc3_++;
         }
      }
      
      public function close() : void
      {
         this.dataList = null;
         var _loc1_:int = this.items == null ? 0 : int(this.items.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            try
            {
               this.items[_loc2_].loader.close();
               this.items[_loc2_].loader.removeEventListener(Event.OPEN,this.dataOpen);
               this.items[_loc2_].loader.removeEventListener(Event.COMPLETE,this.dataLoaded);
               this.items[_loc2_].loader.removeEventListener(IOErrorEvent.IO_ERROR,this.dataError);
               this.items[_loc2_].loader.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
            }
            catch(err:*)
            {
            }
            _loc2_++;
         }
      }
      
      private function dataOpen(param1:Event) : void
      {
         ++this.itemsOpened;
      }
      
      private function dataLoaded(param1:Event) : void
      {
         var _loc4_:Loader = null;
         var _loc2_:Object = this.items[this.getTargetIndex(param1.currentTarget as URLLoader)];
         var _loc3_:ByteArray = param1.currentTarget.data;
         _loc3_.endian = Endian.LITTLE_ENDIAN;
         if(this.autoDataFormat)
         {
            switch(_loc2_.extension)
            {
               case "txt":
                  this.dataList.push(new AnyLoaderItem(String(_loc3_),_loc2_.extension,_loc2_.filename,_loc2_.url));
                  this.dispatchEvent(new Event(Event.OPEN));
                  this.checkIfComplete();
                  break;
               case "xml":
                  try
                  {
                     this.dataList.push(new AnyLoaderItem(XML(String(_loc3_)),_loc2_.extension,_loc2_.filename,_loc2_.url));
                     this.dispatchEvent(new Event(Event.OPEN));
                  }
                  catch(err:*)
                  {
                  }
                  this.checkIfComplete();
                  break;
               case "jpg":
               case "jpeg":
               case "gif":
               case "png":
               case "swf":
                  _loc4_ = new Loader();
                  _loc4_.name = _loc2_.filename + "#$%&" + _loc2_.extension + "#$%&" + _loc2_.url;
                  _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.imgBytesLoaded);
                  _loc4_.loadBytes(ByteArray(_loc3_));
                  break;
               default:
                  this.dataList.push(new AnyLoaderItem(_loc3_,_loc2_.extension,_loc2_.filename,_loc2_.url));
                  this.dispatchEvent(new Event(Event.OPEN));
                  this.checkIfComplete();
            }
         }
         else
         {
            this.dataList.push(new AnyLoaderItem(_loc3_,_loc2_.extension,_loc2_.filename,_loc2_.url));
            this.dispatchEvent(new Event(Event.OPEN));
            this.checkIfComplete();
         }
         param1.currentTarget.removeEventListener(Event.OPEN,this.dataOpen);
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.dataLoaded);
         param1.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,this.dataError);
         param1.currentTarget.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
      }
      
      private function dataError(param1:IOErrorEvent) : void
      {
         param1.currentTarget.removeEventListener(Event.OPEN,this.dataOpen);
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.dataLoaded);
         param1.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,this.dataError);
         param1.currentTarget.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         this.items.splice(this.getTargetIndex(param1.currentTarget as URLLoader),1);
         --this.itemsCounter;
         this.checkIfComplete();
      }
      
      private function dataProgress(param1:ProgressEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = int(this.items.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_ && this.items[_loc5_].loader != param1.currentTarget)
         {
            _loc5_++;
         }
         this.items[_loc5_].loaded = param1.bytesLoaded;
         this.items[_loc5_].total = param1.bytesTotal;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ += this.items[_loc5_].loaded;
            _loc3_ += this.items[_loc5_].total;
            _loc5_++;
         }
         this.progress = _loc2_ / _loc3_;
         if(this.itemsOpened >= this.items.length)
         {
            dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
         }
      }
      
      private function imgBytesLoaded(param1:Event) : void
      {
         var _loc2_:Array = param1.currentTarget.loader.name.split("#$%&");
         this.dataList.push(new AnyLoaderItem(param1.currentTarget.loader.content,_loc2_[1],_loc2_[0],_loc2_[2]));
         this.dispatchEvent(new Event(Event.OPEN));
         this.checkIfComplete();
      }
      
      private function checkIfComplete() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(this.items.length);
         if(++this.itemsCounter >= _loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.items[_loc2_].loader = null;
               _loc2_++;
            }
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function getTargetIndex(param1:URLLoader) : int
      {
         var _loc2_:int = int(this.items.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.items[_loc3_].loader == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function recursivePaths(param1:Array) : void
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_] is Array)
            {
               this.recursivePaths(param1[_loc3_]);
            }
            else
            {
               _loc4_ = String(param1[_loc3_]).split("/").pop().split(".");
               _loc5_ = _loc4_[1];
               _loc6_ = _loc4_[0];
               if(_loc5_ != null)
               {
                  this.items.push({
                     "url":param1[_loc3_],
                     "loader":null,
                     "loaded":0,
                     "total":0,
                     "filename":_loc6_,
                     "extension":_loc5_.toLowerCase()
                  });
               }
            }
            _loc3_++;
         }
      }
   }
}

