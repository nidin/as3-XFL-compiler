package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class AnimationCore 
	{
		public var timeMap:TimeMap;
		public var metadata:Metadata;
		public var propertyContainer:PropertyContainer;
		
		public var TimeScale:int;
		public var Version:int;
		public var duration:int;
		
		public function AnimationCore(data:XMLList=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XMLList):void
		{
			timeMap = new TimeMap(data.TimeMap);
			metadata = new Metadata(data.metadata);
			propertyContainer = new PropertyContainer(data.PropertyContainer);
		}
		
	}

}