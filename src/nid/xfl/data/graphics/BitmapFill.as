package nid.xfl.data.graphics 
{
	import flash.geom.Matrix;
	import nid.xfl.compiler.swf.data.SWFFillStyle;
	import nid.xfl.compiler.swf.data.SWFMatrix;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.dom.DOMDocument;
	import nid.xfl.interfaces.IFillStyle;
	import nid.xfl.utils.Convertor;
	import nid.utils.Boolean2;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class BitmapFill extends FillStyle implements IFillStyle 
	{
		/**
		 * XFL Reference
		 */
		public var doc:DOMDocument;
		
		/**
		 * 
		 */
		public var bitmapPath:String;
		public var bitmapIsClipped:Boolean;
		public var matrix:Matrix;
		
		private var _color:uint;
		public function get color():uint { return _color; }
		public function set color(value:uint):void { _color = value; }		
		
		private var _alpha:Number = 1;
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void { _alpha = value; }
		
		public function BitmapFill(data:XML,refdoc:DOMDocument) 
		{
			doc = refdoc;
			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			index = data.@index;
			bitmapPath = data.BitmapFill.@bitmapPath;
			bitmapIsClipped = Boolean2.toBoolean(data.BitmapFill.@bitmapIsClipped);
			
			matrix = null;
			matrix = new Matrix();
			
			matrix.a = String(data.BitmapFill.matrix.Matrix.@a) == ""?20:data.BitmapFill.matrix.Matrix.@a;
			matrix.b = String(data.BitmapFill.matrix.Matrix.@b) == ""?0:data.BitmapFill.matrix.Matrix.@b;
			matrix.c = String(data.BitmapFill.matrix.Matrix.@c) == ""?0:data.BitmapFill.matrix.Matrix.@c;
			matrix.d = String(data.BitmapFill.matrix.Matrix.@d) == ""?20:data.BitmapFill.matrix.Matrix.@d;
			matrix.tx = String(data.BitmapFill.matrix.Matrix.@tx) == ""?0:data.BitmapFill.matrix.Matrix.@tx;
			matrix.ty = String(data.BitmapFill.matrix.Matrix.@ty) == ""?0:data.BitmapFill.matrix.Matrix.@ty;
			
		}
		public function export(_type:int, tags:Vector.<ITag> = null, property:Object = null):SWFFillStyle
		{
			var fillstyle:SWFFillStyle = new SWFFillStyle();
				fillstyle.type = 0x42;
				
				if (tags == null)
				fillstyle.bitmapId = doc.media.getBitmapId(bitmapPath);
				else 
				fillstyle.bitmapId = doc.media.defineBitmap(bitmapPath, tags, property );
				
				fillstyle.bitmapMatrix = Convertor.toSWFMatrix(matrix);
			
			trace('fillstyle.bitmapId:' + fillstyle.bitmapId);
			//trace('bitmapMatrix:' + fillstyle.bitmapMatrix);
			
			return fillstyle;
		}
		
	}

}