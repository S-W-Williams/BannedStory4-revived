package bs.utils
{
   import bs.events.InterfaceEvent;
   import fl.controls.BaseButton;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.system.Capabilities;
   import flash.text.TextField;
   
   public class KeyboardHandler extends EventDispatcher
   {
      public static var canContinue:Boolean;
      
      public static var KEY_CTR_B:String;
      
      public static var KEY_CTR_C:String;
      
      public static var KEY_CTR_D:String;
      
      public static var KEY_CTR_F:String;
      
      public static var KEY_CTR_G:String;
      
      public static var KEY_CTR_H:String;
      
      public static var KEY_CTR_L:String;
      
      public static var KEY_CTR_N:String;
      
      public static var KEY_CTR_O:String;
      
      public static var KEY_CTR_R:String;
      
      public static var KEY_CTR_S:String;
      
      public static var KEY_CTR_T:String;
      
      public static var KEY_B:String;
      
      public static var KEY_V:String;
      
      public static var KEY_0:String;
      
      public static var KEY_1:String;
      
      public static var KEY_2:String;
      
      public static var KEY_3:String;
      
      public static var KEY_4:String;
      
      public static var KEY_UP:String;
      
      public static var KEY_DOWN:String;
      
      public static var KEY_LEFT:String;
      
      public static var KEY_RIGHT:String;
      
      public static var KEY_SHIFT_UP:String;
      
      public static var KEY_SHIFT_DOWN:String;
      
      public static var KEY_SHIFT_LEFT:String;
      
      public static var KEY_SHIFT_RIGHT:String;
      
      public static var KEY_DELETE:String;
      
      public static var KEY_SPACEBAR:String;
      
      public var keyCode:String;
      
      private var stage:Stage;
      
      public function KeyboardHandler(param1:Stage)
      {
         super();
         var _loc2_:String = Capabilities.os.indexOf("Mac") != -1 ? "Opt" : "Ctrl";
         KEY_CTR_B = _loc2_ + " + B";
         KEY_CTR_C = _loc2_ + " + C";
         KEY_CTR_D = _loc2_ + " + D";
         KEY_CTR_F = _loc2_ + " + F";
         KEY_CTR_G = _loc2_ + " + G";
         KEY_CTR_H = _loc2_ + " + H";
         KEY_CTR_L = _loc2_ + " + L";
         KEY_CTR_N = _loc2_ + " + N";
         KEY_CTR_O = _loc2_ + " + O";
         KEY_CTR_R = _loc2_ + " + R";
         KEY_CTR_S = _loc2_ + " + S";
         KEY_CTR_T = _loc2_ + " + T";
         KEY_B = "B";
         KEY_V = "V";
         KEY_0 = "0";
         KEY_1 = "1";
         KEY_2 = "2";
         KEY_3 = "3";
         KEY_4 = "4";
         KEY_UP = "Up";
         KEY_DOWN = "Down";
         KEY_LEFT = "Left";
         KEY_RIGHT = "Right";
         KEY_SHIFT_UP = "Shift + Up";
         KEY_SHIFT_DOWN = "Shift + Down";
         KEY_SHIFT_LEFT = "Shift + Left";
         KEY_SHIFT_RIGHT = "Shift + Right";
         KEY_DELETE = "Delete";
         KEY_SPACEBAR = "Spacebar";
         this.stage = param1;
         canContinue = true;
         this.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         this.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
      }
      
      private function mouseDown(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton)
         {
            canContinue = false;
         }
         if(param1.target is TextField)
         {
            canContinue = false;
         }
      }
      
      private function keyDown(param1:KeyboardEvent) : void
      {
         this.keyCode = null;
         if(!canContinue)
         {
            return;
         }
         if(param1.ctrlKey)
         {
            switch(param1.keyCode)
            {
               case 66:
                  this.keyCode = KEY_CTR_B;
                  break;
               case 67:
                  this.keyCode = KEY_CTR_C;
                  break;
               case 68:
                  this.keyCode = KEY_CTR_D;
                  break;
               case 70:
                  this.keyCode = KEY_CTR_F;
                  break;
               case 71:
                  this.keyCode = KEY_CTR_G;
                  break;
               case 72:
                  this.keyCode = KEY_CTR_H;
                  break;
               case 76:
                  this.keyCode = KEY_CTR_L;
                  break;
               case 78:
                  this.keyCode = KEY_CTR_N;
                  break;
               case 79:
                  this.keyCode = KEY_CTR_O;
                  break;
               case 82:
                  this.keyCode = KEY_CTR_R;
                  break;
               case 83:
                  this.keyCode = KEY_CTR_S;
                  break;
               case 84:
                  this.keyCode = KEY_CTR_T;
            }
         }
         else if(param1.shiftKey)
         {
            switch(param1.keyCode)
            {
               case 38:
                  this.keyCode = KEY_SHIFT_UP;
                  break;
               case 40:
                  this.keyCode = KEY_SHIFT_DOWN;
                  break;
               case 37:
                  this.keyCode = KEY_SHIFT_LEFT;
                  break;
               case 39:
                  this.keyCode = KEY_SHIFT_RIGHT;
            }
         }
         else
         {
            switch(param1.keyCode)
            {
               case 66:
                  this.keyCode = KEY_B;
                  break;
               case 86:
                  this.keyCode = KEY_V;
                  break;
               case 96:
               case 48:
                  this.keyCode = KEY_0;
                  break;
               case 97:
               case 49:
                  this.keyCode = KEY_1;
                  break;
               case 98:
               case 50:
                  this.keyCode = KEY_2;
                  break;
               case 99:
               case 51:
                  this.keyCode = KEY_3;
                  break;
               case 100:
               case 52:
                  this.keyCode = KEY_4;
                  break;
               case 38:
                  this.keyCode = KEY_UP;
                  break;
               case 40:
                  this.keyCode = KEY_DOWN;
                  break;
               case 37:
                  this.keyCode = KEY_LEFT;
                  break;
               case 39:
                  this.keyCode = KEY_RIGHT;
                  break;
               case 46:
                  this.keyCode = KEY_DELETE;
                  break;
               case 32:
                  this.keyCode = KEY_SPACEBAR;
            }
         }
         if(this.keyCode != null)
         {
            this.dispatchEvent(new Event(InterfaceEvent.KEYBOARD_PRESS));
         }
      }
   }
}

