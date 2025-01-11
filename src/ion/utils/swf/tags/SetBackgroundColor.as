package ion.utils.swf.tags
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import ion.utils.swf.tags.core.BasicTag;
   
   public class SetBackgroundColor extends BasicTag
   {
      private var _backgroundColor:uint;
      
      public function SetBackgroundColor()
      {
         super();
         _type = SET_BACKGROUND_COLOR;
         this._backgroundColor = 16777215;
      }
      
      override public function get serialize() : ByteArray
      {
         _bytes = new ByteArray();
         _bytes.endian = Endian.LITTLE_ENDIAN;
         rgb(this._backgroundColor);
         var _loc1_:ByteArray = buildRecordHeader();
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         _loc2_.writeBytes(_loc1_,0,_loc1_.length);
         _loc2_.writeBytes(_bytes,0,_bytes.length);
         return _loc2_;
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         this._backgroundColor = param1;
      }
      
      public function get backgroundColor() : uint
      {
         return this._backgroundColor;
      }
   }
}

