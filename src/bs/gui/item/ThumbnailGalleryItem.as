package bs.gui.item
{
   import bs.manager.BSCommon;
   import bs.manager.Thumbnail;
   import fl.controls.Label;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import maplestory.struct.Types;
   
   public class ThumbnailGalleryItem extends Sprite
   {
      private var _node:XML;
      
      private var _id:String;
      
      private var _currentType:int;
      
      private var lab:Label;
      
      private var bp:Bitmap;
      
      private var bg:Shape;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _itemName:String;
      
      private var _itemNoThumbName:String;
      
      public function ThumbnailGalleryItem(param1:String, param2:XML, param3:int)
      {
         super();
         this._id = param1 + String(param2.@id);
         this._currentType = param3;
         this._node = param2;
         this.buttonMode = true;
         this.mouseChildren = false;
         var _loc4_:String = String(this._node.@n);
         var _loc5_:Array = this._id.split("/");
         var _loc6_:String = "";
         if(Types.getType(this._id) == Types.PET_EQUIP)
         {
            _loc5_.pop();
         }
         if(this._currentType == Types.ASSET_CHAT_BALLOON || this._currentType == Types.ASSET_NAME_TAG)
         {
            if(_loc5_[_loc5_.length - 2] == "normal")
            {
               _loc5_.splice(_loc5_.length - 2,1);
               this._id = _loc5_.join("/");
            }
         }
         _loc6_ = _loc5_.pop();
         if(_loc4_ == "")
         {
            this._itemName = "ID: " + _loc6_ + "  -  Name: <no name>";
            this._itemNoThumbName = _loc6_ + " :: < no name >";
         }
         else
         {
            this._itemName = "ID: " + _loc6_ + "  -  Name: " + _loc4_;
            this._itemNoThumbName = _loc6_ + "  :: " + _loc4_;
         }
         if(BSCommon.start.thumbnails)
         {
            this.bp = new Bitmap(Thumbnail.getThumbnail(this._id));
            this._width = 40;
            this._height = 40;
            if(this.bp.width > this._width)
            {
               this.bp.width = this._width;
               this.bp.scaleY = this.bp.scaleX;
            }
            if(this.bp.height > this._height)
            {
               this.bp.height = this._height;
               this.bp.scaleX = this.bp.scaleY;
            }
            this.bp.x = Math.floor((this._width - this.bp.width) / 2);
            this.bp.y = Math.floor((this._height - this.bp.height) / 2);
            this.addChild(this.bp);
         }
         else
         {
            this.lab = new Label();
            this.lab.setSize(150,22);
            this._width = this.lab.width + 10;
            this._height = 30;
            this.lab.text = this._itemNoThumbName;
            this.lab.x = 0;
            this.lab.y = Math.floor((this._height - this.lab.height) / 2);
            this.addChild(this.lab);
         }
         this.bg = new Shape();
         this.bg.graphics.beginFill(0,0);
         this.bg.graphics.drawRect(0,0,this._width,this._height);
         this.bg.graphics.endFill();
         this.addChildAt(this.bg,0);
      }
      
      public function destroy() : void
      {
         if(BSCommon.start.thumbnails)
         {
            this.removeChild(this.bp);
            this.bp.bitmapData = null;
            this.bp = null;
            Thumbnail.removeThumbnail(this._id);
         }
         else
         {
            this.removeChild(this.lab);
            this.lab = null;
         }
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      public function get currentType() : int
      {
         return this._currentType;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get itemName() : String
      {
         return this._itemName;
      }
      
      public function get colors() : Array
      {
         if(String(this._node.@c) != null)
         {
            return String(this._node.@c).split(".");
         }
         return [];
      }
   }
}

