package nid.xfl.data.text 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import nid.xfl.compiler.swf.data.SWFGlyphEntry;
	import nid.xfl.compiler.swf.data.SWFKerningRecord;
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.data.SWFShape;
	import nid.xfl.compiler.swf.FontSWF;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagDefineFont3;
	import nid.xfl.compiler.swf.tags.TagDefineFontName;
	import nid.xfl.utils.FontTable;
	import nid.xfl.XFLCompiler;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class FontObject extends Object
	{
		public var bytes:ByteArray;
		
		public var fontName:String;
		public var fontId:uint;
		public var bold:Boolean;
		public var italic:Boolean;
		public var leading:int;
		
		public var codelookup:Dictionary
		public var codeTable:Vector.<uint>;
		public var glyphShapeTable:Vector.<SWFShape>;
		public var fontAdvanceTable:Vector.<int>;
		public var fontBoundsTable:Vector.<SWFRectangle>;
		public var fontKerningTable:Vector.<SWFKerningRecord>;
		
		private var fontSWF:FontSWF;
		private var defineFont3:TagDefineFont3;
		
		public function FontObject(_fontName:String = "", characters:String="")
		{
			fontName = _fontName;
			codeTable = new Vector.<uint>();
			codelookup = new Dictionary();
			if (characters != null) updateCodeTable(characters);
		}
		
		public function updateCodeTable(characters:String):void
		{
			var codeString:String = characters.replace(/%n%/g, "");
			
			for (var i:int = 0; i < codeString.length; i++)
			{
				if (codelookup[codeString.charCodeAt(i)] == undefined)
				{
					codeTable.push(codeString.charCodeAt(i));
					codelookup[codeString.charCodeAt(i)] = true;
				}
			}
		}
		public function glyphEntries(characters:String,fontSize:int):Vector.<SWFGlyphEntry>
		{
			var codeString:String = characters.replace(/%n%/g, "");
			var _glyphEntries:Vector.<SWFGlyphEntry> = new Vector.<SWFGlyphEntry>();
			
			for (var i:int = 0; i < codeString.length; i++)
			{
				
				var glyphEntry:SWFGlyphEntry = new SWFGlyphEntry();
				glyphEntry.index = codeTable.indexOf(codeString.charCodeAt(i))
				glyphEntry.advance = Math.round(fontAdvanceTable[glyphEntry.index] / (1024/fontSize));
				_glyphEntries.push(glyphEntry);
			}
			return _glyphEntries;
		}
		public function ascent(fontSize:int):int
		{
			//return Math.round((fontSWF.ascent / (1024 / (fontSize / 20))) / 20) * 20;
			return (fontSWF.ascent / (1024 / (fontSize / 20)) / 20) * 20;
		}		
		public function descent(fontSize:int):int
		{
			//return Math.round((fontSWF.descent / (1024 / (fontSize / 20))) / 20) * 20;
			return ((fontSWF.descent / (1024 / (fontSize / 20))) / 20) * 20;
		}
		public function load(onComplete:Function, onProgress:Function, onError:Function):void
		{
			//trace('Loading Font:' + fontName);
			
			var urlloader:URLLoader = new URLLoader();
			urlloader.dataFormat = URLLoaderDataFormat.BINARY;
			urlloader.addEventListener(Event.COMPLETE, onInternalComplete);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			urlloader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			urlloader.load(new URLRequest(FontTable.serverFont(fontName)));
			
			function onInternalComplete(e:Event):void 
			{
				trace('font loaded:' + fontName);
				urlloader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				urlloader.removeEventListener(Event.COMPLETE, onInternalComplete);
				urlloader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				bytes = e.target.data as ByteArray;
				onComplete(e);
			}
		}
		
		public function publish(tags:Vector.<ITag>):void
		{
			defineFont3 				= new TagDefineFont3();
			defineFont3.characterId 	= XFLCompiler.characterId++;
			defineFont3.fontName 		= fontName;
			defineFont3.bold 			= bold;
			defineFont3.italic 			= italic;
			defineFont3.leading 		= leading;
			
			fontId = defineFont3.characterId;
			
			fontSWF = new FontSWF(bytes);
			
			glyphShapeTable 	= new Vector.<SWFShape>();
			fontAdvanceTable 	= new Vector.<int>();
			fontBoundsTable 	= new Vector.<SWFRectangle>();
			fontKerningTable 	= new Vector.<SWFKerningRecord>();
			
			for (var i:int = 0; i < codeTable.length; i++)
			{
				for (var j:int = 0; j < fontSWF.codeTable.length; j++ )
				{
					if (codeTable[i] == fontSWF.codeTable[j])
					{
						glyphShapeTable.push(fontSWF.glyphShapeTable[j]);
						fontAdvanceTable.push(fontSWF.fontAdvanceTable[j]);
						if (fontSWF.fontKerningTable.length > 0)
						fontKerningTable.push(fontSWF.fontKerningTable[j]);
					}
				}
			}
			
			defineFont3.codeTable 			= codeTable;
			defineFont3.glyphShapeTable 	= glyphShapeTable;
			//defineFont3.fontAdvanceTable 	= fontAdvanceTable;
			//defineFont3.fontBoundsTable 	= fontBoundsTable;
			//defineFont3.fontKerningTable 	= fontKerningTable;
			
			tags.push(defineFont3);
			
			var defineFontName:TagDefineFontName = fontSWF.defineFontName;
			defineFontName.fontId = defineFont3.characterId;
			tags.push(defineFontName);
		}
	}

}