package nid.xfl.compiler.swf.data.actions.swf3
{
	import nid.xfl.compiler.swf.data.actions.*;
	import nid.xfl.compiler.swf.SWFData;
	
	public class ActionPlay extends Action implements IAction
	{
		public static const CODE:uint = 0x06;
		
		public function ActionPlay(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionPlay]";
		}
	}
}
