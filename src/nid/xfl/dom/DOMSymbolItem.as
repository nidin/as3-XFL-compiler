package nid.xfl.dom 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import nid.xfl.utils.NSRemover;
	import nid.xfl.utils.XMLFormater;
	import nid.xfl.XFLDocument;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMSymbolItem extends DOMTimeline
	{
		
		public var itemID:String;
		public var sourceLibraryItemHRef:String;
		public var lastModified:String;
		
		public function DOMSymbolItem(itemName:String,refdoc:DOMDocument) 
		{
			doc = refdoc;
			
			if (itemName != "")
			{
				load(itemName + ".xml");
			}
		}
		
		public function load(url:String):void 
		{
			if (doc.TYPE == "ZIP")
			{
				InitParse(null, doc.zipDoc.files[doc.NAME + '_' + url]);
			}
			else
			{
				var loader:URLLoader = new URLLoader();
					loader.addEventListener(Event.COMPLETE, InitParse);
					loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
					loader.dataFormat = URLLoaderDataFormat.TEXT;
					loader.load(new URLRequest(doc.LIBRARY_PATH + url));
					//trace('symbol url:' + url);
			}
		}
		
		private function InitParse(e:Event=null,zipdata:String=""):void 
		{
			//trace('symbol loaded');
			var data:XML = XMLFormater.format(String(e == null?zipdata:e.target.data));
			
			itemID 					= data.@itemID;
			sourceLibraryItemHRef 	= data.@sourceLibraryItemHRef;
			lastModified 			= data.@lastModified;
			
			parse(data.timeline.DOMTimeline);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace('Symbol Load Error');
		}
		
	}

}