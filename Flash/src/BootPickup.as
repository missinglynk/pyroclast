package  
{
	/**
	 * ...
	 * @author Matthew Everett
	 */
	
	 import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	 
	public class BootPickup extends FlxSprite
	{
		
		public var tileX:Number;
		public var tileY:Number;
		
		public function BootPickup(tileX:Number, tileY:Number) 
		{
			this.tileX = tileX;
			this.tileY = tileY;
			
			super(tileX*16, tileY*16);
			
			this.loadGraphic(Resources.shoeSprite, true, true, 16, 16);
			addAnimation("anim", new Array(0, 1), 2, true);
			play("anim");
		}
		
	}

}