package {

import flash.display.Bitmap;
import flash.events.Event;
import flash.ui.Keyboard;
import baseui.Font;
import baseui.Screen;
import baseui.ScreenEvent;

//  MenuScreen
// 
public class MenuScreen extends Screen
{
  public function MenuScreen(width:int, height:int)
  {
    var text:Bitmap;
    text = Font.createText("GAME\nPRESS ENTER TO START", 0xffffff, 2, 2);
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
      dispatchEvent(new ScreenEvent(GameScreen));
      break;

    }
  }
}

} // package
