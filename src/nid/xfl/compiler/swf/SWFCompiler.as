package nid.xfl.compiler.swf 
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import nid.xfl.compiler.swf.data.SWFRawTag;
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.data.SWFScene;
	import nid.xfl.compiler.swf.data.SWFSymbol;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagDefineSceneAndFrameLabelData;
	import nid.xfl.compiler.swf.tags.TagDoABC;
	import nid.xfl.compiler.swf.tags.TagFileAttributes;
	import nid.xfl.compiler.swf.tags.TagSetBackgroundColor;
	import nid.xfl.compiler.swf.tags.TagSymbolClass;
	import nid.xfl.core.XFLObject;
	import nid.xfl.XFLCompiler;
	import nid.xfl.XFLDocument;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class SWFCompiler extends EventDispatcher
	{
		public var bytes:ByteArray;
		public var xflobj:XFLObject;
		
		/**
		 * SWF PROPERTIES
		 */
		public var version:int;
		public var fileLength:uint;
		public var fileLengthCompressed:uint;
		public var frameSize:SWFRectangle;
		public var frameRate:Number;
		public var frameCount:uint;
		public var compressed:Boolean;
		public var backgroundColor:uint;
		
		protected static const FILE_LENGTH_POS:uint = 4;
		protected static const COMPRESSION_START_POS:uint = 8;
		
		protected var tags:Vector.<ITag>;
		protected var tagsRaw:Vector.<SWFRawTag>;
		
		public function SWFCompiler()
		{
			version = 10;
			frameRate = 24;
			compressed = true;
			frameCount = 1;
			frameSize = new SWFRectangle();
			
			tags = new Vector.<ITag>();
			tagsRaw = new Vector.<SWFRawTag>();
		}
		
		protected function publishTags(data:SWFData, version:uint):void 
		{
			for (var i:uint = 0; i < tags.length; i++) {
				try {
					if (tags[i] is TagDoABC)
					{
						trace('caught');
					}
					tags[i].publish(data, version);
				}
				catch (e:Error) {
					trace("WARNING: publish error: " + e.message + " (tag: " + tags[i].name + ", index: " + i + ")");
					//tagsRaw[i].publish(data);
				}
			}
		}
		
		protected function initTags():void 
		{
			var fileAttributes:TagFileAttributes = new TagFileAttributes();
				fileAttributes.actionscript3 	= true;
				fileAttributes.hasMetadata 		= false;
				fileAttributes.useDirectBlit 	= true;
				fileAttributes.useGPU 			= true;
				fileAttributes.useNetwork 		= false;
				
			tags.push(fileAttributes);
			
			var backGround:TagSetBackgroundColor = new TagSetBackgroundColor();
				backGround.color = backgroundColor;
			tags.push(backGround);
			
			var defineSceneAndFrameLabelData:TagDefineSceneAndFrameLabelData = new TagDefineSceneAndFrameLabelData();
				defineSceneAndFrameLabelData.scenes.push(new SWFScene(0, "Scene 1"));
			tags.push(defineSceneAndFrameLabelData);
			
		}
		protected function buildHeader(data:SWFData):void 
		{
			data.writeUI8(compressed ? 0x43 : 0x46);
			data.writeUI8(0x57);
			data.writeUI8(0x53);
			data.writeUI8(version);
			data.writeUI32(0);
			data.writeRECT(frameSize);
			data.writeFIXED8(frameRate);
			data.writeUI16(frameCount); // TODO: get the real number of frames from the tags
		}
		protected function publishFinalize(data:SWFData):void {
			fileLength = fileLengthCompressed = data.length;
			if (compressed) {
				data.position = COMPRESSION_START_POS;
				data.swfCompress();
				fileLengthCompressed = data.length;
			}
			var endPos:uint = data.position;
			data.position = FILE_LENGTH_POS;
			data.writeUI32(fileLength);
			data.position = 0;
		}
	}

}