package ion.utils.swf.tags
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import ion.utils.swf.tags.core.BasicTag;
   
   public class Header extends BasicTag
   {
      public var compressed:Boolean;
      
      public var width:int;
      
      public var height:int;
      
      public var swfVersion:int;
      
      public var frameRate:Number;
      
      public var frameCount:uint;
      
      public function Header()
      {
         super();
         _type = HEADER;
         this.compressed = false;
         this.width = 320;
         this.height = 240;
         this.swfVersion = 9;
         this.frameRate = 30;
         this.frameCount = 1;
      }
      
      override public function get serialize() : ByteArray
      {
         _bytes = new ByteArray();
         _bytes.endian = Endian.LITTLE_ENDIAN;
         if(this.compressed)
         {
            ui8(67);
         }
         else
         {
            ui8(70);
         }
         ui8(87);
         ui8(83);
         ui8(this.swfVersion);
         ui32(0);
         rect(0,0,this.width * 20,this.height * 20);
         fixed8(this.frameRate);
         ui16(this.frameCount);
         return _bytes;
      }
   }
}

