package nid.xfl.engine 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import nid.xfl.core.XFLObject;
	import nid.xfl.engine.core.Builder;
	import nid.xfl.XFLDocument;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class XFLEngine extends Builder
	{
		public var xfl:XFLDocument;
		public var xflobj:XFLObject;
		
		public function XFLEngine() 
		{
			/**
			 * Usage Sample
			 */
			xfl = new XFLDocument();
			xfl.addEventListener(Event.COMPLETE, ctor);
			xfl.addEventListener(IOErrorEvent.IO_ERROR,forwardEvent);
			xfl.load("as3 test/abc-1/abc-1.xfl");
		}
		private function ctor(e:Event):void 
		{
			xflobj = new XFLObject();
			xflobj.make(xfl);
			build(xflobj);
		}
		/**
		 * Event forwarder
		 */
		private function forwardEvent(e:*):void
		{
			dispatchEvent(e);
		}
	}

}