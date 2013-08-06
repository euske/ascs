package {

import flash.display.Bitmap;
import flash.events.Event;
import flash.ui.Keyboard;

//  MainState
//
public class MainState extends GameState
{
  public static const NAME:String = "MainState";
  
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

  /// Game-related functions

  private var scene:Scene;
  private var tilemap:TileMap;
  private var player:Player;

  public function MainState(width:int, height:int)
  {
    tilemap = new TileMap(mapimage.bitmapData, tilesimage.bitmapData, 32);
    scene = new Scene(width, height, tilemap);
    player = new Player(scene);
    player.skin = playerimage;
    scene.add(player);
    addChild(tilemap);
    addChild(scene);
  }

  // open()
  public override function open():void
  {
    player.bounds = tilemap.getTileRect(3, 3);
  }

  // close()
  public override function close():void
  {
  }

  // update()
  public override function update():void
  {
    scene.update();
    scene.setCenter(player.pos, 100, 100);
    scene.repaint();
  }

  // keydown(keycode)
  public override function keydown(keycode:int):void
  {
    switch (keycode) {
    case Keyboard.LEFT:
    case 65:			// A
    case 72:			// H
      player.dir.x = -1;
      break;

    case Keyboard.RIGHT:
    case 68:			// D
    case 76:			// L
      player.dir.x = +1;
      break;

    case Keyboard.UP:
    case 87:			// W
    case 75:			// K
      player.dir.y = -1;
      break;

    case Keyboard.DOWN:
    case 83:			// S
    case 74:			// J
      player.dir.y = +1;
      break;

    case Keyboard.SPACE:
    case Keyboard.ENTER:
    case 88:			// X
    case 90:			// Z
      player.action();
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
      player.dir.x = 0;
      break;

    case Keyboard.UP:
    case Keyboard.DOWN:
    case 87:			// W
    case 75:			// K
    case 83:			// S
    case 74:			// J
      player.dir.y = 0;
      break;
    }
  }
}

} // package
