package  
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
		[Embed(source = "../Assets/The Escape Title Screen.png")]
		public static var titleScreenBg:Class;
		
		[Embed(source = "../Assets/The Escape End Screen.png")]
		public static var endScreenBg:Class;
		
		
		//Sprites
		[Embed(source="../Assets/MorganpickleTile.png")]
		public static var morganSpritesheet:Class;
		
		[Embed(source = "../Assets/LavaWave.png")]
		public static var lavaSprite:Class;
		
		[Embed(source = "../Assets/Portal.png")]
		public static var portalSprite:Class;
		
		[Embed(source = "../Assets/Doggie.png")]
		public static var puppySprite:Class;
		
		[Embed(source = "../Assets/gemSprite.png")]
		public static var gemSprite:Class;
		
		[Embed(source = "../Assets/slimeSprite.png")]
		public static var slimeSprite:Class;
		
		[Embed(source = "../Assets/spikeSprite.png")]
		public static var spikeSprite:Class;
		
		[Embed(source = "../Assets/shoeSprite.PNG")]
		public static var shoeSprite:Class;
		
		[Embed(source = "../Assets/forcefieldSprite.png")]
		public static var forcefieldSprite:Class;
		
		[Embed(source = "../Assets/doorSprite.png")]
		public static var doorSprite:Class;
		
		[Embed(source = "../Assets/Bullet.png")]
		public static var bulletSprite:Class;
		
		//Tilesets
		
		[Embed(source = "../Assets/crystalForegroundTiles.png")]
		public static var crystalTiles:Class;
		
		[Embed(source = "../Assets/grassForegroundTiles.png")]
		public static var grassTiles:Class;
		
		[Embed(source = "../Assets/lavaForegroundTiles.png")]
		public static var lavaTiles:Class;
		
		[Embed(source = "../Assets/slimeForegroundTiles.png")]
		public static var slimeTiles:Class;
		
		[Embed(source = "../Assets/shrineForegroundTilesDark.png")]
		public static var shrineTiles:Class;
		
		[Embed(source = "../Assets/VoidRoomTiles.png")]
		public static var voidTiles:Class;
		
		[Embed(source = "../Assets/biodome.png")]
		private static var bgTiles:Class;
		
		[Embed(source = "../Assets/slimeBg.png")]
		private static var slimeBgTiles:Class;
		
		[Embed(source = "../Assets/slimeCleanBg.png")]
		private static var slimeCleanBgTiles:Class;
		
		[Embed(source = "../Assets/shrineBgNew.png")]
		private static var shrineBgTiles:Class;
		
		[Embed(source = "../Assets/crystalCentralBg.png")]
		private static var crystalCentralBg:Class;
		
		//Sound
		[Embed(source="../Assets/Pickup_Coin.mp3")]
		public static var coinSfx:Class;
		
		
		//Music
		[Embed(source="../Assets/405244_Desert_theme_thing_recompressed.mp3")]
		public static var crystalMusic:Class;
		
		[Embed(source="../Assets/529691_Critical-Hit.mp3")]
		public static var slimeMusic:Class;
		
		[Embed(source = "../Assets/508391_Corrupted.mp3")]
		public static var voidMusic:Class;
		
		[Embed(source = "../Assets/530225_Sweet-Potato-Roll.mp3")]
		public static var shrineMusic:Class;
		
		
		//Background maps
		[Embed(source="../Assets/mapCSV_Group1_Background.csv", mimeType="application/octet-stream")]
		private static var CavesBackground:Class;
		
		[Embed(source = "../Assets/mapCSV_Backgrounds_LavaHighBackground.csv", mimeType = "application/octet-stream")]
		private static var LavaHighBackground:Class;
		
		[Embed(source = "../Assets/mapCSV_Backgrounds_LavaLowBackground.csv", mimeType = "application/octet-stream")]
		private static var LavaLowBackground:Class;
		
		[Embed(source="../Assets/mapCSV_Backgrounds_slimeBackground.csv", mimeType="application/octet-stream")]
		private static var SlimeBackground:Class;
		
		[Embed(source="../Assets/mapCSV_Backgrounds_shrineBackground.csv", mimeType="application/octet-stream")]
		private static var ShrineBackground:Class;
		
		[Embed(source="../Assets/mapCSV_Backgrounds_centralBackground.csv", mimeType="application/octet-stream")]
		public static var CentralBackground:Class;
		
		//***Level maps***
		
		//Void
		[Embed(source = "../Assets/mapCSV_100VoidStart_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_100:Class;
		
		[Embed(source = "../Assets/mapCSV_102VoidStartLoop_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_102:Class;
		
		[Embed(source = "../Assets/mapCSV_103VoidExitLoop_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_103:Class;
		
		[Embed(source = "../Assets/mapCSV_104VoidExit_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_104:Class;
		
		//Caves
		[Embed(source = "../Assets/mapCSV_200CaveWestEntrance_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_200:Class;
		
		[Embed(source="../Assets/mapCSV_201UpperCave_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_201:Class;
		
		[Embed(source="../Assets/mapCSV_202CaveCentral_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_202:Class;
		
		[Embed(source = "../Assets/mapCSV_203CaveEastHall_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_203:Class;
		
		[Embed(source = "../Assets/mapCSV_204CaveLowerShaft_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_204:Class;
		
		[Embed(source = "../Assets/mapCSV_205LowerCave_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_205:Class;
		
		[Embed(source="../Assets/mapCSV_206LongPit_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_206:Class;
		
		[Embed(source="../Assets/mapCSV_207CaveLowerChamber_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_207:Class;
		
		
		//Slime
		[Embed(source="../Assets/mapCSV_300SlimePitsUpperExit_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_300:Class;
		
		[Embed(source="../Assets/mapCSV_301SlimePitsWestHall_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_301:Class;
		
		[Embed(source="../Assets/mapCSV_302SlimePitsCentral_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_302:Class;
		
		[Embed(source="../Assets/mapCSV_303LowerSlimePits_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_303:Class;
		
		[Embed(source="../Assets/mapCSV_304DoubleJumpAccess_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_304:Class;
		
		[Embed(source="../Assets/mapCSV_305DoubleJumpRoom_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_305:Class;
		
		[Embed(source="../Assets/mapCSV_306SlimePitsLowerExit_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_306:Class;
		
		[Embed(source="../Assets/mapCSV_307SlimePitsEastHallway_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_307:Class;
		
		[Embed(source="../Assets/mapCSV_308SlimePitsUpperShaft_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_308:Class;
		
		[Embed(source="../Assets/mapCSV_309SlimePitsUpperExit_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_309:Class;
		
		[Embed(source = "../Assets/mapCSV_310SlimePitsUpperChamber_Foreground.csv", mimeType = "application/octet-stream")]
		private static var Room_310:Class;
		
		
		//Shrine
		[Embed(source="../Assets/mapCSV_400UndershrineWestEntrance_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_400:Class;
		
		[Embed(source="../Assets/mapCSV_401UndershrineWestHall_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_401:Class;
		
		[Embed(source="../Assets/mapCSV_402UndershrineEastHall_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_402:Class;
		
		[Embed(source="../Assets/mapCSV_403UndershrineEastEntrance_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_403:Class;
		
		[Embed(source="../Assets/mapCSV_404UndershrineCentral_Foreground.csv", mimeType="application/octet-stream")]
		private static var Room_404:Class;
		
		
		
		
		
		
		public static function GetRoom(roomID:Number):Room
		{
			var r:Room = new Room();
			
			if (roomID == 100)
			{
				r.roomID = 100;
				
				r.backgroundMap = null;
				r.foregroundCollidableMap = ReadMap(Room_100);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = voidTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 102;
				r.bottomExit = 102;
				r.leftExit = 100;
				r.rightExit = 104;
				
				r.musicChange = "Void";
			}
			
			if (roomID == 102)
			{
				r.roomID = 102;
				
				r.backgroundMap = null;
				r.foregroundCollidableMap = ReadMap(Room_102);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = voidTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 103;
				r.rightExit = 103;
				
				r.musicChange = "Void";
			}
			
			if (roomID == 103)
			{
				r.roomID = 103;
				
				r.backgroundMap = null;
				r.foregroundCollidableMap = ReadMap(Room_103);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = voidTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 104;
				r.bottomExit = 104;
				r.leftExit = 102;
				r.rightExit = 102;
				
				r.musicChange = "Void";
			}
			
			if (roomID == 104)
			{
				r.roomID = 104;
				
				r.backgroundMap = null;
				r.foregroundCollidableMap = ReadMap(Room_104);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = voidTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 103;
				r.bottomExit = 103;
				r.leftExit = 100;
				r.rightExit = 200;
				
				r.musicChange = "Void";
			}
			
			if (roomID == 200)
			{
				r.roomID = 200;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_200);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 104;
				r.rightExit = 202;
				
				r.musicChange = "Caves";
			}
			
			if (roomID == 201)
			{
				r.roomID = 201;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_201);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 202;
				r.leftExit = 100;
				r.rightExit = 400;
				
				r.forceFieldActive = true;
				r.forceFieldGemsRequired = 70;
				
				r.musicChange = "Caves";
			}
			
			if (roomID == 202)
			{
				r.roomID = 202;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_202);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 201;
				r.bottomExit = 204;
				r.leftExit = 200;
				r.rightExit = 203;
				
				r.forceFieldActive = true;
				r.forceFieldGemsRequired = 15;
				
				r.musicChange = "Caves";
			}
			
			if (roomID == 203)
			{
				r.roomID = 203;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_203);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 1;
				r.bottomExit = 1;
				r.leftExit = 202;
				r.rightExit = 300;
				
				r.musicChange = "Caves";
			}
			
			if (roomID == 204)
			{
				r.roomID = 204;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_204);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 202;
				r.bottomExit = 205;
				r.leftExit = 100;
				r.rightExit = 207;
			}
			
			if (roomID == 205)
			{
				r.roomID = 205;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_205);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 204;
				r.bottomExit = 100;
				r.leftExit = 100;
				r.rightExit = 206;
			}
			
			if (roomID == 206)
			{
				r.roomID = 206;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_206);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 207;
				r.bottomExit = 100;
				r.leftExit = 205;
				r.rightExit = 306;
				
				r.musicChange = "Caves";
			}
			
			if (roomID == 207)
			{
				r.roomID = 207;
				
				r.backgroundMap = ReadMap(CavesBackground);
				r.foregroundCollidableMap = ReadMap(Room_207);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = bgTiles;
				r.foregroundCollidableTileset = crystalTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 206;
				r.leftExit = 204;
				r.rightExit = 100;
			}
			
			if (roomID == 300)
			{
				r.roomID = 300;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_300);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeCleanBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 203;
				r.rightExit = 301;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 301)
			{
				r.roomID = 301;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_301);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeCleanBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 300;
				r.rightExit = 302;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 302)
			{
				r.roomID = 302;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_302);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeCleanBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 310;
				r.bottomExit = 303;
				r.leftExit = 301;
				r.rightExit = 307;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 303)
			{
				r.roomID = 303;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_303);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 302;
				r.bottomExit = 100;
				r.leftExit = 304;
				r.rightExit = 100;
				
				r.forceFieldActive = true;
				r.forceFieldGemsRequired = 40;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 304)
			{
				r.roomID = 304;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_304);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 305;
				r.leftExit = 100;
				r.rightExit = 303;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 305)
			{
				r.roomID = 305;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_305);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 304;
				r.bottomExit = 100;
				r.leftExit = 306;
				r.rightExit = 100;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 306)
			{
				r.roomID = 306;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_306);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 206;
				r.rightExit = 305;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 307)
			{
				r.roomID = 307;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_307);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeCleanBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 308;
				r.bottomExit = 100;
				r.leftExit = 302;
				r.rightExit = 100;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 308)
			{
				r.roomID = 308;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_308);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeCleanBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 309;
				r.bottomExit = 307;
				r.leftExit = 310;
				r.rightExit = 100;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 309)
			{
				r.roomID = 309;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_309);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeCleanBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 308;
				r.leftExit = 403;
				r.rightExit = 100;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 310)
			{
				r.roomID = 310;
				
				r.backgroundMap = ReadMap(SlimeBackground);
				r.foregroundCollidableMap = ReadMap(Room_310);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = slimeCleanBgTiles;
				r.foregroundCollidableTileset = slimeTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 302;
				r.leftExit = 100;
				r.rightExit = 308;
				
				r.musicChange = "Slime";
			}
			
			if (roomID == 400)
			{
				r.roomID = 400;
				
				r.backgroundMap = ReadMap(ShrineBackground);
				r.foregroundCollidableMap = ReadMap(Room_400);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = shrineBgTiles;
				r.foregroundCollidableTileset = shrineTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 401;
				r.bottomExit = 100;
				r.leftExit = 201;
				r.rightExit = 100;
				
				r.musicChange = "Shrine";
			}
			
			if (roomID == 401)
			{
				r.roomID = 401;
				
				r.backgroundMap = ReadMap(ShrineBackground);
				r.foregroundCollidableMap = ReadMap(Room_401);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = shrineBgTiles;
				r.foregroundCollidableTileset = shrineTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 400;
				r.leftExit = 100;
				r.rightExit = 404;
				
				r.forceFieldActive = true;
				r.forceFieldGemsRequired = 90;
				
				r.musicChange = "Shrine";
			}
			
			if (roomID == 402)
			{
				r.roomID = 402;
				
				r.backgroundMap = ReadMap(ShrineBackground);
				r.foregroundCollidableMap = ReadMap(Room_402);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = shrineBgTiles;
				r.foregroundCollidableTileset = shrineTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 404;
				r.rightExit = 403;
				
				r.forceFieldActive = true;
				r.forceFieldGemsRequired = 90;
				
				r.musicChange = "Shrine";
			}
			
			if (roomID == 403)
			{
				r.roomID = 403;
				
				r.backgroundMap = ReadMap(ShrineBackground);
				r.foregroundCollidableMap = ReadMap(Room_403);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = shrineBgTiles;
				r.foregroundCollidableTileset = shrineTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 402;
				r.rightExit = 309;
				
				r.forceFieldActive = false;
				r.forceFieldGemsRequired = 100;
				
				r.musicChange = "Shrine";
			}
			
			if (roomID == 404)
			{
				r.roomID = 404;
				
				r.backgroundMap = ReadMap(ShrineBackground);
				r.foregroundCollidableMap = ReadMap(Room_404);
				r.foregroundNoncollidableMap = null;
				
				r.backgroundTileset = shrineBgTiles;
				r.foregroundCollidableTileset = shrineTiles;
				r.foregroundNoncollidableTileset = null;
				
				r.topExit = 100;
				r.bottomExit = 100;
				r.leftExit = 401;
				r.rightExit = 402;
				
				r.musicChange = "Shrine";
			}
			
			
			return r;
		}
		
		public static function ReadMap(res:Class):String
		{
			var b:ByteArray = new res();
			var s:String = b.readUTFBytes(b.length);
			return s;
		}
		
	}

}