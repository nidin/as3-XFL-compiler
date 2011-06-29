package nid.xfl.utils 
{
	import nid.xfl.data.filters.FilterList;
	import nid.xfl.interfaces.IFilter;
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
		public static function convert(domfilters:Vector.<IFilter>):Array
		{
			var filters:Array = [];
			
			for (var i:int = 0; i <  domfilters.length; i++)
			{
				switch(domfilters[i].type)
				{
					
					case FilterList.BLUR_FILTER:
					{
						var bfilter:nid.xfl.data.filters.BlurFilter = domfilters[i] as nid.xfl.data.filters.BlurFilter;
						filters.push(new BlurFilter(bfilter.blurX, bfilter.blurY, bfilter.quality));
					}
					break;
					
					case FilterList.DROP_SHADOW_FILTER:
					{
						var dsfilter:nid.xfl.data.filters.DropShadowFilter = domfilters[i] as nid.xfl.data.filters.DropShadowFilter;
						filters.push(new DropShadowFilter(dsfilter.distance, dsfilter.angle, dsfilter.color, 1, dsfilter.blurX, dsfilter.blurY, dsfilter.strength, dsfilter.quality, dsfilter.inner, dsfilter.knockout, dsfilter.hideObject));
					}
					break;
					
					case FilterList.GLOW_FILTER:
					{
						var gfilter:nid.xfl.data.filters.GlowFilter = domfilters[i] as nid.xfl.data.filters.GlowFilter;
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
		
	}

}