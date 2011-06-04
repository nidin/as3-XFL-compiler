package nid.xfl 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import nid.events.ZIPEvent;
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	
	/**
	 * ...
	 * @author Nidin.P.Vinayak
	 */
	public class ZIPDocument extends EventDispatcher
	{
		public var docName:String;
		public var files:Dictionary;
		public var zipFile:ZipFile;
		private var timer:Timer;
		
		public function ZIPDocument() 
		{
			
		}
		public function load(data:ByteArray):void {
			
			zipFile = new ZipFile();
			zipFile.addEventListener(ProgressEvent.PROGRESS, this.dispatchEvent);
			zipFile.addEventListener(Event.COMPLETE, onComplete);
			zipFile.read(data);
		}
		
		private function onComplete(e:Event):void 
		{
			docName = ZipEntry(zipFile.entries[0]).name.split('.xfl')[0];
			
			files = new Dictionary();
			timer = new Timer(200, zipFile.entries.length );
			timer.addEventListener(TimerEvent.TIMER, process);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onProcessComplete);
			timer.start();
		}
		
		private function onProcessComplete(e:TimerEvent):void 
		{
			setTimeout(function():void{
			dispatchEvent(new ZIPEvent(ZIPEvent.DECOMPRESSED)); }, 500 );
		}
		
		private function process(e:TimerEvent):void 
		{
			var entry:ZipEntry = zipFile.entries[timer.currentCount - 1 ];
			var splits:Array = entry.name.split("/");
			var name:String = docName +'_'+ splits[splits.length - 1];
			splits = null;
			if (!entry.isDirectory()) files[name] = zipFile.getInput(entry);
			
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, timer.repeatCount + timer.currentCount  , timer.repeatCount * 2));
		}

	}

}