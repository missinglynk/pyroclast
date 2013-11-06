package org.pyroclast.ai.Actions 
{
	import org.pyroclast.ai.Interfaces.IAIAction;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author John Lynk
	 */
	public class JumpOverTarget implements IAIAction 
	{
		
		private var _parent:FlxSprite;
		private var _target:FlxSprite;
		private var _expiryTime:int = 0;
		private var _priority:int = 0;
		private var _time:Number = 0;
		private var _height:Number = 0;
		
		//Pass in time in seconds
		public function JumpOverTarget( _parent:FlxSprite, _target:FlxSprite, _time:Number, _height:Number ) 
		{
			this._parent = _parent;
			this._target = _target;
			this._time = _time;
			this._height = _height;
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
			var xDiff:Number = _target.x - _parent.x;
			var peak:Number = _parent.y - _height;
			//_parent.velocity.y = ( _height - ( 0.5 * _parent.acceleration.y * _time * _time ) ) / _time;
			_parent.velocity.y = -_parent.acceleration.y * _time;
			_parent.velocity.x = xDiff / ( _time );
		}
		
	}

}