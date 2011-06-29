package nid.xfl.data.filters 
{
	import nid.xfl.interfaces.IFilter;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class GradientGlowFilter implements IFilter 
	{
		
		public function get type():String { return 'GradientGlowFilter'; }
		
		public function GradientGlowFilter(data:XML=null) 
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