package nid.xfl.data.filters 
{
	import nid.xfl.interfaces.IXFilter;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFilterGradientBevel implements IXFilter 
	{
		
		public function get type():String { return 'GradientBevelFilter'; }
		
		public function XFilterGradientBevel(data:XML=null) 
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