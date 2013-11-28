package nid.xfl.data.graphics 
{
	import nid.utils.Colors;
	import nid.xfl.compiler.swf.data.SWFGradientRecord;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class GradientEntry 
	{
		public var color:uint;
		public var alpha:Number=1;
		public var ratio:Number;
		
		public function GradientEntry(data:XML=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			color = String(data.@color) == ''?0xffffff:uint(String(data.@color).replace("#", "0x"));
			alpha = String(data.@alpha) == ''?1:data.@alpha;
			ratio = String(data.@ratio) == ''?1:data.@ratio;
		}
		public function export():SWFGradientRecord
		{
			var record:SWFGradientRecord = new SWFGradientRecord();
				record.hasAlpha =  alpha != 1;
				record.color = uint(Colors.joinAlpha(color,alpha));
				record.ratio = ratio * 255;
			return record;
		}
	}

}