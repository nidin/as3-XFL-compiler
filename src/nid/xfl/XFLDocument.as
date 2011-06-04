package nid.xfl 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	import flash.xml.XMLDocument;
	import nid.events.ZIPEvent;
	import nid.xfl.dom.DOMDocument;
	import nid.xfl.settings.MobileSettings;
	import nid.xfl.settings.PublishSettings;
	import nid.xfl.utils.XMLFormater;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class XFLDocument extends DOMDocument
	{
		
		private var loader:URLLoader;
		
		public function XFLDocument(loadReq:Object=null) 
		{
			if (loadReq != null)
			{
				load(loadReq);
			}
		}
		public function load(loadReq:Object=null):void
		{
			NAME = "untitled";
			TYPE = XFLType.URL;
			loader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, forwardIOError);
			
			var requrl:String
			
			if (loadReq is URLRequest)
			{
				loader.addEventListener(Event.COMPLETE, InitParse);
				loader.load(URLRequest(loadReq));
			}
			else if (loadReq is String)
			{
				if(String(loadReq).indexOf("<DOMDocument") != -1)
				{
					xflparse(new XML(new XMLDocument(String(loadReq))));
				}
				else if(String(loadReq).indexOf("DOMDocument.xml") != -1)
				{
					loader.addEventListener(Event.COMPLETE, InitParse);
					loader.load(new URLRequest(String(loadReq)));
				}
				else if(String(loadReq).substr(String(loadReq).length - 4,String(loadReq).length-1) == ".zip")
				{
					requrl = String(loadReq);
					NAME = requrl.substring(requrl.lastIndexOf("/")+1, requrl.lastIndexOf("."));
					
					loader.addEventListener(Event.COMPLETE, onZipFileLoaded);
					loader.addEventListener(ProgressEvent.PROGRESS, forwardProgressEvent);
					loader.dataFormat = URLLoaderDataFormat.BINARY;
					loader.load(new URLRequest(String(loadReq)));
				}
				else
				{
					requrl = String(loadReq);
					NAME = requrl.substring(requrl.lastIndexOf("/")+1, requrl.lastIndexOf("."));
					
					LIBRARY_PATH = String(loadReq).substring(0, String(loadReq).lastIndexOf("/")) + "/LIBRARY/";
					BIN_PATH = String(loadReq).substring(0, String(loadReq).lastIndexOf("/")) + "/bin/";
					var dom_url:String 	   = String(loadReq).substring(0, String(loadReq).lastIndexOf("/")) + "/DOMDocument.xml";
					var publish_url:String = String(loadReq).substring(0, String(loadReq).lastIndexOf("/")) + "/PublishSettings.xml";
					var mobile_url:String  = String(loadReq).substring(0, String(loadReq).lastIndexOf("/")) + "/MobileSettings.xml";
					
					loader.addEventListener(Event.COMPLETE, InitParse);
					loader.addEventListener(IOErrorEvent.IO_ERROR, forwardIOError);
					loader.dataFormat = URLLoaderDataFormat.TEXT;
					loader.load(new URLRequest(dom_url));
					
					/**
					 * TODO: Add Publish Settings and Mobile Settings
					 */
					publishSettings = new PublishSettings(publish_url);
					mobileSettings = new MobileSettings(mobile_url);
				}
			}
			else if (loadReq is XML || loadReq is XMLList)
			{
				xflparse(XML(loadReq));
			}
			else if (loadReq is ByteArray)
			{
				initZipFile(ByteArray(loadReq));
			}
			else
			{
				throw(new Error("Invalid XFL file data"));
			}
		}
		
		private function onZipFileLoaded(e:Event):void
		{
			initZipFile(ByteArray(e.target.data));
		}
		private function initZipFile(ba:ByteArray):void
		{
			trace('filetype: zip');
			TYPE = XFLType.ZIP;
			
			zipDoc = null;
			zipDoc = new ZIPDocument();
			zipDoc.docName = NAME;
			zipDoc.addEventListener(ProgressEvent.PROGRESS, forwardProgressEvent);
			zipDoc.addEventListener(ZIPEvent.DECOMPRESSION_ERROR, setupZipFile);
			zipDoc.addEventListener(ZIPEvent.DECOMPRESSED, setupZipFile);
			zipDoc.load(ByteArray(ba));
		}
		private function setupZipFile(e:ZIPEvent):void 
		{
			if (e.type == ZIPEvent.DECOMPRESSION_ERROR) 
			{
				trace('decompression error');
				return;
			}
			trace('decompressed successfully');
			NAME = zipDoc.docName;
			xflparse(XMLFormater.format(String(zipDoc.files[NAME + "_" + "DOMDocument.xml"])));
			
			setTimeout(function():void{
			forwardComplete(new Event(Event.COMPLETE));
			},2000);
			
		}
		
		private function InitParse(e:Event):void 
		{
			xflparse(XMLFormater.format(String(e.target.data)));
			trace('completed');
			setTimeout(function():void{
			forwardComplete(new Event(Event.COMPLETE));
			},2000);
		}
		
		
		/**
		 * Forward Events
		 */
		private function forwardProgressEvent(e:ProgressEvent):void { dispatchEvent(e); }
		private function forwardComplete(e:Event):void { dispatchEvent(e); }
		private function forwardIOError(e:IOErrorEvent):void { dispatchEvent(e); }
		
	}

}