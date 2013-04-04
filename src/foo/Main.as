// Main.as

package foo {

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageScaleMode;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.NetStatusEvent;
import flash.events.NetDataEvent;
import flash.media.Sound;
import flash.ui.Keyboard;
import foo.Logger;
import foo.Actor;
import foo.Scene;
import foo.TileMap;


//  Main 
//
[SWF(width="640", height="480", backgroundColor="#000000", frameRate=24)]
public class Main extends Sprite
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

  // Main()
  public function Main()
  {
    stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
    stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
    stage.addEventListener(Event.ENTER_FRAME, OnEnterFrame);
    stage.scaleMode = StageScaleMode.NO_SCALE;

    init(0);
  }

  // OnKeyDown(e)
  protected function OnKeyDown(e:KeyboardEvent):void 
  {
    keydown(e.keyCode);
  }

  // OnKeyUp(e)
  protected function OnKeyUp(e:KeyboardEvent):void 
  {
    keyup(e.keyCode);
  }

  // OnEnterFrame(e)
  protected function OnEnterFrame(e:Event):void
  {
    if (!paused) {
      update();
    }
  }

  /// Game-related functions

  private var state:int = 0;	// 0:title, 1:main
  private var paused:Boolean;
  private var scene:Scene;
  private var tilemap:TileMap;
  private var player:Actor;

  // init(state)
  private function init(state:int):void
  {
    removeChildren();
    addChild(new Logger());

    Logger.log("init "+state);

    switch (state) {
    case 0:
      break;

    case 1:
      tilemap = new TileMap(mapimage.bitmapData, tilesimage.bitmapData, 32);
      scene = new Scene(stage.stageWidth, stage.stageHeight, tilemap);
      player = new Actor(scene, playerimage);
      scene.add(player);
      addChild(background);
      addChild(tilemap);
      addChild(scene);
      paused = false;
      break;
    }

    this.state = state;
  }

  // keydown(keycode)
  private function keydown(keycode:int):void
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
      if (state == 0) {
	init(1);
      }
      break;

    case Keyboard.ESCAPE:	// Esc
    case 81:			// Q
      init(0);
      break;

    case 80:			// P
      // Toggle pause.
      paused = !paused;
      break;
    }
  }

  // keyup(keycode)
  private function keyup(keycode:int):void 
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

  // update()
  private function update():void
  {
    scene.update();
    scene.repaint();
  }

  // onActorAction()
  private function onActorAction(e:ActorActionEvent):void
  {
    if (e.arg == Actor.DIE) {
      scene.remove(Actor(e.currentTarget));
    }
  }

} // Main

} // package
