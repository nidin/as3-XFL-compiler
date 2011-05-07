package nid.utils.zip 
{
	import flash.events.EventDispatcher;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import nid.events.ZIPEvent;
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	
	/**
	 * ...
	 * @author Nidin.P.Vinayak
	 */
	public class ZIPArchive extends EventDispatcher
	{
		
		public var files:Array;
		
		public function ZIPArchive() 
		{
			
		}
		public function load(data:ByteArray):void {
			
			var zipFile:ZipFile = new ZipFile(data);
			
			files = [];
			
			for(var i:int = 0; i < zipFile.entries.length; i++) {
				var entry:ZipEntry = zipFile.entries[i];
				var bytes:ByteArray = zipFile.getInput(entry);
				files.push( { name:entry.name, data:bytes } );
			}
			
			dispatchEvent(new ZIPEvent(ZIPEvent.DECOMPRESSED));
		}

	}

}