package {

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.media.Sound;
import flash.geom.Point;

//  Player
//
public class Player extends Actor
{
  // Sound:
  [Embed(source="../assets/jump.mp3")]
  private static const JumpSoundCls:Class;
  private static const jump:Sound = new JumpSoundCls();

  public const speed:int = 8;
  public const gravity:int = 2;
  public const jumpacc:int = -24;
  public const maxacc:int = 16;

  public var vx:int = 0;
  public var vy:int = 0;
  private var vg:int;

  // Player(scene)
  public function Player(scene:Scene)
  {
    super(scene);
    vg = 0;
  }

  // update()
  public override function update():void
  {
    var isstoppable:Function = (function (b:int):Boolean { return b != 0; });
    var isobstacle:Function = (function (b:int):Boolean { return b < 0 || b == 1; });

    vg += gravity;
    if (maxacc < vg) {
      vg = maxacc;
    }
    var v0:Point = new Point(vx*speed, vg);
    var v1:Point = scene.tilemap.getCollisionByRect(bounds, v0, isstoppable);
    move(v1);
    move(scene.tilemap.getCollisionByRect(bounds, new Point(v0.x-v1.x, 0), isobstacle));
    move(scene.tilemap.getCollisionByRect(bounds, new Point(0, v0.y-v1.y), isobstacle));
    vg = v1.y;
  }

  // action()
  public function action():void
  {
    if (vg == 0) {
      vg = jumpacc;
      jump.play();
    }
  }
}

} // package
