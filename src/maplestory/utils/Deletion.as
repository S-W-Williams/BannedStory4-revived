package maplestory.utils
{
   import ion.utils.SingleList;
   import maplestory.struct.Types;
   
   public class Deletion
   {
      public function Deletion()
      {
         super();
      }
      
      public static function check(param1:String, param2:Array) : Array
      {
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc3_:Array = [];
         var _loc4_:String = param1;
         var _loc5_:int = Types.getType(_loc4_);
         var _loc6_:Array = _loc4_.split("/");
         while(param2.length > 0)
         {
            _loc7_ = param2.shift();
            _loc8_ = Types.getType(_loc7_);
            _loc9_ = _loc7_.split("/");
            if(_loc6_[0] == "mob")
            {
               if(_loc9_[1] == "TamingMob")
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[1] == "TamingMob")
            {
               if(_loc8_ == Types.MOB || _loc5_ == Types.TAMINGMOB_MOB && _loc8_ == Types.TAMINGMOB_SEAT)
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[0] == "character")
            {
               if(Types.isWeapon(_loc4_) && Types.isWeapon(_loc7_))
               {
                  if(_loc8_ == Types.WEAPON_DUAL_BLADE && (_loc5_ != Types.WEAPON_ONE_HANDED_AXE && _loc5_ != Types.WEAPON_ONE_HANDED_MACE && _loc5_ != Types.WEAPON_ONE_HANDED_SWORD && _loc5_ != Types.WEAPON_DAGGER_CUTTER && _loc5_ != Types.WEAPON_446 && _loc5_ != Types.WEAPON_447))
                  {
                     _loc3_.push(_loc7_);
                  }
                  else if(_loc5_ == Types.WEAPON_DUAL_BLADE && (_loc8_ != Types.WEAPON_ONE_HANDED_AXE && _loc8_ != Types.WEAPON_ONE_HANDED_MACE && _loc8_ != Types.WEAPON_ONE_HANDED_SWORD && _loc8_ != Types.WEAPON_DAGGER_CUTTER && _loc8_ != Types.WEAPON_446 && _loc8_ != Types.WEAPON_447))
                  {
                     _loc3_.push(_loc7_);
                  }
                  if(_loc8_ != Types.WEAPON_DUAL_BLADE && _loc5_ != Types.WEAPON_DUAL_BLADE)
                  {
                     _loc3_.push(_loc7_);
                  }
               }
               if(_loc5_ == Types.AFTER_IMAGE && Types.isEffect(_loc7_))
               {
                  _loc3_.push(_loc7_);
               }
               if(_loc5_ == Types.FACE && _loc8_ == Types.FACE_CUSTOM)
               {
                  _loc3_.push(_loc7_);
               }
               if(_loc5_ == Types.SHIELD && Types.isWeapon(_loc7_) && _loc8_ != Types.WEAPON_ONE_HANDED_AXE && _loc8_ != Types.WEAPON_ONE_HANDED_MACE && _loc8_ != Types.WEAPON_ONE_HANDED_SWORD && _loc8_ != Types.WEAPON_DAGGER_CUTTER && _loc8_ != Types.WEAPON_WAND && _loc8_ != Types.WEAPON_WAND_2 && _loc8_ != Types.WEAPON_STAFF && _loc8_ != Types.WEAPON_CLAW)
               {
                  _loc3_.push(_loc7_);
               }
               if(_loc8_ == Types.SHIELD && Types.isWeapon(_loc4_) && _loc5_ != Types.WEAPON_ONE_HANDED_AXE && _loc5_ != Types.WEAPON_ONE_HANDED_MACE && _loc5_ != Types.WEAPON_ONE_HANDED_SWORD && _loc5_ != Types.WEAPON_DAGGER_CUTTER && _loc5_ != Types.WEAPON_WAND && _loc5_ != Types.WEAPON_WAND_2 && _loc5_ != Types.WEAPON_STAFF && _loc5_ != Types.WEAPON_CLAW)
               {
                  _loc3_.push(_loc7_);
               }
               if(_loc5_ == Types.LONG_COAT && (_loc8_ == Types.PANTS || _loc8_ == Types.COAT))
               {
                  _loc3_.push(_loc7_);
               }
               if(_loc8_ == Types.LONG_COAT && (_loc5_ == Types.PANTS || _loc5_ == Types.COAT))
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[0] == "effect")
            {
               if(Types.isEffect(_loc7_))
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[0] == "item")
            {
               if(Types.isItem(_loc7_))
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[1] == "Pet")
            {
               if(_loc5_ == Types.PET && _loc8_ == Types.PET_EQUIP)
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[0] == "map")
            {
               if(_loc9_[0] == "map" || _loc9_[0] == "reactor")
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[0] == "reactor")
            {
               if(_loc9_[0] == "map")
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[1] == "skill")
            {
               if(_loc9_[1] == "skill")
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[0] == "etc")
            {
               if(_loc9_[0] == "etc")
               {
                  _loc3_.push(_loc7_);
               }
            }
            else if(_loc6_[0] == "ui")
            {
               if(_loc5_ == Types.UI_BOAT && _loc8_ == Types.UI_GUILDMARK || _loc5_ == Types.UI_GUILDMARK && _loc8_ == Types.UI_BOAT)
               {
                  _loc3_.push(_loc7_);
               }
            }
            if(_loc5_ == Types.FACE_CUSTOM && _loc8_ == Types.FACE)
            {
               _loc3_.push(_loc7_);
            }
            if(_loc5_ == _loc8_)
            {
               _loc3_.push(_loc7_);
            }
         }
         return SingleList.singleArray(_loc3_);
      }
   }
}

