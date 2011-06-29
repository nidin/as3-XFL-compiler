package nid.xfl.data.filters 
{
	import nid.xfl.interfaces.IFilter;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class BlurFilter implements IFilter
	{
		public var blurX:Number;
		public var blurY:Number;
		public var quality:int;
		
		public function get type():String { return 'BlurFilter'; }
		
		public function BlurFilter(data:XML=null) 
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