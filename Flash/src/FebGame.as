package  
{
	/**
	 * ...
	 * @author Matthew Everett
	 */
	
	 import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
	 
	public class FebGame extends FlxGame
	{
		
		
		public function FebGame() 
		{
			super(320, 240, StartMenuState, 2);
			//forceDebugger = true;
			//FlxG.debug = true;
			//FlxG.visualDebug = true;
		}
		
	}

}