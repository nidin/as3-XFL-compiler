package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class Name 
	{
		public var langID:String;
		public var value:String;
		
		public function Name(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			langID = data.@langID;
			value = data.@value;
		}
		
	}

}