package ion.utils.swf
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import ion.utils.swf.tags.DefineBitsLossless2;
   import ion.utils.swf.tags.DefineShape;
   import ion.utils.swf.tags.End;
   import ion.utils.swf.tags.FileAttributes;
   import ion.utils.swf.tags.Header;
   import ion.utils.swf.tags.PlaceObject2;
   import ion.utils.swf.tags.RemoveObject2;
   import ion.utils.swf.tags.SetBackgroundColor;
   import ion.utils.swf.tags.ShowFrame;
   import ion.utils.swf.tags.core.BasicTag;
   
   public class SWFEncoder
   {
      private var tagList:Array;
      
      private var header:Header;
      
      private var fileAttr:FileAttributes;
      
      private var bgColor:SetBackgroundColor;
      
      public function SWFEncoder()
      {
         super();
         this.header = new Header();
         this.fileAttr = new FileAttributes();
         this.bgColor = new SetBackgroundColor();
         this.tagList = [];
         this.tagList.push(this.fileAttr,this.bgColor,new ShowFrame());
      }
      
      public function setCompressed(param1:Boolean) : void
      {
         this.header.compressed = param1;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.header.width = param1;
         this.header.height = param2;
      }
      
      public function setBackgroundColor(param1:uint) : void
      {
         this.bgColor.backgroundColor = param1;
      }
      
      public function setFrameRate(param1:Number) : void
      {
         this.header.frameRate = param1;
      }
      
      public function addImage(param1:BitmapData, param2:int = 1) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 >= 1 && this.tagList[2] is ShowFrame)
         {
            this.tagList.splice(2,1);
         }
         var _loc3_:DefineBitsLossless2 = new DefineBitsLossless2(param1);
         var _loc4_:DefineShape = new DefineShape();
         var _loc5_:PlaceObject2 = new PlaceObject2();
         var _loc6_:RemoveObject2 = new RemoveObject2();
         _loc4_.fillCharacterID = _loc3_.character;
         _loc4_.width = param1.width;
         _loc4_.height = param1.height;
         _loc5_.characterID = _loc4_.character;
         _loc6_.depthToRemove = _loc5_.depth;
         this.tagList.push(_loc3_,_loc4_,_loc5_);
         var _loc7_:int = 0;
         while(_loc7_ < param2)
         {
            this.tagList.push(new ShowFrame());
            _loc7_++;
         }
         this.tagList.push(_loc6_);
      }
      
      public function serialize() : ByteArray
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:ByteArray = null;
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:int = 0;
         _loc1_.endian = Endian.LITTLE_ENDIAN;
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         _loc5_ = 0;
         _loc4_ = int(this.tagList.length);
         while(_loc5_ < _loc4_)
         {
            if(this.tagList[_loc5_].type == BasicTag.SHOW_FRAME)
            {
               _loc3_++;
            }
            if(!(_loc5_ == _loc4_ - 1 && _loc3_ <= 1 && this.tagList[_loc4_ - 1] is RemoveObject2))
            {
               _loc2_.writeBytes(this.tagList[_loc5_].serialize);
            }
            _loc5_++;
         }
         this.header.frameCount = _loc3_;
         _loc1_.writeBytes(this.header.serialize);
         _loc2_.writeBytes(new End().serialize);
         _loc5_ = int(_loc1_.position);
         _loc1_.position = 4;
         _loc1_.writeUnsignedInt(_loc1_.length + _loc2_.length);
         _loc1_.position = _loc5_;
         _loc1_.writeBytes(_loc2_);
         if(this.header.compressed)
         {
            _loc6_ = new ByteArray();
            _loc7_ = new ByteArray();
            _loc6_.writeBytes(_loc1_,0,8);
            _loc7_.writeBytes(_loc1_,8,_loc1_.length - 8);
            _loc7_.compress();
            _loc1_ = new ByteArray();
            _loc1_.writeBytes(_loc6_);
            _loc1_.writeBytes(_loc7_);
         }
         _loc1_.position = 0;
         return _loc1_;
      }
   }
}

