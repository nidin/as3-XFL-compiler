package nid.xfl.data.filters 
{
	import nid.utils.Boolean2;
	import nid.xfl.interfaces.IXFilter;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFilterDropShadow implements IXFilter
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
		
		public function get type():String { return 'DropShadowFilter'; }
		
		public function XFilterDropShadow(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			angle 		= String(data.@angle) == ''?45:data.@angle;
			blurX 		= String(data.@blurX) == ''?5:data.@blurX;
			blurY 		= String(data.@blurY) == ''?5:data.@blurY;
			color 		= String(data.@color) == ''?0x000000:uint(data.@color.replace("#", "0x"));
			distance 	= String(data.@distance) == ''?5:data.@distance;
			hideObject 	= Boolean2.toBoolean(data.@hideObject);
			inner 		= Boolean2.toBoolean(data.@inner);
			knockout 	= Boolean2.toBoolean(data.@knockout);
			quality 	= String(data.@quality) == ''?1:data.@quality;
			strength 	= String(data.@strength) ==''?100:data.@strength;
		}
		
	}

}