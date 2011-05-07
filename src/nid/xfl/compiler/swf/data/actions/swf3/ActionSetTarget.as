package nid.xfl.compiler.swf.data.actions.swf3
{
	import nid.xfl.compiler.swf.SWFData;
	import nid.xfl.compiler.swf.data.actions.*;
	
	public class ActionSetTarget extends Action implements IAction
	{
		public static const CODE:uint = 0x8b;
		
		public var targetName:String;
		
		public function ActionSetTarget(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			targetName = data.readString();
		}
		
		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			body.writeString(targetName);
			write(data, body);
		}
		
		override public function clone():IAction {
			var action:ActionSetTarget = new ActionSetTarget(code, length);
			action.targetName = targetName;
			return action;
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionSetTarget] TargetName: " + targetName;
		}
	}
}
