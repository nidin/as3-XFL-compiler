package nid.geom 
{
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class DMatrix extends Matrix
	{
		public var rotation:Number=0;
		public var rotationInDegree:Number=0;
		public var scaleX:Number=1;
		public var scaleY:Number=1;
		
		public function DMatrix(a:Number=1, b:Number=0, c:Number=0, d:Number=1, tx:Number=0, ty:Number=0)
		{
			super(a, b, c, d, tx, ty);
		}
		
	}

}