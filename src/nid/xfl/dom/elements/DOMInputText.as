package nid.xfl.dom.elements 
{
	import flash.display.*;
	import flash.geom.*;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import nid.utils.*;
	import nid.xfl.compiler.factory.ElementFactory;
	import nid.xfl.compiler.swf.tags.*;
	import nid.xfl.data.display.Color;
	import nid.xfl.dom.DOMTextRun;
	import nid.xfl.interfaces.*;
	import nid.xfl.utils.SaveUtils;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class DOMInputText implements IElement 
	{
		public static  var TYPE:uint = 3;
		public function get type():uint { return TYPE; }
		
		public var _characterId:uint=1;
		public function get characterId():uint { return _characterId; }
		public function set characterId(value:uint):void { _characterId = value; }
		
		protected var _instanceName:String;
		public function get instanceName():String { return _instanceName; }
		public function set instanceName(value:String):void { _instanceName = value; }
		
		public function get libraryItemName():String { return ElementFactory.NOT_SUPPORTED; }
		public function set libraryItemName(value:String):void {  }
		
		protected var _matrix:Matrix;
		public function get matrix():Matrix { return _matrix; }
		public function set matrix(value:Matrix):void { _matrix = value; }
		
		protected var _color:Color;
		public function get color():Color{return _color}
		public function set color(value:Color):void { _color = value }
		
		public var name:String;
		public var left:Number;
		public var width:Number;
		public var height:Number;
		public var border:Boolean;
		public var lineType:String;
		public var selected:Boolean;
		public var displayText:TextField;
		public var fontRenderingMode:String;
		public var textRuns:Vector.<DOMTextRun>;
		
		public function DOMInputText(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{			
			name 		= String(data.@name);
			left 		= data.@left;
			width 		= data.@width;
			height 		= data.@height;
			border 		= Boolean2.toBoolean(data.@border);
			lineType 	= data.@lineType;
			selected 	= Boolean2.toBoolean(data.@selected);
			fontRenderingMode 	= String(data.@fontRenderingMode);
			
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
		public function publish(tags:Vector.<ITag>,  property:Object):void
		{
			
		}
		public function createDisplay():DisplayObject
		{
			displayText = new TextField();
				displayText.border = border;
				displayText.type = TextFieldType.INPUT;
				if (name != "") displayText.name = name;
				displayText.backgroundColor = 0xffffff;
				displayText.selectable = false;		
				displayText.width = width;
				displayText.height = height + 5;
				displayText.x = left;
			
			displayText.transform.matrix = _matrix;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				textRuns[i].appendText(displayText);
			}
			
			return displayText;
		}
		/**
		 * Save modifications
		 */
		public function save():void
		{
			textRuns = null;
			textRuns =  SaveUtils.updateTextRun(displayText);
		}
		/**
		 * Export 
		 */
		public function export():void
		{
			//TODO: export xml string 
		}
	}

}