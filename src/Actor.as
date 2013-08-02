package {

import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

//  Actor
//
public class Actor extends Sprite
{
  public var scene:Scene;
  public var pos:Point;
  private var _skin:DisplayObject;

  // Actor(scene)
  public function Actor(scene:Scene)
  {
    this.scene = scene;
    this.pos = new Point(0, 0);
  }

  // skin
  public virtual function get skin():DisplayObject
  {
    return _skin;
  }
  public virtual function set skin(value:DisplayObject):void
  {
    if (_skin != null) {
      removeChild(_skin);
    }
    _skin = value;
    if (_skin != null) {
      addChild(_skin);
      _skin.x = -Math.floor(_skin.width/2);
      _skin.y = -Math.floor(_skin.height/2);
    }
  }

  // bounds
  public virtual function get bounds():Rectangle
  {
    return new Rectangle(pos.x+_skin.x, pos.y+_skin.y, _skin.width, _skin.height);
  }
  public virtual function set bounds(value:Rectangle):void
  {
    pos.x = Math.floor((value.left+value.right)/2);
    pos.y = Math.floor((value.top+value.bottom)/2);
  }

  // move(v)
  public function move(v:Point):void
  {
    pos.x += v.x;
    pos.y += v.y;
  }

  // update()
  public virtual function update():void
  {
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
