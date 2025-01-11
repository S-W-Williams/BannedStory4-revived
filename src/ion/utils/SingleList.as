package ion.utils
{
   public class SingleList
   {
      public function SingleList()
      {
         super();
      }
      
      public static function singleArray(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc7_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:int = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc6_)
         {
            _loc4_ = false;
            _loc7_ = int(_loc5_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc7_)
            {
               if(param1[_loc2_] == _loc5_[_loc3_])
               {
                  _loc4_ = true;
                  break;
               }
               _loc3_++;
            }
            if(!_loc4_)
            {
               _loc5_.push(param1[_loc2_]);
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      public static function singleXMLList(param1:XMLList) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc7_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:int = int(param1.length());
         _loc2_ = 0;
         while(_loc2_ < _loc6_)
         {
            _loc4_ = false;
            _loc7_ = int(_loc5_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc7_)
            {
               if(param1[_loc2_] == String(_loc5_[_loc3_]))
               {
                  _loc4_ = true;
                  break;
               }
               _loc3_++;
            }
            if(!_loc4_)
            {
               _loc5_.push(String(param1[_loc2_]));
            }
            _loc2_++;
         }
         return _loc5_;
      }
   }
}

