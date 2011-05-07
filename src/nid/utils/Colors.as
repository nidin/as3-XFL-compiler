package nid.utils
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Colors
	{

		public function Colors()
		{

		}
		static public function extractForegroundColor(hex:uint,a:Number):uint
		{
			
			var rx:Number = (hex >> 16 & 0xff) / 255;
			var gx:Number = (hex >> 8 & 0xff) / 255;
			var bx:Number = (hex & 0xff) / 255;
			
			var A:Number = 1;
			var R:Number = 0;
			var G:Number = 0;
			var B:Number = 0;
			
			var ax:Number = 1 - (1 - a) * (1 - A);
			
			var r:Number = ((rx * ax - (R * A * (1 - a))) / a ) * 255;
			var g:Number = ((gx * ax - (G * A * (1 - a))) / a ) * 255;
			var b:Number = ((bx * ax - (B * A * (1 - a))) / a ) * 255;
			
			return ((a * 255) << 24) | (r << 16 ) | ( g << 8 ) | b;
		}
		static public function combineAlphaColor(fgcolor:uint,bgcolor:uint):uint
		{
			var a:Number = (fgcolor >> 24 & 0xff) / 255;
			var r:Number = (fgcolor >> 16 & 0xff) / 255;
			var g:Number = (fgcolor >> 8 & 0xff) / 255;
			var b:Number = (fgcolor & 0xff) / 255;
			
			var A:Number = (bgcolor >> 24 & 0xff) / 255;
			var R:Number = (bgcolor >> 16 & 0xff) / 255;
			var G:Number = (bgcolor >> 8 & 0xff) / 255;
			var B:Number = (bgcolor & 0xff) / 255;
			
			var ax:Number = 1 - (1 - a) * (1 - A)
			var rx:Number = ((r * a / ax) + (R * A * (1 - a) / ax)) * 255;
			var gx:Number = ((g * a / ax) + (G * A * (1 - a) / ax)) * 255;
			var bx:Number = ((b * a / ax) + (B * A * (1 - a) / ax)) * 255;
			
			return (rx << 16) | (gx << 8) | bx;
		}
		static public function extractALPHA(hex : uint):uint { return hex >> 24 & 0xff; }
		static public function extractRED(hex : uint):uint { return hex >> 16 & 0xff; }
		static public function extractGREEN(hex : uint):uint { return hex >> 8 & 0xff; }
		static public function extractBLUE(hex : uint):uint { return hex & 0xff; }
		
		static public function fixHexColor(hex:String):String
		{
			hex = hex.replace(/#/g, "");
			
			if (hex.length < 6)
			{
				var dif:int = 6 - hex.length;
				
				for (var i:int = 0; i < dif; i++)
				{
					hex = '0' + hex;
				}
			}
			hex = '0x' + hex;
			
			return hex;
		}
		static public function joinAlpha(value:uint,a:Number):String
		{
			var hex:String = value.toString(16);
			hex = hex.replace(/#/g, "");
			
			var alpha:String = (255 * a).toString(16);
				alpha = alpha.length == 1?"0" + alpha:alpha;
			
			if (hex.length < 6)
			{
				var dif:int = 6 - hex.length;
				
				for (var i:int = 0; i < dif; i++)
				{
					hex = '0' + hex;
				}
			}
			hex = '0x' + alpha + hex;
			
			return hex;
		}
	}

}

