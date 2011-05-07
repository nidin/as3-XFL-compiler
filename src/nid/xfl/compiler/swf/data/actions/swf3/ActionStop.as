package nid.xfl.compiler.swf.data.actions.swf3
{
	import nid.xfl.compiler.swf.data.actions.*;
	
	public class ActionStop extends Action implements IAction
	{
		public static const CODE:uint = 0x07;
		
		public function ActionStop(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionStop]";
		}
	}
}
