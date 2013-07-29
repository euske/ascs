package {

import flash.display.Sprite;
import flash.display.Bitmap;

//  Player
//
public class Player extends Actor
{
  // Player(scene, image)
  public function Player(scene:Scene, skin:Bitmap)
  {
    super(scene, skin);
  }

  public function get vx():int
  {
    return v.x;
  }
  public function set vx(value:int):void
  {
    v.x = value * 4;
  }
  public function get vy():int
  {
    return v.y;
  }
  public function set vy(value:int):void
  {
    v.y = value * 4;
  }

  // jump()
  public function jump():void
  {
  }
}

} // package
