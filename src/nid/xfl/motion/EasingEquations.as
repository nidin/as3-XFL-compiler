package nid.xfl.motion 
{
	import fl.motion.MatrixTransformer;
	import flash.errors.IllegalOperationError;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import nid.geom.DMatrix;
	import nid.utils.MatrixConvertor;
	import nid.xfl.data.filters.XFilterBlur;
	import nid.xfl.data.filters.XFilterDropShadow;
	import nid.xfl.data.filters.FilterList;
	import nid.xfl.data.filters.XFilterGlow;
	import nid.xfl.interfaces.IXFilter;
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
		public static function easeMatrix(mat:Matrix, bmat:DMatrix, cmat:DMatrix, tp:Point, bcp:Point, ccp:Point, t:Number, d:Number, a:Number):Matrix
		{
			var tx:Number;
			var ty:Number;
			var sx:Number;
			var sy:Number;
			var r:Number;
			var cp:Point = new Point();
			
			/**
			 * TODO: Exponentional easing with acceleration value
			 */
			var easeFn:Function;
			
			if (a > 0)
			{
				easeFn = easeInQuad;
			}
			else if (a < 0)
			{
				easeFn =  easeOutQuad;
			}
			else
			{
				easeFn =  easeNone;
			}
			
			tx =  easeFn(t, bmat.tx, cmat.tx, d);
			ty =  easeFn(t, bmat.ty, cmat.ty, d);
			sx =  easeFn(t, bmat.scaleX, cmat.scaleX, d);
			sy =  easeFn(t, bmat.scaleY, cmat.scaleY, d);
			r  =  easeFn(t, bmat.rotation, cmat.rotation, d);
			cp.x =  easeFn(t, bcp.x, ccp.x, d);
			cp.y =  easeFn(t, bcp.y, ccp.y, d);
			
			mat.scale(sx, sy);
			
			if (r > 0)
			{
				tp = mat.transformPoint(tp);
				mat.tx = mat.tx - tp.x;
				mat.ty = mat.ty - tp.y;
				mat.rotate(r);
				mat.tx = mat.tx + tp.x;
				mat.ty = mat.ty + tp.y;
				mat.tx =  mat.tx + cp.x - tp.x;
				mat.ty =  mat.ty + cp.y - tp.y;
			}
			else
			{
				mat.tx =  tx;
				mat.ty =  ty;
			}
			
			return mat;
		}
		public static function easeFilters(t:Number, bftrs:Vector.<IXFilter>, iftrs:Vector.<IXFilter>, d:Number, a:Number):Vector.<IXFilter>
		{
			var easeFn:Function;
			
			if (a > 0)
			{
				easeFn =  easeInQuad;
			}
			else if (a < 0)
			{
				easeFn =  easeOutQuad;
			}
			else
			{
				easeFn =  easeNone;
			}
			
			var filters:Vector.<IXFilter> = new Vector.<IXFilter>();
			
			var bblurX:Number;
			var bblurY:Number;
			var bColor:uint;
			var bQuality:Number;
			var bAngle:Number;
			var bDistance:Number;
			var bStrength:Number;
			
			var cblurX:Number;
			var cblurY:Number;
			var cColor:uint;
			var cQuality:Number;
			var cAngle:Number;
			var cDistance:Number;
			var cStrength:Number;
			
			for (var i:int = 0; i <  bftrs.length; i++)
			{
				switch(bftrs[i].type)
				{
					
					case FilterList.BLUR_FILTER:
					{
						var blurfltr:XFilterBlur = new XFilterBlur();
						
						bblurX 		= XFilterBlur(bftrs[i]).blurX;
						bblurY		= XFilterBlur(bftrs[i]).blurY;
						bQuality	= XFilterBlur(bftrs[i]).quality;
						
						cblurX		= XFilterBlur(iftrs[i]).blurX - XFilterBlur(bftrs[i]).blurX;
						cblurY		= XFilterBlur(iftrs[i]).blurY - XFilterBlur(bftrs[i]).blurY;
						cQuality	= XFilterBlur(iftrs[i]).quality - XFilterBlur(bftrs[i]).quality;
						
						blurfltr.blurX 		= easeFn(t, bblurX, cblurX, d);
						blurfltr.blurY 		= easeFn(t, bblurY, cblurY, d);
						blurfltr.quality 	= easeFn(t, bQuality, cQuality, d);
						
						filters.push(blurfltr);
					}
					break;
					
					case FilterList.DROP_SHADOW_FILTER:
					{
						var dropshadowfltr:XFilterDropShadow = new XFilterDropShadow();
						
						bblurX 		= XFilterDropShadow(bftrs[i]).blurX;
						bblurY		= XFilterDropShadow(bftrs[i]).blurY;
						bColor		= XFilterDropShadow(bftrs[i]).color;
						bQuality	= XFilterDropShadow(bftrs[i]).quality;
						bAngle		= XFilterDropShadow(bftrs[i]).angle;
						bDistance	= XFilterDropShadow(bftrs[i]).distance;
						bStrength	= XFilterDropShadow(bftrs[i]).strength;
						
						cblurX		= XFilterDropShadow(iftrs[i]).blurX - XFilterDropShadow(bftrs[i]).blurX;
						cblurY		= XFilterDropShadow(iftrs[i]).blurY - XFilterDropShadow(bftrs[i]).blurY;
						cColor		= XFilterDropShadow(iftrs[i]).blurY - XFilterDropShadow(bftrs[i]).color;
						cQuality	= XFilterDropShadow(iftrs[i]).quality - XFilterDropShadow(bftrs[i]).quality;
						cAngle		= XFilterDropShadow(iftrs[i]).angle - XFilterDropShadow(bftrs[i]).angle;
						cDistance	= XFilterDropShadow(iftrs[i]).distance - XFilterDropShadow(bftrs[i]).distance;
						cStrength	= XFilterDropShadow(iftrs[i]).strength - XFilterDropShadow(bftrs[i]).strength;
						
						dropshadowfltr.blurX 	= easeFn(t, bblurX, cblurX, d);
						dropshadowfltr.blurY 	= easeFn(t, bblurY, cblurY, d);
						dropshadowfltr.quality 	= easeFn(t, bQuality, cQuality, d);
						dropshadowfltr.angle 	= easeFn(t, bAngle, cAngle, d);
						dropshadowfltr.distance = easeFn(t, bDistance, cDistance, d);
						dropshadowfltr.strength = easeFn(t, bStrength, cStrength, d);
						
						/**
						 * TODO: Color transition
						 */
						dropshadowfltr.color = bColor;
						
						dropshadowfltr.inner 		= XFilterDropShadow(bftrs[i]).inner;
						dropshadowfltr.knockout 	= XFilterDropShadow(bftrs[i]).knockout;
						dropshadowfltr.hideObject 	= XFilterDropShadow(bftrs[i]).hideObject;
						
						filters.push(dropshadowfltr);
					}
					break;
					
					case FilterList.GLOW_FILTER:
					{
						var glowfltr:XFilterGlow = new XFilterGlow();
						
						bblurX 		= XFilterGlow(bftrs[i]).blurX;
						bblurY		= XFilterGlow(bftrs[i]).blurY;
						bColor		= XFilterGlow(bftrs[i]).color;
						bQuality	= XFilterGlow(bftrs[i]).quality;
						bStrength	= XFilterGlow(bftrs[i]).strength;
						
						cblurX		= XFilterGlow(iftrs[i]).blurX - XFilterGlow(bftrs[i]).blurX;
						cblurY		= XFilterGlow(iftrs[i]).blurY - XFilterGlow(bftrs[i]).blurY;
						cColor		= XFilterGlow(iftrs[i]).blurY - XFilterGlow(bftrs[i]).color;
						cQuality	= XFilterGlow(iftrs[i]).quality - XFilterGlow(bftrs[i]).quality;
						cStrength	= XFilterGlow(iftrs[i]).strength - XFilterGlow(bftrs[i]).strength;
						
						glowfltr.blurX 		= easeFn(t, bblurX, cblurX, d);
						glowfltr.blurY 		= easeFn(t, bblurY, cblurY, d);
						glowfltr.quality 	= easeFn(t, bQuality, cQuality, d);
						glowfltr.strength 	= easeFn(t, bStrength, cStrength, d);
						
						/**
						 * TODO: Color transition
						 */
						glowfltr.color = bColor;
						
						glowfltr.inner 		= XFilterGlow(bftrs[i]).inner;
						glowfltr.knockout 	= XFilterGlow(bftrs[i]).knockout;
						
						filters.push(glowfltr);
					}
					break;
					
					case FilterList.ADJUST_COLOR_FILTER:
					{
						/**
						 * TODO
						 */
					}
					break;
					
					case FilterList.BEVEL_FILTER:
					{
						/**
						 * TODO
						 */
					}
					break;
					
					case FilterList.GRADIENT_BEVEL_FILTER:
					{
						/**
						 * TODO
						 */
					}
					break;
					
					case FilterList.GRADIENT_GLOW_FILTER:
					{
						/**
						 * TODO
						 */
					}
					break;
				}
			}
			
			return filters;
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