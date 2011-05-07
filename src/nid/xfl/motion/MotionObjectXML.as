package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class MotionObjectXML 
	{
		public var animationCore:AnimationCore;
		
		public function MotionObjectXML(data:XMLList=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XMLList):void
		{
			animationCore = new AnimationCore(data.AnimationCore);
		}
		
	}

}