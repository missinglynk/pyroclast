package  
{
	import flash.events.Event;
	import org.flixel.*;
	[SWF(width = "1280",height="700",backgroundColor="#666666")]
	public class HelloWorld extends FlxGame 
	{
		
		public function HelloWorld() 
		{
			super(1280, 700, EditorState, 1);
			FlxG.mouse.show();
		}
		
	}

}