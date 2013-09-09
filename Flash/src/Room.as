package  
{
	import flash.display.Bitmap;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Matthew Everett
	 */
	public class Room
	{
		public var roomID:Number;
		
		public var backgroundMap:String;
		public var backgroundTileset:Class;
		
		public var foregroundCollidableMap:String;
		public var foregroundCollidableTileset:Class;
		
		public var foregroundNoncollidableMap:String;
		public var foregroundNoncollidableTileset:Class;
		
		public var musicChange:String;
		
		public var actors:Array; //2D array of values for each tile position
		
		public var hasLava:Boolean;
		
		public var retrievedGems:Array;
		
		public var forceFieldActive:Boolean;
		public var forceFieldGemsRequired:int;
		
		//Exits
		public var topExit:Number;
		public var bottomExit:Number;
		public var leftExit:Number;
		public var rightExit:Number;
		
		public function Room() 
		{
			musicChange = "";
			
			topExit = 1;
			bottomExit = 1;
			leftExit = 1;
			rightExit = 1;
			
			hasLava = false;
			
			retrievedGems = new Array();
			
			forceFieldActive = false;
			forceFieldGemsRequired = 0;
		}
		
	}

}