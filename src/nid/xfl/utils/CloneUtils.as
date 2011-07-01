package nid.xfl.utils 
{
	import flash.geom.ColorTransform;
	import nid.xfl.interfaces.IXFilter;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class CloneUtils 
	{
		
		public function CloneUtils() 
		{
			
		}
		static public function colorTransform(cxf:ColorTransform):ColorTransform
		{
			var cxform:ColorTransform = new ColorTransform(cxf.redMultiplier,
			cxf.greenMultiplier, 
			cxf.blueMultiplier, 
			cxf.alphaMultiplier,
			cxf.redOffset,
			cxf.greenOffset,
			cxf.blueOffset,
			cxf.alphaOffset);
			
			return cxform;
		}
		static public function clone(src:Array):Array
		{
			var op:Array = [];
			
			for (var i:int = 0; i < src.length; i++)
			{
				op.push(src[i]);
			}
			
			return op;
		}
	}

}