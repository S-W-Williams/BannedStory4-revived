package bs.save
{
   import bs.gui.win.Alerts;
   import flash.events.Event;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   
   public class FileSave
   {
      private static var fileRef:FileReference;
      
      private static var browseSelectCallback:Function;
      
      private static var browseCancelCallback:Function;
      
      private static var browseDoneCallback:Function;
      
      private static var saveSelectCallback:Function;
      
      private static var saveCancelCallback:Function;
      
      private static var forcedExtension:String = null;
      
      public function FileSave()
      {
         super();
      }
      
      public static function browse(param1:FileFilter, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         if(fileRef == null)
         {
            fileRef = new FileReference();
         }
         browseSelectCallback = param2;
         browseCancelCallback = param3;
         browseDoneCallback = param4;
         fileRef.addEventListener(Event.SELECT,browseSelect);
         fileRef.addEventListener(Event.CANCEL,browseCancel);
         fileRef.addEventListener(Event.COMPLETE,browseDone);
         fileRef.browse([param1]);
      }
      
      public static function save(param1:ByteArray, param2:String, param3:Function = null, param4:Function = null) : void
      {
         if(fileRef == null)
         {
            fileRef = new FileReference();
         }
         if(param2.indexOf(".") == -1)
         {
            forcedExtension = null;
         }
         else
         {
            forcedExtension = param2.split(".").pop().toLowerCase();
         }
         saveSelectCallback = param3;
         saveCancelCallback = param4;
         fileRef.addEventListener(Event.SELECT,saveSelect);
         fileRef.addEventListener(Event.CANCEL,saveCancel);
         fileRef.save(param1,param2);
      }
      
      private static function browseSelect(param1:Event) : void
      {
         if(browseSelectCallback != null)
         {
            browseSelectCallback.call();
         }
         fileRef.load();
      }
      
      private static function browseCancel(param1:Event) : void
      {
         if(browseCancelCallback != null)
         {
            browseCancelCallback.call();
         }
         cleanEvents();
         browseSelectCallback = null;
         browseCancelCallback = null;
         browseDoneCallback = null;
         fileRef = null;
      }
      
      private static function browseDone(param1:Event) : void
      {
         if(browseDoneCallback != null)
         {
            browseDoneCallback.call(null,fileRef.data,fileRef.name,fileRef.type);
         }
         cleanEvents();
         browseSelectCallback = null;
         browseCancelCallback = null;
         browseDoneCallback = null;
         fileRef = null;
      }
      
      private static function saveSelect(param1:Event) : void
      {
         if(saveSelectCallback != null)
         {
            saveSelectCallback.call();
         }
         cleanEvents();
         var _loc2_:String = null;
         if(fileRef.name.indexOf(".") != -1)
         {
            _loc2_ = fileRef.name.split(".").pop().toLowerCase();
         }
         if(_loc2_ == null || _loc2_ != forcedExtension)
         {
            Alerts.setMessage("<font color=\"#ff0000\">WARNING!!</font>\nThe last file saved (" + fileRef.name + ") must end with \"." + forcedExtension + "\"",-1,["OK:fast_alert_close"]);
            Alerts.hideMessage(6);
         }
         saveSelectCallback = null;
         saveCancelCallback = null;
         fileRef = null;
      }
      
      private static function saveCancel(param1:Event) : void
      {
         if(saveCancelCallback != null)
         {
            saveCancelCallback.call(null);
         }
         cleanEvents();
         saveSelectCallback = null;
         saveCancelCallback = null;
         fileRef = null;
      }
      
      private static function cleanEvents() : void
      {
         fileRef.removeEventListener(Event.SELECT,browseSelect);
         fileRef.removeEventListener(Event.CANCEL,browseCancel);
         fileRef.removeEventListener(Event.COMPLETE,browseDone);
         fileRef.removeEventListener(Event.SELECT,saveSelect);
         fileRef.removeEventListener(Event.CANCEL,saveCancel);
      }
   }
}

