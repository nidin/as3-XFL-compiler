package nid.xfl.dom.elements 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	import nid.xfl.compiler.factory.ElementFactory;
	import nid.xfl.compiler.swf.data.*;
	import nid.xfl.compiler.swf.exporters.*;
	import nid.xfl.compiler.swf.exporters.core.*;
	import nid.xfl.compiler.swf.tags.*;
	import nid.xfl.data.display.Color;
	import nid.xfl.data.graphics.*;
	import nid.xfl.dom.DOMDocument;
	import nid.xfl.interfaces.*;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMShape extends Sprite implements IElement
	{
		/**
		 * XFL Reference
		 */
		public var doc:DOMDocument;
		
		/**
		 * 
		 */
		public static  var TYPE:uint = 1;
		public function get type():uint { return TYPE; }
		
		public var shapeRecord:Vector.<SWFShapeRecord>;
		public var shapeBounds:SWFRectangle = new SWFRectangle();
		
		private var _characterId:uint=1;
		public function get characterId():uint { return _characterId; }
		public function set characterId(value:uint):void { _characterId = value; }
		
		public function get instanceName():String { return ElementFactory.NOT_SUPPORTED}
		public function set instanceName(value:String):void { }
		
		public function get libraryItemName():String { return ElementFactory.NOT_SUPPORTED; }
		public function set libraryItemName(value:String):void {  }
		
		protected var _matrix:Matrix;
		public function get matrix():Matrix { return _matrix; }
		public function set matrix(value:Matrix):void { _matrix = value; }
		
		protected var _color:Color;
		public function get color():Color{return _color}
		public function set color(value:Color):void { _color = value }
		
		public var strokes:Vector.<IStrokeStyle>;
		public var fills:Dictionary
		public var edges:Vector.<Edge>;
		public var edgeShapes:Vector.<EdgeShape>;
		public var edgeDictionary:Dictionary;
		public var SWFmatrix:SWFMatrix = new SWFMatrix();
		public var styleArray:Array;
		private var refX:Number=0;
		private var refY:Number = 0;
		private var isBitmapFill:Boolean;
		
		public function DOMShape(data:XML = null, refdoc:DOMDocument = null)
		{
			doc = refdoc;
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			//trace('DOMShape');
			/*
			 * SWF Elements
			 */
			
			_matrix = null;
			_matrix = new Matrix();
			
			_matrix.a = String(data.matrix.Matrix.@a) == ""?1:data.matrix.Matrix.@a;
			_matrix.b = String(data.matrix.Matrix.@b) == ""?0:data.matrix.Matrix.@b;
			_matrix.c = String(data.matrix.Matrix.@c) == ""?0:data.matrix.Matrix.@c;
			_matrix.d = String(data.matrix.Matrix.@d) == ""?1:data.matrix.Matrix.@d;
			_matrix.tx = String(data.matrix.Matrix.@tx) == ""?0:data.matrix.Matrix.@tx;
			_matrix.ty = String(data.matrix.Matrix.@ty) == ""?0:data.matrix.Matrix.@ty;
			
			var i:int = 0;
			/** 
			 * Parse Fills
			 */
			fills = null;
			fills = new Dictionary()
			
			for ( i = 0; i < data.fills.FillStyle.length(); i++)
			{
				if (data.fills.FillStyle[i].toString().indexOf("SolidColor") != -1)
				{
					fills[int(data.fills.FillStyle[i].@index)] = new SolidColor(data.fills.FillStyle[i]);
					if (TYPE < 3 && fills[int(data.fills.FillStyle[i].@index)].alpha != 1)TYPE = 3;
				}
				else if (data.fills.FillStyle[i].toString().indexOf("LinearGradient") != -1)
				{
					fills[int(data.fills.FillStyle[i].@index)] = new LinearGradient(data.fills.FillStyle[i]);
				}
				else if (data.fills.FillStyle[i].toString().indexOf("RadialGradient") != -1)
				{
					fills[int(data.fills.FillStyle[i].@index)] = new RadialGradient(data.fills.FillStyle[i]);
					//TYPE = fills[int(data.fills.FillStyle[i].@index)].focalPointRatio != 0?4:TYPE;
				}
				else if (data.fills.FillStyle[i].toString().indexOf("BitmapFill") != -1)
				{
					fills[int(data.fills.FillStyle[i].@index)] = new BitmapFill(data.fills.FillStyle[i], doc);
					BitmapFill(fills[int(data.fills.FillStyle[i].@index)]).matrix.concat(_matrix);
					isBitmapFill = true;
				}
			}
			fills.length = i;
			/**
			 * Parse Strokes
			 */
			strokes = null;
			strokes = new Vector.<IStrokeStyle>()
			
			for ( i = 0; i < data.strokes.StrokeStyle.length(); i++)
			{
				
				if (data.strokes.StrokeStyle[i].toString().indexOf("SolidStroke") != -1)
				{
					strokes.push(new SolidStroke(data.strokes.StrokeStyle[i]));
				}
				else if (data.strokes.StrokeStyle[i].toString().indexOf("DashedStroke") != -1)
				{
					strokes.push(new DashedStroke(data.strokes.StrokeStyle[i]));
				}
				else if (data.strokes.StrokeStyle[i].toString().indexOf("DottedStroke") != -1)
				{
					strokes.push(new DottedStroke(data.strokes.StrokeStyle[i]));
				}
				else if (data.strokes.StrokeStyle[i].toString().indexOf("StippleStroke") != -1)
				{
					strokes.push(new StippleStroke(data.strokes.StrokeStyle[i]));
				}
				else if (data.strokes.StrokeStyle[i].toString().indexOf("HatchedStroke") != -1)
				{
					strokes.push(new HatchedStroke(data.strokes.StrokeStyle[i]));
				}
				else if (data.strokes.StrokeStyle[i].toString().indexOf("RaggedStroke") != -1)
				{
					strokes.push(new RaggedStroke(data.strokes.StrokeStyle[i]));
				}
			}
			
			shapeRecord = new Vector.<SWFShapeRecord>();
			
			/**
			 * Parse Edges
			 */
			edges = null;
			edges = new Vector.<Edge>();
			styleArray = [];
			
			for (i = 0; i < data.edges.Edge.length(); i++)
			{
				edges.push(new Edge(data.edges.Edge[i], shapeRecord, shapeBounds, matrix));
			}
			shapeRecord.push(new SWFShapeRecordEnd());
			//createDisplay();
			
			
			for each (var fillStyles:* in fills)
			{
				trace('fillStyles:' + fillStyles);
			}
			
		}
		/**
		 * Create Display Object for Shape
		 */
		public function createDisplay():DisplayObject
		{
			var ex:ShapeExporter = new ShapeExporter(doc);
			export(ex);
			
			var hd:Sprite = new Sprite();
			hd.addChild(ex.shape)
			if (!isBitmapFill) hd.transform.matrix = _matrix;
			return hd;
		}
		
		/**
		 * SWF Data Generation
		 */
		public function publish(tags:Vector.<ITag>,  property:Object):void
		{
			var shapes:SWFShapeWithStyle = new SWFShapeWithStyle();
			
			for each (var fillStyles:* in fills)
			{
				if (fillStyles is IFillStyle)
				{
					trace(fillStyles);
					shapes.initialFillStyles.push(fillStyles.export(TYPE, tags, property));
					//trace('initialFillStyles.type:' + shapes.initialFillStyles[shapes.initialFillStyles.length - 1].type.toString(16));
				}
			}
			for each (var lineStyles:* in strokes)
			{
				if(lineStyles is IStrokeStyle)
				shapes.initialLineStyles.push(lineStyles.export());
			}
			//trace('shapeRecord:' + shapeRecord);
			
			shapes.records = shapeRecord;
			
			//trace('shape type:' + type);
			
			_characterId = property.characterId;
			
			//TYPE = 1;
			if (TYPE == 1)
			{
				var shape2tag:TagDefineShape = new TagDefineShape();
					shape2tag.characterId 	= _characterId;
					shape2tag.shapeBounds 	= shapeBounds;
					shape2tag.shapes 		= shapes;
				tags.push(shape2tag);
			}
			else if (TYPE == 3)
			{
				var shape3tag:TagDefineShape3 = new TagDefineShape3();
					shape3tag.characterId 	= _characterId;
					shape3tag.shapeBounds 	= shapeBounds;
					shape3tag.shapes 		= shapes;
				tags.push(shape3tag);
			}
			else if (TYPE == 4)
			{
				var shape4tag:TagDefineShape4 = new TagDefineShape4();
					shape4tag.characterId 	= _characterId;
					shape4tag.shapeBounds 	= shapeBounds;
					shape4tag.edgeBounds 	= shapeBounds;
					shape4tag.shapes 		= shapes;
				tags.push(shape4tag);
			}
		}
		
		/**
		 * Export Shape
		 */
		public function export(handler:IShapeExporter = null):void
		{
			var shapes:SWFShapeWithStyle = new SWFShapeWithStyle();
			
			for each (var fillStyles:* in fills)
			{
				if(fillStyles is IFillStyle)
				shapes.initialFillStyles.push(fillStyles.export(TYPE));
			}
			
			for each (var lineStyles:* in strokes)
			{
				if(lineStyles is IStrokeStyle)
				shapes.initialLineStyles.push(lineStyles.export());
			}
			
			shapes.records = shapeRecord;
			shapes.export(handler);
			
			return;
		}
		/**
		 * Save modifications
		 */
		public function save():void
		{
			
		}
	}
}