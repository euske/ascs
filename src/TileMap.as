package {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import Tile;

//  TileMap
//
public class TileMap extends Bitmap
{
  public var map:BitmapData;
  public var tiles:BitmapData;
  public var tilesize:int;

  private var _prevrect:Rectangle;

  // TileMap(map, tiles, tilesize, width, height)
  public function TileMap(map:BitmapData, 
			  tiles:BitmapData,
			  tilesize:int)
  {
    this.map = map;
    this.tiles = tiles;
    this.tilesize = tilesize;
    this._prevrect = new Rectangle(-1,-1,0,0);
  }

  // mapwidth
  public function get mapwidth():int
  {
    return map.width;
  }
  // mapheight
  public function get mapheight():int
  {
    return map.height;
  }

  // repaint(window)
  public function repaint(window:Rectangle):void
  {
    var x0:int = Math.floor(window.x/tilesize);
    var y0:int = Math.floor(window.y/tilesize);
    var mw:int = Math.floor(window.width/tilesize)+1;
    var mh:int = Math.floor(window.height/tilesize)+1;
    if (_prevrect.x != x0 || _prevrect.y != y0 ||
	_prevrect.width != mw || _prevrect.height != mh) {
      renderTiles(x0, y0, mw, mh);
      _prevrect.x = x0;
      _prevrect.y = y0;
      _prevrect.width = mw;
      _prevrect.height = mh;
    }
    this.x = (x0*tilesize)-window.x;
    this.y = (y0*tilesize)-window.y;
  }

  // renderTiles(x, y)
  protected function renderTiles(x0:int, y0:int, mw:int, mh:int):void
  {
    if (bitmapData == null) {
      bitmapData = new BitmapData(mw*tilesize, 
				  mh*tilesize, 
				  true, 0x00000000);
    }
    for (var dy:int = 0; dy < mh; dy++) {
      for (var dx:int = 0; dx < mw; dx++) {
	var i:int = getTile(x0+dx, y0+dy);
	var src:Rectangle = new Rectangle(i*tilesize, 0, tilesize, tilesize);
	var dst:Point = new Point(dx*tilesize, dy*tilesize);
	bitmapData.copyPixels(tiles, src, dst);
      }
    }
  }

  // getTile(x, y)
  public function getTile(x:int, y:int):int
  {
    if (x < 0 || map.width <= x || 
	y < 0 || map.height <= y) {
      return -1;
    }
    var c:uint = map.getPixel(x, y);
    return Tile.pixelToTileId(c);
  }

  // getTileRect(x, y)
  public function getTileRect(x:int, y:int):Rectangle
  {
    return new Rectangle(x*tilesize, y*tilesize, tilesize, tilesize);
  }
  
  // hasTile(x0, x1, y0, y1, f)
  public function hasTile(x0:int, x1:int, y0:int, y1:int, f:Function):Point
  {
    var dx:int = (x1 < x0)? -1 : +1;
    var dy:int = (y1 < y0)? -1 : +1;
    for (var y:int = y0; y != y1; y += dy) {
      for (var x:int = x0; x != x1; x += dx) {
	if (f(getTile(x, y))) return new Point(x, y);
      }
    }
    return null;
  }
}

} // package
