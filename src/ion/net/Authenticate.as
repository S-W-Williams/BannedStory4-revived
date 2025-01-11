package ion.net
{
   public class Authenticate
   {
      public var local:Boolean = false;
      
      public var allowed:Boolean = false;
      
      public var url:String = "";
      
      public var domain:String = "";
      
      public function Authenticate()
      {
         super();
      }
      
      public function start(param1:String, param2:Array) : void
      {
         var _loc3_:uint = 0;
         this.url = param1.split("\\").join("/");
         if(this.url.indexOf("http://") == -1)
         {
            this.local = true;
            this.allowed = true;
         }
         else
         {
            this.local = false;
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(this.url.indexOf(param2[_loc3_]) == 0)
               {
                  this.domain = param2[_loc3_];
                  this.allowed = true;
                  break;
               }
               _loc3_++;
            }
         }
      }
   }
}

