package nid.xfl.dom 
{
	import flash.text.Font;
	import flash.text.TextFormat;
	import nid.xfl.utils.FontTable;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMTextAttrs 
	{
		public var alignment:String;
		public var aliasText:String;
		public var indent:Number;
		public var leftMargin:Number;
		public var lineSpacing:Number;
		public var size:int;
		public var bitmapSize:int;
		public var characterPosition:String;
		public var face:String;
		public var fillColor:uint;
		public var rightMargin:Number;
		 
		public function DOMTextAttrs(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			alignment 	= String(data.@alignment) == ""?"left":data.@alignment;
			aliasText 	= data.@aliasText;
			indent 		= data.@indent;
			leftMargin 	= data.@leftMargin;
			lineSpacing = data.@lineSpacing;
			rightMargin = data.@rightMargin;
			size 		= String(data.@size) == ""?12:data.@size;
			bitmapSize 	= String(data.@bitmapSize) == ""?(size * 20):data.@bitmapSize;
			characterPosition = data.@characterPosition;
			face 		= data.@face;
			fillColor 	= String(data.@fillColor) == ""?0x000000:uint(String(data.@fillColor).replace("#", "0x"));
		}
		public function getFormat():TextFormat
		{
			var font:Object 		= FontTable.getFont(face);
			var format:TextFormat 	= new TextFormat();
				format.font 		= font.name;
				format.size 		= size;
				format.bold 		= font.bold;
				format.align 		= alignment;
				format.color 		= fillColor;
				format.leading 		= lineSpacing;
			return format;
		}
	}

}