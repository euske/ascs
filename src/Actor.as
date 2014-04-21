package {

import flash.display.DisplayObject;
import flash.geom.Point;
import flash.geom.Rectangle;

//  Actor
//
public class Actor
{
  public var pos:Point;
  public var frame:Rectangle;
  public var skin:DisplayObject;

  private var _scene:Scene;

  // Actor(scene)
  public function Actor(scene:Scene)
  {
    _scene = scene;
    pos = new Point(0, 0);
  }

  // scene
  public function get scene():Scene
  {
    return _scene;
  }

  // bounds
  public function get bounds():Rectangle
  {
    return new Rectangle(pos.x+frame.x, pos.y+frame.y, 
			 frame.width, frame.height);
  }
  public function set bounds(value:Rectangle):void
  {
    frame = new Rectangle(value.x-pos.x, value.y-pos.y,
			  value.width, value.height);
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
  public function isMovable(dx:int, dy:int):Boolean
  {
    return scene.maprect.containsRect(getMovedBounds(dx, dy));
  }

  // update()
  public virtual function update():void
  {
  }

}

} // package
