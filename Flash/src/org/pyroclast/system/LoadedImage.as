package org.pyroclast.system
{
	
	import flash.display.BitmapData;
	
	public class LoadedImage
	{
		public var src:String;
		public var bitmapData:BitmapData;
		
		public function LoadedImage(data:BitmapData,srcfile:String)
		{
			bitmapData = data;
			src = srcfile;
		}
		
	}
	
}