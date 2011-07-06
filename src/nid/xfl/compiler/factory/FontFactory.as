package nid.xfl.compiler.factory 
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import nid.xfl.compiler.swf.data.SWFGlyphEntry;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagDefineFont3;
	import nid.xfl.data.text.FontObject;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class FontFactory 
	{
		static public var fontLibrary:Dictionary = new Dictionary();
		static public var fontDefinitions:Dictionary = new Dictionary();
		
		static public var totalFonts:int=0;
		static public var loadedFonts:int=0;
		
		public function FontFactory() 
		{
			
		}
		/**
		 * Define for tag for swf
		 */
		static public function defineFont(fontName:String,tags:Vector.<ITag>):void
		{
			fontDefinitions[fontName] = true;
			FontObject(fontLibrary[fontName]).publish(tags);
		}
		/**
		 * Get Font ID
		 */
		static public function fontId(fontName:String):uint
		{
			return FontObject(fontLibrary[fontName]).fontId
		}
		/**
		 * Get glyphEntries
		 */
		static public function glyphEntries(fontName:String,characters:String,fontSize:int):Vector.<SWFGlyphEntry>
		{
			return FontObject(fontLibrary[fontName]).glyphEntries(characters,fontSize);
		}
		/**
		 * generate glyph width
		 */
		static public function glyphsWidth(glyphs:Vector.<SWFGlyphEntry>):int
		{
			var width:int = 0;
			
			for (var i:int = 0; i < glyphs.length; i++)
			{
				width += glyphs[i].advance;
			}
			
			return width;
		}
		/**
		 * Reference point
		 */
		static public function ascent(fontName:String,fontSize:int):int
		{
			return FontObject(fontLibrary[fontName]).ascent(fontSize);
		}		
		/**
		 * Descent value
		 */
		static public function descent(fontName:String,fontSize:int):int
		{
			return FontObject(fontLibrary[fontName]).descent(fontSize);
		}
		/**
		 * Load font file
		 */
		static public function loadFonts(onComplete:Function,onProgress:Function=null,onError:Function=null):void
		{
			var fontLoader:Vector.<FontObject> = new Vector.<FontObject>();
			
			for each(var font:FontObject in fontLibrary)
			{
				fontLoader.push(font);
			}
			
			totalFonts  = fontLoader.length;
			loadedFonts = 0;
			
			if (fontLoader.length == 0)
			{
				onComplete(null);
				return;
			}
			
			fontLoader[loadedFonts].load(loadNextFont, onProgress, onError);
			
			function loadNextFont(e:Event):void 
			{
				loadedFonts++;
				if (loadedFonts == totalFonts)
				{
					onComplete(e);
					fontLoader = null;
					return;
				}
				fontLoader[loadedFonts].load(loadNextFont, onProgress, onError);
			}
		}
		
		/**
		 *  Check Font is already defined in swf
		 */
		static public function isFontDefined(fontName:String):Boolean
		{
			return fontDefinitions[fontName] == undefined?false:true;
		}
		/**
		 * Check font is already created
		 */
		static public function isFontExist(fontName:String):Boolean
		{
			return fontLibrary[fontName] == undefined?false:true;
		}
		/**
		 * Register font
		 */
		static public function registerFont(fontName:String,characters:String=""):void
		{
			trace('fontName:' + fontName);
			
			if (!isFontExist(fontName))
			{
				fontLibrary[fontName] = new FontObject(fontName, characters);
			}
			else
			{
				fontLibrary[fontName].updateCodeTable(characters);
			}
		}
		/**
		 * Unregister font
		 */
		static public function unregisterFont(fontName:String):void
		{
			delete fontLibrary[fontName];
		}
	}

}