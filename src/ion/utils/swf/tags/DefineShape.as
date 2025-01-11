package ion.utils.swf.tags
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import ion.utils.swf.tags.core.BasicTag;
   
   public class DefineShape extends BasicTag
   {
      private var _character:int;
      
      public var x:int;
      
      public var y:int;
      
      public var width:int;
      
      public var height:int;
      
      public var fillCharacterID:int;
      
      public function DefineShape()
      {
         super();
         _type = DEFINE_SHAPE;
         this.x = 0;
         this.y = 0;
         this.width = 0;
         this.height = 0;
         this._character = ++characterCounter;
      }
      
      override public function get serialize() : ByteArray
      {
         _bytes = new ByteArray();
         _bytes.endian = Endian.LITTLE_ENDIAN;
         ui16(this._character);
         rect(this.x,this.y,this.width * 20,this.height * 20);
         shapeWithStyle(this.fillCharacterID,this.width * 20,this.height * 20);
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

