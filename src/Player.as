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
  public const jumpacc:int = 24;

  public var dir:Point;
  private var vg:int;

  private static var isstoppable:Function = 
    (function (b:int):Boolean { return b != 0; });
  private static var isobstacle:Function =
    (function (b:int):Boolean { return b < 0 || b == 1; });

  // Player(scene)
  public function Player(scene:Scene)
  {
    super(scene);
    dir = new Point(0, 0);
    vg = 0;
  }

  // update()
  public override function update():void
  {
    move(new Point(dir.x*speed, dir.y*speed));
  }

  public function move(v0:Point):void
  {
    // falling.
    var vf:Point = scene.tilemap.getCollisionByRect(bounds, v0.x, vg, isstoppable);
    pos = Utils.movePoint(pos, vf.x, vf.y);
    // moving (in air).
    var vdx:Point = scene.tilemap.getCollisionByRect(bounds, v0.x-vf.x, 0, isobstacle);
    pos = Utils.movePoint(pos, vdx.x, vdx.y);
    // falling (cont'd).
    var vdy:Point = scene.tilemap.getCollisionByRect(bounds, 0, vg-vf.y, isstoppable);
    pos = Utils.movePoint(pos, vdy.x, vdy.y);
    vg = Math.min(vf.y+vdx.y+vdy.y+gravity, jumpacc);
  }

  // action()
  public function action():void
  {
    if (scene.tilemap.hasCollisionByRect(bounds, 0, vg, isstoppable)) {
      vg = -jumpacc;
      jump.play();
    }
  }
}

} // package
