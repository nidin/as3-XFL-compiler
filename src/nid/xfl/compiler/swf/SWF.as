package nid.xfl.compiler.swf
{
	/**
	 * The MIT License
		
		Copyright (c) 2009 côdeazur brasil Ltda, Claus Wahlers
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in
		all copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
		THE SOFTWARE.
		
		Modified by : Nidin Vinayak
		Date 		: 2011
	 */
	
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.events.SWFEvent;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
	public class SWF extends SWFTimelineContainer
	{
		public var version:int;
		public var fileLength:uint;
		public var fileLengthCompressed:uint;
		public var frameSize:SWFRectangle;
		public var frameRate:Number;
		public var frameCount:uint;
		
		public var compressed:Boolean;
		
		protected var bytes:SWFData;
		
		protected static const FILE_LENGTH_POS:uint = 4;
		protected static const COMPRESSION_START_POS:uint = 8;
		
		public function SWF(ba:ByteArray = null) {
			bytes = new SWFData();
			if (ba != null) {
				loadBytes(ba);
			} else {
				version = 10;
				fileLength = 0;
				fileLengthCompressed = 0;
				frameSize = new SWFRectangle();
				frameRate = 50;
				frameCount = 1;
				compressed = true;
			}
		}
		
		public function loadBytes(ba:ByteArray):void {
			bytes.length = 0;
			ba.position = 0;
			ba.readBytes(bytes);
			parse(bytes);
		}
		
		public function loadBytesAsync(ba:ByteArray):void {
			bytes.length = 0;
			ba.position = 0;
			ba.readBytes(bytes);
			parseAsync(bytes);
		}
		
		public function parse(data:SWFData):void {
			bytes = data;
			parseHeader();
			parseTags(data, version);
		}
		
		public function parseAsync(data:SWFData):void {
			bytes = data;
			parseHeader();
			if(dispatchEvent(new SWFEvent(SWFEvent.HEADER, data, false, true))) {
				parseTagsAsync(data, version);
			}
		}
		
		public function publish(ba:ByteArray):void {
			var data:SWFData = new SWFData();
			publishHeader(data);
			publishTags(data, version);
			publishFinalize(data);
			ba.writeBytes(data);
		}
		
		public function publishAsync(ba:ByteArray):void {
			// TODO
		}
		
		protected function parseHeader():void {
			compressed = false;
			bytes.position = 0;
			var signatureByte:uint = bytes.readUI8();
			if (signatureByte == 0x43) {
				compressed = true;
			} else if (signatureByte != 0x46) {
				throw(new Error("Not a SWF. First signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x43 or 0x46)"));
			}
			signatureByte = bytes.readUI8();
			if (signatureByte != 0x57) {
				throw(new Error("Not a SWF. Second signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x57)"));
			}
			signatureByte = bytes.readUI8();
			if (signatureByte != 0x53) {
				throw(new Error("Not a SWF. Third signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x53)"));
			}
			version = bytes.readUI8();
			fileLength = bytes.readUI32();
			fileLengthCompressed = bytes.length;
			if (compressed) {
				// The following data (up to end of file) is compressed, if header has CWS signature
				bytes.swfUncompress();
			}
			frameSize = bytes.readRECT();
			frameRate = bytes.readFIXED8();
			frameCount = bytes.readUI16();
		}
		
		protected function publishHeader(data:SWFData):void {
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
		
		override public function toString(indent:uint = 0):String {
			return "[SWF]\n" +
				"  Header:\n" +
				"    Version: " + version + "\n" +
				"    FileLength: " + fileLength + "\n" +
				"    FileLengthCompressed: " + fileLengthCompressed + "\n" +
				"    FrameSize: " + frameSize.toStringSize() + "\n" +
				"    FrameRate: " + frameRate + "\n" +
				"    FrameCount: " + frameCount +
				super.toString(indent);
		}
	}
}
