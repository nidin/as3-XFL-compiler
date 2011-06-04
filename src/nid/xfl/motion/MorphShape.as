package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class MorphShape 
	{
		public var morphSegments:Vector.<MorphSegment>;
		public var morphHintsList:Vector.<MorphSegment>;
		
		public function MorphShape(data:XMLList=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XMLList):void
		{
			morphSegments = new Vector.<MorphSegment>();
			
			for (var i:int = 0; i < data.morphSegments.MorphSegment.length(); i++)
			{
				morphSegments.push(new MorphSegment(data.morphSegments.MorphSegment[i]));
			}
			
			morphHintsList = new Vector.<MorphSegment>();
			
			for (i = 0; i < data.morphHintsList.morphHint.length(); i++)
			{
				morphHintsList.push(new MorphHint(data.morphHintsList.morphHint[i]));
			}
		}
		
	}

}