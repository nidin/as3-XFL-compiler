package nid.xfl.data.graphics 
{
	import nid.xfl.compiler.swf.data.SWFFillStyle;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.interfaces.IFillStyle;
	import nid.utils.Colors;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class SolidColor extends FillStyle implements IFillStyle
	{
		private var _color:uint;
		public function get color():uint { return _color; }
		public function set color(value:uint):void { _color = value; }		
		
		private var _alpha:Number = 1;
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void { _alpha = value; }
		
		public var type:String = "SolidColor";
		
		public function SolidColor(data:XML=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			index = data.@index;
			_color = String(data.SolidColor.@color) == ""?0x000000: uint(String(data.SolidColor.@color).replace("#", "0x"));
			_alpha = String(data.SolidColor.@alpha) == ""?1: Number(data.SolidColor.@alpha);
		}
		public function export(_type:int, tags:Vector.<ITag> = null, property:Object = null):SWFFillStyle
		{
			
			var fillstyle:SWFFillStyle = new SWFFillStyle();
				fillstyle.type = 0x00;
				fillstyle.rgb = uint(Colors.joinAlpha(_color, _alpha));
				
				if (_type > 2)
				{
					//fillstyle.rgb = uint(Colors.joinAlpha(_color,_alpha));
				}
				else {
					//fillstyle.rgb = color;
				}
			
			//trace('data:' + fillstyle);
			
			return fillstyle;
		}
	}

}