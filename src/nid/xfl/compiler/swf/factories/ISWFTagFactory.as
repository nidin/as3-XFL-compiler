package nid.xfl.compiler.swf.factories
{
	import nid.xfl.compiler.swf.tags.ITag;

	public interface ISWFTagFactory
	{
		function create(type:uint):ITag;
	}
}