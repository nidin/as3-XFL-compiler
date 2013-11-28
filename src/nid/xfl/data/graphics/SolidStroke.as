package nid.xfl.data.graphics 
{
	import nid.xfl.compiler.swf.data.SWFLineStyle;
	import nid.xfl.interfaces.IFillStyle;
	import nid.xfl.interfaces.IStrokeStyle;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class SolidStroke extends StrokeStyle implements IStrokeStyle
	{
		
		public function SolidStroke(data:XML=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			index = data.@index;
			scaleMode = data.SolidStroke.@scaleMode;
			width = Number(data.SolidStroke.@weight) == 0?1:data.SolidStroke.@weight;
			
			if (data.SolidStroke.fill.toString().indexOf("SolidColor") != -1)
			{
				fill =  new SolidColor(XML(data.SolidStroke.fill));
			}
			else if (data.SolidStroke.fill.toString().indexOf("LinearGradient") != -1)
			{
				fill =  new LinearGradient(XML(data.SolidStroke.fill.LinearGradient));
			}
			else if (data.SolidStroke.fill.toString().indexOf("RadialGradient") != -1)
			{
				fill =  new RadialGradient(XML(data.SolidStroke.fill.RadialGradient));
			}
		}
		public function export():SWFLineStyle
		{
			//trace('SWFLineStyle: color=' + fill.color);
			var lineStyle:SWFLineStyle = new SWFLineStyle ();
				lineStyle.color = fill.color;
				lineStyle.fillType = fill.export(2);
				lineStyle.width = width * 20;
			
			return lineStyle;
		}
	}

}