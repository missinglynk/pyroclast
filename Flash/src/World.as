package  
{
	
	
	
	/**
	 * The World is a collection of Rooms.
	 * It loads rooms into memory as the player visits them,
	 * and keeps old rooms loaded in an array so that any changes the player made
	 * will stay intact in those rooms.
	 * @author Matthew Everett
	 */
	public class World 
	{
		
		var loadedRooms:Array;
		
		public function World() 
		{
			loadedRooms = new Array();
		}
		
		public function GetRoom(roomID:Number):Room
		{
			var r:Room = null;
			var roomFound:Boolean = false;
			var i:Number = 0;
			for (i = 0; i < loadedRooms.length; i++)
			{
				if ((loadedRooms[i] as Room).roomID == roomID)
				{
					r = (loadedRooms[i] as Room);
					return r;
				}
			}
			
			//If we don't have the room loaded yet, load it now
			r = Resources.GetRoom(roomID);
			loadedRooms.push(r);
			return r;
		}
		
	}

}