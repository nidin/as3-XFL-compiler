package nid.xfl.compiler.swf.data.actions.swf6
{
	import nid.xfl.compiler.swf.data.actions.*;
	
	public class ActionEnumerate2 extends Action implements IAction
	{
		public static const CODE:uint = 0x55;
		
		public function ActionEnumerate2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionEnumerate2]";
		}
	}
}
