package nid.xfl.data.graphics 
{
	import flash.geom.Matrix;
	import nid.xfl.compiler.swf.data.SWFFillStyle;
	import nid.xfl.compiler.swf.data.SWFGradient;
	import nid.xfl.compiler.swf.data.SWFMatrix;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.interfaces.IFillStyle;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class LinearGradient extends FillStyle implements IFillStyle 
	{
		public var type:String = "LinearGradient";
		public var matrix:Matrix;
		public var gradientEntry:Vector.<GradientEntry>;
		public var gradient:SWFGradient;
		public var gradientMatrix:SWFMatrix;
		
		private var _color:uint;
		public function get color():uint { return _color; }
		public function set color(value:uint):void { _color = value; }
		
		private var _alpha:Number = 1;
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void { _alpha = value; }
		
		public function LinearGradient(data:XML=null)
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			index = data.@index;
			matrix = null;
			matrix = new Matrix(	data.LinearGradient.matrix.Matrix.@a,
									data.LinearGradient.matrix.Matrix.@b,
									data.LinearGradient.matrix.Matrix.@c,
									data.LinearGradient.matrix.Matrix.@d,
									data.LinearGradient.matrix.Matrix.@tx,
									data.LinearGradient.matrix.Matrix.@ty);
			gradientEntry = null;
			gradientEntry = new Vector.<GradientEntry>();
			
			for (var i:int = 0; i < data.LinearGradient.GradientEntry.length(); i++)
			{
				gradientEntry.push(new GradientEntry(data.LinearGradient.GradientEntry[i]));
			}
		}
		public function export(_type:int,tags:Vector.<ITag>=null, property:Object = null):SWFFillStyle
		{
			gradient = new SWFGradient();
			
			for (var i:int = 0; i < gradientEntry.length; i++)
			{
				gradient.records.push(gradientEntry[i].export());
			}
			
			gradientMatrix 	= new SWFMatrix();
			gradientMatrix.matrix = matrix;
			
			var fillstyle:SWFFillStyle   = new SWFFillStyle();
				fillstyle.type 			 = 0x10;
				fillstyle.gradient 		 = gradient;
				fillstyle.gradientMatrix = gradientMatrix;
			
			return fillstyle;
		}
		
	}

}