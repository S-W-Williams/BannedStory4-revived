package maplestory.display.core
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import ion.geom.ColorMatrix;
   import ion.utils.RasterMaker;
   import maplestory.events.AssetEvent;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.FilterSerializer;
   
   public class Asset extends Sprite
   {
      protected var _pixelated:Boolean;
      
      public var colorMatrix:ColorMatrix;
      
      public var progress:Number;
      
      public function Asset()
      {
         super();
         this.colorMatrix = new ColorMatrix();
         this._pixelated = true;
         this.progress = 0;
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.wasRemovedFromStage);
      }
      
      public function getImagePieces() : Array
      {
         var _loc2_:BitmapData = null;
         var _loc3_:DisplayObject = null;
         var _loc1_:Array = [];
         var _loc4_:int = this.numChildren;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this.getChildAt(_loc5_);
            _loc2_ = RasterMaker.raster(_loc3_);
            if(_loc2_ != null)
            {
               _loc1_.push({
                  "image":_loc2_,
                  "x":_loc3_.x,
                  "y":_loc3_.y
               });
            }
            _loc5_++;
         }
         return _loc1_;
      }
      
      public function setProperties(param1:AssetProperties) : void
      {
         this._pixelated = param1.pixelated;
         this.visible = param1.layerVisible;
         this.blendMode = param1.blendMode;
         this.transform.matrix = param1.transformMatrix;
         this.colorMatrix = param1.colorMatrix;
         super.filters = param1.filters;
      }
      
      public function close() : void
      {
      }
      
      private function wasRemovedFromStage(param1:Event) : void
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.wasRemovedFromStage);
         this.colorMatrix = null;
         this.destroy();
      }
      
      protected function cloneCommonProperties(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Array = this.filters;
         var _loc3_:Array = [];
         param1.pixelated = this.pixelated;
         if(param1 is DisplayObject)
         {
            param1.transform.matrix = this.transform.matrix.clone();
            param1.colorMatrix = this.colorMatrix == null ? null : this.colorMatrix.clone();
            _loc5_ = int(_loc2_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_.push(_loc2_[_loc6_].clone());
               _loc6_++;
            }
         }
         else
         {
            param1.transformMatrix = this.transform.matrix.clone();
            param1.colorMatrix = this.colorMatrix == null ? null : this.colorMatrix.serialize();
            _loc5_ = int(_loc2_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_.push(FilterSerializer.serialize(_loc2_[_loc6_]));
               _loc6_++;
            }
         }
         param1.blendMode = this.blendMode;
         param1.filters = _loc3_;
      }
      
      protected function destroy() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this.colorMatrix = null;
      }
      
      protected function draw() : void
      {
      }
      
      override public function set filters(param1:Array) : void
      {
         super.filters = param1;
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function set pixelated(param1:Boolean) : void
      {
         this._pixelated = param1;
         this.draw();
         this.dispatchEvent(new Event(AssetEvent.ASSET_UPDATE,true));
      }
      
      public function get pixelated() : Boolean
      {
         return this._pixelated;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = Math.floor(param1);
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = Math.floor(param1);
      }
   }
}

