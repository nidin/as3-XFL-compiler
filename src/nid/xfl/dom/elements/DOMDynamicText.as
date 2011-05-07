package nid.xfl.dom.elements 
{
	import flash.display.*;
	import flash.geom.*;
	import flash.text.*;
	import nid.utils.*;
	import nid.xfl.compiler.factory.ElementFactory;
	import nid.xfl.compiler.swf.tags.*;
	import nid.xfl.data.display.Color;
	import nid.xfl.dom.*;
	import nid.xfl.interfaces.*;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMDynamicText implements IElement 
	{
		public static  var TYPE:uint = 2;
		public function get type():uint { return TYPE; }
		
		public var _characterId:uint=1;
		public function get characterId():uint { return _characterId; }
		public function set characterId(value:uint):void { _characterId = value; }
		
		public function get libraryItemName():String { return ElementFactory.NOT_SUPPORTED; }
		public function set libraryItemName(value:String):void {  }
		
		protected var _matrix:Matrix;
		public function get matrix():Matrix { return _matrix; }
		public function set matrix(value:Matrix):void { _matrix = value; }
		
		protected var _color:Color;
		public function get color():Color{return _color}
		public function set color(value:Color):void { _color = value }
		
		public var name:String;
		public var selected:Boolean;
		public var left:Number;
		public var width:Number;
		public var height:Number;
		public var isSelectable:Boolean;
		public var textRuns:Vector.<DOMTextRun>;
		
		public function DOMDynamicText(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{			
			name 			= String(data.@name);
			selected 		= Boolean2.toBoolean(data.@selected);
			left 			= data.@left;
			width 			= data.@width;
			height 			= data.@height;
			isSelectable 	= Boolean2.toBoolean(data.@isSelectable);
			
			_matrix = null;
			_matrix = new Matrix();
			
			_matrix.a = String(data.matrix.Matrix.@a) == ""?1:data.matrix.Matrix.@a;
			_matrix.b = String(data.matrix.Matrix.@b) == ""?0:data.matrix.Matrix.@b;
			_matrix.c = String(data.matrix.Matrix.@c) == ""?0:data.matrix.Matrix.@c;
			_matrix.d = String(data.matrix.Matrix.@d) == ""?1:data.matrix.Matrix.@d;
			_matrix.tx = String(data.matrix.Matrix.@tx) == ""?0:data.matrix.Matrix.@tx;
			_matrix.ty = String(data.matrix.Matrix.@ty) == ""?0:data.matrix.Matrix.@ty;
			
			_matrix.tx += left;
			
			textRuns = null;
			textRuns = new Vector.<DOMTextRun>();
			
			for (var i:int = 0; i < data.textRuns.DOMTextRun.length(); i++)
			{
				textRuns.push(new DOMTextRun(data.textRuns.DOMTextRun[i]));
			}
		}
		public function publish(tags:Vector.<ITag>, property:Object):void
		{
			
		}
		public function createDisplay():DisplayObject
		{
			var txt:TextField = new TextField();
				//txt.background = true;
				txt.type = TextFieldType.DYNAMIC;
				if (name != "") txt.name = name;
				txt.backgroundColor = 0xcccccc;
				txt.selectable = false;		
				txt.width = width;
				txt.height = height + 5;
				txt.x = left;
			
			txt.transform.matrix = _matrix;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				textRuns[i].appendText(txt);
			}
			
			return txt;
		}
	}

}