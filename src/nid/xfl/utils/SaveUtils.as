package nid.xfl.utils 
{
	import flash.text.TextField;
	import flash.xml.XMLDocument;
	import nid.xfl.compiler.factory.FontFactory;
	import nid.xfl.dom.DOMTextRun;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class SaveUtils 
	{
		
		public function SaveUtils() 
		{
			
		}
		public static function updateTextRun(field:TextField):Vector.<DOMTextRun>
		{
			var htmlText:XML;
			var textRuns:Vector.<DOMTextRun> = new Vector.<DOMTextRun>();
			var tr_index:int = 0;
			
			if (field.htmlText.indexOf("<TEXTFORMAT") == -1)
			{
				htmlText = new XML(new XMLDocument("<TEXTRUN><TEXTFORMAT>" + field.htmlText + "</TEXTFORMAT></TEXTRUN>"));
			}
			else
			{
				htmlText = new XML(new XMLDocument("<TEXTRUN>" + field.htmlText + "</TEXTRUN>"));
			}
			
			
			for (var i:int = 0; i < htmlText.TEXTFORMAT.length(); i++)
			{
				var P:XMLList = htmlText.TEXTFORMAT[i].P;
				
				for (var j:int = 0; j < P.length(); j++)
				{
					var fontNodeAvailable:Boolean = true;
					var fontNode:XML = P[j].FONT[0];
					
					while (fontNodeAvailable)
					{
						var tr_string:String = '<DOMTextRun><characters>';
						tr_string += fontNode.text();
						tr_string += '</characters><textAttrs><DOMTextAttrs ';
						tr_string += 'alignment="' + String(P[j].@ALIGN).toLowerCase() + '" ';
						tr_string += 'aliasText="false" ';
						tr_string += 'size="' + String(fontNode.@SIZE == undefined?P[j].FONT.@SIZE:fontNode.@SIZE) + '" ';
						tr_string += 'bitmapSize="' + String(fontNode.@SIZE == undefined?(P[j].FONT.@SIZE * 20):(fontNode.@SIZE * 20)) + '" ';
						tr_string += 'face="' + String(fontNode.@FACE == undefined? P[j].FONT.@FACE:fontNode.@FACE) + '" ';
						tr_string += 'fillColor="' + String(fontNode.@COLOR == undefined? P[j].FONT.@COLOR:fontNode.@COLOR) + '" /></textAttrs></DOMTextRun>';
						
						var tr:DOMTextRun = new DOMTextRun(new XML(tr_string));
						textRuns.push(tr);
						FontFactory.registerFont(textRuns[tr_index].textAttrs.face, textRuns[tr_index].characters);
						tr_index++;
						
						fontNode = lookUpFontNode(fontNode);
						fontNodeAvailable = fontNode != null;
					}
				}
				
			}
			
			return textRuns;
		}
		private static function lookUpFontNode(data:XML):XML
		{
			return String(data.FONT) != ""?data.FONT[0]:null;
		}
	}

}