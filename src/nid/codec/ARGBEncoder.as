package nid.codec 
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class ARGBEncoder 
	{
		
		public function ARGBEncoder() 
		{
			
		}
		public function encode(sourceBitmapData:BitmapData):ByteArray
		{
			var ba:ByteArray = new ByteArray();
			
			for (var y:int = 0; y < sourceBitmapData.height; y++)
			{
				
				var x:int;
				var pixel:uint;
				
				if (!sourceBitmapData.transparent)
				{
					for (x = 0; x < sourceBitmapData.width; x++)
					{
						if (sourceBitmapData)
							pixel = sourceBitmapData.getPixel(x, y);
							
						ba.writeUnsignedInt(uint(0xFF | pixel));
					}
				}
				else
				{
					for (x = 0; x < sourceBitmapData.width; x++)
					{
						if (sourceBitmapData)
							pixel = sourceBitmapData.getPixel32(x, y);
						
						ba.writeUnsignedInt(pixel);
					}
				}
			}
			
			return ba;
		}
	}

}