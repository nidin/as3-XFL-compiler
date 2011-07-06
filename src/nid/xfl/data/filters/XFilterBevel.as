package nid.xfl.data.filters 
{
	import nid.xfl.interfaces.IXFilter;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class XFilterBevel implements IXFilter 
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
		public var highlightColor:uint;
		public var shadowColor:uint;
		
		public function get type():String { return 'BevelFilter'; }
		
		public function XFilterBevel(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			/**
			 * TODO
			 */
		}
		
	}

}