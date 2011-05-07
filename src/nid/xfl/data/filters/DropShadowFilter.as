package nid.xfl.data.filters 
{
	import nid.utils.Boolean2;
	import nid.xfl.interfaces.IFilter;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DropShadowFilter implements IFilter
	{
		public var angle:Number;
		public var blurX:Number;
		public var blurY:Number;
		public var color:uint;
		public var distance:Number;
		public var hideObject:Boolean;
		public var inner:Boolean;
		public var knockout:Boolean;
		public var quality:int;
		public var strength:Number;
		
		public function DropShadowFilter(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			angle = data.@angle;
			blurX = data.@blurX;
			blurY = data.@blurY;
			color = uint(data.@color.replace("#", "0x"));
			distance = data.@distance;
			hideObject = Boolean2.toBoolean(data.@hideObject);
			inner = Boolean2.toBoolean(data.@inner);
			knockout = Boolean2.toBoolean(data.@knockout);
			quality = data.@quality;
			strength = data.@strength;
		}
		
	}

}