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
  [Embed(source="../assets/sound.mp3")]
  private static const JumpSoundCls:Class;
  private static const jump:Sound = new JumpSoundCls();

  public const speed:int = 8;
  public const gravity:int = 2;
  public const jumpacc:int = -24;

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

    var v0:Point = new Point(vx*speed, vg+gravity);
    var v:Point = scene.tilemap.getCollisionByRect(bounds, v0, isstoppable);
    pos.x += v.x;
    pos.y += v.y;
    v0.x -= v.x;
    v0.y -= v.y;
    vg = v.y;

    v = new Point(v0.x, 0);
    v = scene.tilemap.getCollisionByRect(bounds, v, isstoppable);
    pos.x += v.x;
    pos.y += v.y;
    v = new Point(0, v0.y);
    v = scene.tilemap.getCollisionByRect(bounds, v, isstoppable);
    pos.x += v.x;
    pos.y += v.y;
  }

  // action()
  public function action():void
  {
    vg = jumpacc;
    jump.play();
  }
}

} // package
