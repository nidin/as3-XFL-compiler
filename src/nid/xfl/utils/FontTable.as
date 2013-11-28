package nid.xfl.utils 
{
	/**
	 * ...
	 * @author Nidin Vinayak
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
				case "Wingdings3":return fontDir + "Wingdings3.swf"; break;
				case "StymieBT-Medium":return fontDir + "StymieBTMedium.swf"; break;
				case "StymieBT-ExtraBold":return fontDir + "StymieBTExtraBold.swf"; break;
				case "Swiss721BT-RomanCondensed":return fontDir + "Swiss721BTRomanCondensed.swf"; break;
				case "StymieBT-ExtraBoldCondensed":return fontDir + "StymieBTExtraBoldCondensed.swf"; break;
				case "Swiss721BT-BoldCondensed":return fontDir + "Swiss721BTBoldCondensedBold.swf"; break;
				case "DomCasualBT-Regular":return fontDir + "DomCasualBTRegular.swf"; break;
				
				case "Ebrima":return fontDir + "Ebrima.swf"; break;
				case "Ebrima-Bold":return fontDir + "EbrimaBold.swf"; break;
				case "FlashD-Ligh":return fontDir + "FlashDLigh.swf"; break;
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
				case "Wingdings3":return "Wingdings 3"; break;
				case "StymieBT-Medium":return "Stymie Md BT"; break;
				case "StymieBT-ExtraBold":return "Stymie XBd BT"; break;
				case "Swiss721BT-RomanCondensed":return "Swis721 Cn BT"; break;
				case "StymieBT-ExtraBoldCondensed":return "Stymie XBdCn BT"; break;
				case "Swiss721BT-BoldCondensed":return "Swis721 Cn BT"; break;
				case "DomCasualBT-Regular":return "DomCasual BT"; break;
				case "Ebrima":return "Ebrima"; break;
				case "Ebrima-Bold":return "Ebrima"; break;
				case "FlashD-Ligh":return "Flash D"; break;
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
				case "Wingdings3":return { name:"Wingdings 3", bold:false }; break;
				case "StymieBT-Medium":return { name:"Stymie Md BT", bold:false }; break;
				case "StymieBT-ExtraBold":return { name:"Stymie XBd BT", bold:false }; break;
				case "Swiss721BT-RomanCondensed":return { name:"Swis721 Cn BT", bold:true }; break;
				case "StymieBT-ExtraBoldCondensed":return { name:"Stymie XBdCn BT", bold:false }; break;
				case "Swiss721BT-BoldCondensed":return { name:"Swis721 Cn BT", bold:true }; break;
				case "DomCasualBT-Regular":return { name:"DomCasual BT", bold:false }; break;
				
				case "Ebrima":return { name:"Ebrima", bold:false }; break;
				case "Ebrima-Bold":return { name:"Ebrima-Bold", bold:true }; break;
				case "FlashD-Ligh":return { name:"FlashD-Ligh", bold:false }; break;
			}
			
			return { name:"Arial", bold:false };
		}
	}

}