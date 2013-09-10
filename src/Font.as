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
  protected function getCharWidth(c:int):int
  {
    return width;
  }

  // getCharHeight(c)
  //   Returns a height of a character.
  protected function getCharHeight(c:int):int
  {
    return height;
  }

  // getCharOffset(c)
  //   Returns an offset of a character.
  protected function getCharOffset(c:int):int
  {
    return width*(c-32);
  }

  // getLineSize(text)
  public function getLineSize(text:String):Point
  {
    var size:Point = new Point();
    for (var i:int = 0; i < text.length; i++) {
      var c:int = text.charCodeAt(i);
      size.x += getCharWidth(c);
      size.y = Math.max(size.y, getCharHeight(c));
    }
    return size;
  }

  // renderLine(bitmapData, text, p)
  //   Render a text string on a given BitmapData.
  public function renderLine(bitmapData:BitmapData, text:String, p:Point):Point
  {
    p = p.clone();
    var size:Point = new Point();
    for (var i:int = 0; i < text.length; i++) {
      var c:int = text.charCodeAt(i);
      var w:int = getCharWidth(c);
      if (w == 0) continue;
      var h:int = getCharHeight(c);
      var src:Rectangle = new Rectangle(getCharOffset(c), 0, w, h);
      bitmapData.copyPixels(fontglyphs, src, p);
      p.x += w;
      size.x += w;
      size.y = Math.max(size.y, h);
    }
    return size;
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

  // renderText(bitmapData, text, p, linespace)
  //   Render a text string on a given BitmapData.
  public function renderText(bitmapData:BitmapData, text:String, p:Point, linespace:int=0):void
  {
    p = p.clone();
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

  // createText(text, color, linespace, scale)
  //   Creates a Bitmap with a given string rendered.
  public function createText(text:String, 
			     color:uint=0xffffff, linespace:int=0, scale:int=1):Bitmap
  {
    var size:Point = getTextSize(text, linespace);
    var bitmapData:BitmapData = new BitmapData(size.x, size.y, true, 0);
    renderText(bitmapData, text, new Point(), linespace);
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
