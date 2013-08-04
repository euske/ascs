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

  private static var isstoppable:Function = 
    (function (b:int):Boolean { return b != 0; });
  private static var isobstacle:Function =
    (function (b:int):Boolean { return b < 0 || b == 1; });

  // Player(scene)
  public function Player(scene:Scene)
  {
    super(scene);
    vg = 0;
  }

  // update()
  public override function update():void
  {
    var v0:Point = new Point(vx*speed, Math.min(maxacc, vg+gravity));
    var v1:Point = scene.tilemap.getCollisionByRect(bounds, v0, isstoppable);
    move(v1);
    move(scene.tilemap.getCollisionByRect(bounds, new Point(v0.x-v1.x, 0), isobstacle));
    var v2:Point = scene.tilemap.getCollisionByRect(bounds, new Point(0, v0.y-v1.y), isstoppable);
    move(v2);
    vg = v1.y+v2.y;
  }

  // action()
  public function action():void
  {
    if (scene.tilemap.hasCollisionByRect(bounds, new Point(0, 1), isstoppable)) {
      vg = jumpacc;
      jump.play();
    }
  }
}

} // package
