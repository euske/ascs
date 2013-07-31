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
  public var vel:Point;

  // Actor(scene, image)
  public function Actor(scene:Scene, skin:Bitmap)
  {
    this.scene = scene;
    this.skin = skin;
    this.pos = new Point(0, 0);
    this.vel = new Point(0, 0);
    addChild(this.skin);
    this.skin.x = -Math.floor(this.skin.width/2);
    this.skin.y = -Math.floor(this.skin.height/2);
  }

  // bounds
  public virtual function get bounds():Rectangle
  {
    return new Rectangle(pos.x+skin.x, pos.y+skin.y, skin.width, skin.height);
  }
  public virtual function set bounds(value:Rectangle):void
  {
    pos.x = Math.floor((value.left+value.right)/2);
    pos.y = Math.floor((value.top+value.bottom)/2);
  }

  // update()
  public virtual function update():void
  {
    var isstoppable:Function = (function (b:int):Boolean { return b != 0; });
    vel = scene.tilemap.getCollisionByRect(bounds, vel, isstoppable);
    pos.x += vel.x;
    pos.y += vel.y;
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
