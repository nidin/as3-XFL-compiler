package nid.xfl.motion 
{
	import flash.errors.IllegalOperationError;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class EasingEquations 
	{		
		/**
		 * There's no constructor.
		 */
		
		public function EasingEquations()
		{
			trace ("EasingEquations is a static class and should not be instantiated.")
			throw new IllegalOperationError("EasingEquations is a static class and should not be instantiated.")
		}
		/**
		 * Easing equation function for a simple linear tweening, with no easing.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param a		+/- acceleration.
		 * @return		The easing value.
		 */
		public static function ease(t:Number,b:Number,c:Number,d:Number,a:Number):Number
		{
			var value:Number;
			
			if (a > 0)
			{
				value =  easeInQuad(t, b, c, d);
			}
			else if (a < 0)
			{
				value =  easeOutQuad(t, b, c, d);
			}
			else
			{
				value =  easeNone(t, b, c, d);
			}
			
			return value;
		}
		public static function easeMatrix(mat:Matrix,t:Number,bsx:Number,bsy:Number,br:Number,csx:Number,csy:Number,cr:Number,d:Number,a:Number):Matrix
		{
			var sx:Number;
			var sy:Number;
			var r:Number;
			
			if (a > 0)
			{
				sx =  easeInQuad(t, bsx, csx, d);
				sy =  easeInQuad(t, bsy, csy, d);
				r =  easeInQuad(t, br, cr, d);
			}
			else if (a < 0)
			{
				sx =  easeOutQuad(t, bsx, csx, d);
				sy =  easeOutQuad(t, bsy, csy, d);
				r =  easeOutQuad(t, br, cr, d);
			}
			else
			{
				sx =  easeNone(t, bsx, csx, d);
				sy =  easeNone(t, bsy, csy, d);
				r =  easeNone(t, br, cr, d);
			}
			
			mat.scale(sx, sy);
			mat.rotate(r);
			
			return mat;
		}
	// TWEENING EQUATIONS functions -----------------------------------------------------------------------------------------------------
		/**
		 * Easing equation function for a simple linear tweening, with no easing.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function easeNone (t:Number, b:Number, c:Number, d:Number, p_params:Object = null):Number {
			return c*t/d + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing in: accelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function easeInQuad (t:Number, b:Number, c:Number, d:Number, p_params:Object = null):Number {
			return c*(t/=d)*t + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing out: decelerating to zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function easeOutQuad (t:Number, b:Number, c:Number, d:Number, p_params:Object = null):Number {
			return -c *(t/=d)*(t-2) + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing in/out: acceleration until halfway, then deceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function easeInOutQuad (t:Number, b:Number, c:Number, d:Number, p_params:Object = null):Number {
			if ((t/=d/2) < 1) return c/2*t*t + b;
			return -c/2 * ((--t)*(t-2) - 1) + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing out/in: deceleration until halfway, then acceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function easeOutInQuad (t:Number, b:Number, c:Number, d:Number, p_params:Object = null):Number {
			if (t < d/2) return easeOutQuad (t*2, b, c/2, d, p_params);
			return easeInQuad((t*2)-d, b+c/2, c/2, d, p_params);
		}
	}

}