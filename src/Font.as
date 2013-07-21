package {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.ColorTransform;

//  Font
// 
public class Font
{
  [Embed(source="../assets/font.png", mimeType="image/png")]
  private static const FontGlyphsCls:Class;
  private static const fontglyphs:BitmapData = new FontGlyphsCls().bitmapData;

  public const width:int = 8;
  public const height:int = 8;

  // Font()
  public function Font()
  {
  }

  // getCharWidth(c)
  //   Returns a width of a character.
  public function getCharWidth(c:int):int
  {
    return width;
  }

  // getCharOffset(c)
  //   Returns an offset of a character.
  public function getCharOffset(c:int):int
  {
    return width*(c-32);
  }

  // getTextSize(text, linespace)
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

  // render(bitmapData, text, linespace)
  //   Render a text string on a given BitmapData.
  public function render(bitmapData:BitmapData, text:String, linespace:int=0):void
  {
    var p:Point = new Point(0, 0);
    for (var i:int = 0; i < text.length; i++) {
      var c:int = text.charCodeAt(i);
      if (c == 10) {
	p.x = 0;
	p.y += linespace+height;
	continue;
      }
      var w:int = getCharWidth(c);
      if (w == 0) continue;
      var src:Rectangle = new Rectangle(getCharOffset(c), 0, w, height);
      bitmapData.copyPixels(fontglyphs, src, p);
      p.x += w;
    }
  }

  // create(text, color, linespace, scale)
  //   Creates a Bitmap with a given string rendered.
  public function create(text:String, 
			 color:uint=0xffffff, linespace:int=0, scale:int=1):Bitmap
  {
    var size:Point = getTextSize(text, linespace);
    var bitmapData:BitmapData = new BitmapData(size.x, size.y, true, 0);
    render(bitmapData, text, linespace);
    var ct:ColorTransform = new ColorTransform();
    ct.color = color;
    bitmapData.colorTransform(bitmapData.rect, ct);
    var bitmap:Bitmap = new Bitmap(bitmapData);
    bitmap.width *= scale;
    bitmap.height *= scale;
    return bitmap;
  }
}

} // package
