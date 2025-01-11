package maplestory.display.maple
{
   import flash.display.DisplayObject;
   import maplestory.struct.Types;
   import maplestory.utils.AssetProperties;
   import maplestory.utils.ResourceCache;
   
   public class Pet extends AssetMapleMotion
   {
      private var _petID:String;
      
      private var _itemUrlID:String;
      
      public function Pet()
      {
         super();
         this._petID = null;
         this._itemUrlID = null;
      }
      
      override public function remove(param1:String) : void
      {
         var _loc2_:int = Types.getType(param1);
         if(_loc2_ == Types.PET)
         {
            if(this._itemUrlID != null)
            {
               super.remove(this._itemUrlID);
            }
            this._petID = null;
         }
         else if(_loc2_ == Types.PET_EQUIP)
         {
            this._itemUrlID = null;
         }
         super.remove(param1);
      }
      
      override protected function cloneCommonProperties(param1:*) : void
      {
         super.cloneCommonProperties(param1);
         if(param1 is DisplayObject)
         {
            param1._petID = this._petID;
         }
         else
         {
            param1.petID = this._petID;
         }
      }
      
      override public function setProperties(param1:AssetProperties) : void
      {
         this._petID = param1.petID;
         super.setProperties(param1);
      }
      
      override protected function processPak(param1:String, param2:String) : void
      {
         var arrPath:Array = null;
         var fr:String = null;
         var st:String = null;
         var node:XML = null;
         var i:int = 0;
         var xst:XML = null;
         var xfr:XML = null;
         var xno:XML = null;
         var zigzag:String = null;
         var delay:String = null;
         var image:String = null;
         var xx:String = null;
         var yy:String = null;
         var zz:String = null;
         var urlID:String = param1;
         var urlClient:String = param2;
         var data:XML = ResourceCache.getXML(urlID,urlClient);
         var len:int = int(data.*.length());
         var urlType:int = Types.getType(urlID);
         var cc:String = data.@client;
         if(urlType == Types.PET)
         {
            this._petID = urlID.split("/").pop();
         }
         else if(urlType == Types.PET_EQUIP)
         {
            this._itemUrlID = urlID;
         }
         i = 0;
         while(i < len)
         {
            node = data.*[i];
            arrPath = String(node.@path).split(".");
            fr = arrPath.pop();
            st = arrPath.join(".");
            _state = _state == null ? st : _state;
            _frame = _frame < 0 ? 0 : _frame;
            zigzag = String(node.@zigzag) == "1" ? "1" : "0";
            delay = calculateDelay(node.@delay);
            image = String(node.@image);
            xx = String(node.@x);
            yy = String(node.@y);
            zz = urlType == Types.PET_EQUIP ? "0" : "1";
            xst = structure.*.(@name == st)[0];
            if(xst == null)
            {
               xst = <i name={st} zigzag={zigzag}/>;
               structure.appendChild(xst);
            }
            xfr = xst.*.(@name == fr)[0];
            if(xfr == null)
            {
               xfr = <i name={fr} delay={delay}/>;
               xst.appendChild(xfr);
            }
            xno = xfr.*.(@image == image && @url == url)[0];
            if(xno == null)
            {
               xno = <i url={urlID} image={image} v="1" x={xx} y={yy} z={zz} c={cc}/>;
               xfr.appendChild(xno);
            }
            i++;
         }
      }
      
      public function get petID() : String
      {
         return this._petID;
      }
   }
}

