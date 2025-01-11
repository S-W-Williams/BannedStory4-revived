package bs.events
{
   public class InterfaceEvent
   {
      public static const STARTUP_DONE:String = "interfaceStartupDone";
      
      public static const THUMBNAIL_CLICK:String = "interfaceThumbnailClick";
      
      public static const TOOLBAR_CLICK:String = "interfaceToolbarClick";
      
      public static const LAYER_CREATED:String = "interfaceLayerCreated";
      
      public static const LAYER_REMOVED:String = "interfaceLayerRemoved";
      
      public static const LAYER_CHANGE:String = "interfaceLayerChange";
      
      public static const LAYER_THUMBNAIL:String = "interfaceLayerThumbnail";
      
      public static const LAYER_SORT:String = "interfaceLayerSort";
      
      public static const LAYER_VISIBLE:String = "interfaceLayerVisible";
      
      public static const CANVAS_CLICK:String = "interfaceCanvasClick";
      
      public static const CANVAS_COLOR:String = "interfaceCanvasColor";
      
      public static const CANVAS_ZOOM:String = "interfaceCanvasZoom";
      
      public static const ITEM_REMOVED:String = "interfaceInventoryItemRemoved";
      
      public static const ITEM_VISIBLE:String = "interfaceInventoryItemVisible";
      
      public static const ITEM_COLOR:String = "interfaceInventoryItemColor";
      
      public static const ITEM_RESET_COLOR:String = "interfaceInventoryResetColor";
      
      public static const ITEM_CLIENT_CHANGE:String = "interfaceInventoryClientChange";
      
      public static const FACE_MIXER_ITEM_LOADED:String = "faceMixerItemLoaded";
      
      public static const FACE_MIXER_DONE:String = "faceMixerDone";
      
      public static const FACE_MIXER_PIECE_CLICK:String = "faceMixerPieceClick";
      
      public static const FILTER_COLOR_UPDATE:String = "interfaceProperitesFilterColor";
      
      public static const PROPERTIES_SHOW_FACE_MIXER:String = "propertiesShowFaceMixer";
      
      public static const ALERT_CLICK:String = "interfaceAlertButtonClick";
      
      public static const RANDOM_GENERATE:String = "interfaceRandomGeneratorMake";
      
      public static const CUSTOM_CELL_VISIBLE:String = "interfaceCustomCellRendererVisible";
      
      public static const PROJECT_UPDATE:String = "projectLoaderInterfaceUpdate";
      
      public static const TRANSFORMTOOL_RESET:String = "transformToolResetItem";
      
      public static const TRANSFORMTOOL_FLIP_V:String = "transformToolFlipVerticalItem";
      
      public static const TRANSFORMTOOL_FLIP_H:String = "transformToolFlipHorizontalItem";
      
      public static const TRANSFORMTOOL_MOVE_CENTER:String = "transformToolMoveCenterItem";
      
      public static const KEYBOARD_PRESS:String = "keyboardPressEvent";
      
      public function InterfaceEvent()
      {
         super();
      }
   }
}

