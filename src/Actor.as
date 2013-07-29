package {

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

//  Actor
//
public class Actor extends Sprite
{
  public var scene:Scene;
  public var skin:Bitmap;
  public var pos:Point;
  public var v:Point;

  // Actor(scene, image)
  public function Actor(scene:Scene, skin:Bitmap)
  {
    this.scene = scene;
    this.skin = skin;
    this.pos = new Point(0, 0);
    this.v = new Point(0, 0);
    addChild(this.skin);
  }

  // bounds
  public function get bounds():Rectangle
  {
    return new Rectangle(pos.x, pos.y, skin.width, skin.height);
  }

  // update()
  public static var isstoppable:Function = 
    (function (b:int):Boolean { return b != 0; });
  public virtual function update():void
  {
    v = scene.tilemap.getCollisionCoords(bounds, v, isstoppable);
    pos.x += v.x;
    pos.y += v.y;
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
