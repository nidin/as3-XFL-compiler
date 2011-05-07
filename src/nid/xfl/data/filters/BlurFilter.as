package nid.xfl.data.filters 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class BlurFilter 
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