package  
{
	/**
	 * ...
	 * @author Matthew Everett
	 */
	
	 import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	 
	public class DamageTile extends FlxSprite
	{
		
		public var tileX:Number;
		public var tileY:Number;
		
		public function DamageTile(tileX:Number, tileY:Number, area:String) 
		{
			this.tileX = tileX;
			this.tileY = tileY;
			
			super(tileX*16, tileY*16);
			
			if (area == "crystal")
			{
				this.loadGraphic(Resources.spikeSprite, true, true, 16, 16);
			}
			else
			{
				this.loadGraphic(Resources.slimeSprite, true, true, 16, 16);
				addAnimation("flow", new Array(0, 1), 2, true);
				play("flow");
			}
			
		}
		
	}

}