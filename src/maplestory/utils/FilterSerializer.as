package maplestory.utils
{
   import flash.filters.BevelFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   
   public class FilterSerializer
   {
      public static const BEVEL:int = 0;
      
      public static const BLUR:int = 1;
      
      public static const COLOR_TRANSFORM:int = 2;
      
      public static const GLOW:int = 3;
      
      public static const SHADOW:int = 4;
      
      public function FilterSerializer()
      {
         super();
      }
      
      public static function serialize(param1:*) : Object
      {
         var _loc2_:Object = {};
         if(param1 is DropShadowFilter)
         {
            _loc2_ = {
               "filterType":SHADOW,
               "blurX":param1.blurX,
               "blurY":param1.blurY,
               "color":param1.color,
               "alpha":param1.alpha,
               "quality":param1.quality,
               "angle":param1.angle,
               "distance":param1.distance,
               "knockout":param1.knockout,
               "hideObject":param1.hideObject,
               "inner":param1.inner
            };
         }
         else if(param1 is GlowFilter)
         {
            _loc2_ = {
               "filterType":GLOW,
               "blurX":param1.blurX,
               "blurY":param1.blurY,
               "color":param1.color,
               "alpha":param1.alpha,
               "quality":param1.quality,
               "knockout":param1.knockout,
               "inner":param1.inner
            };
         }
         else if(param1 is ColorMatrixFilter)
         {
            _loc2_ = {
               "filterType":COLOR_TRANSFORM,
               "matrix":param1.matrix
            };
         }
         else if(param1 is BlurFilter)
         {
            _loc2_ = {
               "filterType":BLUR,
               "blurX":param1.blurX,
               "blurY":param1.blurY,
               "quality":param1.quality
            };
         }
         else if(param1 is BevelFilter)
         {
            _loc2_ = {
               "filterType":BEVEL,
               "blurX":param1.blurX,
               "blurY":param1.blurY,
               "shadowColor":param1.shadowColor,
               "highlightColor":param1.highlightColor,
               "strength":param1.strength,
               "quality":param1.quality,
               "angle":param1.angle,
               "distance":param1.distance,
               "knockout":param1.knockout
            };
         }
         return _loc2_;
      }
      
      public static function unserialize(param1:Object) : *
      {
         var _loc3_:DropShadowFilter = null;
         var _loc4_:GlowFilter = null;
         var _loc5_:ColorMatrixFilter = null;
         var _loc6_:BlurFilter = null;
         var _loc7_:BevelFilter = null;
         var _loc2_:int = int(param1.filterType);
         if(_loc2_ == SHADOW)
         {
            _loc3_ = new DropShadowFilter();
            _loc3_.blurX = param1.blurX;
            _loc3_.blurY = param1.blurY;
            _loc3_.color = param1.color;
            _loc3_.alpha = param1.alpha;
            _loc3_.quality = param1.quality;
            _loc3_.angle = param1.angle;
            _loc3_.distance = param1.distance;
            _loc3_.knockout = param1.knockout;
            _loc3_.hideObject = param1.hideObject;
            _loc3_.inner = param1.inner;
            return _loc3_;
         }
         if(_loc2_ == GLOW)
         {
            _loc4_ = new GlowFilter();
            _loc4_.blurX = param1.blurX;
            _loc4_.blurY = param1.blurY;
            _loc4_.color = param1.color;
            _loc4_.alpha = param1.alpha;
            _loc4_.quality = param1.quality;
            _loc4_.knockout = param1.knockout;
            _loc4_.inner = param1.inner;
            return _loc4_;
         }
         if(_loc2_ == COLOR_TRANSFORM)
         {
            _loc5_ = new ColorMatrixFilter();
            _loc5_.matrix = param1.matrix as Array;
            return _loc5_;
         }
         if(_loc2_ == BLUR)
         {
            _loc6_ = new BlurFilter();
            _loc6_.blurX = param1.blurX;
            _loc6_.blurY = param1.blurY;
            _loc6_.quality = param1.quality;
            return _loc6_;
         }
         if(_loc2_ == BEVEL)
         {
            _loc7_ = new BevelFilter();
            _loc7_.blurX = param1.blurX;
            _loc7_.blurY = param1.blurY;
            _loc7_.shadowColor = param1.shadowColor;
            _loc7_.highlightColor = param1.highlightColor;
            _loc7_.strength = param1.strength;
            _loc7_.quality = param1.quality;
            _loc7_.angle = param1.angle;
            _loc7_.distance = param1.distance;
            _loc7_.knockout = param1.knockout;
            return _loc7_;
         }
         return null;
      }
   }
}

