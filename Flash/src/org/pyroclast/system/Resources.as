package org.pyroclast.system
{
	
	import flash.display.Bitmap;
	import flash.display.CapsStyle;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Matthew Everett
	 */
	public class Resources 
	{
		//Menus
		[Embed(source = "../../../../Assets/The Escape Title Screen.png")]
		public static var titleScreenBg:Class;
		
		[Embed(source = "../../../../Assets/The Escape End Screen.png")]
		public static var endScreenBg:Class;
		
		
		//Sprites
		[Embed(source="../../../../Assets/MorganpickleTile.png")]
		public static var morganSpritesheet:Class;
		
		[Embed(source = "../../../../Assets/LavaWave.png")]
		public static var lavaSprite:Class;
		
		[Embed(source = "../../../../Assets/Portal.png")]
		public static var portalSprite:Class;
		
		[Embed(source = "../../../../Assets/Doggie.png")]
		public static var puppySprite:Class;
		
		[Embed(source = "../../../../Assets/gemSprite.png")]
		public static var gemSprite:Class;
		
		[Embed(source = "../../../../Assets/slimeSprite.png")]
		public static var slimeSprite:Class;
		
		[Embed(source = "../../../../Assets/spikeSprite.png")]
		public static var spikeSprite:Class;
		
		[Embed(source = "../../../../Assets/shoeSprite.PNG")]
		public static var shoeSprite:Class;
		
		[Embed(source = "../../../../Assets/forcefieldSprite.png")]
		public static var forcefieldSprite:Class;
		
		[Embed(source = "../../../../Assets/doorSprite.png")]
		public static var doorSprite:Class;
		
		[Embed(source = "../../../../Assets/Bullet.png")]
		public static var bulletSprite:Class;
		
		
		//Tilesets
		
		[Embed(source = "../../../../Assets/crystalForegroundTiles.png")]
		public static var crystalTiles:Class;
		
		[Embed(source = "../../../../Assets/grassForegroundTiles.png")]
		public static var grassTiles:Class;
		
		[Embed(source = "../../../../Assets/lavaForegroundTiles.png")]
		public static var lavaTiles:Class;
		
		[Embed(source = "../../../../Assets/slimeForegroundTiles.png")]
		public static var slimeTiles:Class;
		
		[Embed(source = "../../../../Assets/shrineForegroundTilesDark.png")]
		public static var shrineTiles:Class;
		
		[Embed(source = "../../../../Assets/VoidRoomTiles.png")]
		public static var voidTiles:Class;
		
		[Embed(source = "../../../../Assets/biodome.png")]
		private static var bgTiles:Class;
		
		[Embed(source = "../../../../Assets/slimeBg.png")]
		private static var slimeBgTiles:Class;
		
		[Embed(source = "../../../../Assets/slimeCleanBg.png")]
		private static var slimeCleanBgTiles:Class;
		
		[Embed(source = "../../../../Assets/shrineBgNew.png")]
		private static var shrineBgTiles:Class;
		
		[Embed(source = "../../../../Assets/crystalCentralBg.png")]
		private static var crystalCentralBg:Class;
		
		//Sound
		[Embed(source="../../../../Assets/Pickup_Coin.mp3")]
		public static var coinSfx:Class;
		
		
		//Music
		[Embed(source="../../../../Assets/405244_Desert_theme_thing_recompressed.mp3")]
		public static var crystalMusic:Class;
		
		[Embed(source="../../../../Assets/529691_Critical-Hit.mp3")]
		public static var slimeMusic:Class;
		
		[Embed(source = "../../../../Assets/508391_Corrupted.mp3")]
		public static var voidMusic:Class;
		
		[Embed(source = "../../../../Assets/530225_Sweet-Potato-Roll.mp3")]
		public static var shrineMusic:Class;
	}

}