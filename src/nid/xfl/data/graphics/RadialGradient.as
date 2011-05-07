package nid.xfl.data.graphics 
{
	import flash.geom.Matrix;
	import nid.xfl.compiler.swf.data.SWFFillStyle;
	import nid.xfl.compiler.swf.data.SWFFocalGradient;
	import nid.xfl.compiler.swf.data.SWFGradient;
	import nid.xfl.compiler.swf.data.SWFMatrix;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.interfaces.IFillStyle;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class RadialGradient extends FillStyle implements IFillStyle
	{
		public var type:String = "RadialGradient";
		public var matrix:Matrix;
		public var focalPointRatio:Number;
		public var gradientEntry:Vector.<GradientEntry>;
		
		public var gradient:SWFGradient;
		public var focalGradient:SWFFocalGradient;
		public var gradientMatrix:SWFMatrix;
		
		private var _color:uint;
		public function get color():uint { return _color; }
		public function set color(value:uint):void { _color = value; }
		
		private var _alpha:Number = 1;
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void { _alpha = value; }
		
		public function RadialGradient(data:XML=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			index = data.@index;
			focalPointRatio = data.RadialGradient.attribute("focalPointRatio");
			//trace('focalPointRatio:' + focalPointRatio);
			matrix = null;
			matrix = new Matrix(	data.RadialGradient.matrix.Matrix.@a,
									data.RadialGradient.matrix.Matrix.@b,
									data.RadialGradient.matrix.Matrix.@c,
									data.RadialGradient.matrix.Matrix.@d,
									data.RadialGradient.matrix.Matrix.@tx,
									data.RadialGradient.matrix.Matrix.@ty);
			gradientEntry = null;
			gradientEntry = new Vector.<GradientEntry>();
			
			for (var i:int = 0; i < data.RadialGradient.GradientEntry.length(); i++)
			{
				gradientEntry.push(new GradientEntry(data.RadialGradient.GradientEntry[i]));
			}
		}
		public function export(_type:int,tags:Vector.<ITag>=null, property:Object = null):SWFFillStyle
		{
			var fillstyle:SWFFillStyle   = new SWFFillStyle();
			
			if (focalPointRatio == 0)
			{
				gradient = new SWFGradient();
				
				for (var i:int = 0; i < gradientEntry.length; i++)
				{
					gradient.records.push(gradientEntry[i].export());
				}
				fillstyle.type		= 0x12;
				fillstyle.gradient	= gradient;
			}
			else
			{
				focalGradient = new SWFFocalGradient();
				focalGradient.focalPoint = focalPointRatio;
				
				for (i = 0; i < gradientEntry.length; i++)
				{
					focalGradient.records.push(gradientEntry[i].export());
				}
				fillstyle.type	= 0x13;
				fillstyle.gradient	= focalGradient;
			}
			
			gradientMatrix 	= new SWFMatrix();
			gradientMatrix.matrix = matrix;
			
			fillstyle.gradientMatrix = gradientMatrix;
			
			return fillstyle;
			
		}
		
	}

}