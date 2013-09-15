package org.pyroclast.game
{
	/**
	 * ...
	 * @author Matthew Everett
	 */
	
	 import flash.display.Bitmap;
	 import flash.utils.ByteArray;
	 import org.flixel.*;
	 import org.flixel.system.FlxTile;
	 import org.pyroclast.system.*;
	 
	public class PlayState extends FlxState
	{
		
		public var background:FlxTilemap;
		public var foregroundCollidable:FlxTilemap;
		public var foregroundNoncollidable:FlxTilemap;
		
		public var deathParticleGroup:FlxGroup;
		public var damagingTilesGroup:FlxGroup;
		public var forceFieldsGroup:FlxGroup;
		public var forceFieldTextGroup:FlxGroup;
		
		public var player:Player;
		public var puppy:FlxSprite;
		public var portal:FlxSprite;
		
		public var gemsCounter:FlxText;
		public var gemsCounterTimer:Number;
		public var gemsCounterTimerMax:Number;
		
		public var newAreaText:FlxText;
		public var newAreaTextTimer:Number;
		public var newAreaTextTimerMax:Number;
		public var crystalVisited:Boolean;
		public var slimeVisited:Boolean;
		public var shrineVisited:Boolean;
		
		public var actorArray:Array; //FlxSprite type
		
		public var gemsCollected:Number;
		public var gemsNeeded:Number;
		
		public var world:World; //Roomlist
		public var currentRoom:Room;
		
		public var currentMusic:String;
		
		
		public var bulletsGroup:FlxGroup;
		
		override public function create():void
		{
			world = new World(new RoomDataManager(""));
			
			actorArray = new Array();
			
			deathParticleGroup = new FlxGroup();
			forceFieldsGroup = new FlxGroup();
			damagingTilesGroup = new FlxGroup();
			forceFieldTextGroup = new FlxGroup();
			bulletsGroup = new FlxGroup();
			
			currentMusic = "";
			
			LoadRoom(world.GetRoomFromID(100));
			
			gemsCollected = 0;
			gemsNeeded = 100;
			gemsCounterTimer = 0;
			gemsCounterTimerMax = 150;
			
			gemsCounter = new FlxText(10, -20, FlxG.width, "Gems: 0");
			gemsCounter.setFormat(null, 8, 0xFFFFFF);
			add(gemsCounter);
			
			
			newAreaTextTimer = 0;
			newAreaTextTimerMax = 150;
			newAreaText = new FlxText(10, 200, FlxG.width, "The Void");
			newAreaText.setFormat(null, 24, 0xFF0000);
			add(newAreaText);
			newAreaText.alpha = 0;
			crystalVisited = false;
			slimeVisited = false;
			shrineVisited = false;
			
			//Create player
			player = new Player(this, 140, 40);
			player.init();
			player.saveRoomIndex = 100;
			player.saveRoomPosition = player.getMidpoint();
			add(player);
			
			FlxG.camera.setBounds(0, 0, 320, 240, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			add(damagingTilesGroup);
			add(forceFieldsGroup);
			add(deathParticleGroup);
			add(forceFieldTextGroup);
			add(bulletsGroup);
			
		}
		
		override public function update():void
		{
	
			super.update();
			
			FlxG.camera.follow(player);
	
			FlxG.collide(foregroundCollidable, player);
			FlxG.collide(forceFieldsGroup, player);
			FlxG.collide(deathParticleGroup, foregroundCollidable);
			
			
			var bulletCollide = function(object1:FlxObject, object2:FlxObject)
			{
				var bulletObject:FlxSprite;
				if (object1 is FlxSprite)
					bulletObject = object1 as FlxSprite;
				else if (object2 is FlxSprite)
					bulletObject = object2 as FlxSprite;
				
				if (bulletObject != null)
				{
					bulletObject.kill();
				}
			}
			
			
			FlxG.collide(bulletsGroup, foregroundCollidable, bulletCollide);
			
			//Maintain gems counter
			if (gemsCounterTimer > 0)
			{
				gemsCounterTimer--;
			}
			if (gemsCounterTimer <= 0 && gemsCounter.y > -20)
			{
				gemsCounter.y--;
			}
			if (gemsCounterTimer > 0 && gemsCounter.y < 20)
			{
				gemsCounter.y++;
			}
			
			//Maintain new area text
			if (newAreaTextTimer > 0)
			{
				newAreaTextTimer--;
			}
			if (newAreaTextTimer <= 0 && newAreaText.alpha > 0)
			{
				newAreaText.alpha -= .02;
			}
			if (newAreaTextTimer > 0 && newAreaText.alpha < 1)
			{
				newAreaText.alpha += .02;
			}
			
			//Get gems
			var i:Number = 0;
			for (i = 0; i < actorArray.length; i++)
			{
				if (actorArray[i] is BootPickup)
				{
					if (player.overlaps(actorArray[i]))
					{
						player.doubleJumpBoots = true;
						(actorArray[i] as BootPickup).kill();
						actorArray[i] = null;
						FlxG.play(Resources.coinSfx, 0.3);
						newAreaText.text = "Double Jump!";
						newAreaTextTimer = newAreaTextTimerMax;
					}
				}
				else if (actorArray[i] is DamageTile)
				{
					if (player.visible && player.velocity.y > 0 && player.overlaps(actorArray[i]))
					{
						player.die();
					}
				}
			}
			
			if (puppy != null && FlxG.collide(puppy, player))
			{
				GetPuppy();
			}
		}
		
		public function ChangeRoom(direction:String):void
		{
			remove(background);
			remove(foregroundCollidable);
			remove(foregroundNoncollidable);
			forceFieldsGroup.kill();
			forceFieldTextGroup.kill();
			damagingTilesGroup.kill();
			
			portal = null;
			puppy = null;
			
			//Remove everything in actor array
			var i:Number = 0;
			for (i = 0; i < actorArray.length; i++)
			{
				if (actorArray[i] != null)
				{
					remove(actorArray[i]);
				}
			}
			
			//Clear actor array
			actorArray = new Array();
			
			player.solid = FlxObject.NONE;
			
			var roomID:Number = 1;
			if (direction == "down")
			{
				roomID = currentRoom.bottomExit;
			}
			if (direction == "up")
			{
				roomID = currentRoom.topExit;
			}
			if (direction == "left")
			{
				roomID = currentRoom.leftExit;
			}
			if (direction == "right")
			{
				roomID = currentRoom.rightExit;
			}
			
			LoadRoom(world.GetRoomFromID(roomID));
			
			if (direction == "down")
			{
				player.y = -20;
				
				player.velocity.x = 0;
				if (FlxG.keys.LEFT)
					player.x += 1;
				if (FlxG.keys.RIGHT)
					player.x -= 1;
				
				roomID = currentRoom.bottomExit;
			}
			if (direction == "up")
			{
				player.y = 230;
				
				player.velocity.x = 0;
				if (FlxG.keys.LEFT)
					player.x += 1;
				if (FlxG.keys.RIGHT)
					player.x -= 1;
					
				roomID = currentRoom.topExit;
			}
			if (direction == "left")
			{
				player.x = 305;
				roomID = currentRoom.leftExit;
			}
			if (direction == "right")
			{
				player.x = -10;
				//player.y -= 5;
				roomID = currentRoom.rightExit;
			}
			
			player.solid = FlxObject.ANY;
			
		}
		
		public function LoadRoom(room:Room):void
		{
			remove(gemsCounter);
			currentRoom = room;
			
			background = new FlxTilemap();
			foregroundNoncollidable = new FlxTilemap();
			foregroundCollidable = new FlxTilemap();
			forceFieldsGroup.revive();
			forceFieldTextGroup.revive();
			damagingTilesGroup.revive();
			
			background.loadMap(room.backgroundMap, room.backgroundTileset, 32, 32, FlxTilemap.OFF, 0, 0, 0);
			if (room.foregroundCollidableMap != null)
				foregroundCollidable.loadMap(room.foregroundCollidableMap, room.foregroundCollidableTileset, 16, 16, FlxTilemap.OFF);
			if (room.foregroundNoncollidableMap != null)
				foregroundNoncollidable.loadMap(room.foregroundNoncollidableMap, room.foregroundNoncollidableTileset, 16, 16, FlxTilemap.OFF);
			
			if (room.backgroundMap != null)
			{
				FlxG.bgColor = FlxG.BLACK;
				add(background);
			}
			else
			{
				FlxG.bgColor = FlxG.WHITE;
			}
			
			if (room.foregroundCollidableMap != null)
				add(foregroundCollidable);
			if (room.foregroundNoncollidableMap != null)
				add(foregroundNoncollidable);
				
			//Mark tiles as semipassable
			if (room.foregroundCollidableTileset == Resources.crystalTiles)
			{
				//Jumpthru floors
				foregroundCollidable.setTileProperties(11, FlxObject.CEILING);
				foregroundCollidable.setTileProperties(12, FlxObject.CEILING);
				foregroundCollidable.setTileProperties(20, FlxObject.CEILING);
				
				//Decoration
				foregroundCollidable.setTileProperties(40, FlxObject.NONE);
				foregroundCollidable.setTileProperties(41, FlxObject.NONE);
				foregroundCollidable.setTileProperties(52, FlxObject.NONE);
			}
			if (room.foregroundCollidableTileset == Resources.slimeTiles
				|| room.foregroundCollidableTileset == Resources.shrineTiles)
			{
				//Jumpthru floors
				foregroundCollidable.setTileProperties(11, FlxObject.CEILING);
				foregroundCollidable.setTileProperties(12, FlxObject.CEILING);
				foregroundCollidable.setTileProperties(13, FlxObject.CEILING);
				foregroundCollidable.setTileProperties(19, FlxObject.CEILING);
				foregroundCollidable.setTileProperties(20, FlxObject.CEILING);
				
				//Decoration
				foregroundCollidable.setTileProperties(23, FlxObject.NONE);
				foregroundCollidable.setTileProperties(40, FlxObject.NONE);
				foregroundCollidable.setTileProperties(41, FlxObject.NONE);
				foregroundCollidable.setTileProperties(52, FlxObject.NONE);
			}
			
			//Get gem, force field, danger, boot, and save tiles
			var gemTileIndex:Number = 58;
			var ffTileIndex:Number = 52;
			var bootTileIndex:Number = 57;
			var dangerTileIndex:Number = 48;
			var savePointTileIndex:Number = 51;
			
			
			var i:Number = 0;
			var k:Number = 0;

			for (i = 0; i < foregroundCollidable.width; i++)
			{
				for (k = 0; k < foregroundCollidable.height; k++)
				{
					if (foregroundCollidable.getTile(i, k) == bootTileIndex)
					{
						
						foregroundCollidable.setTile(i, k, 0);
						if (!player.doubleJumpBoots)
						{
							var boot:BootPickup = new BootPickup(i, k);
							actorArray.push(boot);
							add(boot);
						}
						
					}
					else if (foregroundCollidable.getTile(i, k) == savePointTileIndex)
					{
						foregroundCollidable.setTile(i, k, 0);
						player.saveRoomIndex = currentRoom.roomID;
						player.saveRoomPosition = new FlxPoint(i * 16, k * 16);
					}
					else if (foregroundCollidable.getTile(i, k) == dangerTileIndex)
					{
						var damageTile:DamageTile;
						if (room.foregroundCollidableTileset == Resources.crystalTiles)
							damageTile = new DamageTile(i, k, "crystal");
						else
							damageTile = new DamageTile(i, k, "slime");
						actorArray.push(damageTile);
						damagingTilesGroup.add(damageTile);
						foregroundCollidable.setTile(i, k, 0);
					}
				}
			}
			

			
			
			//Play music
			if (room.musicChange != "" && room.musicChange != this.currentMusic)
			{
				this.currentMusic = room.musicChange;
				if (room.musicChange == "Caves")
				{
					//FlxG.music.stop();
					FlxG.playMusic(Resources.crystalMusic, 0.6);
					if (!crystalVisited)
					{
						newAreaText.text = "Crystal Caves";
						newAreaTextTimer = newAreaTextTimerMax;
						crystalVisited = true;
					}
						
				}
				
				if (room.musicChange == "Slime")
				{
					FlxG.playMusic(Resources.slimeMusic, 0.6);
					if (!slimeVisited)
					{
						newAreaText.text = "Slime Labs";
						newAreaTextTimer = newAreaTextTimerMax;
						slimeVisited = true;
					}
				}
				
				if (room.musicChange == "Void")
				{
					FlxG.playMusic(Resources.voidMusic, 0.6);
				}
				
				if (room.musicChange == "Shrine")
				{
					FlxG.playMusic(Resources.shrineMusic, 0.6);
					if (!shrineVisited)
					{
						newAreaText.text = "The Undershrine";
						newAreaTextTimer = newAreaTextTimerMax;
						shrineVisited = true;
					}
				}
			}
			
			//Add lava
			if (room.hasLava)
			{
				var i:Number;
				
				for (i = 0; i < 20; i++)
				{
					var lavaTile:FlxSprite = new FlxSprite(i * 16, 208);
					lavaTile.loadGraphic(Resources.lavaSprite, true, false, 16, 16);
					actorArray.push(lavaTile);
					add(lavaTile);
					lavaTile.addAnimation("wave", new Array(0, 1), 2, true);
					lavaTile.play("wave");
					
					var lavaUnderTile:FlxSprite = new FlxSprite(i * 16, 224);
					lavaUnderTile.loadGraphic(Resources.lavaSprite, true, false, 16, 16);
					lavaUnderTile.makeGraphic(16, 16, 0xFFCC0707);
					actorArray.push(lavaUnderTile);
					add(lavaUnderTile);
				}
					
			}
			
			//Add portal/puppy
			if (room.roomID == 20)
			{
				if (gemsCollected >= gemsNeeded)
				{
					portal = new FlxSprite(176, 112);
					portal.loadGraphic(Resources.portalSprite, true, false, 32, 32);
					portal.addAnimation("pulse", new Array(0, 1, 2, 3, 4, 3, 2, 1), 4, true);
					portal.play("pulse");
					actorArray.push(portal);
					add(portal);
				}
				else
				{
					var portalTxt:FlxText = new FlxText(150, 70, FlxG.width, gemsCollected + "/" + gemsNeeded);
					portalTxt.setFormat(null, 8, 0xFF0000);
					actorArray.push(portalTxt);
					add(portalTxt);
				}
			}
			
			if (room.roomID == 404)
			{
				puppy = new FlxSprite(8*16, 10*16);
				puppy.loadGraphic(Resources.doorSprite, true, false, 64, 48);
				//puppy.addAnimation("bounce", new Array(0, 1), 2, true);
				//puppy.play("bounce");
				actorArray.push(puppy);
				add(puppy);
			}
			
			add(gemsCounter);
		}
		
		//Called by player when dead to reset
		public function OnPlayerDeath():void
		{
			remove(gemsCounter);
			remove(background);
			remove(foregroundCollidable);
			remove(foregroundNoncollidable);
			forceFieldsGroup.kill();
			forceFieldTextGroup.kill();
			damagingTilesGroup.kill();
			
			portal = null;
			puppy = null;
			
			//Remove everything in actor array
			var i:Number = 0;
			for (i = 0; i < actorArray.length; i++)
			{
				remove(actorArray[i]);
			}
			
			//Clear actor array
			actorArray = new Array();
			
			player.x = player.saveRoomPosition.x;
			player.y = player.saveRoomPosition.y;
			player.revive();
			player.visible = true;
			player.deathResetTimer = -1;
			
			
			LoadRoom(world.GetRoomFromID(player.saveRoomIndex));
			
			add(gemsCounter);
		}
		
		//Get puppy
		public function GetPuppy():void
		{
			//Goto end screen
			FlxG.switchState(new EndMenuState());
		}
		
		//Removes an actor from a room permanently
		//For gems, upgrades, etc.
		/*
		public function RemoveGemPermanently(gem:Gem):void
		{
			currentRoom.retrievedGems.push(gem);
			remove(gem);
		}
		*/
		
		public function RemoveForceFieldPermanently():void
		{
			currentRoom.forceFieldActive = false;
			forceFieldsGroup.kill();
			forceFieldsGroup.revive();
		}
		
	}

}