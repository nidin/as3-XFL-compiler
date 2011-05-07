package nid.xfl.motion 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Tweens 
	{
		public var CustomEase:Vector.<Point>;
		public var target:String;
		
		public function Tweens(data:XMLList=null) 
		{
			CustomEase = new Vector.<Point>();
			
			if (data != null)
			{
				parse(data)
			}
		}
		
		public function parse(data:XMLList):void 
		{
			target = data.CustomEase.@target;
			
			for (var i:int = 0; i < data.CustomEase.Point.length(); i++)
			{
				CustomEase.push(new Point(data.CustomEase.Point[i].@x, data.CustomEase.Point[i].@y));
			}
		}
		
	}

}