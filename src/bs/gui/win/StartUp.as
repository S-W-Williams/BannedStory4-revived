package bs.gui.win
{
   import bs.events.InterfaceEvent;
   import bs.gui.BaseSprite;
   import bs.gui.InterfaceAssets;
   import caurina.transitions.Tweener;
   import com.yahoo.astra.fl.controls.TabBar;
   import com.yahoo.astra.fl.events.TabBarEvent;
   import fl.controls.Button;
   import fl.controls.CheckBox;
   import fl.controls.Label;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class StartUp extends BaseSprite
   {
      private var holder:Sprite;
      
      private var bg:Shape;
      
      private var btnOK:Button;
      
      private var btnCancel:Button;
      
      private var ckChar:CheckBox;
      
      private var ckPet:CheckBox;
      
      private var ckEffect:CheckBox;
      
      private var ckEtc:CheckBox;
      
      private var ckItem:CheckBox;
      
      private var ckMap:CheckBox;
      
      private var ckMob:CheckBox;
      
      private var ckMorph:CheckBox;
      
      private var ckNPC:CheckBox;
      
      private var ckSkill:CheckBox;
      
      private var ckChat:CheckBox;
      
      private var thumbs:CheckBox;
      
      private var selectAll:Label;
      
      private var selectNone:Label;
      
      private var page2:Sprite;
      
      public function StartUp()
      {
         var _loc1_:Bitmap = null;
         var _loc2_:Bitmap = null;
         var _loc3_:Shape = null;
         var _loc4_:TabBar = null;
         super();
         this.holder = new Sprite();
         this.thumbs = new CheckBox();
         this.bg = new Shape();
         this.btnOK = new Button();
         this.btnCancel = new Button();
         _loc1_ = new Bitmap(InterfaceAssets.logo);
         _loc2_ = new Bitmap(InterfaceAssets.logoNombre);
         _loc3_ = this.buildTop(500,66);
         _loc4_ = new TabBar();
         this.page2 = this.buildPage2();
         var _loc5_:Shape = new Shape();
         var _loc6_:Label = new Label();
         _loc1_.height = _loc3_.height - 2;
         _loc1_.x = 3;
         _loc1_.y = _loc3_.y + Math.floor((_loc3_.height - _loc1_.height) / 2);
         _loc1_.scaleX = _loc1_.scaleY;
         _loc1_.smoothing = true;
         _loc2_.x = _loc1_.x + _loc1_.width + 10;
         _loc2_.y = _loc1_.y + Math.floor((_loc1_.height - _loc2_.height) / 2) + 5;
         _loc4_.dataProvider = new DataProvider(["Categories"]);
         _loc4_.x = 5;
         _loc4_.y = _loc3_.y + _loc3_.height + 7;
         this.page2.x = _loc4_.x;
         this.page2.y = _loc4_.y + _loc4_.height - 1;
         _loc5_.graphics.beginFill(16382457);
         _loc5_.graphics.drawRect(0,0,_loc3_.width,200);
         _loc5_.graphics.beginFill(15658734);
         _loc5_.graphics.drawRect(0,160,_loc3_.width,40);
         _loc5_.graphics.endFill();
         _loc5_.y = _loc3_.y + _loc3_.height;
         this.bg.graphics.beginFill(0,0.1);
         this.bg.graphics.drawRect(0,0,50,50);
         this.bg.graphics.endFill();
         this.thumbs.label = "Include Thumbnails";
         this.thumbs.setSize(150,20);
         this.thumbs.selected = true;
         this.thumbs.x = _loc5_.x + 5;
         this.thumbs.y = _loc5_.y + _loc5_.height - this.thumbs.height - 5;
         this.btnOK.label = "Start";
         this.btnOK.setSize(60,20);
         this.btnOK.x = _loc5_.x + _loc5_.width - this.btnOK.width - 5;
         this.btnOK.y = this.thumbs.y;
         this.btnCancel.label = "Cancel";
         this.btnCancel.setSize(60,20);
         this.btnCancel.x = this.btnOK.x - this.btnCancel.width - 5;
         this.btnCancel.y = this.btnOK.y;
         this.btnCancel.visible = false;
         _loc6_.text = "BannedStory 4.3\nwww.maplesimulator.com";
         _loc6_.setStyle("textFormat",new TextFormat(InterfaceAssets.pfRondaSeven,8,16777215,null,null,null,null,null,TextFormatAlign.RIGHT));
         _loc6_.setSize(120,30);
         _loc6_.x = _loc3_.x + _loc3_.width - _loc6_.width - 3;
         _loc6_.y = _loc3_.y + _loc3_.height - _loc6_.height - 3;
         this.filters = [new DropShadowFilter(2,45,0,0.7,6,6,0.6,2)];
         _loc6_.filters = [new DropShadowFilter(1,45,0,0.7,1,1,0.6,2)];
         this.btnOK.addEventListener(MouseEvent.CLICK,this.okClick);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.cancelClick);
         _loc4_.addEventListener(TabBarEvent.ITEM_CLICK,this.tabClick);
         Alerts.thisAlert.addEventListener(InterfaceEvent.ALERT_CLICK,this.alertClick);
         this.holder.addChild(_loc5_);
         this.holder.addChild(_loc3_);
         this.holder.addChild(_loc1_);
         this.holder.addChild(_loc2_);
         this.holder.addChild(this.thumbs);
         this.holder.addChild(this.btnOK);
         this.holder.addChild(this.btnCancel);
         this.holder.addChild(_loc6_);
         this.holder.addChild(this.page2);
         this.holder.addChild(_loc4_);
         this.addChild(this.bg);
         this.addChild(this.holder);
      }
      
      public function open() : void
      {
         this.visible = true;
         Tweener.addTween(this,{
            "alpha":1,
            "time":0.25
         });
      }
      
      public function close() : void
      {
         this.visible = true;
         Tweener.addTween(this,{
            "alpha":0,
            "time":0.25,
            "onComplete":this.setHidden,
            "onCompleteParams":[false]
         });
      }
      
      override public function onStageResize() : void
      {
         this.holder.x = Math.floor((_stageWidth - 500) / 2);
         this.holder.y = Math.floor((_stageHeight - 266) / 2);
         this.bg.width = _stageWidth;
         this.bg.height = _stageHeight;
      }
      
      private function okClick(param1:MouseEvent = null) : void
      {
         if(!(this.character || this.pet || this.effect || this.etc || this.item || this.map || this.mob || this.morph || this.npc || this.skill || this.chat))
         {
            Alerts.setMessage("Select at least one MapleStory Category",-1,["OK:hide_section_warning"]);
            Alerts.hideMessage(3);
         }
         else
         {
            this.thumbs.enabled = !this.thumbs.selected;
            this.ckChar.enabled = !this.ckChar.selected;
            this.ckPet.enabled = !this.ckPet.selected;
            this.ckEffect.enabled = !this.ckEffect.selected;
            this.ckEtc.enabled = !this.ckEtc.selected;
            this.ckItem.enabled = !this.ckItem.selected;
            this.ckMap.enabled = !this.ckMap.selected;
            this.ckMob.enabled = !this.ckMob.selected;
            this.ckMorph.enabled = !this.ckMorph.selected;
            this.ckNPC.enabled = !this.ckNPC.selected;
            this.ckSkill.enabled = !this.ckSkill.selected;
            this.ckChat.enabled = !this.ckChat.selected;
            Tweener.addTween(this,{
               "alpha":0,
               "time":0.25,
               "onComplete":this.setHidden,
               "onCompleteParams":[true]
            });
         }
      }
      
      private function cancelClick(param1:MouseEvent) : void
      {
         this.ckChar.selected = !this.ckChar.enabled;
         this.ckPet.selected = !this.ckPet.enabled;
         this.ckEffect.selected = !this.ckEffect.enabled;
         this.ckEtc.selected = !this.ckEtc.enabled;
         this.ckItem.selected = !this.ckItem.enabled;
         this.ckMap.selected = !this.ckMap.enabled;
         this.ckMob.selected = !this.ckMob.enabled;
         this.ckMorph.selected = !this.ckMorph.enabled;
         this.ckNPC.selected = !this.ckNPC.enabled;
         this.ckSkill.selected = !this.ckSkill.enabled;
         this.ckChat.selected = !this.ckChat.enabled;
         this.close();
      }
      
      private function alertClick(param1:Event) : void
      {
         var _loc2_:String = Alerts.clickedButtonData;
         if(_loc2_ == "hide_section_warning")
         {
            Alerts.hideMessage();
         }
      }
      
      private function tabClick(param1:TabBarEvent) : void
      {
         this.page2.visible = param1.index == 1;
      }
      
      private function setHidden(param1:Boolean) : void
      {
         this.visible = false;
         if(param1)
         {
            this.btnCancel.visible = true;
            this.dispatchEvent(new Event(InterfaceEvent.STARTUP_DONE,true));
         }
      }
      
      private function buildPage2() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         this.ckChar = new CheckBox();
         this.ckPet = new CheckBox();
         this.ckEffect = new CheckBox();
         this.ckEtc = new CheckBox();
         this.ckItem = new CheckBox();
         this.ckMap = new CheckBox();
         this.ckMob = new CheckBox();
         this.ckMorph = new CheckBox();
         this.ckNPC = new CheckBox();
         this.ckSkill = new CheckBox();
         this.ckChat = new CheckBox();
         this.selectAll = new Label();
         this.selectNone = new Label();
         this.selectAll.text = "Select All";
         this.selectNone.text = "Select None";
         this.ckChar.label = "Character and Equipment";
         this.ckPet.label = "Pets and Pet Equipment";
         this.ckEffect.label = "Special Effects";
         this.ckItem.label = "Cash Items and Effects";
         this.ckMap.label = "Maps and Reactors";
         this.ckMob.label = "Monsters and Taming Mobs";
         this.ckMorph.label = "Character Morphs";
         this.ckNPC.label = "NPCs";
         this.ckSkill.label = "Skills";
         this.ckChat.label = "User Interface";
         this.ckEtc.label = "Miscellaneous";
         this.ckChar.setSize(150,20);
         this.ckPet.setSize(150,20);
         this.ckEffect.setSize(150,20);
         this.ckEtc.setSize(150,20);
         this.ckItem.setSize(150,20);
         this.ckMap.setSize(150,20);
         this.ckMob.setSize(150,20);
         this.ckMorph.setSize(150,20);
         this.ckNPC.setSize(150,20);
         this.ckSkill.setSize(150,20);
         this.ckChat.setSize(150,20);
         this.selectAll.setSize(60,20);
         this.selectNone.setSize(60,20);
         this.ckChar.x = 4;
         this.ckPet.x = this.ckChar.x;
         this.ckEffect.x = this.ckPet.x;
         this.ckChat.x = this.ckEffect.x;
         this.ckItem.x = this.ckChar.x + this.ckChar.width + 4;
         this.ckMap.x = this.ckItem.x;
         this.ckMob.x = this.ckMap.x;
         this.ckMorph.x = this.ckMob.x;
         this.ckNPC.x = this.ckItem.x + this.ckItem.width + 4;
         this.ckSkill.x = this.ckNPC.x;
         this.ckEtc.x = this.ckSkill.x;
         this.ckChar.y = 10;
         this.ckPet.y = this.ckChar.y + this.ckChar.height;
         this.ckEffect.y = this.ckPet.y + this.ckPet.height;
         this.ckChat.y = this.ckEffect.y + this.ckEffect.height;
         this.ckItem.y = this.ckChar.y;
         this.ckMap.y = this.ckItem.y + this.ckItem.height;
         this.ckMob.y = this.ckMap.y + this.ckMap.height;
         this.ckMorph.y = this.ckMob.y + this.ckMob.height;
         this.ckNPC.y = this.ckItem.y;
         this.ckSkill.y = this.ckNPC.y + this.ckNPC.height;
         this.ckEtc.y = this.ckSkill.y + this.ckSkill.height;
         this.selectAll.x = 363;
         this.selectAll.y = 105;
         this.selectNone.x = this.selectAll.x + this.selectAll.width;
         this.selectNone.y = this.selectAll.y;
         this.selectAll.addEventListener(MouseEvent.MOUSE_OVER,this.labelColorChange);
         this.selectNone.addEventListener(MouseEvent.MOUSE_OVER,this.labelColorChange);
         this.selectAll.addEventListener(MouseEvent.MOUSE_OUT,this.labelColorChange);
         this.selectNone.addEventListener(MouseEvent.MOUSE_OUT,this.labelColorChange);
         this.selectAll.addEventListener(MouseEvent.CLICK,this.selectClick);
         this.selectNone.addEventListener(MouseEvent.CLICK,this.selectClick);
         this.ckChar.selected = true;
         _loc1_.addChild(this.ckChar);
         _loc1_.addChild(this.ckPet);
         _loc1_.addChild(this.ckEffect);
         _loc1_.addChild(this.ckEtc);
         _loc1_.addChild(this.ckItem);
         _loc1_.addChild(this.ckMap);
         _loc1_.addChild(this.ckMob);
         _loc1_.addChild(this.ckMorph);
         _loc1_.addChild(this.ckNPC);
         _loc1_.addChild(this.ckSkill);
         _loc1_.addChild(this.ckChat);
         _loc1_.addChild(this.selectAll);
         _loc1_.addChild(this.selectNone);
         _loc1_.graphics.lineStyle(0,12172478);
         _loc1_.graphics.moveTo(0,0);
         _loc1_.graphics.lineTo(0,124);
         _loc1_.graphics.lineTo(487,124);
         _loc1_.graphics.lineTo(487,0);
         _loc1_.graphics.lineTo(69,0);
         return _loc1_;
      }
      
      private function buildTop(param1:int, param2:int) : Shape
      {
         var _loc3_:Shape = new Shape();
         var _loc4_:Matrix = new Matrix();
         _loc4_.createGradientBox(param1,param2,Math.PI / 180 * 150);
         _loc3_.graphics.beginGradientFill(GradientType.LINEAR,[10930923,4757192],[1,1],[0,255],_loc4_);
         _loc3_.graphics.drawRect(0,0,param1,param2);
         _loc3_.graphics.endFill();
         _loc3_.filters = [new GlowFilter(2648211,1,25,25,0.4,2,true)];
         return _loc3_;
      }
      
      private function selectClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget == this.selectAll)
         {
            this.ckChar.selected = true;
            this.ckChat.selected = true;
            this.ckEffect.selected = true;
            this.ckEtc.selected = true;
            this.ckItem.selected = true;
            this.ckMap.selected = true;
            this.ckMob.selected = true;
            this.ckMorph.selected = true;
            this.ckNPC.selected = true;
            this.ckPet.selected = true;
            this.ckSkill.selected = true;
         }
         else
         {
            false;
            this.ckChar.selected = !this.ckChar.enabled;
            false;
            this.ckChat.selected = !this.ckChat.enabled;
            false;
            this.ckEffect.selected = !this.ckEffect.enabled;
            false;
            this.ckEtc.selected = !this.ckEtc.enabled;
            false;
            this.ckItem.selected = !this.ckItem.enabled;
            false;
            this.ckMap.selected = !this.ckMap.enabled;
            false;
            this.ckMob.selected = !this.ckMob.enabled;
            false;
            this.ckMorph.selected = !this.ckMorph.enabled;
            false;
            this.ckNPC.selected = !this.ckNPC.enabled;
            false;
            this.ckPet.selected = !this.ckPet.enabled;
            false;
            this.ckSkill.selected = !this.ckSkill.enabled;
         }
      }
      
      private function labelColorChange(param1:MouseEvent) : void
      {
         var _loc2_:TextFormat = new TextFormat(InterfaceAssets.pfRondaSeven,8);
         if(param1.type == MouseEvent.MOUSE_OVER)
         {
            _loc2_.color = 14090240;
         }
         else
         {
            _loc2_.color = 0;
         }
         param1.currentTarget.setStyle("textFormat",_loc2_);
      }
      
      public function get thumbnails() : Boolean
      {
         return this.thumbs.selected;
      }
      
      public function set thumbnails(param1:Boolean) : void
      {
         this.thumbs.selected = param1;
         this.thumbs.enabled = !param1;
      }
      
      public function get character() : Boolean
      {
         return this.ckChar.selected;
      }
      
      public function set character(param1:Boolean) : void
      {
         this.ckChar.selected = param1;
         this.ckChar.enabled = !param1;
      }
      
      public function get pet() : Boolean
      {
         return this.ckPet.selected;
      }
      
      public function set pet(param1:Boolean) : void
      {
         this.ckPet.selected = param1;
         this.ckPet.enabled = !param1;
      }
      
      public function get effect() : Boolean
      {
         return this.ckEffect.selected;
      }
      
      public function set effect(param1:Boolean) : void
      {
         this.ckEffect.selected = param1;
         this.ckEffect.enabled = !param1;
      }
      
      public function get etc() : Boolean
      {
         return this.ckEtc.selected;
      }
      
      public function set etc(param1:Boolean) : void
      {
         this.ckEtc.selected = param1;
         this.ckEtc.enabled = !param1;
      }
      
      public function get item() : Boolean
      {
         return this.ckItem.selected;
      }
      
      public function set item(param1:Boolean) : void
      {
         this.ckItem.selected = param1;
         this.ckItem.enabled = !param1;
      }
      
      public function get map() : Boolean
      {
         return this.ckMap.selected;
      }
      
      public function set map(param1:Boolean) : void
      {
         this.ckMap.selected = param1;
         this.ckMap.enabled = !param1;
      }
      
      public function get mob() : Boolean
      {
         return this.ckMob.selected;
      }
      
      public function set mob(param1:Boolean) : void
      {
         this.ckMob.selected = param1;
         this.ckMob.enabled = !param1;
      }
      
      public function get morph() : Boolean
      {
         return this.ckMorph.selected;
      }
      
      public function set morph(param1:Boolean) : void
      {
         this.ckMorph.selected = param1;
         this.ckMorph.enabled = !param1;
      }
      
      public function get npc() : Boolean
      {
         return this.ckNPC.selected;
      }
      
      public function set npc(param1:Boolean) : void
      {
         this.ckNPC.selected = param1;
         this.ckNPC.enabled = !param1;
      }
      
      public function get skill() : Boolean
      {
         return this.ckSkill.selected;
      }
      
      public function set skill(param1:Boolean) : void
      {
         this.ckSkill.selected = param1;
         this.ckSkill.enabled = !param1;
      }
      
      public function get chat() : Boolean
      {
         return this.ckChat.selected;
      }
      
      public function set chat(param1:Boolean) : void
      {
         this.ckChat.selected = param1;
         this.ckChat.enabled = !param1;
      }
   }
}

