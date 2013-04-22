package {

//  Tile
// 
public class Tile
{
  public static const NONE:int = 0;

  // pixelToTileId(c)
  public static function pixelToTileId(c:uint):int
  {
    switch (c) {
    case 0x000000: // 0
      return 0;
    case 0x404040: // 1
      return 1;
    case 0xff0000: // 2
      return 2;
    case 0xff6a00: // 3
      return 3;
    case 0xffd800: // 4
      return 4;
    case 0xb6ff00: // 5
      return 5;
    case 0x4cff00: // 6
      return 6;
    case 0x00ff21: // 7
      return 7;
    case 0x00ff90: // 8
      return 8;
    case 0x00ffff: // 9
      return 9;
    case 0x0094ff: // 10
      return 10;
    case 0x0026ff: // 11
      return 11;
    case 0x4800ff: // 12
      return 12;
    case 0xb200ff: // 13
      return 13;
    case 0xff00dc: // 14
      return 14;
    case 0xff006e: // 15
      return 15;
    default:
      return NONE;
    }
  }
}

} // package
