package nid.codec 
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class JPEG3Encoder extends JPEGEncoder
	{
		public var bitmapBytes:ByteArray;
		public var bitmapAlphaBytes:ByteArray;
		
		public function JPEG3Encoder(quality:Number = 50.0)
		{
			super(quality);
		}
		override public function encode(source:BitmapData):ByteArray
		{
			var sourceBitmapData:BitmapData = source as BitmapData;
			var sourceByteArray:ByteArray = source as ByteArray;
			
			bitmapBytes = super.encode(sourceBitmapData);
			
			bitmapAlphaBytes = new ByteArray();
			
			for (var y:int = 0; y < source.height; y++)
			{
				//IDAT.writeByte(0); // no filter
				
				var x:int;
				var pixel:uint;
				
				if (!sourceBitmapData.transparent)
				{
					for (x = 0; x < source.width; x++)
					{
						if (sourceBitmapData)
							pixel = sourceBitmapData.getPixel(x, y);
						else
							pixel = sourceByteArray.readUnsignedInt();
						
						//IDAT.writeUnsignedInt(uint(((pixel & 0xFFFFFF) << 8) | 0xFF));
					}
				}
				else
				{
					for (x = 0; x < source.width; x++)
					{
						if (sourceBitmapData)
							pixel = sourceBitmapData.getPixel32(x, y);
						else
							pixel = sourceByteArray.readUnsignedInt();
							
						//IDAT.writeUnsignedInt(uint(((pixel & 0xFFFFFF) << 8) |(pixel >>> 24)));
						//trace(pixel.toString(16));
						bitmapAlphaBytes.writeByte(pixel >> 24 & 0xFF);
					}
				}
			}
			
			return bitmapBytes;
		}
		
	}

}