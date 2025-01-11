package ion.net
{
   public class AnyLoaderItem
   {
      public var data:*;
      
      public var extension:String;
      
      public var filename:String;
      
      public var url:String;
      
      public function AnyLoaderItem(param1:*, param2:String, param3:String, param4:String)
      {
         super();
         this.data = param1;
         this.extension = param2;
         this.filename = param3;
         this.url = param4;
      }
   }
}

