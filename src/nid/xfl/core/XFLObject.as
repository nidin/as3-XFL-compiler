package nid.xfl.core 
{
	import flash.display.Shape;
	import nid.xfl.XFLDocument;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XFLObject extends TimeLine
	{
		static public var level:int = 0;
		
		private var bg:Shape;
		
		public function XFLObject() 
		{
			bg = new Shape();
		}
		public function make(xfl:XFLDocument):void 
		{
			doc = xfl;
			bg.graphics.clear();
			bg.graphics.beginFill(xfl.backgroundColor);
			bg.graphics.drawRect(0,0, xfl.width, xfl.height);
			bg.graphics.endFill();
			addChild(bg);
			
			super.construct(xfl);
			updateDisplay();
		}
	}

}