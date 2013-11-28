package nid.xfl.compiler.mediator 
{
	import nid.xfl.data.script.Actionscript;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class ScriptPool 
	{
		public var frameIndex:int;
		public var script:Array;
		
		public function ScriptPool(fi:int=0) 
		{
			frameIndex = fi;
			script = new Array();
		}
		public function push(value:Actionscript):int
		{
			return script.push(value);
		}
		public function toString():String
		{
			trace(script);
			return '';
		}
		
	}

}