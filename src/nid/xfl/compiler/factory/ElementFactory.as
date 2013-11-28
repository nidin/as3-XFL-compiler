package nid.xfl.compiler.factory 
{
	import nid.xfl.compiler.swf.data.SWFButtonRecord;
	import nid.xfl.dom.DOMBitmapItem;
	import nid.xfl.interfaces.IElement;
	import nid.xfl.XFLCompiler;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class ElementFactory 
	{
		static public const NOT_SUPPORTED:String = "not_supported";
		
		public function ElementFactory() 
		{
			
		}
		static public function isExistInLibrary(element:IElement):Object
		{
			if (element.libraryItemName == NOT_SUPPORTED) return { exist:false };
			
			for each(var _element:IElement in XFLCompiler.elementLibrary)
			{
				if(_element.libraryItemName == element.libraryItemName)
				{
					return { exist:true, element:_element };
				}
			}
			return { exist:false };
		}
		static public function getElementByLibraryItemName(libraryItemName:String):IElement
		{
			for each(var _element:IElement in XFLCompiler.elementLibrary)
			{
				if (_element.libraryItemName == libraryItemName)
				{
					return _element;
				}
			}
			return null;
		}
		static public function getElementIdByLibraryItemName(libraryItemName:String):int
		{
			for each(var _element:IElement in XFLCompiler.elementLibrary)
			{
				if (_element.libraryItemName == libraryItemName)
				{
					return _element.characterId;
				}
			}
			return 0;
		}
		static public function getButtonRecordById(id:int,records:Vector.<SWFButtonRecord>):SWFButtonRecord
		{
			for each(var rec:SWFButtonRecord in records)
			{
				if (rec.characterId == id)
				{
					return rec;
				}
			}
			
			return null;
		}
	}

}