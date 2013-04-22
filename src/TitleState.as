package {

import flash.display.Bitmap;
import flash.events.Event;
import flash.ui.Keyboard;
import GameState;

//  TitleState
// 
public class TitleState extends GameState
{
  private var text:Bitmap;

  public function TitleState(width:int, height:int)
  {
    text = Main.Font.render("GAME\nPRESS ENTER TO START", 0x0000ff, 2);
    text.x = (width-text.width)/2;
    text.y = (height-text.height)/2;
  }

  // open()
  public override function open():void
  {
    addChild(text);
  }

  // close()
  public override function close():void
  {
    removeChild(text);
  }

  // keydown(keycode)
  public override function keydown(keycode:int):void
  {
    switch (keycode) {
    case Keyboard.SPACE:
    case Keyboard.ENTER:
    case 88:			// X
    case 90:			// Z
      dispatchEvent(new Event(CHANGED));
      break;

    }
  }
}

} // package
