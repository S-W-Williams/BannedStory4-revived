package bs.manager
{
   import bs.gui.Canvas;
   import bs.gui.win.FaceMixer;
   import bs.gui.win.Inventory;
   import bs.gui.win.Layer;
   import bs.gui.win.Properties;
   import bs.gui.win.StartUp;
   import bs.gui.win.ThumbnailGallery;
   
   public class BSCommon
   {
      public static var layer:Layer;
      
      public static var canvas:Canvas;
      
      public static var inventory:Inventory;
      
      public static var properties:Properties;
      
      public static var thumbs:ThumbnailGallery;
      
      public static var start:StartUp;
      
      public static var faceMixer:FaceMixer;
      
      public function BSCommon()
      {
         super();
      }
   }
}

