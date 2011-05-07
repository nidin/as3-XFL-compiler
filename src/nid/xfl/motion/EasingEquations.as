package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class EasingEquations 
	{
		
		static private const k:Number = 1.265;
		
		/**
		 * There's no constructor.
		 */
		
		public function EasingEquations()
		{
			trace ("EasingEquations is a static class and should not be instantiated.")
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
	}

}