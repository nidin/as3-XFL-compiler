package nid.xfl.data.filters 
{
	import nid.xfl.interfaces.IFilter;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class AdjustColorFilter implements IFilter 
	{
		
		public function AdjustColorFilter(data:XML=null) 
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