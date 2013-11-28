package nid.xfl.dom 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import nid.codec.ARGBEncoder;
	import nid.codec.JPEG3Encoder;
	import nid.codec.JPEGEncoder;
	import nid.utils.Boolean2;
	import nid.utils.Colors;
	import nid.xfl.compiler.swf.data.consts.BitmapType;
	import nid.xfl.XFLType;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class DOMBitmapItem 
	{
		/**
		 * XFL Reference
		 */
		public var doc:DOMDocument;
		
		/**
		 * Properties
		 */
		public var id:int=1;
		public var characterId:int=1;
		public var name:String;
		public var itemID:String;
		public var sourceExternalFilepath:String;
		public var sourceLastImported:String;
		public var useImportedJPEGData:Boolean;
		public var quality:int;
		public var originalCompressionType:String;
		public var compressionType:String;
		public var href:String;
		public var bitmapDataHRef:String;
		public var frameRight:int;
		public var frameBottom:int;
		public var isJPEG:Boolean;
		public var externalFileSize:int;
		public var allowSmoothing:Boolean;
		public var useDeblocking:Boolean;
		
		public var bitmap:Bitmap;
		public var bitmapBytes:ByteArray;
		public var bitmapAlphaData:ByteArray;
		public var bitmapType:uint;
		public var bitmapData:ByteArray;
		
		public function DOMBitmapItem(data:XML=null,refdoc:DOMDocument=null) 
		{
			doc = refdoc;
			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			name 					= data.@name;
			itemID 					= data.@itemID;
			sourceExternalFilepath 	= data.@sourceExternalFilepath;
			sourceLastImported 		= data.@sourceLastImported;
			useImportedJPEGData 	= Boolean2.toBoolean(data.@useImportedJPEGData);
			quality 				= data.@quality;
			originalCompressionType = data.@originalCompressionType;
			compressionType 		= String(data.@compressionType) == ""?"jpeg":data.@compressionType;
			href 					= data.@href;
			bitmapDataHRef 			= data.@bitmapDataHRef;
			frameRight 				= data.@frameRight;
			frameBottom 			= data.@frameBottom;
			isJPEG 					= Boolean2.toBoolean(data.@isJPEG);
			externalFileSize 		= data.@externalFileSize;
			allowSmoothing 			= Boolean2.toBoolean(data.@allowSmoothing);
			useDeblocking 			= Boolean2.toBoolean(data.@useDeblocking);
			
			loadbitmap_phase1();
		}
		
		internal function loadbitmap_phase1():void 
		{
			var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadbitmap_phase2);
			
			if (doc.TYPE == XFLType.ZIP)
			{
				var img_data:ByteArray = doc.zipDoc.files[doc.NAME + '_' + name];
				
				if (img_data != null)
				{
					loader.contentLoaderInfo.addEventListener(Event.INIT, encodeImage);
					loader.loadBytes(img_data);
					//trace('image ok');
				}
				else
				{
					//trace('NULL image data:' + doc.NAME + '_' + name);
				}
			}
			else
			{
				//trace('loadbitmap_phase1:' + doc.LIBRARY_PATH + name);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, encodeImage);
				loader.load(new URLRequest(doc.LIBRARY_PATH + name));
			}
		}
		internal function loadbitmap_phase2(e:IOErrorEvent):void
		{
			//trace("error:" + e.toString());
			//trace('loadbitmap_phase2');
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onPhase2Complete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(new URLRequest(doc.BIN_PATH + '/' + bitmapDataHRef));
		}
		internal function onPhase2Complete(e:Event):void 
		{
			//trace('onPhase2Complete');
			bitmapBytes = e.target.data;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, encodeImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadbitmap_phase3);
			loader.loadBytes(e.target.data);
		}
		internal function loadbitmap_phase3(e:Event):void 
		{
			//trace('dat file not supported');
			return ;
			
			bitmapBytes.position = 0;
			
			var alphaDataOffset:uint = bitmapBytes.readUnsignedShort();
			
			bitmapData = new ByteArray();
			bitmapBytes.readBytes(bitmapData, 0, 1284);
			
			var bmpLoader:Loader = new Loader();
				bmpLoader.contentLoaderInfo.addEventListener(Event.INIT, generateBitmap);
				bmpLoader.loadBytes(bitmapData);
			
			return;
			
			if (bitmapData[0] == 0xff && (bitmapData[1] == 0xd8 || bitmapData[1] == 0xd9)) {
				bitmapType = BitmapType.JPEG;
			} else if (bitmapData[0] == 0x89 && bitmapData[1] == 0x50 && bitmapData[2] == 0x4e && bitmapData[3] == 0x47 && bitmapData[4] == 0x0d && bitmapData[5] == 0x0a && bitmapData[6] == 0x1a && bitmapData[7] == 0x0a) {
				bitmapType = BitmapType.PNG;
			} else if (bitmapData[0] == 0x47 && bitmapData[1] == 0x49 && bitmapData[2] == 0x46 && bitmapData[3] == 0x38 && bitmapData[4] == 0x39 && bitmapData[5] == 0x61) {
				bitmapType = BitmapType.GIF89A;
			}
			var alphaDataSize:uint = bitmapBytes.length - alphaDataOffset - 6;
			if (alphaDataSize > 0) {
				bitmapBytes.readBytes(bitmapAlphaData, 0, alphaDataSize);
			}
			
		}
		internal function generateBitmap(e:Event):void
		{
			//trace('generateBitmap');
			var bmp_data:BitmapData = new BitmapData(e.target.content.width, e.target.content.height, true);
			bmp_data.draw(e.target.content);
			
			bitmapAlphaData.uncompress();
			bitmapAlphaData.position = 0;
			
			for (var j:int = 0; j < bmp_data.height; j++)
			{
				for (var i:int = 0; i < bmp_data.width; i++)
				{
					var pixel:uint = bmp_data.getPixel32(i, j);
					var alpha:Number = bitmapAlphaData.readUnsignedByte() / 255;
					
					if (alpha == 0)
					{
						bmp_data.setPixel32(i,j,0);
					}
					else
					{
						bmp_data.setPixel32(i, j,Colors.extractForegroundColor(pixel, alpha));
					}
					
				}
			}
			bitmapAlphaData.compress();
			
			bitmap = new Bitmap(bmp_data);
		}
		private function encodeImage(e:Event):void 
		{
			//trace('image loaded');
			bitmap = new Bitmap(Bitmap(e.target.content).bitmapData);
			
			bitmapData = new ByteArray();
			
			if (isJPEG)
			{
				bitmap.smoothing = true;
				var jpeg2Encoder:JPEGEncoder = new JPEGEncoder();
				bitmapData = jpeg2Encoder.encode(bitmap.bitmapData);
				//trace('JPEG DATA GENERATED');
			}
			else if (compressionType == "lossless")
			{
				var argbEncoder:ARGBEncoder = new ARGBEncoder();
				bitmapData = argbEncoder.encode(bitmap.bitmapData);
				bitmapData.compress();
			}
			else
			{
				bitmap.smoothing = true;
				var jpeg3Encoder:JPEG3Encoder = new JPEG3Encoder();
				bitmapData = jpeg3Encoder.encode(bitmap.bitmapData);
				bitmapAlphaData = jpeg3Encoder.bitmapAlphaBytes;
				bitmapAlphaData.compress();
			}
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace("error:"+e.toString());
		}
	}

}