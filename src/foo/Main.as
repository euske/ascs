// Main.as

package foo {

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import foo.GameState;
import foo.Logger;

//  Main 
//
[SWF(width="640", height="480", backgroundColor="#000000", frameRate=24)]
public class Main extends Sprite
{
  private var state:GameState;
  private var paused:Boolean;

  // Main()
  public function Main()
  {
    stage.scaleMode = StageScaleMode.NO_SCALE;
    stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
    stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
    stage.addEventListener(Event.ENTER_FRAME, OnEnterFrame);

    SetGameState(new MainState(stage.stageWidth, stage.stageHeight));
  }

  // OnKeyDown(e)
  protected function OnKeyDown(e:KeyboardEvent):void 
  {
    switch (e.keyCode) {
    case 80:			// P
      // Toggle pause.
      paused = !paused;
      break;

    case Keyboard.ESCAPE:	// Esc
    case 81:			// Q
      SetGameState(new MainState(stage.stageWidth, stage.stageHeight));
      break;
    }
    
    if (state != null) {
      state.keydown(e.keyCode);
    }
  }

  // OnKeyUp(e)
  protected function OnKeyUp(e:KeyboardEvent):void 
  {
    if (state != null) {
      state.keyup(e.keyCode);
    }
  }

  // OnEnterFrame(e)
  protected function OnEnterFrame(e:Event):void
  {
    if (!paused) {
      if (state != null) {
	state.update();
      }
    }
  }

  protected function SetGameState(state:GameState):void
  {
    if (this.state != null) {
      Logger.log("close: "+this.state);
      this.state.close();
      removeChild(this.state);
    }
    this.state = state;
    if (this.state != null) {
      Logger.log("open: "+this.state);
      this.state.open();
      addChild(this.state);
    }
  }
} // Main

} // package
