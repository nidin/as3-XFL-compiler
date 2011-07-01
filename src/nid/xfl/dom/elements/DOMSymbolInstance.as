package nid.xfl.dom.elements 
{
	import flash.display.*;
	import flash.geom.*;
	import nid.utils.*;
	import nid.xfl.compiler.swf.data.SWFButtonRecord;
	import nid.xfl.compiler.swf.data.SWFSymbol;
	import nid.xfl.compiler.swf.tags.*;
	import nid.xfl.core.Button2;
	import nid.xfl.core.TimeLine;
	import nid.xfl.data.display.*;
	import nid.xfl.data.filters.*;
	import nid.xfl.dom.*;
	import nid.xfl.interfaces.*;
	import nid.xfl.XFLCompiler;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMSymbolInstance extends Sprite  implements IElement 
	{
		/**
		 * XFL Reference
		 */
		public var doc:DOMDocument;
		
		/**
		 * 
		 */
		public static  var TYPE:uint = 5;
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
		
		public var symbolType:String;
		public var loop:String;
		public var selected:Boolean;
		
		//TODO: public var matrix3D:Matrix3D;
		public var centerPoint3DX:Number;
		public var centerPoint3DY:Number;
		public var centerPoint3DZ:Number;
		
		public var transformationPoint:Point;
		public var _filters:Vector.<IXFilter>;
		public var symbolItem:DOMSymbolItem;
		public var timeline:TimeLine;
		public var button:Button2;
		public var qName:String;
		public var instanceName:String;
		
		public function DOMSymbolInstance(data:XML,refdoc:DOMDocument) 
		{	
			doc = refdoc;
			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			
			instanceName 	= String(data.@name);
			symbolType 		= data.@symbolType;
			libraryItemName = data.@libraryItemName;
			centerPoint3DX 	= data.@centerPoint3DX;
			centerPoint3DY 	= data.@centerPoint3DY;
			loop 			= data.@loop;
			selected 		= Boolean2.toBoolean(data.@selected);
			
			qName			= libraryItemName.replace(/[ ]/g, "");
			if(qName.indexOf("-") != -1)
			qName			= qName.substring(0, qName.indexOf("-"));
			
			color = new Color();
			color.alphaMultiplier =  String(data.color.Color.@alphaMultiplier) == ""?1:data.color.Color.@alphaMultiplier;
			
			_matrix = null;
			_matrix = new Matrix();
			
			_matrix.a = String(data.matrix.Matrix.@a) == ""?1:data.matrix.Matrix.@a;
			_matrix.b = String(data.matrix.Matrix.@b) == ""?0:data.matrix.Matrix.@b;
			_matrix.c = String(data.matrix.Matrix.@c) == ""?0:data.matrix.Matrix.@c;
			_matrix.d = String(data.matrix.Matrix.@d) == ""?1:data.matrix.Matrix.@d;
			_matrix.tx = String(data.matrix.Matrix.@tx) == ""?0:data.matrix.Matrix.@tx;
			_matrix.ty = String(data.matrix.Matrix.@ty) == ""?0:data.matrix.Matrix.@ty;
			_matrix.transformPoint(new Point(centerPoint3DX, centerPoint3DY));
			
			/**
			 * TODO: 3D TRANSFORMATION
			 */
			//var mat3d:Array = String(data.@matrix3D).split(" ");
			//
			//matrix3D = new Matrix3D();
			//matrix3D.appendTranslation(mat3d[12], mat3d[13], mat3d[14]);
			//
			//rotationX = data.@rotationX;
			//rotationY = data.@rotationY;
			//rotationZ = data.@rotationZ;
			
			transformationPoint = new Point(data.transformationPoint.Point.@x, data.transformationPoint.Point.@y);
			
			_filters = new Vector.<IXFilter>();
			
			for (var i:int = 0; i < data.filters.*.length(); i++)
			{
				if (data.filters.*[i].toXMLString().indexOf("BlurFilter") != -1)
				{
					_filters.push(new XFilterBlur(data.filters.*[i]));
				}
				else if (data.filters.*[i].toXMLString().indexOf("DropShadowFilter") != -1)
				{
					_filters.push(new XFilterDropShadow(data.filters.*[i]));
				}
				else if (data.filters.*[i].toXMLString().indexOf("GlowFilter") != -1)
				{
					_filters.push(new XFilterGlow(data.filters.*[i]));
				}
				else if (data.filters.*[i].toXMLString().indexOf("BevelFilter") != -1)
				{
					_filters.push(new XFilterBevel(data.filters.*[i]));
				}
				else if (data.filters.*[i].toXMLString().indexOf("GradientGlowFilter") != -1)
				{
					_filters.push(new XFilterGradientGlow(data.filters.*[i]));
				}
				else if (data.filters.*[i].toXMLString().indexOf("GradientBevelFilter") != -1)
				{
					_filters.push(new XFilterGradientBevel(data.filters.*[i]));
				}
				else if (data.filters.*[i].toXMLString().indexOf("AdjustColorFilter") != -1)
				{
					_filters.push(new XFilterAdjustColor(data.filters.*[i]));
				}
			}
			
			symbolItem = new DOMSymbolItem(libraryItemName, doc );
			
			if (symbolType == "button")
			{
				button = new Button2(null, doc);
			}
			else
			{
				timeline = new TimeLine(null, doc);
			}
			
		}
		public function scan():void
		{
			if (symbolType == "button")
			{
				button.scan();
			}
			else
			{
				timeline.scan();
			}
		}
		public function publish(tags:Vector.<ITag>, property:Object):void
		{
			var _property:Object = { p_depth:property.p_depth +'_' + String(property.depth), depth:1, docName:property.docName };
			
			_property.frameScriptPool = [];
			
			var sub_tags:Vector.<ITag> = new Vector.<ITag>();
			
			switch(symbolType)
			{
				case "button":
				{
					var characters:Vector.<SWFButtonRecord> = button.publish(tags, _property, sub_tags);
					
					var defineButton2:TagDefineButton2 	= new TagDefineButton2();
						defineButton2.characterId 		= XFLCompiler.characterId;
						defineButton2.characters		= characters;
					tags.push(defineButton2);
				}
				break;
				
				case "graphics":
				{
					//TODO: cast movie clip to shape
				}
				break;
				
				default:
				{					
					timeline.publish(tags, _property, sub_tags);
					
					_property.tagId = XFLCompiler.characterId;
					
					buildScriptPool(_property);
					
					var defineSprite:TagDefineSprite = new TagDefineSprite();
						defineSprite.frameCount 	 = timeline.totalFrames;
						defineSprite.characterId 	 = XFLCompiler.characterId;
						defineSprite.tags 			 = sub_tags;
					tags.push(defineSprite);
				}
				break;
			}
			
			property.characterId = XFLCompiler.characterId;
			
			XFLCompiler.characterId++;
		}
		
		private function buildScriptPool(property:Object):void
		{
			if (property.frameScriptPool.length > 0)
			{
				if (!XFLCompiler.findSymbol(property.docName + '_fla.' + qName))
				{
					XFLCompiler.SymbolClass.symbols.push(SWFSymbol.create(property.tagId, property.docName + '_fla.' + qName));
				}
				
				XFLCompiler.abcGenerator.addSymbolClass(property.docName + '_fla',qName, property.frameScriptPool);
			}
		}
		
		public function createDisplay():DisplayObject
		{
			if (symbolType == "button")
			{
				button.construct(symbolItem);
				button.instanceName 	= name;
				button._filters 		= _filters;
				button.transform.matrix = matrix;
				return button;
			}
			else
			{
				timeline.construct(symbolItem);
				timeline.instanceName 	  = name;
				timeline._filters 		  = _filters;
				timeline.matrix 		  = matrix;
				timeline.centerPoint3DX   = centerPoint3DX; 
				timeline.centerPoint3DY   = centerPoint3DY; 
				timeline.centerPoint3DZ   = centerPoint3DZ; 
				return timeline;
			}
			
			return null;
		}
	}

}