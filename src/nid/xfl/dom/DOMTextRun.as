package nid.xfl.dom 
{
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import nid.xfl.compiler.factory.FontFactory;
	import nid.xfl.compiler.swf.data.SWFGlyphEntry;
	import nid.xfl.compiler.swf.data.SWFTextRecord;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.XFLCompiler;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMTextRun 
	{
		public var characters:String;
		public var textAttrs:DOMTextAttrs;
		public var textRecords:Vector.<SWFTextRecord>;
		public var xOffset:int=0;
		public var newLine:Boolean;
		
		public function DOMTextRun(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			if (String(data.characters[0]).length == 0)
			{
				characters = " ";
			}
			else
			{
				characters = String(data.characters[0]);
			}
			
			textAttrs = new DOMTextAttrs(XML(data.textAttrs.DOMTextAttrs));
		}
		public function appendText(txt:TextField):void
		{
			var begin:int = txt.length;
			var chars:String = characters.replace(/%n%/g, "\n");
			chars = chars.replace(/%s%/g, " ");
			txt.appendText(chars);
			if (begin < txt.length) txt.setTextFormat(textAttrs.getFormat(), begin, txt.length);
		}
		public function appendTextRecord(tags:Vector.<ITag>, property:Object, _newLine:Boolean = false, _begin:Boolean = false):Boolean
		{			
			newLine = _newLine;
			textRecords = new Vector.<SWFTextRecord>();
			var lineBreak:Boolean = characters.charAt(characters.length - 1) == "%"?true:false;
			
			if (!newLine)
			{
				newLine = characters.charAt(0) == "%"?true:false;
			}
			
			if (characters == "%n%")
			{
				textRecords.push(null);
				return lineBreak;
			}
			
			var textLines:Array = characters.split("%n%");
			
			if (textLines[textLines.length - 1].length == 0)
			{
				textLines.pop();
			}
			
			for (var j:int = 0; j < textLines.length; j++)
			{
				
				var textRecord:SWFTextRecord = new SWFTextRecord();
				
				/**
				 * Set font
				 */
				textRecord.hasFont 	= true;
				
				if (!FontFactory.isFontDefined(textAttrs.face))
				{
					FontFactory.defineFont(textAttrs.face, tags);
					
					textRecord.fontId 		= FontFactory.fontId(textAttrs.face);
					property.characterId 	= XFLCompiler.characterId
				}
				else 
				{
					textRecord.fontId	= FontFactory.fontId(textAttrs.face);
				}
				/**
				 * Set font color and font size
				 */
				textRecord.hasColor 	= true;
				textRecord.textColor 	= textAttrs.fillColor;
				textRecord.textHeight 	= textAttrs.bitmapSize;
				
				/**
				 * Set glyphs of the text record
				 */
				textRecord.glyphEntries = FontFactory.glyphEntries(textAttrs.face, textLines[j],textAttrs.size);
				
				/**
				 * Set alignment of the text record
				 */
				if (newLine)
				{
					textRecord.hasXOffset 	= true;
					textRecord.xOffset 		= 0;
					//trace('_begin:' + _begin);
					textRecord.hasYOffset 	= true;
					textRecord.yOffset 		= (_begin?0:(textAttrs.lineSpacing * 20));
				}
				else
				{
					textRecord.hasYOffset 	= false;
				}
				
				/*if (textRecord.glyphEntries.length > 0)
				{
					textRecords.push(textRecord);
					records.push(textRecord);
				}*/
				textRecords.push(textRecord);
				_begin = false;
			}
			textRecords.push(null);
			return lineBreak;
		}
		public function update(records:Vector.<SWFTextRecord>):void
		{
			for (var i:int = 0; i < textRecords.length; i++)
			{
				records.push(textRecords[i]);
			}
		}
	}

}