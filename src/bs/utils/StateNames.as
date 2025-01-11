package bs.utils
{
   public class StateNames
   {
      public function StateNames()
      {
         super();
      }
      
      public static function petStateName(param1:String) : String
      {
         switch(param1)
         {
            case "stand0":
               param1 = "Standing 1";
               break;
            case "stand1":
               param1 = "Standing 2";
               break;
            case "move":
               param1 = "Moving";
               break;
            case "jump":
               param1 = "Jumping";
               break;
            case "rest0":
               param1 = "Resting";
               break;
            case "chat":
               param1 = "Talking";
               break;
            case "hang":
               param1 = "Hanging";
               break;
            case "rise":
               param1 = "Rising";
               break;
            case "stretch":
               param1 = "Stretching";
               break;
            case "cry":
               param1 = "Crying";
               break;
            case "fly":
               param1 = "Flying";
               break;
            case "nap":
               param1 = "Sleeping";
               break;
            case "tedious":
               param1 = "Bored";
               break;
            case "hug":
               param1 = "Hugging";
               break;
            case "donno":
               param1 = "Huh?";
               break;
            case "eye":
               param1 = "Mean Look";
               break;
            case "smile":
               param1 = "Smiling";
               break;
            case "eat":
               param1 = "Eating";
               break;
            case "play":
               param1 = "Playing";
               break;
            case "sleep":
               param1 = "Sleeping";
               break;
            case "deride":
               param1 = "Mock";
               break;
            case "wait":
               param1 = "Waiting";
               break;
            case "plot":
               param1 = "Mean Look";
               break;
            case "go":
               param1 = "Go!";
               break;
            case "warn":
               param1 = "Aggressive";
               break;
            case "irrelevant":
               param1 = "Huh?";
               break;
            case "good":
               param1 = "Good Boy!";
               break;
            case "fight":
               param1 = "Fighting";
               break;
            case "change":
               param1 = "Change 1";
               break;
            case "charge":
               param1 = "Charging";
               break;
            case "change1":
               param1 = "Change 2";
               break;
            case "dance":
               param1 = "Dancing";
               break;
            case "goodboy":
               param1 = "Good Boy!";
               break;
            case "birdeye":
               param1 = "Mean Look";
               break;
            case "imhungry":
               param1 = "Shock";
               break;
            case "jumpfly":
               param1 = "Jumping";
               break;
            case "kiss":
               param1 = "Kiss Me";
               break;
            case "puling":
               param1 = "Pulling";
               break;
            case "love2":
               param1 = "Blush";
               break;
            case "turn":
               param1 = "Spinning";
               break;
            case "sigh":
               param1 = "Sigh...";
         }
         var _loc2_:Array = param1.split(" ");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = _loc2_[_loc3_].charAt(0).toUpperCase() + _loc2_[_loc3_].substr(1);
            _loc3_++;
         }
         param1 = _loc2_.join(" ");
         return numberDivide(param1);
      }
      
      public static function charStateName(param1:String) : String
      {
         switch(param1)
         {
            case "walk1":
               return "Walking 1";
            case "walk2":
               return "Walking 2";
            case "stand1":
               return "Standing 1";
            case "stand2":
               return "Standing 2";
            case "alert":
               return "Alert";
            case "swingO1":
               return "1H Weapon Swing 1";
            case "swingO2":
               return "1H Weapon Swing 2";
            case "swingO3":
               return "1H Weapon Swing 3";
            case "swingOF":
               return "1H Weapon Swing 4";
            case "swingT1":
               return "2H Weapon Swing 1";
            case "swingT2":
               return "2H Weapon Swing 2";
            case "swingT3":
               return "2H Weapon Swing 3";
            case "swingTF":
               return "2H Weapon Swing 4";
            case "swingP1":
               return "2H Weapon Swing 5";
            case "swingP2":
               return "2H Weapon Swing 6";
            case "swingPF":
               return "2H Weapon Swing 7";
            case "stabO1":
               return "1H Weapon Stab 1";
            case "stabO2":
               return "1H Weapon Stab 2";
            case "stabOF":
               return "1H Weapon Stab 3";
            case "stabT1":
               return "2H Weapon Stab 1";
            case "stabT2":
               return "2H Weapon Stab 2";
            case "stabTF":
               return "2H Weapon Stab 3";
            case "shoot1":
               return "Weapon Shoot 1";
            case "shoot2":
               return "Weapon Shoot 2";
            case "shootF":
               return "Weapon Shoot 3";
            case "proneStab":
               return "On Floor Stab";
            case "prone":
               return "On Floor";
            case "heal":
               return "Healing";
            case "fly":
               return "Flying";
            case "jump":
               return "Jumping";
            case "sit":
               return "Sit";
            case "ladder":
               return "Climbing a Ladder";
            case "rope":
               return "Climbing a Rope";
            default:
               return numberDivide(param1);
         }
      }
      
      public static function regularStateName(param1:String) : String
      {
         param1 = param1.split(".").join(" ");
         var _loc2_:Array = param1.split(" ");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = _loc2_[_loc3_].charAt(0).toUpperCase() + _loc2_[_loc3_].substr(1);
            _loc3_++;
         }
         param1 = _loc2_.join(" ");
         return numberDivide(param1);
      }
      
      private static function numberDivide(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:Array = param1.split(" ");
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_];
            _loc4_ = "";
            if(isNaN(parseInt(_loc3_)))
            {
               while(!isNaN(parseInt(_loc3_.charAt(_loc3_.length - 1))) && _loc3_.length > 0)
               {
                  _loc4_ = _loc3_.charAt(_loc3_.length - 1) + _loc4_;
                  _loc3_ = _loc3_.substr(0,-1);
               }
               if(_loc4_ != "")
               {
                  _loc2_[_loc5_] = _loc3_ + " " + _loc4_;
               }
            }
            _loc5_++;
         }
         return _loc2_.join(" ");
      }
   }
}

