package bs.utils
{
   import ion.net.Authenticate;
   
   public class BSPaths
   {
      private static const bsID:String = "201109050826";
      
      private static const thumbsDataID:String = "201408210345";
      
      private static var _domainAllowed:Boolean = true;
      
      private static var _bsPath:String = "";
      
      private static var _thumbsPath:String = "";
      
      private static var _dataPath:String = "";
      
      public function BSPaths()
      {
         super();
      }
      
      public static function setCurrentDomain(param1:String) : void
      {
         var _loc2_:Authenticate = new Authenticate();
         _loc2_.start(param1,["http://www.dev.maplesimulator.com","http://dev.maplesimulator.com","http://www.maplesimulator.com","http://www.bspy2.dev.s3-website-us-west-2.amazonaws.com","http://bannedstory4.s3-website-us-west-2.amazonaws.com","https://bspy2.dev"]);
         _domainAllowed = _loc2_.allowed;
         if(_loc2_.allowed)
         {
            if(_loc2_.local)
            {
               _bsPath = "";
               _dataPath = _bsPath + "dat/";
               _thumbsPath = _bsPath + "thumbs/";
            }
            else
            {
               _bsPath = _loc2_.domain + "/program_bs5_" + bsID + "/";
               _dataPath = _bsPath + "config_" + thumbsDataID + "/dat/";
               _thumbsPath = _bsPath + "config_" + thumbsDataID + "/thumbs/";
            }
         }
      }
      
      public static function get domainAllowed() : Boolean
      {
         return _domainAllowed;
      }
      
      public static function get bannedStoryPath() : String
      {
         return _bsPath;
      }
      
      public static function set bannedStoryPath(param1:String) : void
      {
         if(param1.charAt(param1.length - 1) != "/")
         {
            param1 += "/";
         }
         _bsPath = param1;
         _dataPath = _bsPath + "dat/";
         _thumbsPath = _bsPath + "thumbs/";
      }
      
      public static function get dataPath() : String
      {
         return _dataPath;
      }
      
      public static function get thumbnailsPath() : String
      {
         return _thumbsPath;
      }
   }
}

