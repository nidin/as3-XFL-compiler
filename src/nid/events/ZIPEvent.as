package nid.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nidin.P.Vinayak
	 */
	public class ZIPEvent extends Event 
	{
		public static const DECOMPRESSED:String = "decompressed";
		public static const COMPRESSED:String 	= "compressed";
		public static const COMPRESSION_ERROR:String 	= "compression_error";
		public static const DECOMPRESSION_ERROR:String 	= "decompression_error";
		
		public function ZIPEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZIPEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZIPEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}