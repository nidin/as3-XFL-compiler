package nid.xfl 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	import nid.xfl.compiler.factory.FontFactory;
	import nid.xfl.editor.avm.AVMEnvironment;
	import nid.xfl.events.XFLEvent;
	import nid.xfl.XFLDocument;
	import nid.xfl.core.XFLObject;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFLEditor extends Sprite 
	{
		private var xflFile:XFLDocument;
		private var xflObject:XFLObject;
		private var avm:AVMEnvironment;
		private var compiler:XFLCompiler;
		private var loader_txt:TextField;
		private var file:Object;
		
		public function XFLEditor() 
		{
			compiler = new XFLCompiler();
			compiler.addEventListener(XFLEvent.SWF_EXPORTED, saveSWF);
		}
		
		private function saveSWF(e:XFLEvent):void 
		{
			var fileref:FileReference = new FileReference();
			fileref.addEventListener(Event.SELECT, onFileSelect);
			fileref.save(compiler.bytes,"test.swf");
		}
		
		private function onFileSelect(e:Event):void 
		{
			trace('swf saved');
		}
		public function reload():void
		{
			loader_txt.text = "Reloading XFL file";
			xflFile.load(file);
		}
		public function load(_file:Object):void
		{
			file = _file;
			trace("Loading XFL file");
			loader_txt = new TextField();
			loader_txt.autoSize = "left";
			loader_txt.selectable = false;
			loader_txt.defaultTextFormat = new TextFormat("Tahoma", 12, 0xff0000, true);
			addChild(loader_txt);
			loader_txt.text = "Loading XFL file";
			
			avm = new AVMEnvironment();
			xflFile = new XFLDocument();
			xflFile.addEventListener(ProgressEvent.PROGRESS, onProgress);
			xflFile.addEventListener(Event.COMPLETE, loadFonts);
			xflFile.load(file);
		}
		
		private function loadFonts(e:Event):void 
		{
			trace("Loading Fonts");
			setTimeout(function():void{
			FontFactory.loadFonts(onComplete, onFontProgress,onIOError);
			},1000);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace("Font Load Error:"+e.text);
			loader_txt.text = "Font Load Error:"+e.text;
		}
		
		private function onFontProgress(e:ProgressEvent):void 
		{
			loader_txt.text = "Loading Fonts: " + FontFactory.totalFonts + "/" + FontFactory.loadedFonts + " - " + (int(e.bytesTotal) / 1000) + "kb/" + (int(e.bytesLoaded) / 1000) + "kb";
		}
		private function onProgress(e:ProgressEvent):void 
		{
			loader_txt.text = "Loading XFL file: " + (int(e.bytesTotal)/1000) + "kb/" + (int(e.bytesLoaded)/1000)+"kb";
		}
		
		private function onComplete(e:Event):void 
		{
			trace('xfl loaded');
			loader_txt.text = "Building AVM Environment"
			
			setTimeout(createXFLObject,1000);
		}
		
		private function createXFLObject():void 
		{
			xflObject = new XFLObject();
			xflObject.y = 25;
			addChild(xflObject);
			
			xflObject.make(xflFile);
			
			stage.addEventListener(MouseEvent.CLICK, avm.playPause);
			
			avm.render(xflObject);
			
			xflObject.addEventListener(MouseEvent.CLICK, track);
			
			loader_txt.text = "";
			
			dispatchEvent(new XFLEvent(XFLEvent.READY));
		}
		
		private function track(e:MouseEvent):void 
		{
			trace('target:' + e.target, 'name:' + e.target.name);
		}
		
		public function exportSWF():void
		{
			compiler.build(xflObject);
		}
		
	}

}