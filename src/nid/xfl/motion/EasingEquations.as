package nid.xfl.motion 
{
	import fl.motion.MatrixTransformer;
	import flash.errors.IllegalOperationError;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import nid.geom.DMatrix;
	import nid.utils.MatrixConvertor;
	import nid.xfl.data.filters.BlurFilter;
	import nid.xfl.data.filters.DropShadowFilter;
	import nid.xfl.data.filters.FilterList;
	import nid.xfl.data.filters.GlowFilter;
	import nid.xfl.interfaces.IFilter;
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
		public static function easeFilters(t:Number, bftrs:Vector.<IFilter>, iftrs:Vector.<IFilter>, d:Number, a:Number):Vector.<IFilter>
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
			
			var filters:Vector.<IFilter> = new Vector.<IFilter>();
			
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
						var blurfltr:BlurFilter = new BlurFilter();
						
						bblurX 		= BlurFilter(bftrs[i]).blurX;
						bblurY		= BlurFilter(bftrs[i]).blurY;
						bQuality	= BlurFilter(bftrs[i]).quality;
						
						cblurX		= BlurFilter(iftrs[i]).blurX - BlurFilter(bftrs[i]).blurX;
						cblurY		= BlurFilter(iftrs[i]).blurY - BlurFilter(bftrs[i]).blurY;
						cQuality	= BlurFilter(iftrs[i]).quality - BlurFilter(bftrs[i]).quality;
						
						blurfltr.blurX 		= easeFn(t, bblurX, cblurX, d);
						blurfltr.blurY 		= easeFn(t, bblurY, cblurY, d);
						blurfltr.quality 	= easeFn(t, bQuality, cQuality, d);
						
						filters.push(blurfltr);
					}
					break;
					
					case FilterList.DROP_SHADOW_FILTER:
					{
						var dropshadowfltr:DropShadowFilter = new DropShadowFilter();
						
						bblurX 		= DropShadowFilter(bftrs[i]).blurX;
						bblurY		= DropShadowFilter(bftrs[i]).blurY;
						bColor		= DropShadowFilter(bftrs[i]).color;
						bQuality	= DropShadowFilter(bftrs[i]).quality;
						bAngle		= DropShadowFilter(bftrs[i]).angle;
						bDistance	= DropShadowFilter(bftrs[i]).distance;
						bStrength	= DropShadowFilter(bftrs[i]).strength;
						
						cblurX		= DropShadowFilter(iftrs[i]).blurX - DropShadowFilter(bftrs[i]).blurX;
						cblurY		= DropShadowFilter(iftrs[i]).blurY - DropShadowFilter(bftrs[i]).blurY;
						cColor		= DropShadowFilter(iftrs[i]).blurY - DropShadowFilter(bftrs[i]).color;
						cQuality	= DropShadowFilter(iftrs[i]).quality - DropShadowFilter(bftrs[i]).quality;
						cAngle		= DropShadowFilter(iftrs[i]).angle - DropShadowFilter(bftrs[i]).angle;
						cDistance	= DropShadowFilter(iftrs[i]).distance - DropShadowFilter(bftrs[i]).distance;
						cStrength	= DropShadowFilter(iftrs[i]).strength - DropShadowFilter(bftrs[i]).strength;
						
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
						
						dropshadowfltr.inner 		= DropShadowFilter(bftrs[i]).inner;
						dropshadowfltr.knockout 	= DropShadowFilter(bftrs[i]).knockout;
						dropshadowfltr.hideObject 	= DropShadowFilter(bftrs[i]).hideObject;
						
						filters.push(dropshadowfltr);
					}
					break;
					
					case FilterList.GLOW_FILTER:
					{
						var glowfltr:GlowFilter = new GlowFilter();
						
						bblurX 		= GlowFilter(bftrs[i]).blurX;
						bblurY		= GlowFilter(bftrs[i]).blurY;
						bColor		= GlowFilter(bftrs[i]).color;
						bQuality	= GlowFilter(bftrs[i]).quality;
						bStrength	= GlowFilter(bftrs[i]).strength;
						
						cblurX		= GlowFilter(iftrs[i]).blurX - GlowFilter(bftrs[i]).blurX;
						cblurY		= GlowFilter(iftrs[i]).blurY - GlowFilter(bftrs[i]).blurY;
						cColor		= GlowFilter(iftrs[i]).blurY - GlowFilter(bftrs[i]).color;
						cQuality	= GlowFilter(iftrs[i]).quality - GlowFilter(bftrs[i]).quality;
						cStrength	= GlowFilter(iftrs[i]).strength - GlowFilter(bftrs[i]).strength;
						
						glowfltr.blurX 		= easeFn(t, bblurX, cblurX, d);
						glowfltr.blurY 		= easeFn(t, bblurY, cblurY, d);
						glowfltr.quality 	= easeFn(t, bQuality, cQuality, d);
						glowfltr.strength 	= easeFn(t, bStrength, cStrength, d);
						
						/**
						 * TODO: Color transition
						 */
						glowfltr.color = bColor;
						
						glowfltr.inner 		= GlowFilter(bftrs[i]).inner;
						glowfltr.knockout 	= GlowFilter(bftrs[i]).knockout;
						
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