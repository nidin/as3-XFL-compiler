package nid.xfl.compiler.swf.exporters 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.InterpolationMethod;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import nid.xfl.compiler.swf.exporters.core.IShapeExporter;
	import nid.xfl.dom.DOMDocument;
	import nid.xfl.utils.Convertor;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class ShapeExporter implements IShapeExporter
	{
		public var shape:Sprite;
		public var doc:DOMDocument;
		
		public function ShapeExporter(refdoc:DOMDocument=null)
		{
			doc = refdoc;
			shape = new Sprite();
		}
		public function getShape():Sprite
		{
			return shape;
		}
		public function beginShape():void 
		{
			
		}
		public function endShape():void 
		{
			
		}
		public function beginFills():void 
		{
			
		}
		public function endFills():void 
		{
			
		}
		public function beginLines():void 
		{
			
			
		}
		public function endLines():void 
		{
			
		}
		
		public function beginFill(color:uint, alpha:Number = 1.0):void 
		{
			shape.graphics.beginFill(color, alpha);
		}
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void 
		{
			shape.graphics.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		public function beginBitmapFill(bitmapId:uint, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void 
		{
			shape.graphics.beginBitmapFill(doc.media.getBitmapById(bitmapId).bitmapData, matrix, repeat, smooth);
		}
		public function endFill():void 
		{
			shape.graphics.endFill();
		}
		
		public function lineStyle(thickness:Number = 0, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, startCaps:String = null, endCaps:String = null, joints:String = null, miterLimit:Number = 3):void 
		{
			shape.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, startCaps, joints, miterLimit);
		}
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void 
		{
			shape.graphics.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}

		public function moveTo(x:Number, y:Number):void 
		{
			//trace('graphics.moveTo(', x, ',', y, ')');
			shape.graphics.moveTo(x, y);
		}
		public function lineTo(x:Number, y:Number):void 
		{
			//trace('graphics.lineTo(', x, ',', y, ')');
			shape.graphics.lineTo(x, y);
		}
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void 
		{
			shape.graphics.curveTo(controlX, controlY, anchorX, anchorY);
		}
	}

}