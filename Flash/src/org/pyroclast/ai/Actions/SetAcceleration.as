package org.pyroclast.ai.Actions 
{
	import org.pyroclast.ai.Interfaces.IAIAction;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author John Lynk
	 */
	public class SetAcceleration implements IAIAction 
	{
		
		private var _parent:FlxSprite;
		private var _expiryTime:int = 0;
		private var _priority:int = 0;
		private var _acceleration:FlxPoint;
		
		public function SetAcceleration( _parent:FlxSprite, acceleration:FlxPoint ) 
		{
			this._parent = _parent;
			_acceleration = acceleration;
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
			return true;
		}
		
		public function isComplete():Boolean 
		{
			return true;
		}
		
		public function execute():void 
		{
			_parent.acceleration.x = _acceleration.x;
			_parent.acceleration.y = _acceleration.y;
		}
		
	}

}