package nid.xfl.compiler.swf.data
{
	import nid.xfl.compiler.swf.SWFData;
	
	public class SWFGradientRecord
	{
		public var ratio:uint;
		public var color:uint;
		public var hasAlpha:Boolean;
		
		public function SWFGradientRecord(data:SWFData = null, level:uint = 1) {
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function parse(data:SWFData, level:uint):void {
			ratio = data.readUI8();
			//color = (level <= 2) ? data.readRGB() : data.readRGBA();
			color = (hasAlpha) ? data.readRGBA():data.readRGB();
		}
		
		public function publish(data:SWFData, level:uint):void {
			data.writeUI8(ratio);
			if(hasAlpha) {
				data.writeRGBA(color);
			} else {
				data.writeRGB(color);
			}
		}
		
		public function clone():SWFGradientRecord {
			var gradientRecord:SWFGradientRecord = new SWFGradientRecord();
			gradientRecord.ratio = ratio;
			gradientRecord.color = color;
			return gradientRecord;
		}
		
		public function toString():String {
			return "[" + ratio + "," + color.toString(16) + "]";
		}
	}
}
