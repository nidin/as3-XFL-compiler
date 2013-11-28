package nid.xfl.data.filters 
{
	import nid.xfl.interfaces.IXFilter;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFilterAdjustColor implements IXFilter 
	{
		public function get type():String { return 'AdjustColorFilter'; }
		
		public function XFilterAdjustColor(data:XML=null) 
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