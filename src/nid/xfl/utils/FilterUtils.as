package nid.xfl.utils 
{
	import nid.xfl.compiler.swf.data.filters.FilterBevel;
	import nid.xfl.compiler.swf.data.filters.FilterBlur;
	import nid.xfl.compiler.swf.data.filters.FilterColorMatrix;
	import nid.xfl.compiler.swf.data.filters.FilterConvolution;
	import nid.xfl.compiler.swf.data.filters.FilterDropShadow;
	import nid.xfl.compiler.swf.data.filters.FilterGlow;
	import nid.xfl.compiler.swf.data.filters.FilterGradientBevel;
	import nid.xfl.compiler.swf.data.filters.FilterGradientGlow;
	import nid.xfl.compiler.swf.data.filters.IFilter;
	import nid.xfl.data.filters.FilterList;
	import nid.xfl.data.filters.XFilterBlur;
	import nid.xfl.data.filters.XFilterDropShadow;
	import nid.xfl.data.filters.XFilterGlow;
	import nid.xfl.interfaces.IXFilter;
	import flash.filters.*;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class FilterUtils 
	{
		
		public function FilterUtils() 
		{
			
		}
		public static function convertToFlash(domfilters:Vector.<IXFilter>):Array
		{
			var filters:Array = [];
			
			for (var i:int = 0; i <  domfilters.length; i++)
			{
				switch(domfilters[i].type)
				{
					
					case FilterList.BLUR_FILTER:
					{
						var bfilter:XFilterBlur = domfilters[i] as XFilterBlur;
						filters.push(new BlurFilter(bfilter.blurX, bfilter.blurY, bfilter.quality));
					}
					break;
					
					case FilterList.DROP_SHADOW_FILTER:
					{
						var dsfilter:XFilterDropShadow = domfilters[i] as XFilterDropShadow;
						filters.push(new DropShadowFilter(dsfilter.distance, dsfilter.angle, dsfilter.color, 1, dsfilter.blurX, dsfilter.blurY, dsfilter.strength, dsfilter.quality, dsfilter.inner, dsfilter.knockout, dsfilter.hideObject));
					}
					break;
					
					case FilterList.GLOW_FILTER:
					{
						var gfilter:XFilterGlow = domfilters[i] as XFilterGlow;
						filters.push(new GlowFilter(gfilter.color, 1, gfilter.blurX, gfilter.blurY, gfilter.strength, gfilter.quality, gfilter.inner, gfilter.knockout));
					}
					break;
					
					/**
					 * TODO
					 */
					case FilterList.ADJUST_COLOR_FILTER:
					{
						
					}
					break;
					
					case FilterList.BEVEL_FILTER:
					{
						
					}
					break;
					
					case FilterList.GRADIENT_BEVEL_FILTER:
					{
						
					}
					break;
					
					case FilterList.GRADIENT_GLOW_FILTER:
					{
						
					}
					break;
				}
			}
			
			return filters;
		}
		
		public static function convertToSWF(domfilters:Vector.<IXFilter>):Vector.<IFilter>
		{
			var filters:Vector.<IFilter> = new Vector.<IFilter>();
			
			for (var i:int = 0; i <  domfilters.length; i++)
			{
				switch(domfilters[i].type)
				{
					
					case FilterList.BLUR_FILTER:
					{
						var bfilter:FilterBlur = new FilterBlur(1);
						bfilter.blurX 	= XFilterBlur(domfilters[i]).blurX;
						bfilter.blurY 	= XFilterBlur(domfilters[i]).blurY;
						bfilter.passes 	= XFilterBlur(domfilters[i]).quality;
						filters.push(bfilter);
					}
					break;
					
					case FilterList.DROP_SHADOW_FILTER:
					{
						var dsfilter:FilterDropShadow = new FilterDropShadow(0);
						dsfilter.distance 			=  XFilterDropShadow(domfilters[i]).distance;
						dsfilter.angle 				=  XFilterDropShadow(domfilters[i]).angle;
						dsfilter.dropShadowColor 	=  XFilterDropShadow(domfilters[i]).color;
						dsfilter.blurX 				=  XFilterDropShadow(domfilters[i]).blurX;
						dsfilter.blurY 				=  XFilterDropShadow(domfilters[i]).blurY;
						dsfilter.strength 			=  XFilterDropShadow(domfilters[i]).strength;
						dsfilter.passes 			=  XFilterDropShadow(domfilters[i]).quality;
						dsfilter.innerShadow 		=  XFilterDropShadow(domfilters[i]).inner;
						dsfilter.knockout 			=  XFilterDropShadow(domfilters[i]).knockout;
						dsfilter.compositeSource 	=  XFilterDropShadow(domfilters[i]).hideObject;
						filters.push(dsfilter);
					}
					break;
					
					case FilterList.GLOW_FILTER:
					{
						var gfilter:FilterGlow = new FilterGlow(2);
						gfilter.glowColor 	= XFilterGlow(domfilters[i]).color;
						gfilter.blurX 		= XFilterGlow(domfilters[i]).blurX;
						gfilter.blurY 		= XFilterGlow(domfilters[i]).blurY;
						gfilter.strength 	= XFilterGlow(domfilters[i]).strength;
						gfilter.passes 		= XFilterGlow(domfilters[i]).quality;
						gfilter.innerGlow 	= XFilterGlow(domfilters[i]).inner;
						gfilter.knockout 	= XFilterGlow(domfilters[i]).knockout;
						filters.push(gfilter);
					}
					break;
					
					/**
					 * TODO
					 */
					
					case FilterList.BEVEL_FILTER:
					{
						var bvlfilter:FilterBevel = new FilterBevel(3);
					}
					break;
					
					case FilterList.GRADIENT_GLOW_FILTER:
					{
						var ggbfilter:FilterGradientGlow= new FilterGradientGlow(4);
					}
					break;
					
					case FilterList.CONVOLUTION_FILTER:
					{
						var cvfilter:FilterConvolution = new FilterConvolution(4);
					}
					break;
					
					case FilterList.ADJUST_COLOR_FILTER:
					{
						var cmfilter:FilterColorMatrix= new FilterColorMatrix(6);
					}
					break;
					
					
					case FilterList.GRADIENT_BEVEL_FILTER:
					{
						var gbvlfilter:FilterGradientBevel= new FilterGradientBevel(7);
					}
					break;
					
				}
			}
			
			return filters;
		}
		
		public static function cloneXFilter(domfilters:Vector.<IXFilter>):Vector.<IXFilter>
		{
			if (domfilters == null) return null;
			
			var filters:Vector.<IXFilter> = new Vector.<IXFilter>();
			
			for (var i:int = 0; i <  domfilters.length; i++)
			{
				switch(domfilters[i].type)
				{
					
					case FilterList.BLUR_FILTER:
					{
						var bfilter:XFilterBlur = new XFilterBlur();
						bfilter.blurX 	= XFilterBlur(domfilters[i]).blurX;
						bfilter.blurY 	= XFilterBlur(domfilters[i]).blurY;
						bfilter.quality = XFilterBlur(domfilters[i]).quality;
						filters.push(bfilter);
					}
					break;
					
					case FilterList.DROP_SHADOW_FILTER:
					{
						var dsfilter:XFilterDropShadow = new XFilterDropShadow();
						dsfilter.distance 			=  XFilterDropShadow(domfilters[i]).distance;
						dsfilter.angle 				=  XFilterDropShadow(domfilters[i]).angle;
						dsfilter.color			 	=  XFilterDropShadow(domfilters[i]).color;
						dsfilter.blurX 				=  XFilterDropShadow(domfilters[i]).blurX;
						dsfilter.blurY 				=  XFilterDropShadow(domfilters[i]).blurY;
						dsfilter.strength 			=  XFilterDropShadow(domfilters[i]).strength;
						dsfilter.quality 			=  XFilterDropShadow(domfilters[i]).quality;
						dsfilter.inner		 		=  XFilterDropShadow(domfilters[i]).inner;
						dsfilter.knockout 			=  XFilterDropShadow(domfilters[i]).knockout;
						dsfilter.hideObject		 	=  XFilterDropShadow(domfilters[i]).hideObject;
						filters.push(dsfilter);
					}
					break;
					
					case FilterList.GLOW_FILTER:
					{
						var gfilter:XFilterGlow = new XFilterGlow();
						gfilter.color	 	= XFilterGlow(domfilters[i]).color;
						gfilter.blurX 		= XFilterGlow(domfilters[i]).blurX;
						gfilter.blurY 		= XFilterGlow(domfilters[i]).blurY;
						gfilter.strength 	= XFilterGlow(domfilters[i]).strength;
						gfilter.quality		= XFilterGlow(domfilters[i]).quality;
						gfilter.inner	 	= XFilterGlow(domfilters[i]).inner;
						gfilter.knockout 	= XFilterGlow(domfilters[i]).knockout;
						filters.push(gfilter);
					}
					break;
					
					/**
					 * TODO
					 */
					case FilterList.ADJUST_COLOR_FILTER:
					{
						
					}
					break;
					
					case FilterList.BEVEL_FILTER:
					{
						
					}
					break;
					
					case FilterList.GRADIENT_BEVEL_FILTER:
					{
						
					}
					break;
					
					case FilterList.GRADIENT_GLOW_FILTER:
					{
						
					}
					break;
				}
			}
			
			return filters;
		}
		
	}

}