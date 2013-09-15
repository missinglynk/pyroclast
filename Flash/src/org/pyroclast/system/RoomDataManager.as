package org.pyroclast.system 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Matthew Everett
	 */
	public class RoomDataManager 
	{
		
		private var room_data:Vector.<RoomData>;
		private var manifestPath:String;
		private var idCounter:uint;
		
		public function RoomDataManager(manifestPath:String) 
		{
			this.manifestPath = manifestPath;
			loadManifest();
		}
		
		public function getRoomDataFromID(roomID:int):RoomData
		{
			for (var i:int = 0; i < room_data.length; i++)
			{
				if (room_data[i].room_id == roomID)
					return room_data[i];
			}
			
			//If we get down here, there's no room there so we'll make a blank room and add it
			//TODO
			
			return null;
		}
		
		public function getRoomDataFromCoordinates(x:int, y:int):RoomData
		{
			for (var i:int = 0; i < room_data.length; i++)
			{
				if (room_data[i].roomX == x && room_data[i].roomY == y)
					return room_data[i];
			}
			
			//If we get down here, there's no room there so we'll make a blank room and add it
			//TODO
			
			return null;
		}
		
		public function reloadAll():void
		{
			loadManifest();
		}
		
		public function saveAllRoomDataAndManifest():void
		{
			
		}
		
		private function loadManifest():void
		{
			room_data = new Vector.<RoomData>();
			idCounter = 0;
			
			var xml:XML;
			var loader:URLLoader = new URLLoader();
			
			loader.load(new URLRequest(manifestPath));
			loader.addEventListener(Event.COMPLETE, loadComplete);
			
			function loadComplete(e:Event):void
			{
				xml = XML(e.target.data);
				onComplete(xml);
			}
			
			function onComplete(xml:XML):void
			{
				for each(var room:XML in xml.rooms.room)
				{
					//Increment id assignment counter
					if (room.@id > idCounter)
						idCounter = room.@id + 1;
					
					var newRoom:RoomData = new RoomData(room.@id, room.@roomx, room.@roomy);
					newRoom.loadFromXML(room);
					room_data.push(newRoom);
				}
				
				
			}
		}
		
	}

}