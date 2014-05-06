package {

import flash.events.EventDispatcher;
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.geom.Rectangle;

//  Actor
//
public class Actor extends EventDispatcher
{
  public var pos:Point;
  public var skin:DisplayObject;

  private var _scene:Scene;

  // Actor(scene)
  public function Actor(scene:Scene)
  {
    _scene = scene;
    pos = new Point();
  }

  // scene
  public function get scene():Scene
  {
    return _scene;
  }

  // skinBounds: Character boundary (relative to pos).
  public function get skinBounds():Rectangle
  {
    return new Rectangle(-10, -10, 20, 20);
  }

  // bounds
  public function get bounds():Rectangle
  {
    return new Rectangle(pos.x+skinBounds.x, 
			 pos.y+skinBounds.y, 
			 skinBounds.width,
			 skinBounds.height);
  }

  // move(dx, dy)
  public function move(dx:int, dy:int):void
  {
    pos = Utils.movePoint(pos, dx, dy);
  }

  // getMovedBounds(dx, dy)
  public function getMovedBounds(dx:int, dy:int):Rectangle
  {
    return Utils.moveRect(bounds, dx, dy);
  }

  // isMovable(dx, dy)
  public virtual function isMovable(dx:int, dy:int):Boolean
  {
    return scene.maprect.containsRect(getMovedBounds(dx, dy));
  }

  // active
  public virtual function get active():Boolean
  {
    return true;
  }

  // collide(actor): called when the actor is colliding with another actor.
  public virtual function collide(actor:Actor):void
  {
  }

  // update(t)
  public virtual function update(t:int):void
  {
  }

}

} // package
