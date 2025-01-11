package ion.utils.swf.tags
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import ion.utils.swf.tags.core.BasicTag;
   
   public class DefineBitsLossless2 extends BasicTag
   {
      private var width:int;
      
      private var height:int;
      
      private var baImage:ByteArray;
      
      private var _character:int;
      
      public function DefineBitsLossless2(param1:BitmapData)
      {
         super();
         _type = DEFINE_BITS_LOSSLESS2;
         this._character = ++characterCounter;
         if(param1 != null)
         {
            this.width = param1.width;
            this.height = param1.height;
            this.baImage = param1.getPixels(param1.rect);
            this.baImage.compress();
         }
      }
      
      override public function get serialize() : ByteArray
      {
         _bytes = new ByteArray();
         _bytes.endian = Endian.LITTLE_ENDIAN;
         if(this.baImage != null)
         {
            ui16(this._character);
            ui8(5);
            ui16(this.width);
            ui16(this.height);
            _bytes.writeBytes(this.baImage,0);
         }
         var _loc1_:ByteArray = buildRecordHeader();
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         _loc2_.writeBytes(_loc1_,0,_loc1_.length);
         _loc2_.writeBytes(_bytes,0,_bytes.length);
         return _loc2_;
      }
      
      public function get character() : int
      {
         return this._character;
      }
   }
}

