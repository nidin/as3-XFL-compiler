package nid.xfl 
{
	import flash.events.EventDispatcher;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
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
		
		public function ZIPDocument() 
		{
			
		}
		public function load(data:ByteArray):void {
			
			zipFile = new ZipFile(data);
			
			files = new Dictionary();
			
			for (var i:int = 0; i < zipFile.entries.length; i++) 
			{
				var entry:ZipEntry = zipFile.entries[i];
				var splits:Array = entry.name.split("/");
				var name:String = docName +'_'+ splits[splits.length - 1];
				splits = null;
				if (!entry.isDirectory()) files[name] = zipFile.getInput(entry);
			}
			
			dispatchEvent(new ZIPEvent(ZIPEvent.DECOMPRESSED));
		}

	}

}