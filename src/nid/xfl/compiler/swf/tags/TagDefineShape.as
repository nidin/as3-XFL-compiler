package nid.xfl.compiler.swf.tags
{
	import nid.xfl.compiler.swf.SWFData;
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.data.SWFShapeWithStyle;
	import nid.xfl.compiler.swf.exporters.core.IShapeExporter;
	
	public class TagDefineShape implements IDefinitionTag
	{
		public static const TYPE:uint = 2;
		
		public var shapeBounds:SWFRectangle;
		public var shapes:SWFShapeWithStyle;
		
		public var _level:int = 1;
		
		protected var _characterId:uint;
		
		public function TagDefineShape() {}
		
		public function get characterId():uint { return _characterId; }
		public function set characterId(value:uint):void { _characterId = value; }
		
		public function parse(data:SWFData, length:uint, version:uint, async:Boolean = false):void {
			_characterId = data.readUI16();
			shapeBounds = data.readRECT();
			shapes = data.readSHAPEWITHSTYLE(level);
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeRECT(shapeBounds);
			body.writeSHAPEWITHSTYLE(shapes, level);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		public function clone():IDefinitionTag {
			var tag:TagDefineShape = new TagDefineShape();
			throw(new Error("Not implemented yet."));
			return tag;
		}
		
		public function export(handler:IShapeExporter = null):void {
			shapes.export(handler);
		}
		
		public function get type():uint { return TYPE; }
		public function get name():String { return "DefineShape"; }
		public function get version():uint { return 1; }
		public function get level():uint { return _level; }

		public function toString(indent:uint = 0):String {
			var str:String = Tag.toStringCommon(type, name, indent) +
				"ID: " + characterId + ", " +
				"Bounds: " + shapeBounds;
			str += shapes.toString(indent + 2);
			return str;
		}
	}
}
