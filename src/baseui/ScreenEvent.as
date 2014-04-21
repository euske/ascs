package baseui {

import flash.events.Event;

//  ScreenEvent
//
public class ScreenEvent extends Event
{
  public static const CHANGED:String = "ScreenEvent.CHANGED";

  public var screen:Class;
  
  public function ScreenEvent(screen:Class)
  {
    super(CHANGED);
    this.screen = screen;
  }
  
}

} // package baseui
