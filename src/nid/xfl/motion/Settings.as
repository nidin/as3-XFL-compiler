package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class Settings 
	{
		public var orientToPath:Number;
		public var xformPtXOffsetPct:Number;
		public var xformPtYOffsetPct:Number;
		public var xformPtZOffsetPixels:Number;
		
		public function Settings(data:XMLList=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XMLList):void
		{
			orientToPath = data.@orientToPath;
			xformPtXOffsetPct = data.@xformPtXOffsetPct;
			xformPtYOffsetPct = data.@xformPtYOffsetPct;
			xformPtZOffsetPixels = data.@xformPtZOffsetPixels;
		}
		
	}

}