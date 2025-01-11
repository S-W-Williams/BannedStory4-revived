package ion.components.skin
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import ion.components.events.IComponentEvent;
   import ion.components.utils.BD9Grid;
   
   public class ISkinGrid extends Sprite
   {
      private var _width:int;
      
      private var _height:int;
      
      private var _state:int = 0;
      
      private var _canResize:Boolean = true;
      
      private var _bg:Bitmap;
      
      private var _skin:ISkinAssets;
      
      private var _newCenter:Rectangle;
      
      public function ISkinGrid()
      {
         super();
         this._bg = new Bitmap();
         addChild(this._bg);
      }
      
      public function resize(param1:int, param2:int, param3:int = -1) : void
      {
         this._width = param1;
         this._height = param2;
         this._state = param3 < 0 ? this._state : param3;
         this.state = this._state;
      }
      
      public function clearArea(param1:Rectangle) : void
      {
         this._bg.bitmapData.fillRect(param1,0);
      }
      
      public function destroy() : void
      {
         removeChild(this._bg);
         this.skin = null;
         this._bg = null;
      }
      
      public function set canResize(param1:Boolean) : void
      {
         this._canResize = param1;
         this.state = this._state;
      }
      
      public function set skin(param1:ISkinAssets) : void
      {
         if(this._bg.bitmapData != null)
         {
            this._bg.bitmapData.dispose();
         }
         this._bg.bitmapData = null;
         this._newCenter = null;
         this._skin = param1;
      }
      
      public function get fontColor() : int
      {
         if(this._skin != null)
         {
            if(this._skin.fontColors[this._state] != undefined)
            {
               return this._skin.fontColors[this._state];
            }
         }
         return 0;
      }
      
      public function set state(param1:int) : void
      {
         var _loc2_:BitmapData = null;
         if(this._skin == null)
         {
            return;
         }
         if(param1 < 0 || param1 >= this._skin.states.length)
         {
            param1 = 0;
         }
         this._state = param1;
         if(this._bg.bitmapData != null)
         {
            this._bg.bitmapData.dispose();
            this._bg.bitmapData = null;
         }
         if(this._canResize)
         {
            _loc2_ = new BitmapData(this._width,this._height,true,0);
         }
         else
         {
            _loc2_ = new BitmapData(this._skin.states[this._state].width,this._skin.states[this._state].height,true,0);
         }
         this._newCenter = BD9Grid.resize(this._skin.bitmapData,_loc2_,this._skin.center,this._skin.states[this._state]);
         this._bg.bitmapData = _loc2_;
         dispatchEvent(new Event(IComponentEvent.SKIN_CHANGE));
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function get center() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         if(this._newCenter != null)
         {
            _loc1_ = this._newCenter.clone();
            _loc1_.x += this.x;
            _loc1_.y += this.y;
            _loc1_.width -= this.x;
            _loc1_.height -= this.y;
         }
         return _loc1_;
      }
   }
}

