package baseui {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.ColorTransform;

//  Font
// 
public class Font
{
  [Embed(source="../../assets/font.png", mimeType="image/png")]
  private static const FontGlyphsCls:Class;

  private static var _glyphs:BitmapData = new FontGlyphsCls().bitmapData;
  private static var _width:int = 8;
  private static var _height:int = 8;

  // getCharOffset(c)
  //   Returns an offset of a character.
  protected static function getCharOffset(c:int):int
  {
    return _width*(c-32);
  }

  // getTextSize(text, linespace)
  //   Returns a width of a given string.
  public static function getTextSize(text:String, linespace:int=0):Point
  {
    var mw:int = 0;
    var mh:int = 0;
    var w:int = 0;
    for (var i:int = 0; i < text.length; i++) {
      var c:int = text.charCodeAt(i);
      if (c == 10) {
	mw = Math.max(w, mw);
	mh += _height+linespace;
	w = 0;
      } else {
	w += _width;
      }
    }
    mw = Math.max(w, mw);
    mh += _height;
    return new Point(mw, mh);
  }

  // renderText(bitmapData, text, p, linespace)
  //   Render a text string on a given BitmapData.
  public static function renderText(bitmapData:BitmapData, text:String, 
				    x:int=0, y:int=0, 
				    color:uint=0xffffff, linespace:int=0):void
  {
    var p:Point = new Point(x, y);
    for (var i:int = 0; i < text.length; i++) {
      var c:int = text.charCodeAt(i);
      if (c == 10) {
	p.x = 0;
	p.y += _height+linespace;
	continue;
      }
      var src:Rectangle = new Rectangle(getCharOffset(c), 0, _width, _height);
      bitmapData.copyPixels(_glyphs, src, p);
      p.x += _width;
    }
    var ct:ColorTransform = new ColorTransform();
    ct.color = color;
    bitmapData.colorTransform(bitmapData.rect, ct);
  }

  // createText(text, color, linespace, scale)
  //   Creates a Bitmap with a given string rendered.
  public static function createText(text:String, 
				    color:uint=0xffffff, linespace:int=0, 
				    scale:int=1):Bitmap
  {
    var size:Point = getTextSize(text, linespace);
    var bitmapData:BitmapData = new BitmapData(size.x, size.y, true, 0);
    renderText(bitmapData, text, 0, 0, color, linespace);
    var bitmap:Bitmap = new Bitmap(bitmapData);
    bitmap.width *= scale;
    bitmap.height *= scale;
    return bitmap;
  }
}

} // package baseui
