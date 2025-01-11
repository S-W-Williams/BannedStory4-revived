package maplestory.struct
{
   public class DepthList
   {
      private static const depthList:Array = new Array("mobEquipFront","tamingMobFront","mobEquipMid","saddleFront","mobEquipUnderSaddle","tamingMobMid","characterStart","emotionOverBody","weaponWristOverGlove","capeOverHead","weaponOverGlove","gloveWristOverHair","gloveOverHair","handOverHair","weaponOverHand","shieldOverHair","gloveWristBelowWeapon","gloveBelowWeapon","handBelowWeapon","weaponOverArm","gloveWristBelowMailArm","mailArmOverHair","gloveBelowMailArm","armOverHair","mailArmOverHairBelowWeapon","armOverHairBelowWeapon","weaponBelowArm","capOverHair","accessoryEarOverHair","accessoryOverHair","hairOverHead","accessoryEyeOverCap","capAccessory","cap","hair","accessoryEye","accessoryEyeShadow","accessoryFace","capAccessoryBelowAccFace","accessoryEar","capBelowAccessory","accessoryFaceOverFaceBelowCap","face","accessoryFaceBelowFace","hairShade","head","hairBelowHead","cape","gloveWrist","mailArm","glove","hand","arm","weapon","shield","weaponOverArmBelowHead","gloveWristBelowHead","mailArmBelowHeadOverMailChest"
      ,"gloveBelowHead","armBelowHeadOverMailChest","mailArmBelowHead","armBelowHead","weaponOverBody","mailChestTop","gloveWristOverBody","mailChestOverHighest","pantsOverMailChest","mailChest","shoesTop","pantsOverShoesBelowMailChest","shoesOverPants","mailChestOverPants","pants","shoes","pantsBelowShoes","mailChestBelowPants","gloveOverBody","body","capBelowBody","gloveWristBelowBody","gloveBelowBody","capAccessoryBelowBody","shieldBelowBody","capeBelowBody","hairBelowBody","weaponBelowBody","backHairOverCape","backWing","backWeaponOverShield","backShield","backCapOverHair","backHair","backCap","backWeaponOverHead","backHairBelowCapWide","backHairBelowCapNarrow","backHairBelowCap","backCape","backAccessoryOverHead","backAccessoryFaceOverHead","backHead","backMailChestOverPants","backPantsOverMailChest","backMailChest","backPantsOverShoesBelowMailChest","backShoes","backPants","backShoesBelowPants","backPantsBelowShoes","backMailChestBelowPants","backWeaponOverGlove","backGloveWrist","backGlove"
      ,"backBody","backAccessoryEar","backAccessoryFace","backCapAccessory","backMailChestAccessory","backShieldBelowBody","backHairBelowHead","backWeapon","characterEnd","saddleRear","tamingMobRear","mobEquipRear","backMobEquipFront","backTamingMobFront","backMobEquipMid","backSaddle","backMobEquipUnderSaddle","backTamingMobMid","Sd","Tm","Sr","Wg","Ma","Ws","Pn","So","Si","Wp","Gv","Ri","Cp","Ay","As","Ae","Am","Af","At","Fc","Hr","Hd","Bd");
      
      public function DepthList()
      {
         super();
      }
      
      public static function getValue(param1:XMLList) : int
      {
         var _loc2_:int = int(depthList.length);
         var _loc3_:String = String(param1[0]);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(depthList[_loc4_].toLowerCase() == _loc3_.toLowerCase())
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return 0;
      }
   }
}

