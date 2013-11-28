package nid.utils 
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import nid.geom.DMatrix;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class MatrixConvertor 
	{
		public static const degree:Number = 180 / Math.PI;
		public static const radian:Number = Math.PI / 180;
		
		public function MatrixConvertor()
		{
			
		}
		public static function convert(mat:Matrix):DMatrix 
		{
			var dmat:DMatrix = new DMatrix(mat.a, mat.b, mat.c, mat.d, mat.tx, mat.ty);
			var rad:Number;
			var deg:Number;
			var sign:Number;
			/**
			 * scaleX = √(a^2+c^2)
			 * scaleY = √(b^2+d^2)
			 * rotation = tan^-1(c/d) = tan^-1(-b/a) it will not work sometimes 
			 * rotation = a / scaleX  = d / scaleY
			 */
			with (dmat)
			{
				scaleX = Math.sqrt((a * a) + (c * c));
				scaleY = Math.sqrt((b * b) + (d * d));
				
				sign = Math.atan(-c / a);
				rad  = Math.acos(a / scaleX);
				deg  = rad * degree;
				
				if (deg > 90 && sign > 0)
				{
					rotation = (360 - deg) * radian;
				}
				else if (deg < 90 && sign < 0)
				{
					rotation = (360 - deg) * radian;
				}
				else
				{
					rotation = rad;
				}
				rotationInDegree = rotation * degree;
			}
			return dmat;
		}
	}

}