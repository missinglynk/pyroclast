package org.pyroclast.ai.StateMachines 
{
	/**
	 * ...
	 * @author John Lynk
	 */
	public class StateMachineFactory 
	{
		
		import org.pyroclast.ai.Actions.ChaseAction;
		import org.pyroclast.ai.Actions.ChaseWithDistance;
		import org.pyroclast.ai.Actions.CreateProjectileAction;
		import org.pyroclast.ai.Actions.FireOrbitingObjectAction;
		import org.pyroclast.ai.Actions.FleeAction;
		import org.pyroclast.ai.Actions.JumpOverTarget;
		import org.pyroclast.ai.Actions.KillAction;
		import org.pyroclast.ai.Actions.KillArray;
		import org.pyroclast.ai.Actions.PlayAnimationAction;
		import org.pyroclast.ai.Actions.SetAcceleration;
		import org.pyroclast.ai.Actions.SetVelocity;
		import org.pyroclast.ai.Actions.SineYPositionAction;
		import org.pyroclast.ai.Actions.TurnAtEdgeAction;
		import org.pyroclast.ai.Actions.UpdateCirclingChildren;
		import org.pyroclast.ai.Conditions.HealthCondition;
		import org.pyroclast.ai.Conditions.VelocityYCondition;
		import org.pyroclast.ai.Interfaces.IAIState;
		import org.pyroclast.ai.Interfaces.ITransition;
		import org.pyroclast.ai.StateMachines.AIStateMachine;
		import org.pyroclast.ai.StateMachines.AISubStateMachine;
		import org.pyroclast.ai.StateMachines.StateMachineState;
		import org.pyroclast.ai.Transitions.ConditionBasedTransition;
		import org.pyroclast.ai.Transitions.TestKeyTransition;
		import org.pyroclast.ai.Transitions.TestTransition;
		import org.pyroclast.ai.Transitions.TimeBasedTransition;
		import org.flixel.FlxPoint;
		import org.flixel.FlxSprite;
		import org.flixel.FlxTilemap;
		
		private static var DEAD_HEALTH:Number = 0;
		
		private static var BAT_AMPLITUDE:Number = 500;
		private static var BAT_T_INCREMENT:Number = 0.1;
		
		private static var SPITFIRE_FIRE_STATE_DURATION:Number = 1;
		private static var SPITFIRE_ORBITING_STATE_DURATION:Number = 1;
		private static var SPITFIRE_CHASE_DISTANCE:Number = 50;
		private static var SPITFIRE_PROJECTILE_ANGULAR_VELOCITY:Number = 0.1;
		private static var SPITFIRE_PROJECTILE_SPEED:Number = 50;
		
		private static var SPIDER_PATROL_STATE_DURATION:Number = 5;
		private static var SPIDER_SHOOTING_STATE_DURATION:Number = 1;
		private static var SPIDER_PROJECTILE_ORIGIN_OFFSET:FlxPoint = new FlxPoint( 5, 0 );
		private static var SPIDER_PROJECTILE_INITIAL_VELOCITY:FlxPoint = new FlxPoint( 90, 0 );
		private static var SPIDER_PROJECTILE_INITIAL_ACCELERATION:FlxPoint = new FlxPoint( 0, 0 );
		private static var SPIDER_PROJECTILE_INITIAL_DRAG:FlxPoint = new FlxPoint( 0, 0 );
		
		private static var MOLE_IDLE_STATE_DURATION:Number = 5;
		private static var MOLE_SHOOTING_STATE_DURATION:Number = 1;
		private static var MOLE_PROJECTILE_ORIGIN_OFFSET:FlxPoint = new FlxPoint( 5, 5 );
		private static var MOLE_PROJECTILE_INITIAL_VELOCITY:FlxPoint = new FlxPoint( 30, -45 );
		private static var MOLE_PROJECTILE_INITIAL_ACCELERATION:FlxPoint = new FlxPoint( 0, 80 );
		private static var MOLE_PROJECTILE_INITIAL_DRAG:FlxPoint = new FlxPoint( 0, 0 );
		
		private static var BOSS_IDLE_STATE_LENGTH:Number = 2;
		private static var BOSS_ROLL_STATE_LENGTH:Number = 3;
		private static var BOSS_MIDAIR_STATE_LENGTH:Number = 2;
		private static var BOSS_SQUISH_STATE_LENGTH:Number = 1;
		private static var BOSS_ROLL_VELOCITY:FlxPoint = new FlxPoint( 80, 0 );
		private static var BOSS_TIME_TO_JUMP_PEAK:Number = 0.5;
		private static var BOSS_JUMP_HEIGHT:Number = 1;
		private static var BOSS_MIDAIR_VELOCITY:FlxPoint = new FlxPoint();
		private static var BOSS_MIDAIR_ACCELERATION:FlxPoint = new FlxPoint();
		
		public function StateMachineFactory() 
		{
			
		}
		
		public static function createScorpionStateMachine( _scorpion:FlxSprite, _tilemap:FlxTilemap ):AIStateMachine
		{
			//Create an array to store your states
			var states:Array = new Array();
			
			//Create all your necessary transitions here
			var transitionToDead:ITransition = new ConditionBasedTransition( [new HealthCondition( _scorpion, DEAD_HEALTH, HealthCondition.LESS_THAN_EQUAL_TO )], [] );
			
			//Create your actions here
			
			var patrolActions:Array = new Array();
			patrolActions.push( new TurnAtEdgeAction( _scorpion, _tilemap ) );
			
			
			//Create your states here
			var deadState:IAIState = new StateMachineState( [], [new KillAction(_scorpion)], [], [] );
			
			var patrolState:IAIState = new StateMachineState( patrolActions, [], [], [transitionToDead] );
			
			//Set your transition target states here
			transitionToDead.setState( deadState );
			
			//Return a new AIStateMachine with the proper initial state
			return new AIStateMachine( patrolState );
		}
		
		public static function createBatStateMachine( _bat:FlxSprite ):AIStateMachine
		{
			//Create an array to store your states
			var states:Array = new Array();
			
			//Create all your necessary transitions here
			var transitionToDead:ITransition = new ConditionBasedTransition( [new HealthCondition( _bat, DEAD_HEALTH, HealthCondition.LESS_THAN_EQUAL_TO )], [] );
			
			//Create your actions here
			var flyingActions:Array = new Array();
			flyingActions.push( new SineYPositionAction( _bat, BAT_AMPLITUDE, BAT_T_INCREMENT ) );
			
			//Create your states here
			var flyingState:IAIState = new StateMachineState( flyingActions, [], [], [transitionToDead] );
			var deadState:IAIState = new StateMachineState( [], [new KillAction( _bat )], [], [] );
			
			//Set your transition target states here
			transitionToDead.setState( deadState );
			
			//Return a new AIStateMachine with the proper initial state
			return new AIStateMachine( flyingState );
		}
		
		public static function createSpitfireStateMachine( _spitfire:FlxSprite, _rocks:Array, _projectileArrays:Array, _player:FlxSprite ):AIStateMachine
		{
			var states:Array = new Array();
			
			//Transitions
			var transitionToFireState:ITransition = new TimeBasedTransition( [], SPITFIRE_ORBITING_STATE_DURATION );
			var transitionToOrbitingState:ITransition = new TimeBasedTransition( [], SPITFIRE_FIRE_STATE_DURATION );
			var transitionToDeadState:ITransition = new ConditionBasedTransition( [new HealthCondition( _spitfire, DEAD_HEALTH, HealthCondition.LESS_THAN_EQUAL_TO )], [] );
			
			var orbitingActions:Array = new Array();
			var circlingAction:UpdateCirclingChildren = new UpdateCirclingChildren( _spitfire, _rocks, SPITFIRE_PROJECTILE_ANGULAR_VELOCITY );
			
			//These need to be in THIS ORDER!!!
			orbitingActions.push( new ChaseWithDistance( _spitfire, _player, SPITFIRE_CHASE_DISTANCE ) );
			orbitingActions.push( circlingAction );
			
			var fireActions:Array = new Array();
			fireActions.push( new FireOrbitingObjectAction( circlingAction.getLinks(), _player, SPITFIRE_PROJECTILE_SPEED ) );
			
			var orbitingState:IAIState = new StateMachineState( orbitingActions, [], [], [transitionToFireState] );
			var fireState:IAIState = new StateMachineState( orbitingActions, fireActions, [], [transitionToOrbitingState] );
			var deadState:IAIState = new StateMachineState( [], [new KillAction(_spitfire), new KillArray(_rocks)], [], [] );
			
			var subMachine:AISubStateMachine = new AISubStateMachine( orbitingState, [transitionToDeadState] );
			
			transitionToFireState.setState( fireState );
			transitionToOrbitingState.setState( orbitingState );
			
			return new AIStateMachine( subMachine );
		}
		
		public static function createSpiderStateMachine( _spider:FlxSprite, _projectileClass:Class, _tilemap:FlxTilemap, _projectileGroups:Array, _arrays:Array ):AIStateMachine
		{
			var states:Array = new Array();
			
			//Transitions
			var transitionToShootingState:ITransition = new TimeBasedTransition( [], SPIDER_PATROL_STATE_DURATION );
			var transitionToPatrolState:ITransition = new TimeBasedTransition( [], SPIDER_SHOOTING_STATE_DURATION );
			var transitionToDeadState:ITransition = new ConditionBasedTransition( [new HealthCondition( _spider, DEAD_HEALTH, HealthCondition.LESS_THAN_EQUAL_TO )], [] );
			
			var throwProjectileEntryActions:Array = new Array();
			//parent:FlxSprite, originOffset:FlxPoint, velocity:FlxPoint, acceleration:FlxPoint, drag:FlxPoint, graphic:Class, groups:Array, arrays:Array
			throwProjectileEntryActions.push( new CreateProjectileAction( _spider, SPIDER_PROJECTILE_ORIGIN_OFFSET, SPIDER_PROJECTILE_INITIAL_VELOCITY, SPIDER_PROJECTILE_INITIAL_ACCELERATION, SPIDER_PROJECTILE_INITIAL_DRAG, _projectileClass, _projectileGroups, _arrays ) );
			throwProjectileEntryActions.push( new PlayAnimationAction( _spider, "Throw", true ) );
			
			var patrolActions:Array = new Array();
			patrolActions.push( new TurnAtEdgeAction( _spider, _tilemap ) );
			var patrolEntryActions:Array = new Array();
			patrolEntryActions.push( new PlayAnimationAction( _spider, "Walk", true ) );
			
			var shootingState:IAIState = new StateMachineState( [], throwProjectileEntryActions, [], [transitionToPatrolState] );
			var patrolState:IAIState = new StateMachineState( patrolActions, patrolEntryActions, [], [transitionToShootingState] );
			var deadState:IAIState = new StateMachineState( [], [new KillAction(_spider)], [], [] );
			
			var subMachine:AISubStateMachine = new AISubStateMachine( patrolState, [transitionToDeadState] );
			
			transitionToPatrolState.setState( patrolState );
			transitionToShootingState.setState( shootingState );
			transitionToDeadState.setState( deadState );
			
			return new AIStateMachine( subMachine );
		}
		
		public static function createMoleStateMachine( _mole:FlxSprite, _projectileClass:Class, _tilemap:FlxTilemap, _projectileGroups:Array, _arrays:Array ):AIStateMachine
		{
			var states:Array = new Array();
			
			//Transitions
			var transitionToShootingState:ITransition = new TimeBasedTransition( [], MOLE_IDLE_STATE_DURATION );
			var transitionToIdleState:ITransition = new TimeBasedTransition( [], MOLE_SHOOTING_STATE_DURATION );
			var transitionToDeadState:ITransition = new ConditionBasedTransition( [new HealthCondition( _mole, DEAD_HEALTH, HealthCondition.LESS_THAN_EQUAL_TO )], [] );
			
			var throwProjectileEntryActions:Array = new Array();
			//parent:FlxSprite, originOffset:FlxPoint, velocity:FlxPoint, acceleration:FlxPoint, drag:FlxPoint, graphic:Class, groups:Array, arrays:Array
			throwProjectileEntryActions.push( new CreateProjectileAction( _mole, MOLE_PROJECTILE_ORIGIN_OFFSET, MOLE_PROJECTILE_INITIAL_VELOCITY, MOLE_PROJECTILE_INITIAL_ACCELERATION, MOLE_PROJECTILE_INITIAL_DRAG, _projectileClass, _projectileGroups, _arrays ) );
			throwProjectileEntryActions.push( new PlayAnimationAction( _mole, "Throw", true ) );
			
			var idleActions:Array = new Array();
			
			var shootingState:IAIState = new StateMachineState( [], throwProjectileEntryActions, [], [transitionToIdleState] );
			var idleState:IAIState = new StateMachineState( idleActions, [], [], [transitionToShootingState] );
			var deadState:IAIState = new StateMachineState( [], [new KillAction(_mole)], [], [] );
			
			var subMachine:AISubStateMachine = new AISubStateMachine( idleState, [transitionToDeadState] );
			
			transitionToIdleState.setState( idleState );
			transitionToShootingState.setState( shootingState );
			transitionToDeadState.setState( deadState );
			
			return new AIStateMachine( subMachine );
		}
		
		public static function createBossStateMachine( _boss:FlxSprite, _tilemap:FlxTilemap, _player:FlxSprite ):AIStateMachine
		{
			var states:Array = new Array();
			
			//Transitions
			
			//TODO - set this to the length of the animation
			var transitionToRollState:ITransition = new TimeBasedTransition( [], BOSS_IDLE_STATE_LENGTH );
			//TODO - Change this if we want the pattern to be based on number of rolls / change throughout instead of time based
			var transitionToJumpState:ITransition = new TimeBasedTransition( [], BOSS_ROLL_STATE_LENGTH );
			//TODO - Change to Greater_Than if positive y-direction is down instead of up
			var transitionToMidairState:ITransition = new ConditionBasedTransition( [new VelocityYCondition( _boss, 1, VelocityYCondition.GREATER_THAN )], [] );
			var transitionToFallingState:ITransition = new TimeBasedTransition( [], BOSS_MIDAIR_STATE_LENGTH );
			var transitionToSquishState:ITransition = new ConditionBasedTransition( [new VelocityYCondition( _boss, 1, VelocityYCondition.LESS_THAN_EQUAL_TO )], [] );
			//TODO - Change this based on length of animation
			var transitionToIdleState:ITransition = new TimeBasedTransition( [], BOSS_SQUISH_STATE_LENGTH );
			var transitionToDeadState:ITransition = new ConditionBasedTransition( [new HealthCondition( _boss, DEAD_HEALTH, HealthCondition.LESS_THAN_EQUAL_TO )], [] );
			
			//Create actions here
			var rollEntryActions:Array = new Array();
			rollEntryActions.push( new PlayAnimationAction( _boss, "roll", true ) );
			rollEntryActions.push( new SetVelocity( _boss, BOSS_ROLL_VELOCITY ) );
			//TODO - Do we want him to be invulnerable here? Need some sort of boolean to set on the FlxSprite, and need an action to set it
			var rollActions:Array = [ new TurnAtEdgeAction(_boss, _tilemap )];
			
			//TODO - Tweak these numbers, check if the action works correctly
			var enterJumpStateActions:Array = [ new JumpOverTarget( _boss, _player, BOSS_TIME_TO_JUMP_PEAK, BOSS_JUMP_HEIGHT ) ];
			
			//Will this let us keep it in midair without changing acceleration so we don't need to store it?
			var midairStateActions:Array = [ new SetVelocity( _boss, BOSS_MIDAIR_VELOCITY )];
			var midairEntryActions:Array = [ new SetAcceleration( _boss, BOSS_MIDAIR_ACCELERATION ) ];
			
			var fallingEntryActions:Array = [ new SetAcceleration( _boss, new FlxPoint( 0, _boss.acceleration.y ) ) ];
			
			var enterSquishStateActions:Array = [ new PlayAnimationAction( _boss, "squish", false ) ];
			
			var enterIdleStateActions:Array = [ new PlayAnimationAction( _boss, "idle", false ) ];
			
			//Transition into roll -> roll -> roll back -> jump, aiming to land on player -> stops in the air for a second -> comes down -> transition squish animation -> idle state for 2s -> repeat
			
			//TODO - Are my timers pausing when the game state pauses????
			
			var rollState:IAIState = new StateMachineState( rollActions, rollEntryActions, [], [transitionToJumpState] );
			var jumpState:IAIState = new StateMachineState( [], enterJumpStateActions, [], [transitionToMidairState] );
			var midairState:IAIState = new StateMachineState( midairStateActions, midairEntryActions, [], [transitionToFallingState] );
			var fallingState:IAIState = new StateMachineState( [], fallingEntryActions, [], [transitionToSquishState] );
			var squishState:IAIState = new StateMachineState( [], enterSquishStateActions, [], [transitionToIdleState] );
			var idleState:IAIState = new StateMachineState( [], enterIdleStateActions, [], [transitionToRollState] );
			var deadState:IAIState = new StateMachineState( [], [new KillAction(_boss)], [], [] );
			
			var subMachine:IAIState = new AISubStateMachine( idleState, [transitionToDeadState] );
			
			//Set transition states
			transitionToRollState.setState( rollState );
			transitionToJumpState.setState( jumpState );
			transitionToMidairState.setState( midairState );
			transitionToFallingState.setState( fallingState );
			transitionToSquishState.setState( squishState );
			transitionToIdleState.setState( idleState );
			transitionToDeadState.setState( deadState );
			
			_boss.health = 100;
			
			return new AIStateMachine( subMachine );
		}
	}

}