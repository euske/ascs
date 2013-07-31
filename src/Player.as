package {

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.media.Sound;

//  Player
//
public class Player extends Actor
{
  // Sound:
  [Embed(source="../assets/sound.mp3")]
  private static const JumpSoundCls:Class;
  private static const jump:Sound = new JumpSoundCls();

  // Player(scene, image)
  public function Player(scene:Scene, skin:Bitmap)
  {
    super(scene, skin);
  }

  public function get vx():int
  {
    return vel.x;
  }
  public function set vx(value:int):void
  {
    vel.x = value * 4;
  }
  public function get vy():int
  {
    return vel.y;
  }
  public function set vy(value:int):void
  {
    vel.y = value * 4;
  }

  // action()
  public function action():void
  {
    jump.play();
  }
}

} // package
