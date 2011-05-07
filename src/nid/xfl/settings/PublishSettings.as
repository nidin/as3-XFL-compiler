package nid.xfl.settings 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class PublishSettings 
	{
		private var loader:URLLoader;
		
		public function PublishSettings(url:String="") 
		{
			if (url != null)
			{
				load(url);
			}
		}
		public function load(url:String):void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(new URLRequest(url));
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			
		}
		
		private function onComplete(e:Event):void 
		{
			
		}
		
	}

}