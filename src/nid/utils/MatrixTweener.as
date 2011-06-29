package nid.utils 
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class MatrixTweener extends Object
	{
		
		public function MatrixTweener()
		{
			
		}
		
        public static function getScaleX(mat:Matrix):Number
        {
            return Math.sqrt(mat.a * mat.a + mat.b * mat.b);
        }

        public static function setScaleX(mat:Matrix, arg2:Number):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc1:*= getScaleX(mat);
			
            if (loc1) 
            {
                loc2 = arg2 / loc1;
                mat.a = mat.a * loc2;
                mat.b = mat.b * loc2;
            }
            else 
            {
                loc3 = getSkewYRadians(mat);
                mat.a = Math.cos(loc3) * arg2;
                mat.b = Math.sin(loc3) * arg2;
            }
            return;
        }

        public static function getScaleY(mat:Matrix):Number
        {
            return Math.sqrt(mat.c * mat.c + mat.d * mat.d);
        }

        public static function setScaleY(mat:Matrix, arg2:Number):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc1:*=getScaleY(mat);
            if (loc1) 
            {
                loc2 = arg2 / loc1;
                mat.c = mat.c * loc2;
                mat.d = mat.d * loc2;
            }
            else 
            {
                loc3 = getSkewXRadians(mat);
                mat.c = (-Math.sin(loc3)) * arg2;
                mat.d = Math.cos(loc3) * arg2;
            }
            return;
        }

        public static function getSkewXRadians(mat:Matrix):Number
        {
            return Math.atan2(-mat.c, mat.d);
        }

        public static function setSkewXRadians(mat:Matrix, arg2:Number):void
        {
            var loc1:*=getScaleY(mat);
            mat.c = (-loc1) * Math.sin(arg2);
            mat.d = loc1 * Math.cos(arg2);
            return;
        }

        public static function getSkewYRadians(mat:Matrix):Number
        {
            return Math.atan2(mat.b, mat.a);
        }

        public static function setSkewYRadians(mat:Matrix, arg2:Number):void
        {
            var loc1:*=getScaleX(mat);
            mat.a = loc1 * Math.cos(arg2);
            mat.b = loc1 * Math.sin(arg2);
            return;
        }

        public static function getSkewX(mat:Matrix):Number
        {
            return Math.atan2(-mat.c, mat.d) * 180 / Math.PI;
        }

        public static function setSkewX(mat:Matrix, arg2:Number):void
        {
            setSkewXRadians(mat, arg2 * Math.PI / 180);
            return;
        }

        public static function getSkewY(mat:Matrix):Number
        {
            return Math.atan2(mat.b, mat.a) * 180 / Math.PI;
        }

        public static function setSkewY(mat:Matrix, arg2:Number):void
        {
            setSkewYRadians(mat, arg2 * Math.PI / 180);
            return;
        }

        public static function getRotationRadians(mat:Matrix):Number
        {
            return getSkewYRadians(mat);
        }

        public static function setRotationRadians(mat:Matrix, arg2:Number):void
        {
            var loc1:*=getRotationRadians(mat);
            var loc2:*=getSkewXRadians(mat);
            setSkewXRadians(mat, loc2 + arg2 - loc1);
            setSkewYRadians(mat, arg2);
            return;
        }

        public static function getRotation(mat:Matrix):Number
        {
            return getRotationRadians(mat) * 180 / Math.PI;
        }

        public static function setRotation(mat:Matrix, arg2:Number):void
        {
            setRotationRadians(mat, arg2 * Math.PI / 180);
            return;
        }

        public static function rotateAroundInternalPoint(mat:Matrix, x:Number, y:Number, deg:Number):void
        {
            var tp:Point = new Point(x, y);
            tp = mat.transformPoint(tp);
            mat.tx = mat.tx - tp.x;
            mat.ty = mat.ty - tp.y;
            mat.rotate(deg * Math.PI / 180);
            mat.tx = mat.tx + tp.x;
            mat.ty = mat.ty + tp.y;
            return;
        }

        public static function rotateAroundExternalPoint(mat:Matrix, x:Number, y:Number, deg:Number):void
        {
            mat.tx = mat.tx - x;
            mat.ty = mat.ty - y;
            mat.rotate(deg * Math.PI / 180);
            mat.tx = mat.tx + x;
            mat.ty = mat.ty + y;
            return;
        }

        public static function matchInternalPointWithExternal(mat:Matrix, p1:Point, arg3:Point):void
        {
            var tp:*=mat.transformPoint(p1);
            var loc2:*=arg3.x - tp.x;
            var loc3:*=arg3.y - tp.y;
            mat.tx = mat.tx + loc2;
            mat.ty = mat.ty + loc3;
            return;
        }
    }
}


