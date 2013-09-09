package  
{
	/**
	 * ...
	 * @author Matthew Everett
	 */
	import flash.display.Bitmap;
	 import flash.utils.ByteArray;
	 import org.flixel.*;
	 import org.flixel.system.FlxTile;
	 
	public class EndMenuState extends FlxState
	{
		
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0);
			background.loadGraphic(Resources.endScreenBg);
			add(background);
			FlxG.playMusic(Resources.slimeMusic, 0.3);
			
			var credits1:FlxText = new FlxText(0, 220, FlxG.width, "Graphics and design by Matthew Everett and Alicia Cornelia");
			var credits2:FlxText = new FlxText(0, 132, FlxG.width, "All music from Newgrounds:");
			var credits3:FlxText = new FlxText(0, 148, FlxG.width, "'Desert Theme' by Coffee Break");
			var credits4:FlxText = new FlxText(0, 164, FlxG.width, "'Critical Hit' and 'Sweet Potato Roll' by Genclops");
			var credits5:FlxText = new FlxText(0, 180, FlxG.width, "'Corrupted' by DJB3lfry");
			var credits6:FlxText = new FlxText(0, 88, FlxG.width, "Maps made in DAME");
			var credits7:FlxText = new FlxText(0, 72, FlxG.width, "Powered by Flixel");
			var credits8:FlxText = new FlxText(0, 30, FlxG.width, "CREDITS:");
			
			
			credits1.setFormat(null, 8, 0xFFFFFF, "center");
			credits2.setFormat(null, 8, 0xFFFFFF, "right");
			credits3.setFormat(null, 8, 0xFFFFFF, "right");
			credits4.setFormat(null, 8, 0xFFFFFF, "right");
			credits5.setFormat(null, 8, 0xFFFFFF, "right");
			credits6.setFormat(null, 8, 0xFFFFFF, "right");
			credits7.setFormat(null, 8, 0xFFFFFF, "right");
			credits8.setFormat(null, 8, 0xFFFFFF, "right");
			
			add(credits1);
			add(credits2);
			add(credits3);
			add(credits4);
			add(credits5);
			add(credits6);
			add(credits7);
			add(credits8);
			
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}