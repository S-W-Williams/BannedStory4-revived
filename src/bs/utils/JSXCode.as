package bs.utils
{
   public class JSXCode
   {
      public function JSXCode()
      {
         super();
      }
      
      public static function build(param1:String, param2:int, param3:int) : String
      {
         var _loc4_:String = "";
         _loc4_ = _loc4_ + getHeader();
         _loc4_ = _loc4_ + ("var images = new Array(\n" + param1 + ");\n");
         _loc4_ = _loc4_ + (getFunctions() + "\n");
         return _loc4_ + getStarter(param2,param3);
      }
      
      private static function getHeader() : String
      {
         var _loc1_:* = "";
         _loc1_ += "/********************************************************************\n";
         _loc1_ += "BannedStory 4.0 by Ion - Animated Character Simulator for MapleStory.\n";
         _loc1_ += "All images used here are property of Nexon / Wizet.\n";
         _loc1_ += "I do not claim those images as mine, neither should you.\n";
         _loc1_ += "*********************************************************************/\n\n\n";
         _loc1_ += "var globalPath;\n";
         _loc1_ += "var docMain;\n";
         return _loc1_ + "var folder = Folder.selectDialog (\"Locate the folder where the images are stored\");\n\n";
      }
      
      private static function getFunctions() : String
      {
         return "function startProcess() {var setMaxCounter = 0;var setCounter = 0;var emptyLayer = docMain.activeLayer;for (var i = images.length - 1; i >= 0; --i) {var set;if (images[i].maxImages != undefined) {set = docMain.layerSets.add();set.name = images[i].name;setMaxCounter = images[i].maxImages;setCounter = 0;continue;}var fileImg = new File(globalPath + images[i].image);var docImg;try {docImg = app.open(fileImg);}catch (err) {alert(fileImg.fsName + \" was not found.\", \"Error\");continue;}docImg.activeLayer.copy();docImg.close(SaveOptions.DONOTSAVECHANGES);if (setCounter < setMaxCounter) {++setCounter;addImage(set.artLayers.add(), images[i]);}else {addImage(docMain.artLayers.add(), images[i]);}}try{emptyLayer.remove();docMain.trim(TrimType.TRANSPARENT);}catch (error) {}app.purge(PurgeTarget.ALLCACHES);}function addImage(layer, objImg) {docMain.paste();var layerBounds = layer.bounds;layer.name = objImg.image.split(\".png\")[0];layer.translate(-layerBounds[0] + objImg.x,-layerBounds[1] + objImg.y);}";
      }
      
      private static function getStarter(param1:int, param2:int) : String
      {
         return "if (folder != null) {globalPath = folder.fsName + \"/\";docMain = app.documents.add(" + param1 + "," + param2 + ", 72, \"BannedStory Image\", NewDocumentMode.RGB, DocumentFill.TRANSPARENT);startProcess();}";
      }
   }
}

