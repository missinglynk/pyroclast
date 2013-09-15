package org.pyroclast.system
{
	import flash.utils.Dictionary;
	import flash.display.Bitmap;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.Loader;
	import flash.display.BitmapData;
	
	public class  AssetLoader
	{
		public const ASSET_DIR:String = "../assets/";
		public const TILESET_DIR:String = "tilesets/";
		
		public var tilesets:Vector.<LoadedImage>;
		
		public var total_assets:uint = 1;
		public var loaded_assets:uint = 0;
		
		public var onFullyLoaded:Function;
		
		public var masterFilePath:String; 						// Just because it sounds cool
		
		public function AssetLoader(callback:Function = null)
		{
			onFullyLoaded = callback;
			trace("got here!!");
			loadXML(ASSET_DIR + TILESET_DIR + "images.xml", loadTilesets);
			loadXML(ASSET_DIR + "masterFilePath.xml", setMasterFilePath);
			
			function setMasterFilePath(xml:XML):void
			{
				masterFilePath = xml.@src;
				trace(masterFilePath);
				countLoadedAsset();
			}
		}
		
		public function loadXML(file:String, onComplete:Function):void
		{
			var xml:XML;
			var loader:URLLoader = new URLLoader();
			
			loader.load(new URLRequest(file));
			loader.addEventListener(Event.COMPLETE, loadComplete);
			function loadComplete(e:Event):void 
			{
				xml = new XML(e.target.data);
				onComplete(xml);
			}
		}
		
		public function loadTilesets(xml:XML):void
		{
			tilesets = new Vector.<LoadedImage>();
			var loaders:Array = new Array();
			
			for each(var image:XML in xml.image)
			{
				var loader:SpecialLoader = new SpecialLoader();
				var src:String = image.attribute("src");
				//trace("Source Found! : " + src);
				
				loader.data.push(src);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImage);
				loader.load(new URLRequest(ASSET_DIR + TILESET_DIR + src));
				loaders.push(loader);
				++total_assets;
			}
			
			function loadImage(e:Event):void
			{
				trace(e.target.loader.data[0]);
				var completedImage:LoadedImage = new LoadedImage(Bitmap(e.target.content).bitmapData, e.target.loader.data[0]);
				tilesets.push(completedImage);
				countLoadedAsset();
			}
		}
		
		public function countLoadedAsset():void
		{
			++loaded_assets;
			if (onFullyLoaded && loaded_assets == total_assets)
			{
				onFullyLoaded();
			}
		}
		
		public function getTilesetBySrc(src:String):LoadedImage
		{
			if (!tilesets) return null;
			
			//trace("src received: " + src);
			for (var i:int = 0; i < tilesets.length; i++)
			{
				//trace("Checking src: " + src + " against src: " + tilesets[i].src);
				if (tilesets[i].src == src)
					return tilesets[i];
			}
			
			return null;
		}
	}
	
}