package nid.xfl.dom.elements 
{
	import flash.display.*;
	import flash.geom.*;
	import nid.utils.*;
	import nid.xfl.compiler.swf.data.consts.BitmapFormat;
	import nid.xfl.compiler.swf.data.consts.BitmapType;
	import nid.xfl.compiler.swf.data.SWFFillStyle;
	import nid.xfl.compiler.swf.data.SWFMatrix;
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.data.SWFShapeRecord;
	import nid.xfl.compiler.swf.data.SWFShapeWithStyle;
	import nid.xfl.compiler.swf.tags.*;
	import nid.xfl.data.bitmap.BitmapShape;
	import nid.xfl.data.display.Color;
	import nid.xfl.dom.DOMBitmapItem;
	import nid.xfl.dom.DOMDocument;
	import nid.xfl.interfaces.*;
	import nid.xfl.utils.Convertor;
	import nid.xfl.XFLCompiler;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMBitmapInstance implements IElement
	{
		/**
		 * XFL Reference
		 */
		public var doc:DOMDocument;
		
		/**
		 * Properties
		 */
		public static  var TYPE:uint = 6;
		public function get type():uint { return TYPE; }
		
		protected var _characterId:uint=1;
		public function get characterId():uint { return _characterId; }
		public function set characterId(value:uint):void { _characterId = value; }
		
		protected var _libraryItemName:String;
		public function get libraryItemName():String { return _libraryItemName; }
		public function set libraryItemName(value:String):void { _libraryItemName = value; }
		
		protected var _matrix:Matrix;
		public function get matrix():Matrix { return _matrix; }
		public function set matrix(value:Matrix):void { _matrix = value; }
		
		protected var _color:Color;
		public function get color():Color{return _color}
		public function set color(value:Color):void { _color = value }
		
		public var name:String;
		public var referenceID:String;
		public var centerPoint3DX:Number;
		public var centerPoint3DY:Number;
		public var transformationPoint:Point;
		public var selected:Boolean;
		
		public function DOMBitmapInstance(data:XML,refdoc:DOMDocument) 
		{	
			doc = refdoc;
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{			
			name 			= data.@name;
			libraryItemName = data.@libraryItemName;
			referenceID 	= data.@referenceID;
			selected 		= Boolean2.toBoolean(data.@selected);
			
			_matrix = null;
			_matrix = new Matrix();
			
			_matrix.a = String(data.matrix.Matrix.@a) 	== ""?1:data.matrix.Matrix.@a;
			_matrix.b = String(data.matrix.Matrix.@b) 	== ""?0:data.matrix.Matrix.@b;
			_matrix.c = String(data.matrix.Matrix.@c) 	== ""?0:data.matrix.Matrix.@c;
			_matrix.d = String(data.matrix.Matrix.@d) 	== ""?1:data.matrix.Matrix.@d;
			_matrix.tx = String(data.matrix.Matrix.@tx)	== ""?0:data.matrix.Matrix.@tx;
			_matrix.ty = String(data.matrix.Matrix.@ty) == ""?0:data.matrix.Matrix.@ty;
			
			transformationPoint = new Point(data.transformationPoint.Point.@x, data.transformationPoint.Point.@y);
			
		}
		public function publish(tags:Vector.<ITag>,property:Object):void
		{
			
			var bitmapItem:DOMBitmapItem 	= doc.media.bitmaps[libraryItemName];
			var shapeBounds:SWFRectangle 	= new SWFRectangle();
			var shapes:SWFShapeWithStyle 	= new SWFShapeWithStyle();
			var fillstyle1:SWFFillStyle 	= new SWFFillStyle();
			var fillstyle2:SWFFillStyle 	= new SWFFillStyle();
			var shapetag:TagDefineShape 	= new TagDefineShape();
			var placeObject:TagPlaceObject2 = new TagPlaceObject2();
			
			var records:Vector.<SWFShapeRecord> = BitmapShape.createBitmapShapeRecord(bitmapItem.bitmap.width, bitmapItem.bitmap.height);
			
			shapes.records = records;
			
			shapeBounds.xmin = 0;
			shapeBounds.xmax = bitmapItem.bitmap.width * 20;
			shapeBounds.ymin = 0;
			shapeBounds.ymax = bitmapItem.bitmap.height * 20;
			
			
			var bitmapMatrix:SWFMatrix = new SWFMatrix();
			bitmapMatrix.scaleX  	= 20;
			bitmapMatrix.scaleY  	= 20;
			
			fillstyle1.type 		= bitmapItem.allowSmoothing?0x41:0x43;
			fillstyle1.bitmapId 	= 65535;
			fillstyle1.bitmapMatrix = bitmapMatrix;		
			
			fillstyle2.type 		= bitmapItem.allowSmoothing?0x41:0x43;
			fillstyle2.bitmapId 	= property.characterId;
			fillstyle2.bitmapMatrix = bitmapMatrix;
			
			if (bitmapItem.isJPEG)
			{
				var defineJPEG2:TagDefineBitsJPEG2 = new TagDefineBitsJPEG2();
				defineJPEG2.characterId = property.characterId;
				defineJPEG2.bitmapType	= BitmapType.JPEG;
				defineJPEG2.bitmapData 	= bitmapItem.bitmapData;
				tags.push(defineJPEG2);
			}
			else if (bitmapItem.compressionType == "lossless")
			{
				var defineBitsLossless2:TagDefineBitsLossless2 = new TagDefineBitsLossless2();
				defineBitsLossless2.characterId 	= property.characterId;
				defineBitsLossless2.bitmapFormat 	= BitmapFormat.BIT_32;
				defineBitsLossless2.bitmapWidth 	= bitmapItem.bitmap.width;
				defineBitsLossless2.bitmapHeight 	= bitmapItem.bitmap.height;
				defineBitsLossless2.zlibBitmapData 	= bitmapItem.bitmapData;
				defineBitsLossless2.bitmapColorTableSize 	= 0;
				tags.push(defineBitsLossless2);
			}
			else
			{
				var defineJPEG3:TagDefineBitsJPEG3 = new TagDefineBitsJPEG3();
				defineJPEG3.characterId 	= property.characterId;
				defineJPEG3.bitmapType		= BitmapType.PNG;
				defineJPEG3.bitmapData 		= bitmapItem.bitmapData;
				defineJPEG3.bitmapAlphaData = bitmapItem.bitmapAlphaData;
				tags.push(defineJPEG3);
			}
			
			property.characterId = ++XFLCompiler.characterId;
			_characterId = property.characterId;
			
			shapes.initialFillStyles.push(fillstyle1);
			shapes.initialFillStyles.push(fillstyle2);
			
			shapetag.characterId 	= _characterId;
			shapetag.shapeBounds 	= shapeBounds;
			shapetag.shapes 		= shapes;
			
			tags.push(shapetag);
			
			placeObject.characterId 	= property.characterId;
			placeObject.depth 			= property.depth;
			placeObject.hasMatrix 		= true;
			placeObject.hasCharacter 	= true;
			placeObject.matrix 			= Convertor.toSWFMatrix(matrix);
			
			XFLCompiler.elementLibrary[property.characterId] = this;
			
		}
		public function createDisplay():DisplayObject
		{
			var bmp:Bitmap = doc.media.getBitmapByName(libraryItemName);
			
			if (bmp == null)
			{
				trace('Image:'+libraryItemName+' - not found in zip file');
				return new Sprite();
			}
			else
			{
				var bmp_data:BitmapData = bmp.bitmapData.clone();
				var bitmap:Bitmap = new Bitmap(bmp_data);
				bitmap.transform.matrix = _matrix;
				bitmap.name = name;
				return bitmap;
			}
			return new Sprite();
		}
	}

}