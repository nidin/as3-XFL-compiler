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
		
		public function BlurFilter(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			blurX = data.@blurX;
			blurY = data.@blurY;
			quality = data.@quality;
		}
		
	}

}