package nid.xfl.compiler.swf.tags.etc
{
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagUnknown;
	
	public class TagSWFEncryptSignature extends TagUnknown implements ITag
	{
		public static const TYPE:uint = 255;
		
		public function TagSWFEncryptSignature(type:uint = 0) {}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "SWFEncryptSignature"; }
	}
}
