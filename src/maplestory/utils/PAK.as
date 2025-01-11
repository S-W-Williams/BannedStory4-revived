package maplestory.utils
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import maplestory.struct.Types;
   
   public class PAK extends EventDispatcher
   {
      private var loader:URLLoader;
      
      private var _urlID:String;
      
      private var _url:String;
      
      private var _client:String;
      
      public function PAK()
      {
         super();
         this.loader = new URLLoader();
         this._urlID = "";
         this._url = "";
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.COMPLETE,this.dataLoaded);
         this.loader.addEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.dataError);
      }
      
      public function load(param1:Object) : void
      {
         this._urlID = Types.getValidURL(param1.url);
         this._url = param1.url;
         this._client = param1.client;
         if(ResourceCache.resourceExists(this._urlID))
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.loader.load(new URLRequest(this._url));
         }
      }
      
      public function loadBytes(param1:String, param2:ByteArray) : void
      {
         this._urlID = param1;
         this._url = param1;
         this._client = null;
         var _loc3_:Boolean = ResourceCache.setResource(param1,param2,true);
         if(_loc3_)
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.buildErrorMessage("Invalid BannedStory PAK file.");
         }
      }
      
      public function close() : void
      {
         try
         {
            this.loader.close();
         }
         catch(err:*)
         {
         }
      }
      
      public function destroy() : void
      {
         this.close();
         this.loader.removeEventListener(Event.COMPLETE,this.dataLoaded);
         this.loader.removeEventListener(ProgressEvent.PROGRESS,this.dataProgress);
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.dataError);
         this._client = null;
         this._url = null;
         this._urlID = null;
         this.loader = null;
      }
      
      private function dataProgress(param1:ProgressEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function dataError(param1:IOErrorEvent) : void
      {
         this.close();
         this.buildErrorMessage("PAK not found: " + this._url);
      }
      
      private function dataLoaded(param1:Event) : void
      {
         var _loc2_:Boolean = ResourceCache.setResource(this._urlID,this.loader.data);
         if(_loc2_)
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.buildErrorMessage("Invalid BannedStory PAK file.");
         }
      }
      
      private function buildErrorMessage(param1:String) : void
      {
         var _loc2_:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
         _loc2_.text = param1;
         this.dispatchEvent(_loc2_);
      }
      
      public function get urlID() : String
      {
         return this._urlID;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get client() : String
      {
         return this._client;
      }
   }
}

