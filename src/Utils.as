package {

import flash.geom.Point;
import flash.geom.Rectangle;

//  Utility Functions
// 
public class Utils
{
  private static function collideHLine(x0:int, x1:int, y:int, r:Rectangle, v:Point):Point
  {
    var dy:int;
    if (y <= r.top && r.top < y+v.y) {
      dy = r.top - y;
    } else if (r.bottom <= y && y+v.y < r.bottom) {
      dy = r.bottom - y;
    } else {
      return v;
    }
    var dx:int = Math.floor(v.x*dy / v.y);
    if (x1+dx < r.left || r.right < x0+dx) {
      return v;
    }
    return new Point(dx, dy);
  }

  private static function collideVLine(y0:int, y1:int, x:int, r:Rectangle, v:Point):Point
  {
    var dx:int;
    if (x <= r.left && r.left < x+v.x) {
      dx = r.left - x;
    } else if (r.right <= x && x+v.x < r.right) {
      dx = r.right - x;
    } else {
      return v;
    }
    var dy:int = Math.floor(v.y*dx / v.x);
    if (y1+dy < r.top || r.bottom < y0+dy) {
      return v;
    }
    return new Point(dx, dy);
  }

  public static function collideRect(r0:Rectangle, r1:Rectangle, v:Point):Point
  {
    if (0 < v.x && r1.right <= r0.left) {
      v = collideVLine(r1.top, r1.bottom, r1.right, r0, v);
    } else if (v.x < 0 && r0.right <= r1.left) {
      v = collideVLine(r1.top, r1.bottom, r1.left, r0, v);
    }
    if (0 < v.y && r1.bottom <= r0.top) {
      v = collideHLine(r1.left, r1.right, r1.bottom, r0, v);
    } else if (v.y < 0 && r0.bottom <= r1.top) {
      v = collideHLine(r1.left, r1.right, r1.top, r0, v);
    }
    return v;
  }
}

} // package
