package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class MorphSegment 
	{
		
		public var startPointA:String;
		public var startPointB:String;
		public var strokeIndex1:int;
		public var strokeIndex2:int;
		public var fillIndex1:int;
		public var fillIndex2:int;
		
		public var morphCurves:Vector.<MorphCurves>;
		
		public function MorphSegment(data:XML=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			startPointA 	= data.@startPointA;
			startPointB 	= data.@startPointB;
			strokeIndex1 	= data.@strokeIndex1;
			strokeIndex2 	= data.@strokeIndex2;
			fillIndex1 		= data.@fillIndex1;
			fillIndex2 		= data.@fillIndex2;
			
			morphCurves = new Vector.<MorphCurves>();
			
			for (var i:int = 0; i < data.MorphCurves.length(); i++)
			{
				morphCurves.push(new MorphCurves(data.MorphCurves[i]));
			}
		}
		
	}

}