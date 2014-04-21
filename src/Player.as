package {

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.media.Sound;
import flash.geom.Point;

//  Player
//
public class Player extends Actor
{
  public var vx:int;
  public var vy:int;

  public const speed:int = 8;

  // Player(scene)
  public function Player(scene:Scene)
  {
    super(scene);
    vx = 0;
    vy = 0;
  }

  // update()
  public override function update():void
  {
    var dx:int = vx*speed;
    var dy:int = vy*speed;
    if (isMovable(dx, dy)) {
      move(dx, dy);
    }
  }

  // action()
  public function action():void
  {
  }
}

} // package
