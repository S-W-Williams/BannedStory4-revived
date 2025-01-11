package bs.gui
{
   import bs.gui.item.CustomMenuCell;
   import bs.utils.KeyboardHandler;
   import com.yahoo.astra.fl.controls.Menu;
   import com.yahoo.astra.fl.controls.MenuBar;
   import com.yahoo.astra.fl.data.XMLDataProvider;
   import com.yahoo.astra.fl.events.MenuEvent;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   
   public class TopMenuBar extends BaseSprite
   {
      private var menuBar:MenuBar;
      
      private var bg:Shape;
      
      private var _code:String = "";
      
      public function TopMenuBar()
      {
         super();
         this.bg = new Shape();
         var _loc1_:Matrix = new Matrix();
         _loc1_.createGradientBox(50,22,Math.PI / 2);
         this.bg.graphics.beginGradientFill(GradientType.LINEAR,[16777215,15132390],[1,1],[0,255],_loc1_);
         this.bg.graphics.moveTo(0,0);
         this.bg.graphics.lineTo(50,0);
         this.bg.graphics.lineStyle(0,10066329,1,true);
         this.bg.graphics.lineTo(50,22);
         this.bg.graphics.lineTo(0,22);
         this.bg.graphics.lineTo(0,0);
         this.bg.graphics.endFill();
         this.addEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.addChild(this.bg);
      }
      
      private function wasAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.wasAddedToStage);
         this.menuBar = new MenuBar(this);
         this.menuBar.dataProvider = this.buildMenuBar();
         this.menuBar.setStyle("skin",Shape);
         this.menuBar.addEventListener(MenuEvent.ITEM_CLICK,this.menuClick);
         this.menuBar.addEventListener(MenuEvent.MENU_SHOW,this.menuShow);
         this.addChild(this.menuBar);
      }
      
      override public function onStageResize() : void
      {
         this.bg.width = _stageWidth;
      }
      
      private function menuShow(param1:MenuEvent) : void
      {
         var _loc2_:Menu = param1.menu;
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215);
         _loc3_.graphics.drawRect(0,0,50,50);
         _loc3_.graphics.endFill();
         _loc3_.filters = [new DropShadowFilter(2,45,0,0.6,2,2)];
         _loc2_.width = 200;
         _loc2_.setStyle("cellRenderer",CustomMenuCell);
         _loc2_.setStyle("skin",_loc3_);
      }
      
      private function menuClick(param1:MenuEvent) : void
      {
         this._code = param1.item.code;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function buildMenuBar() : XMLDataProvider
      {
         var _loc1_:XML = <i>
				<i label="File">
					<i label="New Project" code="fileNewProject" icon="newDocument" shortcut={KeyboardHandler.KEY_CTR_N}/>
					<i label="Open Project" code="fileLoadProject" icon="folder" shortcut={KeyboardHandler.KEY_CTR_O}/>
					<i label="Save Project" code="fileSaveProject" icon="saveFile" shortcut={KeyboardHandler.KEY_CTR_S}/>
					
					<i type="separator"/>
					
					<i label="Import Project" code="importBSProject" icon="importDocument"/>
					<i label="Import Image" code="fileLoadImage" icon="folderImage"/>
					
					<i type="separator"/>
					
					<i label="Save PNG Image" icon="saveImage1">
						<i label="Whole Scene" code="fileSavePNGScene"/>
						<i label="Selected Image" code="fileSavePNGSelected"/>
					</i>
					<i label="Save JPG Image" icon="saveImage2">
						<i label="Whole Scene" code="fileSaveJPGScene"/>
						<i label="Selected Image" code="fileSaveJPGSelected"/>
					</i>
					
					<i label="Save Animation" icon="animation">
						<i label="As SWF" code="fileSaveSWF"/>
						<i label="As GIF" code="fileSaveGIF"/>
					</i>
					
					<i type="separator"/>
					
					<i label="Save Sprite Sheet" icon="spriteSheet">
						<i label="Normal Sprite Sheet" code="fileSaveNormalSpriteSheet" shortcut={KeyboardHandler
         .KEY_CTR_G}/>
						<i label="Sprite Sheet with Face Expressions" code="fileSaveSpriteSheetFace"/>
					</i>
					
					<i label="Save Photoshop Code" code="fileSavePhotoshopCode" icon="scriptPhotoshop" shortcut={KeyboardHandler.KEY_CTR_D}/>
					
					<i type="separator"/>
					
					<i label="Add new Category" code="fileAddCategory" icon="plusBS" shortcut={KeyboardHandler.KEY_CTR_B}/>
				</i>
				<i label="Layers">
					<i label="Create Layer" code="layersCreateLayer" icon="addLayer" shortcut={KeyboardHandler.KEY_CTR_L}/>
					
					<i type="separator"/>
					
					<i label="Clone Layer" code="editDuplicateImage" icon="copyImage" shortcut={KeyboardHandler.KEY_CTR_C}/>
					<i label="Clone Layer States" code="editCloneStates" icon="copyStates"/>
					<i label="Clone Layer Frames" code="editCloneFrames" icon="copyFrames"/>
					
					<i type="separator"/>
					
					<i label="Delete Layer" code="layersDeleteLayer" icon="removeLayer" shortcut={KeyboardHandler.KEY_DELETE}/>
					<i label="Explode Layer" code="editExplodeImage" icon="explode" shortcut={KeyboardHandler
         .KEY_CTR_T}/>
					<i label="Rasterize Layer" code="editRasterizeImage" icon="rasterize" shortcut={KeyboardHandler.KEY_CTR_R}/>
				</i>
				<i label="Tools">
					<i label="Use Normal Cursor" code="editToolsNormalSelect" icon="cursor" shortcut={KeyboardHandler.KEY_V}/>
					<i label="Use Transform Tool" code="editToolsTransform" icon="transformTool" shortcut={KeyboardHandler.KEY_B}/>
				</i>
				<i label="View">
					<i label="Full Screen" code="viewFullScreen" icon="fullScreen" shortcut={KeyboardHandler.KEY_CTR_F}/>
				</i>
				<i label="Window">
					<i label="Thumbnail Gallery" code="windowThumb" icon="winThumbnail" shortcut={KeyboardHandler.KEY_0}/>
					<i label="Layer Panel" code="windowLayer" icon="winLayer" shortcut={KeyboardHandler.KEY_1}/>
					<i label="Inventory Panel" code="windowInventory" icon="winInventory" shortcut={KeyboardHandler.KEY_2}/>
					<i label="Properties Panel" code="windowProperty" icon="winProperties" shortcut={KeyboardHandler.KEY_3}/>
					<i label="Random Generator" code="windowRandom" icon="winRandom" shortcut={KeyboardHandler
         .KEY_4}/>
					<i type="separator"/>
					<i label="Arrange Windows" code="windowArrangeWindows" shortcut={KeyboardHandler.KEY_SPACEBAR}/>
				</i>
				<i label="Help">
					<i label="User's Guide" code="helpGuide" shortcut={KeyboardHandler.KEY_CTR_H}/>
					<i label="About..." code="helpAbout" icon="informationLetter"/>
				</i>
			</i>;
         return new XMLDataProvider(_loc1_);
      }
      
      public function get code() : String
      {
         return this._code;
      }
      
      override public function get height() : Number
      {
         return 22;
      }
   }
}

