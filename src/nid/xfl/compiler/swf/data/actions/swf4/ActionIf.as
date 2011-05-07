package nid.xfl.compiler.swf.data.actions.swf4
{
	import nid.xfl.compiler.swf.data.actions.*;
	import nid.xfl.compiler.swf.SWFData;
	
	public class ActionIf extends Action implements IAction
	{
		public static const CODE:uint = 0x9d;
		
		public var branchOffset:int;
		
		public function ActionIf(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			branchOffset = data.readSI16();
		}
		
		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			body.writeSI16(branchOffset);
			write(data, body);
		}
		
		override public function clone():IAction {
			var action:ActionIf = new ActionIf(code, length);
			action.branchOffset = branchOffset;
			return action;
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionIf] BranchOffset: " + branchOffset;
		}
	}
}
