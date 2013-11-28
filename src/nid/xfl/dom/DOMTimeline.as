package nid.xfl.dom 
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import nid.xfl.compiler.swf.data.SWFRawTag;
	import nid.xfl.compiler.swf.factories.SWFTagFactory;
	import nid.xfl.compiler.swf.SWFData;
	import nid.xfl.compiler.swf.tags.IDefinitionTag;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagJPEGTables;
	import nid.xfl.compiler.swf.timeline.Frame;
	import nid.xfl.compiler.swf.timeline.Layer;
	import nid.xfl.compiler.swf.timeline.Scene;
	import nid.xfl.compiler.swf.timeline.SoundStream;
	import nid.xfl.core.FrameElement;
	import nid.xfl.dom.DOMDocument;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class DOMTimeline extends EventDispatcher
	{
		/**
		 * XFL Reference
		 */
		public var doc:DOMDocument;
		
		/**
		 * 
		 */
		public var name:String;
		public var currentDOMFrame:int;
		public var domlayers:Vector.<DOMLayer>;
		public var domframes:Vector.<DOMLayer>;
		
		/**
		 * SWF PROEPRTIES
		 */
		public static var TIMEOUT:int = 50;
		public static var AUTOBUILD_LAYERS:Boolean = false;
		public static var EXTRACT_SOUND_STREAM:Boolean = true;
		
		protected var _tags:Vector.<ITag>;
		protected var _tagsRaw:Vector.<SWFRawTag>;
		protected var _dictionary:Dictionary;
		protected var characterPool:Vector.<FrameElement>;
		protected var _scenes:Vector.<Scene>;
		protected var _frames:Vector.<Frame>;
		protected var _layers:Vector.<Layer>;
		protected var _soundStream:SoundStream;

		protected var currentFrame:Frame;
		protected var currentDepth:int=1;
		protected var frameLabels:Dictionary;
		protected var hasSoundStream:Boolean = false;

		protected var enterFrameProvider:Sprite;
		protected var eof:Boolean;

		protected var _tmpData:SWFData;
		protected var _tmpVersion:uint;

		protected var _tagFactory:SWFTagFactory;

		public var jpegTablesTag:TagJPEGTables;
		
		public function get tags():Vector.<ITag> { return _tags; }
		public function get tagsRaw():Vector.<SWFRawTag> { return _tagsRaw; }
		public function get dictionary():Dictionary { return _dictionary; }
		public function get scenes():Vector.<Scene> { return _scenes; }
		public function get frames():Vector.<Frame> { return _frames; }
		public function get layers():Vector.<Layer> { return _layers; }

		public function get soundStream():SoundStream { return _soundStream; }
		
		public function get tagFactory():SWFTagFactory { return _tagFactory; }
		public function set tagFactory(value:SWFTagFactory):void { _tagFactory = value; }
		
		public function getCharacter(characterId:uint):IDefinitionTag {
			return dictionary[characterId] as IDefinitionTag;
		}
		
		public function DOMTimeline() 
		{
			_tags = new Vector.<ITag>();
			_tagsRaw = new Vector.<SWFRawTag>();
			_dictionary = new Dictionary();
			_scenes = new Vector.<Scene>();
			_frames = new Vector.<Frame>();
			_layers = new Vector.<Layer>();
			characterPool = new Vector.<FrameElement>();
			_tagFactory = new SWFTagFactory();
			
			enterFrameProvider = new Sprite();
		}
		/**
		 * PARSE THE XFL TIMELINE AND GENERATE DATA REFERENCE
		 * FOR SWF GENERATION AND MODIFICATION
		 */
		public function parse(data:XMLList):void
		{
			name = data.@name;
			currentDOMFrame = data.@currentFrame;
			
			domlayers = null;
			domlayers = new Vector.<DOMLayer>();
			
			for (var k:int = 0; k < data.layers.DOMLayer.length(); k++)
			{
				domlayers.push(new DOMLayer(data.layers.DOMLayer[k], doc));
			}
		}
		
		/**
		 * Export
		 */
		public function export():void
		{
			
		}
	}

}