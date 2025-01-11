package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.manager.BSCommon;
   import bs.manager.Data;
   import bs.utils.BSPaths;
   import bs.utils.KeyboardHandler;
   import fl.controls.BaseButton;
   import fl.controls.Button;
   import fl.controls.CheckBox;
   import fl.controls.ComboBox;
   import fl.controls.Label;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import maplestory.struct.*;
   
   public class RandomGenerator extends WindowBase
   {
      private var comTypes:ComboBox;
      
      private var btnStart:Button;
      
      private var spCharacter:Sprite;
      
      private var spMap:Sprite;
      
      private var spMob:Sprite;
      
      private var spPet:Sprite;
      
      private var charMale:CheckBox;
      
      private var charFemale:CheckBox;
      
      private var charNoGender:CheckBox;
      
      private var charBody:CheckBox;
      
      private var charFace:CheckBox;
      
      private var charHair:CheckBox;
      
      private var charFaceAcc:CheckBox;
      
      private var charEyeAcc:CheckBox;
      
      private var charEarAcc:CheckBox;
      
      private var charHat:CheckBox;
      
      private var charTop:CheckBox;
      
      private var charBottom:CheckBox;
      
      private var charOverall:CheckBox;
      
      private var charCape:CheckBox;
      
      private var charGloves:CheckBox;
      
      private var charShield:CheckBox;
      
      private var charShoes:CheckBox;
      
      private var charWeapon:CheckBox;
      
      private var mapMap:CheckBox;
      
      private var mapReactor:CheckBox;
      
      private var mobMob:CheckBox;
      
      private var mobTamingMob:CheckBox;
      
      private var mobTamingMobEquip:CheckBox;
      
      private var petPet:CheckBox;
      
      private var petPetEquip:CheckBox;
      
      public var urlList:Array;
      
      public var currentType:int;
      
      public function RandomGenerator()
      {
         super();
         var _loc1_:Label = new Label();
         this.comTypes = new ComboBox();
         this.btnStart = new Button();
         this.spCharacter = new Sprite();
         this.spMap = new Sprite();
         this.spMob = new Sprite();
         this.spPet = new Sprite();
         this.charMale = new CheckBox();
         this.charFemale = new CheckBox();
         this.charNoGender = new CheckBox();
         this.charBody = new CheckBox();
         this.charFace = new CheckBox();
         this.charHair = new CheckBox();
         this.charFaceAcc = new CheckBox();
         this.charEyeAcc = new CheckBox();
         this.charEarAcc = new CheckBox();
         this.charHat = new CheckBox();
         this.charTop = new CheckBox();
         this.charBottom = new CheckBox();
         this.charOverall = new CheckBox();
         this.charCape = new CheckBox();
         this.charGloves = new CheckBox();
         this.charShield = new CheckBox();
         this.charShoes = new CheckBox();
         this.charWeapon = new CheckBox();
         this.mapMap = new CheckBox();
         this.mapReactor = new CheckBox();
         this.mobMob = new CheckBox();
         this.mobTamingMob = new CheckBox();
         this.mobTamingMobEquip = new CheckBox();
         this.petPet = new CheckBox();
         this.petPetEquip = new CheckBox();
         this.charMale.selected = true;
         this.charFemale.selected = true;
         this.charNoGender.selected = true;
         this.mapMap.selected = true;
         this.mobMob.selected = true;
         this.petPet.selected = true;
         this.charBody.selected = true;
         this.charFace.selected = true;
         this.charMale.label = "Male";
         this.charFemale.label = "Female";
         this.charNoGender.label = "No Gender";
         this.charBody.label = "Body";
         this.charFace.label = "Face";
         this.charHair.label = "Hair";
         this.charFaceAcc.label = "Face Acc.";
         this.charEyeAcc.label = "Eye Acc.";
         this.charEarAcc.label = "Ear Acc.";
         this.charHat.label = "Hat";
         this.charTop.label = "Top";
         this.charBottom.label = "Bottom";
         this.charOverall.label = "Overall";
         this.charCape.label = "Cape";
         this.charGloves.label = "Gloves";
         this.charShield.label = "Shield";
         this.charShoes.label = "Shoes";
         this.charWeapon.label = "Weapon";
         this.mapMap.label = "Map";
         this.mapReactor.label = "Reactor";
         this.mobMob.label = "Mob";
         this.mobTamingMob.label = "Taming Mob";
         this.mobTamingMobEquip.label = "Taming Mob Equipment";
         this.petPet.label = "Pet";
         this.petPetEquip.label = "Pet Equipment";
         this.btnStart.label = "Generate";
         _loc1_.text = "Item Type";
         this.comTypes.setSize(250,22);
         this.comTypes.dropdown.setRendererStyle("upSkin",Shape);
         this.comTypes.rowCount = 6;
         this.comTypes.dropdown.rowHeight = 30;
         this.mobTamingMob.setSize(150,22);
         this.mobTamingMobEquip.setSize(150,22);
         this.buildCombo();
         _loc1_.x = 0;
         _loc1_.y = 0;
         this.comTypes.x = 300 - this.comTypes.width;
         this.comTypes.y = _loc1_.y;
         this.btnStart.x = Math.floor((300 - this.btnStart.width) / 2);
         this.spCharacter.x = 0;
         this.spCharacter.y = this.comTypes.y + this.comTypes.height + 2;
         this.spMap.x = this.spCharacter.x;
         this.spMap.y = this.spCharacter.y;
         this.spMob.x = this.spCharacter.x;
         this.spMob.y = this.spCharacter.y;
         this.spPet.x = this.spCharacter.x;
         this.spPet.y = this.spCharacter.y;
         this.charMale.x = 0;
         this.charMale.y = 0;
         this.charFemale.x = this.charMale.x + this.charMale.width;
         this.charFemale.y = this.charMale.y;
         this.charNoGender.x = this.charFemale.x + this.charFemale.width;
         this.charNoGender.y = this.charFemale.y;
         this.charBody.x = this.charMale.x;
         this.charBody.y = this.charMale.y + this.charMale.height + 15;
         this.charFace.x = this.charBody.x;
         this.charFace.y = this.charBody.y + this.charBody.height;
         this.charHair.x = this.charFace.x;
         this.charHair.y = this.charFace.y + this.charFace.height;
         this.charFaceAcc.x = this.charHair.x;
         this.charFaceAcc.y = this.charHair.y + this.charHair.height;
         this.charEyeAcc.x = this.charFaceAcc.x;
         this.charEyeAcc.y = this.charFaceAcc.y + this.charFaceAcc.height;
         this.charEarAcc.x = this.charFemale.x;
         this.charEarAcc.y = this.charBody.y;
         this.charHat.x = this.charEarAcc.x;
         this.charHat.y = this.charEarAcc.y + this.charEarAcc.height;
         this.charTop.x = this.charHat.x;
         this.charTop.y = this.charHat.y + this.charHat.height;
         this.charBottom.x = this.charTop.x;
         this.charBottom.y = this.charTop.y + this.charTop.height;
         this.charOverall.x = this.charBottom.x;
         this.charOverall.y = this.charBottom.y + this.charBottom.height;
         this.charCape.x = this.charNoGender.x;
         this.charCape.y = this.charBody.y;
         this.charGloves.x = this.charCape.x;
         this.charGloves.y = this.charCape.y + this.charCape.height;
         this.charShield.x = this.charGloves.x;
         this.charShield.y = this.charGloves.y + this.charGloves.height;
         this.charShoes.x = this.charShield.x;
         this.charShoes.y = this.charShield.y + this.charShield.height;
         this.charWeapon.x = this.charShoes.x;
         this.charWeapon.y = this.charShoes.y + this.charShoes.height;
         this.mapMap.x = 0;
         this.mapMap.y = 0;
         this.mapReactor.x = this.mapMap.x;
         this.mapReactor.y = this.mapMap.y + this.mapMap.height;
         this.mobMob.x = 0;
         this.mobMob.y = 0;
         this.mobTamingMob.x = this.mobMob.x;
         this.mobTamingMob.y = this.mobMob.y + this.mobMob.height;
         this.mobTamingMobEquip.x = this.mobTamingMob.x;
         this.mobTamingMobEquip.y = this.mobTamingMob.y + this.mobTamingMob.height;
         this.petPet.x = 0;
         this.petPet.y = 0;
         this.petPetEquip.x = this.petPet.x;
         this.petPetEquip.y = this.petPet.y + this.petPet.height;
         this.comTypes.addEventListener(Event.CHANGE,this.typesChange);
         this.btnStart.addEventListener(MouseEvent.CLICK,this.startClick);
         this.charTop.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.charBottom.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.charOverall.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.mapMap.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.mapReactor.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.mobMob.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.mobTamingMob.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.mobTamingMobEquip.addEventListener(MouseEvent.CLICK,this.checkClick);
         this.addEventListener(MouseEvent.MOUSE_UP,this.removeFocus);
         this.spCharacter.addChild(this.charMale);
         this.spCharacter.addChild(this.charFemale);
         this.spCharacter.addChild(this.charNoGender);
         this.spCharacter.addChild(this.charBody);
         this.spCharacter.addChild(this.charFace);
         this.spCharacter.addChild(this.charHair);
         this.spCharacter.addChild(this.charFaceAcc);
         this.spCharacter.addChild(this.charEyeAcc);
         this.spCharacter.addChild(this.charEarAcc);
         this.spCharacter.addChild(this.charHat);
         this.spCharacter.addChild(this.charTop);
         this.spCharacter.addChild(this.charBottom);
         this.spCharacter.addChild(this.charOverall);
         this.spCharacter.addChild(this.charCape);
         this.spCharacter.addChild(this.charGloves);
         this.spCharacter.addChild(this.charShield);
         this.spCharacter.addChild(this.charShoes);
         this.spCharacter.addChild(this.charWeapon);
         this.spMap.addChild(this.mapMap);
         this.spMap.addChild(this.mapReactor);
         this.spMob.addChild(this.mobMob);
         this.spMob.addChild(this.mobTamingMob);
         this.spMob.addChild(this.mobTamingMobEquip);
         this.spPet.addChild(this.petPet);
         this.spPet.addChild(this.petPetEquip);
         this.addChild(this.spCharacter);
         this.addChild(this.spMap);
         this.addChild(this.spMob);
         this.addChild(this.spPet);
         this.addChild(_loc1_);
         this.addChild(this.comTypes);
         this.addChild(this.btnStart);
         this.comTypes.selectedIndex = 0;
         this.typesChange();
      }
      
      public function rebuild() : void
      {
         this.buildCombo();
         this.typesChange();
      }
      
      private function removeFocus(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton || param1.target is TextField)
         {
            return;
         }
         stage.focus = null;
         KeyboardHandler.canContinue = true;
      }
      
      private function checkClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget == this.charOverall)
         {
            this.charTop.selected = false;
            this.charBottom.selected = false;
         }
         else if(param1.currentTarget == this.charTop || param1.currentTarget == this.charBottom)
         {
            this.charOverall.selected = false;
         }
         else if(param1.currentTarget == this.mapMap)
         {
            this.mapReactor.selected = false;
         }
         else if(param1.currentTarget == this.mapReactor)
         {
            this.mapMap.selected = false;
         }
         else if(param1.currentTarget == this.mobMob)
         {
            this.mobTamingMob.selected = false;
            this.mobTamingMobEquip.selected = false;
         }
         else if(param1.currentTarget == this.mobTamingMob || param1.currentTarget == this.mobTamingMobEquip)
         {
            this.mobMob.selected = false;
         }
      }
      
      private function startClick(param1:MouseEvent) : void
      {
         switch(this.comTypes.selectedItem.data)
         {
            case Types.ASSET_CHARACTER:
               this.operationsCharacter();
               break;
            case Types.ASSET_CHAT_BALLOON:
               this.operationsChatBalloon();
               break;
            case Types.ASSET_EFFECT:
               this.operationsEffect();
               break;
            case Types.ASSET_ETC:
               this.operationsEtc();
               break;
            case Types.ASSET_ITEM:
               this.operationsItem();
               break;
            case Types.ASSET_MAP:
               this.operationsMap();
               break;
            case Types.ASSET_MOB:
               this.operationsMob();
               break;
            case Types.ASSET_MORPH:
               this.operationsMorph();
               break;
            case Types.ASSET_NAME_TAG:
               this.operationsNameTag();
               break;
            case Types.ASSET_NPC:
               this.operationsNpc();
               break;
            case Types.ASSET_PET:
               this.operationsPet();
               break;
            case Types.ASSET_SKILL:
               this.operationsSkill();
         }
      }
      
      private function typesChange(param1:Event = null) : void
      {
         this.spCharacter.visible = this.comTypes.selectedItem.data == Types.ASSET_CHARACTER;
         this.spMap.visible = this.comTypes.selectedItem.data == Types.ASSET_MAP;
         this.spMob.visible = this.comTypes.selectedItem.data == Types.ASSET_MOB;
         this.spPet.visible = this.comTypes.selectedItem.data == Types.ASSET_PET;
         if(this.spCharacter.visible)
         {
            resizeWindow(300,204);
            this.btnStart.y = 180;
         }
         else if(this.spMap.visible || this.spPet.visible)
         {
            resizeWindow(300,99);
            this.btnStart.y = 75;
         }
         else if(this.spMob.visible)
         {
            resizeWindow(300,124);
            this.btnStart.y = 100;
         }
         else
         {
            resizeWindow(300,69);
            this.btnStart.y = 45;
         }
      }
      
      private function operationsCharacter() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         var genderIndex:int = 0;
         var genderMale:String = null;
         var genderFemale:String = null;
         var genderNoGender:String = null;
         var currentCheck:String = null;
         var checkList:Array = null;
         var colorArr:Array = null;
         var resultID:String = null;
         xml = Data.data.*.(@type == String(Types.ASSET_CHARACTER));
         nodeList = [];
         genderIndex = 4;
         genderMale = "0";
         genderFemale = "1";
         genderNoGender = "2";
         checkList = [];
         if(this.charFaceAcc.selected)
         {
            checkList.push("character/Accessory/0101");
         }
         if(this.charEyeAcc.selected)
         {
            checkList.push("character/Accessory/0102");
         }
         if(this.charEarAcc.selected)
         {
            checkList.push("character/Accessory/0103");
         }
         if(this.charHat.selected)
         {
            checkList.push("character/Cap/");
         }
         if(this.charTop.selected)
         {
            checkList.push("character/Coat/");
         }
         if(this.charBottom.selected)
         {
            checkList.push("character/Pants/");
         }
         if(this.charOverall.selected)
         {
            checkList.push("character/Longcoat/");
         }
         if(this.charCape.selected)
         {
            checkList.push("character/Cape/");
         }
         if(this.charGloves.selected)
         {
            checkList.push("character/Glove/");
         }
         if(this.charShield.selected)
         {
            checkList.push("character/Shield/");
         }
         if(this.charShoes.selected)
         {
            checkList.push("character/Shoes/");
         }
         while(checkList.length > 0)
         {
            currentCheck = checkList.shift();
            if(currentCheck.indexOf("/Accessory/") != -1)
            {
               genderIndex = 0;
            }
            else
            {
               genderIndex = 4;
            }
            li = xml.*.*.(@data == currentCheck).*.(String(@id).charAt(genderIndex) == genderMale && charMale.selected || String(@id).charAt(genderIndex) == genderFemale && charFemale.selected || String(@id).charAt(genderIndex) == genderNoGender && charNoGender.selected);
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         if(this.charWeapon.selected)
         {
            li = xml.*.*.(String(@data).indexOf("/Weapon/") != -1).*.(String(@id).charAt(0) == genderMale && charMale.selected || String(@id).charAt(0) == genderFemale && charFemale.selected || String(@id).charAt(0) == genderNoGender && charNoGender.selected);
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         if(this.charFace.selected)
         {
            li = xml.*.*.(@data == "character/Face/").*.(String(@id).charAt(genderIndex) == genderMale && charMale.selected || String(@id).charAt(genderIndex) == genderFemale && charFemale.selected || String(@id).charAt(genderIndex) == genderNoGender && charNoGender.selected);
            node = this.getRandomNode(li);
            if(node != null)
            {
               colorArr = String(node.@c).split(".");
               resultID = String(node.@id).substr(0,5) + colorArr[Math.round(Math.random() * (colorArr.length - 1))] + String(node.@id).substr(6);
               nodeList.push({
                  "node":node,
                  "id":resultID
               });
            }
         }
         if(this.charHair.selected)
         {
            li = xml.*.*.(@data == "character/Hair/").*.(String(@id).charAt(genderIndex) == genderMale && charMale.selected || String(@id).charAt(genderIndex) == genderFemale && charFemale.selected || String(@id).charAt(genderIndex) == genderNoGender && charNoGender.selected);
            node = this.getRandomNode(li);
            if(node != null)
            {
               colorArr = String(node.@c).split(".");
               resultID = String(node.@id).substr(0,7) + colorArr[Math.round(Math.random() * (colorArr.length - 1))];
               nodeList.push({
                  "node":node,
                  "id":resultID
               });
            }
         }
         if(this.charBody.selected)
         {
            li = xml.*.*.(@data == "character/").*.(String(@id).indexOf("0000") == 0);
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
               li = xml.*.*.(@data == "character/").*.(String(@id).substr(4) == String(node.@id).substr(4) && String(@id).charAt(3) == "1");
               node = this.getRandomNode(li);
               if(node != null)
               {
                  nodeList.push({
                     "node":node,
                     "id":String(node.@id)
                  });
               }
            }
         }
         this.processFilters(nodeList);
      }
      
      private function operationsChatBalloon() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_CHAT_BALLOON)).*.(@data == "ui/ChatBalloon/");
         nodeList = [];
         li = xml.*.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }],["normal/"]);
         }
      }
      
      private function operationsEffect() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_EFFECT));
         nodeList = [];
         li = xml.*.*.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }]);
         }
      }
      
      private function operationsEtc() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_ETC));
         nodeList = [];
         li = xml.*.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }]);
         }
      }
      
      private function operationsItem() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_ITEM));
         nodeList = [];
         li = xml.*.*.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }]);
         }
      }
      
      private function operationsMap() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_MAP));
         nodeList = [];
         if(this.mapMap.selected)
         {
            li = xml.*.(String(@data).indexOf("map/") == 0).*;
            node = this.getRandomNode(li);
            if(node.*.length() > 0)
            {
               node = this.getRandomNode(node.*);
            }
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         if(this.mapReactor.selected)
         {
            li = xml.*.(String(@data).indexOf("reactor/") == 0).*;
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         this.processFilters(nodeList);
      }
      
      private function operationsMob() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_MOB));
         nodeList = [];
         if(this.mobMob.selected)
         {
            li = xml.*.*.(String(@data).indexOf("mob/") == 0).*;
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         if(this.mobTamingMob.selected)
         {
            li = xml.*.*.(String(@data) == "character/TamingMob/0190").*;
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         if(this.mobTamingMobEquip.selected)
         {
            li = xml.*.*.(String(@data) == "character/TamingMob/0191").*;
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         this.processFilters(nodeList);
      }
      
      private function operationsMorph() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_MORPH));
         nodeList = [];
         li = xml.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }]);
         }
      }
      
      private function operationsNameTag() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_CHAT_BALLOON)).*.(@data == "ui/NameTag/");
         nodeList = [];
         li = xml.*.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }],["normal/"]);
         }
      }
      
      private function operationsNpc() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_NPC));
         nodeList = [];
         li = xml.*.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }]);
         }
      }
      
      private function operationsPet() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_PET));
         nodeList = [];
         if(this.petPet.selected)
         {
            li = xml.*.(String(@data) == "item/Pet/").*;
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         if(this.petPetEquip.selected)
         {
            if(node == null)
            {
               li = xml.*.(String(@data) == "character/PetEquip/").*;
            }
            else
            {
               li = xml.*.(String(@data) == "character/PetEquip/").*.(String(@id).split("/").pop() == String(node.@id));
            }
            node = this.getRandomNode(li);
            if(node != null)
            {
               nodeList.push({
                  "node":node,
                  "id":String(node.@id)
               });
            }
         }
         this.processFilters(nodeList);
      }
      
      private function operationsSkill() : void
      {
         var xml:XMLList = null;
         var li:XMLList = null;
         var nodeList:Array = null;
         var node:XML = null;
         xml = Data.data.*.(@type == String(Types.ASSET_SKILL));
         nodeList = [];
         li = xml.*.*.*;
         node = this.getRandomNode(li);
         if(node != null)
         {
            this.processFilters([{
               "node":node,
               "id":node.@id
            }]);
         }
      }
      
      private function buildCombo() : void
      {
         this.comTypes.removeAll();
         if(BSCommon.start.character)
         {
            this.comTypes.addItem({
               "label":"Character Items",
               "data":Types.ASSET_CHARACTER
            });
         }
         if(BSCommon.start.chat)
         {
            this.comTypes.addItem({
               "label":"Chat Balloons",
               "data":Types.ASSET_CHAT_BALLOON
            });
         }
         if(BSCommon.start.effect)
         {
            this.comTypes.addItem({
               "label":"Special Effects",
               "data":Types.ASSET_EFFECT
            });
         }
         if(BSCommon.start.etc)
         {
            this.comTypes.addItem({
               "label":"Miscellaneous",
               "data":Types.ASSET_ETC
            });
         }
         if(BSCommon.start.item)
         {
            this.comTypes.addItem({
               "label":"Cash Items",
               "data":Types.ASSET_ITEM
            });
         }
         if(BSCommon.start.map)
         {
            this.comTypes.addItem({
               "label":"Map Items and Reactors",
               "data":Types.ASSET_MAP
            });
         }
         if(BSCommon.start.mob)
         {
            this.comTypes.addItem({
               "label":"Monsters and Taming Mobs",
               "data":Types.ASSET_MOB
            });
         }
         if(BSCommon.start.morph)
         {
            this.comTypes.addItem({
               "label":"Character Morphs",
               "data":Types.ASSET_MORPH
            });
         }
         if(BSCommon.start.chat)
         {
            this.comTypes.addItem({
               "label":"Name Tags",
               "data":Types.ASSET_NAME_TAG
            });
         }
         if(BSCommon.start.npc)
         {
            this.comTypes.addItem({
               "label":"NPCs",
               "data":Types.ASSET_NPC
            });
         }
         if(BSCommon.start.pet)
         {
            this.comTypes.addItem({
               "label":"Pets and Pet Equipment",
               "data":Types.ASSET_PET
            });
         }
         if(BSCommon.start.skill)
         {
            this.comTypes.addItem({
               "label":"Skills",
               "data":Types.ASSET_SKILL
            });
         }
         this.comTypes.selectedIndex = 0;
      }
      
      private function getRandomNode(param1:XMLList) : XML
      {
         var _loc2_:int = int(param1.length());
         if(_loc2_ == 0)
         {
            return null;
         }
         return param1[Math.round(Math.random() * (_loc2_ - 1))];
      }
      
      private function processFilters(param1:Array, param2:Array = null) : void
      {
         var _loc4_:XML = null;
         var _loc5_:* = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:String = null;
         if(param1.length == 0)
         {
            return;
         }
         var _loc3_:int = int(param1.length);
         var _loc9_:int = param2 == null ? 0 : int(param2.length);
         this.urlList = [];
         this.currentType = this.comTypes.selectedItem.data;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = param1[_loc7_].node.parent();
            _loc5_ = param1[_loc7_].id + ".pak";
            while(_loc4_ != null)
            {
               if(_loc4_.@data != undefined)
               {
                  _loc6_ = true;
                  _loc8_ = 0;
                  while(_loc8_ < _loc9_)
                  {
                     if(param2[_loc8_] == String(_loc4_.@data))
                     {
                        _loc6_ = false;
                        break;
                     }
                     _loc8_++;
                  }
                  if(_loc6_)
                  {
                     _loc5_ = _loc4_.@data + _loc5_;
                  }
               }
               _loc4_ = _loc4_.parent();
            }
            _loc10_ = BSPaths.bannedStoryPath + "pak" + _loc5_;
            this.urlList.push(_loc10_);
            _loc7_++;
         }
         this.dispatchEvent(new Event(InterfaceEvent.RANDOM_GENERATE));
      }
   }
}

