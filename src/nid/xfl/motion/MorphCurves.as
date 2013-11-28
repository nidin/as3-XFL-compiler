package nid.xfl.motion 
{
	import nid.utils.Boolean2;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class MorphCurves 
	{		
		public var controlPointA:String
		public var anchorPointA:String
		public var controlPointB:String
		public var anchorPointB:String
		public var isLine:Boolean
		
		public function MorphCurves(data:XML=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			controlPointA 	= data.@controlPointA;
			anchorPointA 	= data.@anchorPointA;
			controlPointB 	= data.@controlPointB;
			anchorPointB 	= data.@anchorPointB;
			isLine 			= Boolean2.toBoolean(data.@isLine);
		}
		
	}

}