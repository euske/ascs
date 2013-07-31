package {

import flash.display.Bitmap;
import flash.events.Event;
import flash.ui.Keyboard;
import GameState;

//  MenuState
// 
public class MenuState extends GameState
{
  public static const NAME:String = "MenuState";

  public function MenuState(width:int, height:int)
  {
    var text:Bitmap;
    text = Main.font.create("GAME\nPRESS ENTER TO START", 0xffffff, 2, 2);
    text.x = Math.floor(width-text.width)/2;
    text.y = Math.floor(height-text.height)/2;
    addChild(text);
  }

  // keydown(keycode)
  public override function keydown(keycode:int):void
  {
    switch (keycode) {
    case Keyboard.SPACE:
    case Keyboard.ENTER:
    case 88:			// X
    case 90:			// Z
      dispatchEvent(new GameStateEvent(MainState.NAME));
      break;

    }
  }
}

} // package
