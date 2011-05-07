package nid.xfl.core 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import nid.xfl.dom.DOMBitmapInstance;
	import nid.xfl.dom.DOMDynamicText;
	import nid.xfl.dom.DOMInputText;
	import nid.xfl.dom.DOMShape;
	import nid.xfl.dom.DOMStaticText;
	import nid.xfl.dom.DOMSymbolInstance;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMFactory 
	{
		
		public function DOMFactory() 
		{
			
		}
		static public function create(type:int):DisplayObject
		{
			switch(type)
			{ 
				case DOMStaticText.TYPE:
				{
					
					break;
				}
				case DOMDynamicText.TYPE:
				{
					
					break;
				}
				case DOMInputText.TYPE:
				{
					
					break;
				}
				case DOMShape.TYPE:
				{
					
					
					break;
				}
				case DOMSymbolInstance.TYPE:
				{
					
					break;
				}				
				case DOMBitmapInstance.TYPE:
				{
					
					break;
				}
			}
			
			return null;
		}
		
	}

}