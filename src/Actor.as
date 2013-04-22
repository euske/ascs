package {

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.events.Event;
import flash.geom.Point;

//  Actor
//
public class Actor extends Sprite
{
  public var scene:Scene;
  public var skin:Bitmap;
  public var pos:Point;
  public var vx:int, vy:int;

  // Actor(scene, image)
  public function Actor(scene:Scene, skin:Bitmap)
  {
    this.scene = scene;
    this.skin = skin;
    this.pos = new Point(0, 0);
    addChild(this.skin);
  }

  // move(vx, vy)
  public function move(vx:int, vy:int):void
  {
    this.vx = vx;
    this.vy = vy;
  }

  // update()
  public virtual function update():void
  {
    pos.x += vx;
    pos.y += vy;
  }

  // repaint()
  public virtual function repaint():void
  {
    var p:Point = scene.translatePoint(pos);
    this.x = p.x;
    this.y = p.y;
  }
}

} // package
