package org.pyroclast.editor
{
	import org.flixel.*;
	import flash.utils.getTimer;
	
	public class GridCursor
	{
		public var cursor:FlxSprite;
		public var glow_period:Number = 0.5;
		public var rate:int = 1;
		public var base_color:uint = 0xFFBE2625;//0xFF8C1717;//0xFFDC143C;//0xFFDC143C;
		public var interp_color:uint = 0xFFFFE600;//0xFFDC143C;
		
		public var width:uint;
		public var height:uint;
		public var thickness:uint = 2;
		
		public var cur_time:Number;
		public var prev_time:Number;
		public var t:Number = 0;
		
		public function GridCursor(w:uint, h:uint)
		{
			width = w + thickness * .5;
			height = h + thickness * .5;
			cursor = new FlxSprite(0, 0);
			
			activate(false);
		}
		
		public function update():void
		{
			if (!active()) return;
			
			prev_time = cur_time;
			cur_time = getTimer();
			var dt:Number = (cur_time - prev_time) * .001;
			t += (dt/glow_period) * rate;
			if (t <= 0 || t >= 1)
			{
				rate = -rate;
				t = clamp(0, 1, t);
			}
			
			draw_cursor();
		}
		
		private function draw_cursor():void
		{
			cursor.makeGraphic(width, height, 0x00000000);
			var color:uint = interpolate(base_color, interp_color, t);//base_color + interp_color * t;
			//trace(color + ", " + base_color + ", " + interp_color + ", " + t);
			var x:uint = thickness * .5;
			var y:uint = thickness * .5;
			var w:uint = width - x;
			var h:uint = height - y;
			
			cursor.drawLine(x, y, w, y, color, thickness);
			cursor.drawLine(w, y, w, h, color, thickness);
			cursor.drawLine(w, h, x, h, color, thickness);
			cursor.drawLine(x, h, x, y, color, thickness);
		}
		
		public function activate(state:Boolean):void
		{
			if (cursor.visible == state) return;
			
			cursor.visible = state;
			if (cursor.visible)
			{
				cur_time = getTimer();
				t = 0;
				rate = 1;
			}
		}
		
		public function setPosition(x:int, y:int):void
		{
			cursor.x = x;
			cursor.y = y;
		}
		
		public function clamp(min:Number, max:Number, value:Number):Number
		{
			return Math.min(Math.max(value, min), max);
		}
		
		public function active():Boolean
		{
			return cursor.visible;
		}
		
		public function interpolate(base:uint, interp:uint, prog:Number):uint
		{
			var b_a:uint = (base >> 24)   	& 0xFF;
			var b_r:uint = (base >> 16)		& 0xFF;
			var b_g:uint = (base >> 8)		& 0xFF;
			var b_b:uint =  base 		  	& 0xFF;
			var i_a:uint = (interp >> 24) 	& 0xFF;
			var i_r:uint = (interp >> 16) 	& 0xFF;
			var i_g:uint = (interp >> 8)  	& 0xFF;
			var i_b:uint =  interp		  	& 0xFF;
			
			var result:uint = (b_a + (i_a - b_a) * prog) << 24 | (b_r + (i_r - b_r) * prog) << 16 | (b_g + (i_g - b_g) * prog) << 8 | (b_b + (i_b - b_b) * prog);
			return result;
		}
	}
}