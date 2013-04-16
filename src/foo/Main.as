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

    SetGameState(new GameState1(stage.stageWidth, stage.stageHeight));
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
      SetGameState(new GameState1(stage.stageWidth, stage.stageHeight));
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

import flash.display.Bitmap;
import flash.media.Sound;
import flash.ui.Keyboard;
import foo.GameState;
import foo.Actor;
import foo.ActorActionEvent;
import foo.Scene;
import foo.TileMap;

class GameState1 extends GameState
{
  // Background image: 
  [Embed(source="../../assets/background.png", mimeType="image/png")]
  private static const BackgroundCls:Class;
  private static const background:Bitmap = new BackgroundCls();

  // Tile image:
  [Embed(source="../../assets/tiles.png", mimeType="image/png")]
  private static const TilesImageCls:Class;
  private static const tilesimage:Bitmap = new TilesImageCls();

  // Map image:
  [Embed(source="../../assets/map.png", mimeType="image/png")]
  private static const MapImageCls:Class;
  private static const mapimage:Bitmap = new MapImageCls();
  
  // Player image:
  [Embed(source="../../assets/player.png", mimeType="image/png")]
  private static const PlayerImageCls:Class;
  private static const playerimage:Bitmap = new PlayerImageCls();

  // Sound:
  [Embed(source="../../assets/sound.mp3")]
  private static const JumpSoundCls:Class;
  private static const jump:Sound = new JumpSoundCls();

  /// Game-related functions

  private var scene:Scene;
  private var tilemap:TileMap;
  private var player:Actor;

  public function GameState1(width:int, height:int)
  {
    tilemap = new TileMap(mapimage.bitmapData, tilesimage.bitmapData, 32);
    scene = new Scene(width, height, tilemap);
    player = new Actor(scene, playerimage);
    scene.add(player);
  }

  // open()
  public override function open():void
  {
    addChild(background);
    addChild(tilemap);
    addChild(scene);
  }

  // close()
  public override function close():void
  {
    removeChild(background);
    removeChild(tilemap);
    removeChild(scene);
  }

  // update()
  public override function update():void
  {
    scene.update();
    scene.repaint();
  }

  // keydown(keycode)
  public override function keydown(keycode:int):void
  {
    switch (keycode) {
    case Keyboard.LEFT:
    case 65:			// A
    case 72:			// H
      player.move(-1, 0);
      break;

    case Keyboard.RIGHT:
    case 68:			// D
    case 76:			// L
      player.move(+1, 0);
      break;

    case Keyboard.UP:
    case 87:			// W
    case 75:			// K
      player.move(0, -1);
      break;

    case Keyboard.DOWN:
    case 83:			// S
    case 74:			// J
      player.move(0, +1);
      break;

    case Keyboard.SPACE:
    case Keyboard.ENTER:
    case 88:			// X
    case 90:			// Z
      jump.play();
      break;

    }
  }

  // keyup(keycode)
  public override function keyup(keycode:int):void 
  {
    switch (keycode) {
    case Keyboard.LEFT:
    case Keyboard.RIGHT:
    case 65:			// A
    case 68:			// D
    case 72:			// H
    case 76:			// L
      player.move(0, 0);
      break;

    case Keyboard.UP:
    case Keyboard.DOWN:
    case 87:			// W
    case 75:			// K
    case 83:			// S
    case 74:			// J
      player.move(0, 0);
      break;
    }
  }

  // onActorAction()
  private function onActorAction(e:ActorActionEvent):void
  {
    if (e.arg == Actor.DIE) {
      scene.remove(Actor(e.currentTarget));
    }
  }
}
