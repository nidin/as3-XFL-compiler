package nid.xfl.data.filters 
{
	import nid.xfl.interfaces.IXFilter;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFilterBlur implements IXFilter
	{
		public var blurX:Number;
		public var blurY:Number;
		public var quality:int;
		
		public function get type():String { return 'BlurFilter'; }
		
		public function XFilterBlur(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			blurX 	= String(data.@blurX) == ''?5:data.@blurX;
			blurY 	= String(data.@blurY) == ''?5:data.@blurY;
			quality = String(data.@quality) == ''?1:data.@quality;
		}
		
	}

}