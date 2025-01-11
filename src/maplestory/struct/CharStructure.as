package maplestory.struct
{
   import flash.utils.Dictionary;
   
   public class CharStructure
   {
      private static var bodyList:Dictionary;
      
      private static var faceList:Dictionary;
      
      private static var bodyXML:XML;
      
      private static var faceXML:XML;
      
      public function CharStructure()
      {
         super();
      }
      
      public static function getFaceXML() : XML
      {
         if(faceXML == null)
         {
            buildFaceXML();
         }
         return faceXML.copy();
      }
      
      public static function getBodyXML() : XML
      {
         if(bodyXML == null)
         {
            buildBodyXML();
         }
         return bodyXML.copy();
      }
      
      public static function getBody(param1:String, param2:int) : Object
      {
         if(bodyList == null)
         {
            buildBodyList();
         }
         if(bodyList[param1 + "." + param2] == undefined)
         {
            return null;
         }
         return bodyList[param1 + "." + param2];
      }
      
      private static function buildFaceXML() : void
      {
         faceXML = <i>
			  <i name="blink">
				<i name="0" delay="2000"/>
				<i name="1" delay="60"/>
				<i name="2" delay="60"/>
			  </i>
			  <i name="hit">
				<i name="0" delay="100"/>
			  </i>
			  <i name="smile">
				<i name="0" delay="100"/>
			  </i>
			  <i name="troubled">
				<i name="0" delay="100"/>
			  </i>
			  <i name="cry">
				<i name="0" delay="100"/>
			  </i>
			  <i name="angry">
				<i name="0" delay="100"/>
			  </i>
			  <i name="bewildered">
				<i name="0" delay="100"/>
			  </i>
			  <i name="stunned">
				<i name="0" delay="100"/>
			  </i>
			  <i name="vomit">
				<i name="0" delay="120"/>
				<i name="1" delay="120"/>
			  </i>
			  <i name="oops">
				<i name="0" delay="100"/>
			  </i>
			  <i name="cheers">
				<i name="0" delay="100"/>
			  </i>
			  <i name="chu">
				<i name="0" delay="100"/>
			  </i>
			  <i name="wink">
				<i name="0" delay="100"/>
			  </i>
			  <i name="pain">
				<i name="0" delay="100"/>
			  </i>
			  <i name="glitter">
				<i name="0" delay="150"/>
				<i name="1" delay="150"/>
			  </i>
			  <i name="despair">
				<i name="0" delay="150"/>
				<i name="1" delay="150"/>
			  </i>
			  <i name="love">
				<i name="0" delay="150"/>
				<i name="1" delay="150"/>
			  </i>
			  <i name="shine">
				<i name="0" delay="100"/>
			  </i>
			  <i name="blaze">
				<i name="0" delay="110"/>
				<i name="1" delay="110"/>
			  </i>
			  <i name="hum">
				<i name="0" delay="110"/>
				<i name="1" delay="110"/>
			  </i>
			  <i name="bowing">
				<i name="0" delay="110"/>
				<i name="1" delay="110"/>
			  </i>
			  <i name="hot">
				<i name="0" delay="110"/>
				<i name="1" delay="110"/>
			  </i>
			  <i name="dam">
				<i name="0" delay="240"/>
				<i name="1" delay="240"/>
			  </i>
			  
			  <i name="bangle">
				<i name="0" delay="240"/>
				<i name="1" delay="240"/>
				<i name="2" delay="240"/>
				<i name="3" delay="240"/>
				<i name="4" delay="240"/>
				<i name="5" delay="240"/>
				<i name="6" delay="240"/>
				<i name="7" delay="240"/>
			  </i>
			  
			  <i name="setback">
				<i name="0" delay="240"/>
				<i name="1" delay="240"/>
				<i name="2" delay="240"/>
				<i name="3" delay="240"/>
				<i name="4" delay="240"/>
				<i name="5" delay="240"/>
				<i name="6" delay="240"/>
				<i name="7" delay="240"/>
			  </i>
			  
			  <i name="wickedness">
				<i name="0" delay="240"/>
				<i name="1" delay="240"/>
				<i name="2" delay="240"/>
				<i name="3" delay="240"/>
				<i name="4" delay="240"/>
				<i name="5" delay="240"/>
				<i name="6" delay="240"/>
				<i name="7" delay="240"/>
			  </i>
			  
			</i>;
      }
      
      private static function buildBodyXML() : void
      {
         bodyXML = <i>
			  <i name="walk1">
				<i name="0" delay="180"/>
				<i name="1" delay="180"/>
				<i name="2" delay="180"/>
				<i name="3" delay="180"/>
			  </i>
			  <i name="walk2">
				<i name="0" delay="180"/>
				<i name="1" delay="180"/>
				<i name="2" delay="180"/>
				<i name="3" delay="180"/>
			  </i>
			  <i name="stand1" zigzag="1">
				<i name="0" delay="500"/>
				<i name="1" delay="500"/>
				<i name="2" delay="500"/>
			  </i>
			  <i name="stand2" zigzag="1">
				<i name="0" delay="500"/>
				<i name="1" delay="500"/>
				<i name="2" delay="500"/>
			  </i>
			  <i name="alert" zigzag="1">
				<i name="0" delay="500"/>
				<i name="1" delay="500"/>
				<i name="2" delay="500"/>
			  </i>
			  <i name="swingO1">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingO2">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingO3">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingOF">
				<i name="0" delay="200"/>
				<i name="1" delay="100"/>
				<i name="2" delay="100"/>
				<i name="3" delay="300"/>
			  </i>
			  <i name="swingT1">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingT2">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingT3">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingTF">
				<i name="0" delay="200"/>
				<i name="1" delay="150"/>
				<i name="2" delay="150"/>
				<i name="3" delay="200"/>
			  </i>
			  <i name="swingP1">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingP2">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="swingPF">
				<i name="0" delay="100"/>
				<i name="1" delay="200"/>
				<i name="2" delay="200"/>
				<i name="3" delay="200"/>
			  </i>
			  <i name="stabO1">
				<i name="0" delay="350"/>
				<i name="1" delay="450"/>
			  </i>
			  <i name="stabO2">
				<i name="0" delay="350"/>
				<i name="1" delay="450"/>
			  </i>
			  <i name="stabOF">
				<i name="0" delay="250"/>
				<i name="1" delay="150"/>
				<i name="2" delay="300"/>
			  </i>
			  <i name="stabT1">
				<i name="0" delay="300"/>
				<i name="1" delay="100"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="stabT2">
				<i name="0" delay="300"/>
				<i name="1" delay="100"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="stabTF">
				<i name="0" delay="100"/>
				<i name="1" delay="200"/>
				<i name="2" delay="200"/>
				<i name="3" delay="200"/>
			  </i>
			  <i name="shoot1">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="shoot2">
				<i name="0" delay="160"/>
				<i name="1" delay="160"/>
				<i name="2" delay="250"/>
				<i name="3" delay="100"/>
				<i name="4" delay="150"/>
			  </i>
			  <i name="shootF">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="250"/>
			  </i>
			  <i name="proneStab">
				<i name="0" delay="300"/>
				<i name="1" delay="400"/>
			  </i>
			  <i name="prone">
				<i name="0" delay="100"/>
			  </i>
			  <i name="heal">
				<i name="0" delay="300"/>
				<i name="1" delay="150"/>
				<i name="2" delay="350"/>
			  </i>
			  <i name="fly">
				<i name="0" delay="300"/>
				<i name="1" delay="300"/>
			  </i>
			  <i name="jump">
				<i name="0" delay="200"/>
			  </i>
			  <i name="sit">
				<i name="0" delay="100"/>
			  </i>
			  <i name="ladder">
				<i name="0" delay="250"/>
				<i name="1" delay="250"/>
			  </i>
			  <i name="rope">
				<i name="0" delay="250"/>
				<i name="1" delay="250"/>
			  </i>
			</i>;
      }
      
      private static function buildBodyList() : void
      {
         bodyList = new Dictionary(true);
         bodyList["walk1.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["walk1.1"] = {
            "x":-8,
            "y":-51,
            "face":true
         };
         bodyList["walk1.2"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["walk1.3"] = {
            "x":-8,
            "y":-51,
            "face":true
         };
         bodyList["walk2.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["walk2.1"] = {
            "x":-8,
            "y":-51,
            "face":true
         };
         bodyList["walk2.2"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["walk2.3"] = {
            "x":-8,
            "y":-51,
            "face":true
         };
         bodyList["stand1.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["stand1.1"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["stand1.2"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["stand2.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["stand2.1"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["stand2.2"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["alert.0"] = {
            "x":-8,
            "y":-49,
            "face":true
         };
         bodyList["alert.1"] = {
            "x":-8,
            "y":-50,
            "face":true
         };
         bodyList["alert.2"] = {
            "x":-8,
            "y":-51,
            "face":true
         };
         bodyList["swingO1.0"] = {
            "x":-13,
            "y":-46,
            "face":true
         };
         bodyList["swingO1.1"] = {
            "x":-14,
            "y":-51,
            "face":true
         };
         bodyList["swingO1.2"] = {
            "x":-41,
            "y":-45,
            "face":true
         };
         bodyList["swingO2.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["swingO2.1"] = {
            "x":-17,
            "y":-50,
            "face":true
         };
         bodyList["swingO2.2"] = {
            "x":-21,
            "y":-47,
            "face":true
         };
         bodyList["swingO3.0"] = {
            "x":-15,
            "y":-47,
            "face":true
         };
         bodyList["swingO3.1"] = {
            "x":-35,
            "y":-48,
            "face":true
         };
         bodyList["swingO3.2"] = {
            "x":-38,
            "y":-46,
            "face":true
         };
         bodyList["swingOF.0"] = {
            "x":-18,
            "y":-46,
            "face":true
         };
         bodyList["swingOF.1"] = {
            "x":-13,
            "y":-62,
            "face":false
         };
         bodyList["swingOF.2"] = {
            "x":-33,
            "y":-58,
            "face":true
         };
         bodyList["swingOF.3"] = {
            "x":-56,
            "y":-41,
            "face":true
         };
         bodyList["swingT1.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["swingT1.1"] = {
            "x":-23,
            "y":-50,
            "face":true
         };
         bodyList["swingT1.2"] = {
            "x":-37,
            "y":-45,
            "face":true
         };
         bodyList["swingT2.0"] = {
            "x":-8,
            "y":-50,
            "face":true
         };
         bodyList["swingT2.1"] = {
            "x":-17,
            "y":-50,
            "face":true
         };
         bodyList["swingT2.2"] = {
            "x":-37,
            "y":-44,
            "face":true
         };
         bodyList["swingT3.0"] = {
            "x":-8,
            "y":-50,
            "face":true
         };
         bodyList["swingT3.1"] = {
            "x":-20,
            "y":-44,
            "face":true
         };
         bodyList["swingT3.2"] = {
            "x":-24,
            "y":-47,
            "face":true
         };
         bodyList["swingTF.0"] = {
            "x":-9,
            "y":-52,
            "face":false
         };
         bodyList["swingTF.1"] = {
            "x":-13,
            "y":-53,
            "face":true
         };
         bodyList["swingTF.2"] = {
            "x":-26,
            "y":-50,
            "face":true
         };
         bodyList["swingTF.3"] = {
            "x":-41,
            "y":-44,
            "face":true
         };
         bodyList["swingP1.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["swingP1.1"] = {
            "x":-23,
            "y":-50,
            "face":true
         };
         bodyList["swingP1.2"] = {
            "x":-37,
            "y":-45,
            "face":true
         };
         bodyList["swingP2.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["swingP2.1"] = {
            "x":-17,
            "y":-50,
            "face":true
         };
         bodyList["swingP2.2"] = {
            "x":-33,
            "y":-44,
            "face":true
         };
         bodyList["swingPF.0"] = {
            "x":-15,
            "y":-47,
            "face":true
         };
         bodyList["swingPF.1"] = {
            "x":-15,
            "y":-46,
            "face":true
         };
         bodyList["swingPF.2"] = {
            "x":-25,
            "y":-78,
            "face":true
         };
         bodyList["swingPF.3"] = {
            "x":-52,
            "y":-45,
            "face":true
         };
         bodyList["stabO1.0"] = {
            "x":-8,
            "y":-49,
            "face":true
         };
         bodyList["stabO1.1"] = {
            "x":-27,
            "y":-46,
            "face":true
         };
         bodyList["stabO2.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["stabO2.1"] = {
            "x":-30,
            "y":-45,
            "face":true
         };
         bodyList["stabOF.0"] = {
            "x":-9,
            "y":-45,
            "face":true
         };
         bodyList["stabOF.1"] = {
            "x":-34,
            "y":-50,
            "face":true
         };
         bodyList["stabOF.2"] = {
            "x":-54,
            "y":-44,
            "face":true
         };
         bodyList["stabT1.0"] = {
            "x":-22,
            "y":-48,
            "face":true
         };
         bodyList["stabT1.1"] = {
            "x":-35,
            "y":-44,
            "face":true
         };
         bodyList["stabT1.2"] = {
            "x":-39,
            "y":-43,
            "face":true
         };
         bodyList["stabT2.0"] = {
            "x":-13,
            "y":-49,
            "face":true
         };
         bodyList["stabT2.1"] = {
            "x":-29,
            "y":-42,
            "face":true
         };
         bodyList["stabT2.2"] = {
            "x":-32,
            "y":-43,
            "face":true
         };
         bodyList["stabTF.0"] = {
            "x":-15,
            "y":-47,
            "face":true
         };
         bodyList["stabTF.1"] = {
            "x":-15,
            "y":-46,
            "face":true
         };
         bodyList["stabTF.2"] = {
            "x":-25,
            "y":-78,
            "face":true
         };
         bodyList["stabTF.3"] = {
            "x":-39,
            "y":-43,
            "face":true
         };
         bodyList["shoot1.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["shoot1.1"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["shoot1.2"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["shoot2.0"] = {
            "x":-9,
            "y":-51,
            "face":true
         };
         bodyList["shoot2.1"] = {
            "x":-9,
            "y":-51,
            "face":true
         };
         bodyList["shoot2.2"] = {
            "x":-9,
            "y":-51,
            "face":true
         };
         bodyList["shoot2.3"] = {
            "x":-9,
            "y":-51,
            "face":true
         };
         bodyList["shoot2.4"] = {
            "x":-8,
            "y":-51,
            "face":true
         };
         bodyList["shootF.0"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["shootF.1"] = {
            "x":-7,
            "y":-51,
            "face":true
         };
         bodyList["shootF.2"] = {
            "x":-7,
            "y":-51,
            "face":true
         };
         bodyList["proneStab.0"] = {
            "x":-27,
            "y":-24,
            "face":true
         };
         bodyList["proneStab.1"] = {
            "x":-27,
            "y":-24,
            "face":true
         };
         bodyList["prone.0"] = {
            "x":-27,
            "y":-24,
            "face":true
         };
         bodyList["heal.0"] = {
            "x":-8,
            "y":-50,
            "face":true
         };
         bodyList["heal.1"] = {
            "x":-15,
            "y":-50,
            "face":true
         };
         bodyList["heal.2"] = {
            "x":-8,
            "y":-52,
            "face":true
         };
         bodyList["fly.0"] = {
            "x":-8,
            "y":-57,
            "face":true
         };
         bodyList["fly.1"] = {
            "x":-8,
            "y":-57,
            "face":true
         };
         bodyList["jump.0"] = {
            "x":-8,
            "y":-50,
            "face":true
         };
         bodyList["sit.0"] = {
            "x":-5,
            "y":-48,
            "face":true
         };
         bodyList["ladder.0"] = {
            "x":-5,
            "y":-50,
            "face":false
         };
         bodyList["ladder.1"] = {
            "x":-2,
            "y":-48,
            "face":false
         };
         bodyList["rope.0"] = {
            "x":-3,
            "y":-53,
            "face":false
         };
         bodyList["rope.1"] = {
            "x":-3,
            "y":-48,
            "face":false
         };
      }
   }
}

