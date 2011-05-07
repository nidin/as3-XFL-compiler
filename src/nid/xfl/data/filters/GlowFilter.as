package nid.xfl.data.filters 
{
	import nid.utils.Boolean2;
	import nid.xfl.interfaces.IFilter;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class GlowFilter implements IFilter 
	{
		public var blurX:Number;
		public var blurY:Number;
		public var color:uint;
		public var inner:Boolean;
		public var knockout:Boolean;
		public var quality:int;
		public var strength:Number;
		
		public function GlowFilter(data:XML=null) 
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
			color = uint(data.@color.replace("#", "0x"));
			inner = Boolean2.toBoolean(data.@inner);
			knockout = Boolean2.toBoolean(data.@knockout);
			quality = data.@quality;
			strength = data.@strength;
		}
		
	}

}