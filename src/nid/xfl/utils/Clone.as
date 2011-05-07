package nid.xfl.utils 
{
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Clone 
	{
		
		public function Clone() 
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
	}

}