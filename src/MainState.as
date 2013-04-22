package {

import flash.display.Bitmap;
import flash.events.Event;
import flash.media.Sound;
import flash.ui.Keyboard;
import GameState;
import Actor;
import Scene;
import TileMap;

//  MainState
//
public class MainState extends GameState
{
  // Tile image:
  [Embed(source="../assets/tiles.png", mimeType="image/png")]
  private static const TilesImageCls:Class;
  private static const tilesimage:Bitmap = new TilesImageCls();

  // Map image:
  [Embed(source="../assets/map.png", mimeType="image/png")]
  private static const MapImageCls:Class;
  private static const mapimage:Bitmap = new MapImageCls();
  
  // Player image:
  [Embed(source="../assets/player.png", mimeType="image/png")]
  private static const PlayerImageCls:Class;
  private static const playerimage:Bitmap = new PlayerImageCls();

  // Sound:
  [Embed(source="../assets/sound.mp3")]
  private static const JumpSoundCls:Class;
  private static const jump:Sound = new JumpSoundCls();

  /// Game-related functions

  private var scene:Scene;
  private var tilemap:TileMap;
  private var player:Actor;

  public function MainState(width:int, height:int)
  {
    tilemap = new TileMap(mapimage.bitmapData, tilesimage.bitmapData, 32);
    scene = new Scene(width, height, tilemap);
    player = new Actor(scene, playerimage);
    scene.add(player);
  }

  // open()
  public override function open():void
  {
    addChild(tilemap);
    addChild(scene);
  }

  // close()
  public override function close():void
  {
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
      Main.log("foo");
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
}

} // package
