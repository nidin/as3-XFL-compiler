package nid.xfl.compiler.swf.data.actions.swf4
{
	import nid.xfl.compiler.swf.data.actions.*;
	
	public class ActionStartDrag extends Action implements IAction
	{
		public static const CODE:uint = 0x27;
		
		public function ActionStartDrag(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionStartDrag]";
		}
	}
}
