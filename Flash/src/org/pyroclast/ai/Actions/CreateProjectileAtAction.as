package org.pyroclast.ai.Actions 
{
	import org.pyroclast.ai.Interfaces.IAIAction;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	
	 //TO BE USED WITH A STATIC AREA
	public class CreateProjectileActionAtAction implements IAIAction 
	{
		private var _origin:FlxPoint;
		private var _velocity:FlxPoint;
		private var _acceleration:FlxPoint;
		private var _drag:FlxPoint;
		private var _graphic:Class;
		private var _groups:Array;
		private var _arrays:Array;
		
		private var _expiryTime:int = 0;
		private var _priority:int = 0;
		
		//originOffset is the offset from the parent's origin if the parent is facing LEFT for the point it should be created at
		public function CreateProjectileActionAtAction( origin:FlxPoint, velocity:FlxPoint, acceleration:FlxPoint, drag:FlxPoint, graphic:Class, groups:Array, arrays:Array ) 
		{
			_origin = origin;
			_velocity = velocity;
			_acceleration = acceleration;
			_drag = drag;
			_graphic = graphic;
			_groups = groups;
			_arrays = arrays;
		}
		
		/* INTERFACE org.pyroclast.ai.Interfaces.IAIAction */
		
		public function get expiryTime():Number 
		{
			return _expiryTime;
		}
		
		public function set priority(value:int):void 
		{
			_priority = value;
		}
		
		public function get priority():int 
		{
			return _priority;
		}
		
		public function canInterrupt():Boolean 
		{
			return false;
		}
		
		public function canDoBoth(otherAction:IAIAction):Boolean 
		{
			return false;
		}
		
		public function isComplete():Boolean 
		{
			return true;
		}
		
		public function execute():void 
		{
			var projectileSprite:FlxSprite = new FlxSprite( 0, 0 );
			projectileSprite.loadGraphic( _graphic );
			projectileSprite.x = _origin.x;
			projectileSprite.y = _origin.y;
			projectileSprite.velocity.x = _velocity.x;
			projectileSprite.velocity.y = _velocity.y;
			projectileSprite.acceleration.x = _acceleration.x;
			projectileSprite.acceleration.y = _acceleration.y;
			projectileSprite.drag.x = _drag.x;
			projectileSprite.drag.y = _drag.y;
			for ( var i:int = 0; i < _groups.length; ++i )
			{
				var group:FlxGroup = ( _groups[i] as FlxGroup );
				group.add( projectileSprite );
			}
			for ( var j:int = 0; j < _arrays.length; ++j )
			{
				var currentArray:Array = ( _arrays[j] as Array );
				currentArray.push( projectileSprite );
			}
		}
		
	}

}