package {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.ColorTransform;

//  BitmapFont
// 
public class BitmapFont
{
  private var _glyphs:BitmapData;
  private var _widths:Array;

  // height
  //   The height of this font.
  public var height:int;

  // BitmapFont(glyphs, widths)
  public function BitmapFont(glyphs:BitmapData, widths:Array)
  {
    _glyphs = glyphs;
    _widths = widths;
    height = glyphs.height;
  }

  // getTextSize(text)
  //   Returns a width of a given string.
  public function getTextSize(text:String, linespace:int=0):Point
  {
    var mw:int = 0;
    var w:int = 0;
    var h:int = height;
    for (var i:int = 0; i < text.length; i++) {
      var c:int = text.charCodeAt(i);
      if (c == 10) {
	mw = Math.max(w, mw);
	w = 0;
	h += linespace+height;
      } else {
	w += getCharWidth(c);
      }
    }
    mw = Math.max(w, mw);
    return new Point(mw, h);
  }

  // render(text, color)
  //   Creates a Bitmap with a given string rendered.
  public function render(text:String, color:uint=0xffffff, scale:int=1, linespace:int=0):Bitmap
  {
    var size:Point = getTextSize(text);
    var data:BitmapData = new BitmapData(size.x, size.y, true, 0);
    var p:Point = new Point(0, 0);
    for (var i:int = 0; i < text.length; i++) {
      var c:int = text.charCodeAt(i);
      if (c == 10) {
	p.x = 0;
	p.y += linespace+height;
	continue;
      }
      if (_widths.length <= c+1) continue;
      var w:int = getCharWidth(c);
      var src:Rectangle = new Rectangle(_widths[c], 0, w, height);
      data.copyPixels(_glyphs, src, p);
      p.x += w;
    }
    var ct:ColorTransform = new ColorTransform();
    ct.color = color;
    data.colorTransform(data.rect, ct);
    var bitmap:Bitmap = new Bitmap(data);
    bitmap.width *= scale;
    bitmap.height *= scale;
    return bitmap;
  }

  private function getCharWidth(c:int):int
  {
    if (_widths.length <= c+1) return 0;
    return _widths[c+1] - _widths[c];
  }

}

} // package
