package  
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import mx.core.MovieClipLoaderAsset;
	import nid.events.StatusEvent;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class UI extends MovieClip 
	{
		[Embed(source = 'BuilderUI.swf', mimeType = 'application/octet-stream')]
		private var EmbeddedSkin:Class;
		
		public var skin:MovieClip;
		
		public function get select_xfl():DisplayObject { return skin.getChildByName("select_xfl"); }
		public function get select_swf():DisplayObject { return skin.getChildByName("select_swf"); }
		public function get export():DisplayObject { return skin.getChildByName("export"); }
		public function get dump():DisplayObject { return skin.getChildByName("dump"); }
		public function get clear():DisplayObject { return skin.getChildByName("clear"); }
		public function get loadSample():DisplayObject { return skin.getChildByName("load_sample"); }
		public function get downloadSample():DisplayObject { return skin.getChildByName("download_sample"); }
		
		public function UI()
		{
			loadSkin();
		}
		private function loadSkin():void 
		{
			trace('loadSkin');
			var context:LoaderContext = new LoaderContext(false);
			context.allowCodeImport = true;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, configureSkin);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
			loader.loadBytes(new EmbeddedSkin(), context);
		}
		
		private function onInit(e:Event):void 
		{
			trace(e.target.content);
		}
		private function configureSkin(e:Event):void {
			skin 	= e.currentTarget.content;
			skin.x 	= 0;
			skin.y 	= 0;
			addChild(skin);
			dispatchEvent(new StatusEvent(StatusEvent.READY));
		}
	}

}