package  
{
	/**
	 * ...
	 * @author Matthew Everett
	 */
	
	 import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	 
	public class ForceField extends FlxSprite
	{
		private var _playState:PlayState;
		
		public var tileX:Number;
		public var tileY:Number;
		
		public var vanishing:Boolean;
		
		public var gemsNeeded:int;
		
		public function ForceField(playState:PlayState, tileX:Number, tileY:Number, gemsNeeded:int) 
		{
			this._playState = playState;
			this.tileX = tileX;
			this.tileY = tileY;
			this.gemsNeeded = gemsNeeded;
			
			super(tileX * 16, tileY * 16);
			
			this.immovable = true;
			this.solid = true;
			
			this.loadGraphic(Resources.forcefieldSprite, true, false, 16, 16);
			addAnimation("anim", new Array(0, 1, 2, 3, 4, 5, 6, 7), 10, true);
			play("anim");
			
			vanishing = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (vanishing)
			{
				alpha -= .01;
				if (alpha <= .1)
				{
					_playState.RemoveForceFieldPermanently();
				}
			}
			else if (_playState.gemsCollected >= gemsNeeded)
			{
				vanishing = true;
			}
		}
		
	}

}