package nid.xfl.dom 
{
	import nid.xfl.compiler.swf.tags.TagSymbolClass;
	import nid.xfl.Media;
	import nid.xfl.settings.MobileSettings;
	import nid.xfl.settings.PublishSettings;
	import nid.xfl.XFLDocument;
	import nid.xfl.ZIPDocument;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class DOMDocument extends DOMTimeline
	{
		public var NAME:String;
		public var TYPE:String = "URL";
		public var LIBRARY_PATH:String = "LIBRARY/";
		public var BIN_PATH:String = "bin/";
		public var zipDoc:ZIPDocument;
		public var DoABC:Boolean;
		
		public var publishSettings:PublishSettings;
		public var mobileSettings:MobileSettings;
		
		/**
		 * XFL PROPERTIES
		 */
		public var xflVersion:String = '2.0';
		public var width:uint;
		public var height:uint;
		public var backgroundColor:uint=0xffffff;
		public var currentTimeline:uint;
		public var creatorInfo:String;
		public var platform:String;
		public var versionInfo:String;
		public var majorVersion:int;
		public var buildNumber:int;
		public var guidesVisible:Boolean;
		public var rulerVisible:Boolean;
		public var viewAngle3D:Number;
		public var nextSceneIdentifier:int;
		public var playOptionsPlayLoop:Boolean;
		public var playOptionsPlayPages:Boolean;
		public var playOptionsPlayFrameActions:Boolean;
		
		public var symbols:XMLList;
		public var media:Media;
		
		public function DOMDocument() 
		{
			
		}
		public function xflparse(data:XML):void
		{
			symbols 		= data.symbols;
			media 			= String(data.media) == ""?new Media(null,this):new Media(XML(data.media),this);
			width 			= String(data.@width) == ""?550:data.@width;
			height 			= String(data.@height) == ""?400:data.@height;
			backgroundColor = String(data.@backgroundColor)==""?0xffffff:uint(String(data.@backgroundColor).replace("#","0x"));
			currentTimeline = data.@currentTimeline;
			xflVersion		= data.@xflVersion;
			creatorInfo		= data.@creatorInfo;
			platform		= data.@platform;
			versionInfo		= data.@versionInfo;
			majorVersion	= data.@majorVersion;
			buildNumber		= data.@buildNumber;
			guidesVisible	= data.@guidesVisible;
			rulerVisible	= data.@rulerVisible;
			viewAngle3D		= data.@viewAngle3D;
			nextSceneIdentifier= data.@nextSceneIdentifier;
			playOptionsPlayLoop= data.@playOptionsPlayLoop;
			playOptionsPlayPages= data.@playOptionsPlayPages;
			playOptionsPlayFrameActions= data.@playOptionsPlayFrameActions;
			
			doc = this;
			
			parse(data.timelines.DOMTimeline);
		}
		
		/**
		 * Export
		 */
		override public function export():void
		{
			super.export();
		}
	}

}