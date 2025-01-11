package maplestory.events
{
   public class AssetEvent
   {
      public static const ASSET_UPDATE:String = "assetUpdate";
      
      public static const ASSET_ITEM_LOADED:String = "assetItemLoaded";
      
      public static const ASSET_ITEM_ERROR:String = "assetItemError";
      
      public static const ASSET_ITEM_PROGRESS:String = "assetItemProgress";
      
      public static const FRAME_CHANGE:String = "assetFrameChange";
      
      public static const STATE_CHANGE:String = "assetStateChange";
      
      public static const FACE_FRAME_CHANGE:String = "assetFaceFrameChange";
      
      public static const FACE_STATE_CHANGE:String = "assetFaceStateChange";
      
      public function AssetEvent()
      {
         super();
      }
   }
}

