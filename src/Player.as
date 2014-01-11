package {

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.media.Sound;
import flash.geom.Point;

//  Player
//
public class Player extends Actor
{
  public var dir:Point;

  public const speed:int = 8;

  // Player(scene)
  public function Player(scene:Scene)
  {
    super(scene);
    dir = new Point(0, 0);
  }

  // update()
  public override function update():void
  {
    move(new Point(dir.x*speed, dir.y*speed));
  }

  // move(v)
  public function move(v:Point):void
  {
    pos = Utils.movePoint(pos, v.x, v.y);
  }

  // action()
  public function action():void
  {
  }
}

} // package
