package nid.xfl.compiler.swf.data.actions.swf4
{
	import nid.xfl.compiler.swf.data.actions.*;
	
	public class ActionSetTarget2 extends Action implements IAction
	{
		public static const CODE:uint = 0x20;
		
		public function ActionSetTarget2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionSetTarget2]";
		}
	}
}
