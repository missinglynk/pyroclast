package org.pyroclast.editor
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	public class FlxGrid
	{
		//public var grid:Vector.<Vector.<FlxSprite>>;			// This will contain the images that make up the grid
		public var grid:BitmapData;								// Change of plans...This is the new "grid". Tiles will be blitted to squares in here and the whole thing will be displayed as a FlxSprite.
		public var grid_display:FlxSprite;						// This is the FlxSprite to which the grid bitmap data will be drawn
		public var overlay:FlxSprite;							// This will be the grid overlay for drawing lines
		public var grid_group:FlxGroup;							// The group that contains all of the objects in this grid....for ease of adding to the playstate
		public var current_tileset:LoadedImage;					// The tileset currently associated with this grid
		public var tileset_dimensions:Point;					// The dimensions of the current tileset (in number of tiles)
		//public var tile_coords:Vector.<Vector.<Point>>;			// An array storing the coordinates from which each tile's bitmap was extracted (coordinates represent how many horizontal and vertical tiles the tile is offset by)
		public var cursor:GridCursor;							// The cursor used to highlight a selected cell
		
		public var x:int;
		public var y:int;
		public var width:uint;
		public var height:uint;
		public var cell_size:uint;								// All cells will be cell_size x cell_size pixels...let's keep em' squares
		public var rows_displayed:uint;							// Both the number of rows visible at a time as well as the initial number of rows created
		public var cols_displayed:uint;							// Both the number of columns visible at a time as well as the initial number of columns created
		
		public var drag_selectable:Boolean = false;				// Can the user select cells just by clicking and dragging?
		public var scrollable:Boolean = false;					// Can the user scroll within the grid?
		public var xoffset:int = 0;
		public var yoffset:int = 0;
		
		public var onClickCallback:Function;					// What happens when this frame is clicked
		
		public function FlxGrid(X:int, Y:int, w:uint, h:uint, cs:uint, bg_color:uint = 0xFF000000)
		{
			x = X;
			y = Y;
			cell_size = cs;
			width = w - (w % cell_size) + 1;
			height = h - (h % cell_size) + 1;
			
			cols_displayed = uint(width / cell_size);
			rows_displayed = uint(height / cell_size);
			//trace(cols_displayed + ", " + rows_displayed);
			
			setupGrid(bg_color);
		}
		
		public function handleClick(mx:uint,my:uint):void
		{
			if (hidden()) return;
			//trace(mx + ", " + my + ", " + x + ", " + y + ", " + (x + width) + ", " + (y + height));
			if (mx < x || mx >= x + width - 1) return;
			if (my < y || my >= y + height - 1) return;
			
			var xindex:uint = uint(uint(mx - x) / cell_size) + xoffset;
			var yindex:uint = uint(uint(my - y) / cell_size) + yoffset;
			
			if (xindex < 0 || xindex >= cols_displayed) return;
			if (yindex < 0 || yindex >= rows_displayed) return;
			//if (!grid[yindex][xindex].visible) return;
			
			if (this.onClickCallback)
				onClickCallback(new Point(xindex, yindex));
				
			cursor.setPosition(x + xindex * cell_size, y + yindex * cell_size);
		}
		
		
		
		public function setupGrid(bg_color:uint):void
		{
			grid = new BitmapData(width, height, true, bg_color);
			grid_display = new FlxSprite(x, y);
			grid_group = new FlxGroup(int.MAX_VALUE);
			
			redisplayGrid();
			grid_group.add(grid_display);
			
			overlay = new FlxSprite(x, y);
			overlay.width = width;
			overlay.height = height;
			overlay.origin = new FlxPoint(0, 0);
			overlay.makeGraphic(width, height, 0x00000000, true);
			
			var i:int; 
			for (i = 0; i < rows_displayed+1; i++)
			{
				var vpos:int = cell_size * i;
				overlay.drawLine(0, vpos, width, vpos, 0xFFFFFFFF, 1);
			}
			for (i = 0; i < cols_displayed+1; i++)
			{
				var hpos:int = cell_size * i;
				overlay.drawLine(hpos, 0, hpos, height, 0xFFFFFFFF, 1);
			}
			grid_group.add(overlay);
			
			cursor = new GridCursor(cell_size, cell_size);
			cursor.setPosition(x, y);
			grid_group.add(cursor.cursor);
		}
		
		// ToDo: Modify this function to take in the resolution of the tiles in the tileset. This will then be used to decide whether and how much 
		// the tileset is upscaled to match the resolution of the grid cells.
		public function setTileset(image:LoadedImage):void
		{
			current_tileset = image;
			clearGrid();
			grid.draw(image.bitmapData);
			redisplayGrid();
			
			tileset_dimensions = new Point(Math.round(current_tileset.bitmapData.width / cell_size), Math.round(current_tileset.bitmapData.height / cell_size));
		}
		
		public function redisplayGrid():void
		{
			var container:Bitmap = new Bitmap(grid);
			grid_display.loadExtGraphic(container, false, false, grid.width, grid.height, true);
		}
		
		public function getTile(j:uint, i:uint):BitmapData
		{
			if (i < 0 || i >= tileset_dimensions.y) return null;
			if (j < 0 || j >= tileset_dimensions.x) return null;
			
			var tile:BitmapData = new BitmapData(cell_size, cell_size, true, 0x00000000);
			tile.copyPixels(grid, new Rectangle(j * cell_size, i * cell_size, cell_size, cell_size), new Point(0, 0));
			
			return tile;
		}
		
		public function setTile(j:uint, i:uint, tile:BitmapData):void
		{
			if (i < 0 || i >= rows_displayed) return;
			if (j < 0 || j >= cols_displayed) return;
			
			var scale_factor:Number = tile.width == cell_size ? 1 : cell_size / tile.width;
			grid.draw(tile, new Matrix(scale_factor, 0, 0, scale_factor, j * cell_size, i * cell_size));
			redisplayGrid();
		}
		
		public function setCellColor(j:uint, i:uint, color:uint):void
		{
			if (i < 0 || i >= rows_displayed) return;
			if (j < 0 || j >= cols_displayed) return;
			
			grid.fillRect(new Rectangle(j * cell_size, i * cell_size, cell_size, cell_size), color);
			redisplayGrid();
		}
		
		public function clearGrid():void
		{
			//trace("Grid Cleared!");
			grid.fillRect(new Rectangle(0, 0, width, height), 0x00000000);
			redisplayGrid();
		}
		
		public function loadRoomData(layer:uint, assets:AssetLoader, data:RoomData):void
		{
			clearGrid();
			
			var tile_data:Vector.<Vector.<TileData>> = data.layer_data[layer]
			var i:int;
			var j:int;
			for (i = 0; i < tile_data.length; i++)
			{
				for (j = 0; j < tile_data[i].length; j++)
				{
					var tileset:TileData = tile_data[i][j];
					if (!tileset) continue;
					var tileset_image:BitmapData = assets.getTilesetBySrc(tileset.src).bitmapData;
					var coords:Point = tileset.coords;
					var tile:BitmapData = new BitmapData(16, 16, true, 0xFFFF0000);
					tile.copyPixels(tileset_image, new Rectangle(coords.x * 16, coords.y * 16, 16, 16),new Point(0,0));
					var scale_factor:Number = tile.width == cell_size ? 1 : cell_size / tile.width;
					grid.draw(tile, new Matrix(scale_factor, 0, 0, scale_factor, j * cell_size, i * cell_size));
				}
			}
			
			redisplayGrid();
		}
		
		/*
		// I know, this function is long and unsightly, but I don't care to break it up into smaller functions because all of the functionality is only useful here anyway.... and I'm just lazy...
		public function scroll(xscroll:int, yscroll:int):void
		{
			if (!scrollable) return;
			
			var n_xoffset:int = (xoffset + xscroll);
			var n_yoffset:int = (yoffset + yscroll);
			
			// Before we do any scrolling of the existing grid, we need to check if we have scrolled beyond the boundaries of the grid array and, if so,
			// add new rows/columns. Yay...
			
			// Let's start with horizontal stuff...
			var i:int;
			var j:int;
			if (n_xoffset < 0)
			{
				for (i = 0; i < grid.length; i++)
				{
					var new_row:Vector.<FlxSprite> = new Vector.<FlxSprite>();
					
					for (j = 0; j < -n_xoffset; j++)
					{
						//trace("this this this " + i);
						var temp:FlxSprite = new FlxSprite(x - (xoffset*cell_size) + cell_size * j, y - (yoffset*cell_size) + cell_size * i);
						temp.setOriginToCorner();
						temp.width = cell_size;
						temp.height = cell_size;
						temp.makeGraphic(cell_size, cell_size, 0xFFFF0000);
						new_row.push(temp);
						grid_group.add(temp);
					}
					
					grid[i] = new_row.concat(grid[i]);
				}
				xoffset = 0;
			}
			else if (cols_displayed + n_xoffset > grid[0].length)
			{
				var diff:int = cols_displayed + n_xoffset - grid[0].length;
				for (i = 0; i < grid.length; i++)
				{
					for (j = 0; j < diff; j++)
					{
						var temp:FlxSprite = new FlxSprite(100,100);
						temp.setOriginToCorner();
						temp.width = cell_size;
						temp.height = cell_size;
						temp.makeGraphic(cell_size, cell_size, 0xFFFF0000);
						grid[i].push(temp);
						grid_group.add(temp);
					}
				}
				xoffset = n_xoffset;
				
			}
			else
			{
				xoffset = n_xoffset;
			}
			
			// Next, vertical stuff...
			if (n_yoffset < 0)
			{
				var new_grid:Vector.<Vector.<FlxSprite>> = new Vector.<Vector.<FlxSprite>>();
				for (i = 0; i < -n_yoffset; i++)
				{
					var new_row:Vector.<FlxSprite> = new Vector.<FlxSprite>();
					for (j = 0; j < grid[0].length; j++)
					{
						var temp:FlxSprite = new FlxSprite(x - (xoffset*cell_size) + cell_size * j, y - (yoffset*cell_size) + cell_size * i);
						temp.setOriginToCorner();
						temp.width = cell_size;
						temp.height = cell_size;
						temp.makeGraphic(cell_size, cell_size, 0xFF000000);
						new_row.push(temp);
						grid_group.add(temp);
					}
					new_grid.push(new_row);
				}
				grid = new_grid.concat(grid);
				yoffset = 0;
			}
			else if (rows_displayed + n_yoffset >= grid.length)
			{
				var diff:int = rows_displayed + n_yoffset - grid.length;
				for (i = 0; i < diff; i++)
				{
					var new_row:Vector.<FlxSprite> = new Vector.<FlxSprite>();
					for (j = 0; j < grid[0].length; j++)
					{
						var temp:FlxSprite = new FlxSprite(x - (xoffset*cell_size) + (j*cell_size), y - (yoffset*cell_size) + cell_size * i);
						temp.setOriginToCorner();
						temp.width = cell_size;
						temp.height = cell_size;
						temp.makeGraphic(cell_size, cell_size, 0xFF000000);
						new_row.push(temp);
						grid_group.add(temp);
					}
					grid.push(new_row);
				}
				yoffset = n_yoffset;
			}
			else
			{
				yoffset = n_yoffset;
			}
			
			
			// Now, after all that garbage, it's time to make sure everything is properly positioned and visible.
			
			var horizontal_offset:int = x - (xoffset * cell_size);
			var vertical_offset:int = y - (yoffset * cell_size);
			
			for (i = 0; i < grid.length; i++)
			{
				for (j = 0; j < grid[i].length; j++)
				{
					var sprite:FlxSprite = grid[i][j];
					sprite.x = horizontal_offset + j * cell_size;
					sprite.y = vertical_offset + i * cell_size;
					sprite.visible = (i >= yoffset && i <= yoffset + rows_displayed - 1 && j >= xoffset && j <= xoffset + cols_displayed - 1 ) ? true : false;
				}
			}
			
			//trace(grid[0].length + ", " + grid[0][0].alpha + ", " + grid[0][0].visible);
			///trace(grid[0].length + ", " + grid[0][grid[0].length - 1].x + ", " + grid[0][grid[0].length - 1].y + ", " + grid[0][grid[0].length - 1].visible);
			grid_group.add(grid_group.remove(overlay, true)); // Do this to make sure the grid is still on top of everything else
			grid_group.add(grid_group.remove(cursor.cursor, true)); // And the same to esure the cursor still shows up
		}
		*/
		
		/*****************************************************
		 * 	
		 * 					Cursor Fuctions
		 * 
		 ****************************************************/
		 public function updateCursor():void
		{
			cursor.update();
		}
		
		public function positionCursor(p:Point):void
		{
			cursor.setPosition(x + p.x*cell_size,y + p.y*cell_size);
		}
		
		public function showCursor():void
		{
			cursor.activate(true);
			cursor.setPosition(x, y);
		}
		
		public function hideCursor():void
		{
			cursor.activate(false);
		}
		
		public function cursorActive():Boolean
		{
			return cursor.active();
		}
		
		
		/*****************************************************
		 * 	
		 * 					Visibility Fuctions
		 * 
		 ****************************************************/
		public function show():void
		{
			grid_group.visible = true;
		}
		
		public function hide():void
		{
			grid_group.visible = false;
		}
		
		public function hidden():Boolean
		{
			return !grid_group.visible;
		}
		
		
	}
	
}