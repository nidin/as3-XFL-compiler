package nid.xfl 
{
	import flash.utils.ByteArray;
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.SWFCompiler;
	import nid.xfl.compiler.swf.SWFData;
	import nid.xfl.compiler.swf.tags.TagDefineSceneAndFrameLabelData;
	import nid.xfl.compiler.swf.tags.TagFileAttributes;
	import nid.xfl.compiler.swf.tags.TagSetBackgroundColor;
	import nid.xfl.XFLDocument;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class Complier extends SWFCompiler
	{
		public var source:XFLDocument;
		public var output:ByteArray;
		
		public function Complier() 
		{
			
		}
		public function compile(src:XFLDocument):void
		{
			source  = null;
			source  = src;
			output = null
			output = new ByteArray();
			
			if (source.publishSettings)
			{
				/**
				 * TODO: add publish settings from xml
				 */
			}
			else
			{
				
			}
			
			publish(output);
		}
		public function publish(ba:ByteArray):void
		{
			var data:SWFData = new SWFData();
			publishHeader(data);
			buildSWFTags();
			publishTags(data, version);
			publishFinalize(data);
			ba.writeBytes(data);
		}
		override public function buildSWFTags():void 
		{
			initTags();
			super.buildSWFTags();
		}
		private function initTags():void 
		{			
			var fileAttributes:TagFileAttributes = new TagFileAttributes();
				fileAttributes.actionscript3 	= true;
				fileAttributes.hasMetadata 		= false;
				fileAttributes.useDirectBlit 	= false;
				fileAttributes.useGPU 			= false;
				fileAttributes.useNetwork 		= false;
				
			_tags.push(fileAttributes);
			
			var backGround:TagSetBackgroundColor = new TagSetBackgroundColor();
				backGround.color = backgroundColor;//0xffffff;
			_tags.push(backGround);
			
			var defineSceneAndFrameLabelData:TagDefineSceneAndFrameLabelData = new TagDefineSceneAndFrameLabelData();
				defineSceneAndFrameLabelData.scenes.push(new SWFScene(0, "Scene 1"));
			_tags.push(defineSceneAndFrameLabelData);
		}
		protected function publishHeader(data:SWFData):void 
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