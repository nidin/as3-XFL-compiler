package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import ispg.framework.ui.controls.Button;
	import nid.xfl.editor.avm.AVMEnvironment;
	import nid.xfl.events.XFLEvent;
	import nid.xfl.XFLEditor;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Main extends Sprite 
	{
		static public var _stage:Stage;
		private var xfleditor:XFLEditor;
		private var fileref:FileReference;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_stage = stage;
			
			xfleditor = new XFLEditor();
			addChild(xfleditor);
			xfleditor.addEventListener(XFLEvent.READY, exportSWF);
			//xfleditor.load("sample3/sample3.xfl");
			//xfleditor.load("template test/alpha_test/alpha_test.xfl");
			//xfleditor.load("template test/dynamic_text/dynamic_text.xfl");
			//xfleditor.load("template test/cliped bitmap/cliped bitmap.xfl");
			//xfleditor.load("as3 test/abc-1/abc-1.xfl");
			//xfleditor.load("as3 test/abc-2/abc-2.xfl");
			//xfleditor.load("template test/advanced_text/advanced_text.xfl");
			//xfleditor.load("template test/lossless image/lossless image.xfl");
			//xfleditor.load("template test/swf_build_test0/swf_build_test0.xfl");
			xfleditor.load("250x250/250x250.xfl");
			//xfleditor.load("250x250.zip");
			//xfleditor.load("336x280/336x280.xfl");
			//xfleditor.load("template test/250x250-f1/250x250-f1.xfl");
			//xfleditor.load("template test/simple text/simple text.xfl");
			//xfleditor.load("http://dev3.ispg.in/nidin/ad4adwords/xfl-compiler/250x250/250x250.zip");
			//xfleditor.load("template test/sample1/sample1.xfl");
			//xfleditor.load("template test/animation_1/animation_1.xfl");
			
			/**
			 * Unit Test
			 */
			//xfleditor.load("UnitTest/shape/shape.xfl");
			//xfleditor.load("UnitTest/sprite/sprite.xfl");
			//xfleditor.load("UnitTest/ClassicTween/ClassicTween.xfl");
			//xfleditor.load("UnitTest/ClassicTween/ClassicTween.xfl");
			//xfleditor.load("UnitTest/button/button.xfl");
			//xfleditor.load("UnitTest/button_text/button_text.xfl");
			//xfleditor.load("UnitTest/gradients/gradients.xfl");
			//xfleditor.load("UnitTest/bitmap_fill/bitmap_fill.xfl");
			//xfleditor.load("UnitTest/bitmaps/bitmaps.xfl");
			
			var build:Button = new Button("Build SWF",100);
			build.x  = stage.stageWidth - build.width;
			addChild(build);
			
			var reload:Button = new Button("Reload XFL",100);
			reload.x  = build.x - reload.width;
			addChild(reload);
			
			var fps:TextField = new TextField();
			fps.defaultTextFormat = new TextFormat("Arial", 12, 0xff0000, true);
			fps.width = 60;
			fps.x = reload.x - 70;
			fps.text =  'FPS:'+AVMEnvironment.fps.toString();
			addChild(fps);
			
			build.addEventListener(MouseEvent.CLICK, saveSWF);
			reload.addEventListener(MouseEvent.CLICK, reloadXFL);
		}
		
		private function reloadXFL(e:MouseEvent):void 
		{
			
			xfleditor.reload();
		}
		
		private function saveSWF(e:MouseEvent):void 
		{
			xfleditor.exportSWF();
		}
		
		private function exportSWF(e:XFLEvent):void 
		{
			//xfleditor.exportSWF();
		}
		
		private function browseFile(e:MouseEvent):void 
		{
			fileref = new FileReference();
			fileref.addEventListener(Event.SELECT, onSelect);
			fileref.browse();
		}
		
		private function onSelect(e:Event):void 
		{
			fileref.addEventListener(Event.COMPLETE, onFileLoaded);
			fileref.load();
			//xfleditor.load(fileref.data);
		}
		
		private function onFileLoaded(e:Event):void 
		{
			trace('data loaded');
			xfleditor.load(fileref.data);
		}
		
	}
	
}