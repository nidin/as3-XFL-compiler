package nid.xfl.utils 
{
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import nid.xfl.compiler.swf.data.SWFColorTransformWithAlpha;
	import nid.xfl.compiler.swf.data.SWFMatrix;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class Convertor 
	{
		
		public function Convertor() 
		{
			
		}
		static public function toSWFMatrix(mat:Matrix):SWFMatrix
		{
			var m2:SWFMatrix = new SWFMatrix();
				m2.matrix = mat;
			return m2;
		}		
		static public function toBitmapMatrix(mat:Matrix,offset:int=20):Matrix
		{
			mat.a 	= 1
			mat.b 	*= offset;
			mat.c 	*= offset;
			mat.d	= 1;
			mat.tx 	*= offset;
			mat.ty 	*= offset;
			
			return mat;
		}
		static public function toSWFColorTransform(cxform:ColorTransform):SWFColorTransformWithAlpha
		{
			var colorTransform:SWFColorTransformWithAlpha = new SWFColorTransformWithAlpha();
			colorTransform.hasMultTerms = true;
			colorTransform.rMult = cxform.redMultiplier * 256;
			colorTransform.gMult = cxform.redMultiplier * 256;
			colorTransform.bMult = cxform.blueMultiplier * 256;
			colorTransform.aMult = cxform.alphaMultiplier * 256;
			colorTransform.rAdd = cxform.redOffset * 256;
			colorTransform.gAdd = cxform.greenOffset * 256;
			colorTransform.bAdd = cxform.blueOffset * 256;
			colorTransform.aAdd = cxform.alphaOffset * 256;
			return colorTransform;
		}
	}

}