package nid.xfl.interfaces 
{
	import nid.xfl.compiler.swf.data.SWFFillStyle;
	import nid.xfl.compiler.swf.tags.ITag;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public interface IFillStyle 
	{
		function export(type:int, tags:Vector.<ITag> = null, property:Object = null):SWFFillStyle;
		function get color():uint;
		function get alpha():Number;
		function get index():uint;
	}
	
}