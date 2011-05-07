package nid.xfl.compiler.swf.data.actions.swf3
{
	import nid.xfl.compiler.swf.data.actions.*;
	
	public class ActionPreviousFrame extends Action implements IAction
	{
		public static const CODE:uint = 0x05;
		
		public function ActionPreviousFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionPreviousFrame]";
		}
	}
}
