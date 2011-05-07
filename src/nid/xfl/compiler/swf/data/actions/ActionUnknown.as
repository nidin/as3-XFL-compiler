package nid.xfl.compiler.swf.data.actions
{
	import nid.xfl.compiler.swf.SWFData;
	
	public class ActionUnknown extends Action implements IAction
	{
		public function ActionUnknown(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			if (_length > 0) {
				data.skipBytes(_length);
			}
		}
		
		override public function toString(indent:uint = 0):String {
			return "[????] Code: " + _code.toString(16) + ", Length: " + _length;
		}
	}
}
