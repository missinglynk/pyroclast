package  
{
	/**
	 * ...
	 * @author Matthew Everett
	 */
	
	 import org.flixel.FlxEmitter;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.system.FlxDebugger;
	 
	public class Enemy extends FlxSprite
	{
		
		protected var playState:PlayState;
		
		public var jumpImpulse:Number;
		protected var jumpTimer:Number;
		public var maxJumpTimer:Number;
		public var deathParticleEmitter:FlxEmitter;
		public var deathParticleSprite:FlxParticle;
		
		public function Enemy(state:PlayState, x:Number, y:Number) 
		{
			
		}
		
	}

}