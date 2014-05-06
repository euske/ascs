package {

import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

//  Scene
// 
public class Scene extends Sprite
{
  private var _window:Rectangle;
  private var _tilesize:int;
  private var _tilemap:TileMap;
  private var _tilewindow:Rectangle;
  private var _tiles:BitmapData;
  private var _mapimage:Bitmap;
  private var _maprect:Rectangle;
  private var _actors:Array;

  // Scene(w, h, tilemap)
  public function Scene(w:int, h:int, tilesize:int,
			tilemap:TileMap, tiles:BitmapData)
  {
    _window = new Rectangle(0, 0, w*tilesize, h*tilesize);
    _tilesize = tilesize;
    _tilemap = tilemap;
    _tiles = tiles;
    _tilewindow = new Rectangle();
    _mapimage = new Bitmap(new BitmapData((w+1)*tilesize, 
					  (h+1)*tilesize, 
					  true, 0x00000000));
    _maprect = new Rectangle(0, 0,
			     tilemap.width*tilesize,
			     tilemap.height*tilesize);
    _actors = new Array();
    addChild(_mapimage);
    
    var clipping:Shape = new Shape();
    clipping.graphics.beginFill(0xffffff);
    clipping.graphics.drawRect(0, 0, _window.width, _window.height);
    addChild(clipping);
    mask = clipping;
  }

  // tilesize
  public function get tilesize():int
  {
    return _tilesize;
  }

  // tilemap
  public function get tilemap():TileMap
  {
    return _tilemap;
  }

  // maprect
  public function get maprect():Rectangle
  {
    return _maprect;
  }

  // window
  public function get window():Rectangle
  {
    return _window;
  }

  // add(actor)
  public function add(actor:Actor):void
  {
    _actors.push(actor);
    addChild(actor.skin);
  }

  // remove(actor)
  public function remove(actor:Actor):void
  {
    var i:int = _actors.indexOf(actor);
    if (0 <= i) {
      _actors.splice(i, 1);
      removeChild(actor.skin);
    }
  }

  // clear()
  public function clear():void
  {
    for each (var actor:Actor in _actors) {
      removeChild(actor.skin);
    }
    _actors = new Array();
  }

  // update()
  public function update(t:int):void
  {
    for (var i:int = 0; i < _actors.length; i++) {
      var actor:Actor = _actors[i];
      if (!actor.active) continue;
      for (var j:int = i+1; j < _actors.length; j++) {
	var a:Actor = _actors[j];
	if (a.active && actor.bounds.intersects(a.bounds)) {
	  actor.collide(a);
	  a.collide(actor);
	}
      }
      actor.update(t);
    }
  }

  // paint()
  public function paint():void
  {
    // Render each actor.
    for each (var actor:Actor in _actors) {
      var p:Point = translatePoint(actor.pos);
      actor.skin.x = p.x+actor.skinBounds.x;
      actor.skin.y = p.y+actor.skinBounds.y;
    }

    // Refresh the map if needed.
    var x0:int = Math.floor(_window.left/_tilesize);
    var y0:int = Math.floor(_window.top/_tilesize);
    var x1:int = Math.ceil(_window.right/_tilesize);
    var y1:int = Math.ceil(_window.bottom/_tilesize);
    var r:Rectangle = new Rectangle(x0, y0, x1-x0+1, y1-y0+1);
    if (!_tilewindow.equals(r)) {
      renderTiles(r);
    }
    _mapimage.x = (_tilewindow.x*_tilesize)-_window.x;
    _mapimage.y = (_tilewindow.y*_tilesize)-_window.y;
  }

  // refreshTiles()
  public function refreshTiles():void
  {
    _tilewindow = new Rectangle();
  }

  // renderTiles(x, y)
  private function renderTiles(r:Rectangle):void
  {
    for (var dy:int = 0; dy <= r.height; dy++) {
      for (var dx:int = 0; dx <= r.width; dx++) {
	var i:int = _tilemap.getTile(r.x+dx, r.y+dy);
	if (0 <= i) {
	  var src:Rectangle = new Rectangle(i*_tilesize, 0, _tilesize, _tilesize);
	  var dst:Point = new Point(dx*_tilesize, dy*_tilesize);
	  _mapimage.bitmapData.copyPixels(_tiles, src, dst);
	}
      }
    }
    _tilewindow = r;
  }

  // setCenter(p)
  public function setCenter(p:Point, hmargin:int, vmargin:int):void
  {
    // Center the window position.
    if (_maprect.width < _window.width) {
      _window.x = -(_window.width-_maprect.width)/2;
    } else if (p.x-hmargin < _window.left) {
      _window.x = Math.max(_maprect.left, p.x-hmargin);
    } else if (_window.right < p.x+hmargin) {
      _window.x = Math.min(_maprect.right, p.x+hmargin)-_window.width;
    }
    if (_maprect.height < _window.height) {
      _window.y = -(_window.height-_maprect.height)/2;
    } else if (p.y-vmargin < _window.top) {
      _window.y = Math.max(_maprect.top, p.y-vmargin);
    } else if (_window.bottom < p.y+vmargin) {
      _window.y = Math.min(_maprect.bottom, p.y+vmargin)-_window.height;
    }
  }

  // translatePoint(p)
  public function translatePoint(p:Point):Point
  {
    return new Point(p.x-_window.x, p.y-_window.y);
  }

  // getCenteredBounds(center, margin)
  public function getCenteredBounds(center:Point, margin:int=0):Rectangle
  {
    var x0:int = Math.floor(_window.left/_tilesize);
    x0 = Math.max(x0-margin, 0);
    var y0:int = Math.floor(_window.top/_tilesize);
    y0 = Math.max(y0-margin, 0);
    var x1:int = Math.ceil(_window.right/_tilesize);
    x1 = Math.min(x1+margin, _tilemap.width-1);
    var y1:int = Math.ceil(_window.bottom/_tilesize);
    y1 = Math.min(y1+margin, _tilemap.height-1);
    return new Rectangle(x0, y0, x1-x0, y1-y0);
  }

  // getCollisionByRect(r, vx, vy, f): 
  //   adjusts vector (vx,vy) so that the rectangle doesn't collide with a tile specified by f.
  public function getCollisionByRect(r:Rectangle, vx:int, vy:int, f:Function):Point
  {
    var src:Rectangle = r.union(Utils.moveRect(r, vx, vy));
    var a:Array = _tilemap.scanTileByRect(src, f);
    var v:Point = new Point(vx, vy);
    for each (var p:Point in a) {
      var b:Rectangle = _tilemap.getTileBounds(p.x, p.y);
      v = Utils.collideRect(b, r, v);
    }
    return v;
  }
}

} // package
