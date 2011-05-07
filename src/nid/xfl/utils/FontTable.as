package nid.xfl.utils 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class FontTable 
	{
		static public var fontDir:String = "fonts/";
		
		public function FontTable() 
		{
			
		}
		static public function serverFont(fontName:String):String
		{
			switch(fontName)
			{
				case "Tahoma":return fontDir + "tahoma_regular_2.swf"; break;
				case "ArialMT":return fontDir + "arial_regular.swf"; break;
				case "Arial-BoldMT":return fontDir + "arial_bold.swf"; break;
				case "Arial-Black":return fontDir + "arial_black.swf"; break;
				case "ZagBold":return fontDir + "zag_bold.swf"; break;
				case "Swiss721BT-BlackCondensed":return fontDir + "Swiss721BTBlackCondensed.swf"; break;
				case "SegoeUI":return fontDir + "segoe_ui_regular.swf"; break;
			}
			
			return fontDir + "arial_regular.swf";
		}
		
		static public function systemName(value:String):String
		{
			switch(value)
			{
				case "Tahoma":return "Tahoma"; break;
				case "ArialMT":return "Arial"; break;
				case "Arial-BoldMT":return "Arial"; break;
				case "Arial-Black":return "Arial"; break;
				case "ZagBold":return "Zag Bold"; break;
				case "Swiss721BT-BlackCondensed":return "Swis721 BlkCn BT"; break;
			}
			
			return "Arial";
		}		
		static public function getFont(value:String):Object
		{
			switch(value)
			{
				case "Tahoma":return { name:"Tahoma", bold:false }; break;
				case "ArialMT":return { name:"Arial", bold:false }; break;
				case "Arial-BoldMT":return { name:"Arial", bold:true }; break;
				case "Arial-Black":return { name:"Arial", bold:true }; break;
				case "ZagBold":return { name:"Zag Bold", bold:false }; break;
				case "Swiss721BT-BlackCondensed":return { name:"Swis721 BlkCn BT", bold:false }; break;
				case "SegoeUI":return { name:"Segoe UI", bold:false }; break;
			}
			
			return { name:"Arial", bold:false };
		}
	}

}