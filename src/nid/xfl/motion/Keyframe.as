package nid.xfl.motion 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Keyframe 
	{
		public var anchor:Point;
		public var next:Point;
		public var previous:Point;
		public var roving:Number;
		public var timevalue:Number;
		
		public function Keyframe(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			var tmp:Array= data.@anchor.split(",");
			
			anchor 	= new Point(tmp[0], tmp[1]);
			
			tmp = null;
			tmp = data.@next.split(",");
			
			next = new Point(tmp[0], tmp[1]);
			
			tmp = null;
			tmp = data.@previous.split(",");
			
			previous 	= new Point(tmp[0], tmp[1]);
			
			roving 		= data.@roving;
			timevalue 	= data.@timevalue;
		}
		
	}

}