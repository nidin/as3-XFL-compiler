package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	import nid.events.StatusEvent;
	import nid.xfl.compiler.factory.FontFactory;
	import nid.xfl.compiler.swf.SWF;
	import nid.xfl.editor.avm.AVMEnvironment;
	import nid.xfl.events.XFLEvent;
	import nid.xfl.utils.FontTable;
	import nid.xfl.XFLCompiler;
	import nid.xfl.XFLDocument;
	import nid.xfl.core.XFLObject;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	
	[SWF(backgroundColor = "#ffffff", frameRate = "60", quality = "HIGH", width = "550", height = "600")]
	
	public class Builder extends Sprite 
	{
		private var xflFile:XFLDocument;
		private var xflObject:XFLObject;
		private var compiler:XFLCompiler;
		private var fileref:FileReference;
		private var fileType:String;
		private var ui:UI;
		private var isReady:Boolean;
		private var dump:Boolean;
		private var swf:SWF;
		
		public function Builder() 
		{
			ui = new UI();
			ui.addEventListener(StatusEvent.READY, configUI);
			addChild(ui);
		}
		private function configUI(e:StatusEvent):void 
		{
			FontTable.fontDir = this.loaderInfo.parameters.fontDir;
			
			ui.select_xfl.addEventListener(MouseEvent.CLICK, browse);
			ui.select_swf.addEventListener(MouseEvent.CLICK, browse);
			ui.export.addEventListener(MouseEvent.CLICK, exportSWF);
			ui.dump.addEventListener(MouseEvent.CLICK, dumpSWF);
			ui.clear.addEventListener(MouseEvent.CLICK, clearConsole);
			ui.loadSample.addEventListener(MouseEvent.CLICK, loadSampleXFL);
			ui.downloadSample.addEventListener(MouseEvent.CLICK, downloadSampleXFL);
			
			compiler = new XFLCompiler();
			compiler.addEventListener(XFLEvent.SWF_EXPORTED, saveSWF);
		}
		
		private function downloadSampleXFL(e:MouseEvent):void 
		{
			if (this.loaderInfo.parameters.sample != undefined)
			{
				var fileref:FileReference = new FileReference();
				fileref.download(new URLRequest(this.loaderInfo.parameters.sample), 'sample.xfl.zip');
			}
			else
			{
				log('sample not defined\n');
			}
		}
		
		private function loadSampleXFL(e:MouseEvent):void 
		{
			if (this.loaderInfo.parameters.sample != undefined)
			{
				load(this.loaderInfo.parameters.sample);
			}
			else
			{
				log('sample not defined\n');
			}
		}
		
		private function dumpSWF(e:MouseEvent):void 
		{
			if (fileType == "xfl")
			{
				exportSWF(e);
			}
			else if (fileType == "swf")
			{
				log(swf.toString());
			}
		}
		
		public function exportSWF(e:Event):void
		{
			if (e.currentTarget.name == "dump")
			{
				dump = true;
			}else {
				dump = false;
			}
			
			if (isReady)
			{
				
				compiler.build(xflObject);
			}
			else
			{
				ui.skin.input.text = "XFL file is not ready";
			}
		}
		private function clearConsole(e:MouseEvent):void 
		{
			ui.skin.console.text = '';
		}
		private function browse(e:MouseEvent):void 
		{
			
			fileref = new FileReference();
			fileref.addEventListener(Event.SELECT, loadFile);
			fileref.browse();
		}
		
		private function loadFile(e:Event):void 
		{
			isReady = false;
			ui.skin.input.text = fileref.name;
			fileref.addEventListener(Event.COMPLETE, loadBytes);
			fileref.load();
		}
		
		private function loadBytes(e:Event):void 
		{
			if (fileref.name.indexOf('swf') != -1)
			{
				fileType = "swf";
				swf = new SWF(fileref.data);
			}
			else if(fileref.name.indexOf('zip') != -1)
			{
				fileType = "xfl";
				load(fileref.data);
			}
		}
		
		private function saveSWF(e:XFLEvent):void 
		{
			if (dump)
			{
				log(compiler.dumpString);
			}
			else 
			{
				var fileref:FileReference = new FileReference();
				fileref.addEventListener(Event.SELECT, onFileSelect);
				fileref.save(compiler.bytes,"output.swf");
			}
		}
		
		private function onFileSelect(e:Event):void 
		{
			trace('swf saved');
		}
		public function load(file:Object):void
		{
			log("XFL loading\n");
			xflFile = new XFLDocument();
			xflFile.addEventListener(ProgressEvent.PROGRESS, onProgress);
			xflFile.addEventListener(Event.COMPLETE, loadFonts);
			xflFile.load(file);
		}
		
		private function loadFonts(e:Event):void 
		{
			trace("Loading Fonts");
			log("Font loading\n");
			setTimeout(function():void{
			FontFactory.loadFonts(onComplete, onFontProgress,onIOError);
			},1000);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace("Font Load Error:" + e.text);
			log("Font load error\n");
		}
		
		private function onFontProgress(e:ProgressEvent):void 
		{
			trace("Loading Fonts: " + FontFactory.totalFonts + "/" + FontFactory.loadedFonts + " - " + (int(e.bytesTotal) / 1000) + "kb/" + (int(e.bytesLoaded) / 1000) + "kb");
		}
		private function onProgress(e:ProgressEvent):void 
		{
			trace("Loading XFL file: " + (int(e.bytesTotal)/1000) + "kb/" + (int(e.bytesLoaded)/1000)+"kb");
		}
		
		private function onComplete(e:Event):void 
		{
			trace('xfl loaded');
			log("XFL Loaded\n");
			setTimeout(createXFLObject,1000);
		}
		
		private function createXFLObject():void 
		{
			xflObject = new XFLObject();
			xflObject.make(xflFile);
			log("Ready\n");
			dispatchEvent(new XFLEvent(XFLEvent.READY));
			isReady = true;
		}
		public function log(value:String):void
		{
			ui.skin.console.text += value;
		}
	}

}