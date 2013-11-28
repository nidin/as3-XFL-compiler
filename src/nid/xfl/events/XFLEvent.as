package nid.xfl.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFLEvent extends Event 
	{
		static public const SWF_EXPORTED:String = "swf_exported";
		static public const MODIFY:String = "modify";
		static public const SAVED:String = "saved";
		static public const READY:String = "ready";
		
		public function XFLEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new XFLEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("XFLEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}