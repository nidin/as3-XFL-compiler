package nid.xfl.compiler.swf.timeline
{
	import nid.xfl.compiler.utils.StringUtils2;

	public class Scene
	{
		public var frameNumber:uint = 0;
		public var name:String;
		
		public function Scene(frameNumber:uint, name:String)
		{
			this.frameNumber = frameNumber;
			this.name = name;
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils2.repeat(indent) + 
				"Name: " + name + ", " +
				"Frame: " + frameNumber;
		}
	}
}