package ion.components.skin
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class ISkinAssets
   {
      private var _states:Array;
      
      private var _fontColors:Array;
      
      private var _center:Rectangle;
      
      private var _source:BitmapData;
      
      public function ISkinAssets(param1:Array, param2:Array, param3:Rectangle, param4:BitmapData)
      {
         super();
         this._states = param1;
         this._fontColors = param2;
         this._center = param3;
         this._source = param4;
      }
      
      public function destroy() : void
      {
         if(this._source != null)
         {
            this._source.dispose();
         }
         this._states = null;
         this._fontColors = null;
         this._center = null;
         this._source = null;
      }
      
      public function get states() : Array
      {
         return this._states;
      }
      
      public function get fontColors() : Array
      {
         return this._fontColors;
      }
      
      public function get center() : Rectangle
      {
         return this._center;
      }
      
      public function get bitmapData() : BitmapData
      {
         return this._source;
      }
   }
}

