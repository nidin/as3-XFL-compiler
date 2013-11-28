package nid.xfl.data.filters 
{
	import nid.utils.Boolean2;
	import nid.xfl.interfaces.IXFilter;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFilterGlow implements IXFilter 
	{
		public var blurX:Number;
		public var blurY:Number;
		public var color:uint;
		public var inner:Boolean;
		public var knockout:Boolean;
		public var quality:int;
		public var strength:Number;
		
		public function get type():String { return 'GlowFilter'; }
		
		public function XFilterGlow(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			blurX 		= String(data.@blurX) == ''?5:data.@blurX;
			blurY 		= String(data.@blurY) == ''?5:data.@blurY;
			color 		= String(data.@color) == ''?0xFF0000:uint(data.@color.replace("#", "0x"));
			inner 		= Boolean2.toBoolean(data.@inner);
			knockout 	= Boolean2.toBoolean(data.@knockout);
			quality 	= String(data.@quality) == ''?1:data.@quality;
			strength 	= String(data.@strength) ==''?100:data.@strength;
		}
		
	}

}