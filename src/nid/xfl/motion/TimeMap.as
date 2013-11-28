package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class TimeMap 
	{
		public var strength:Number;
		public var type:String;
		
		public function TimeMap(data:XMLList=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XMLList):void
		{
			strength = data.@strength;
			type = data.@type;
		}
		
	}

}