package nid.xfl.dom.elements 
{
	import flash.display.*;
	import flash.geom.*;
	import flash.text.*;
	import nid.utils.*;
	import nid.xfl.compiler.factory.ElementFactory;
	import nid.xfl.compiler.factory.FontFactory;
	import nid.xfl.compiler.swf.data.SWFMatrix;
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.data.SWFTextRecord;
	import nid.xfl.compiler.swf.tags.*;
	import nid.xfl.data.display.Color;
	import nid.xfl.dom.*;
	import nid.xfl.interfaces.*;
	import nid.xfl.XFLCompiler;
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
		public function publish(tags:Vector.<ITag>,  property:Object):void
		{
			var recordLength:int = 0;
			var defineText:TagDefineEditText = new TagDefineEditText();
			
			var textBounds:SWFRectangle = new SWFRectangle();
				textBounds.xmin = 0
				textBounds.xmax = width * 20;
				textBounds.ymin = 0
				textBounds.ymax = height * 20;
			defineText.bounds = textBounds;
			
			/**
			 *  Setup text records
			 */
			property.yOffset 		= 0;
			var newLine:Boolean 	= true;
			var nextLine:Boolean 	= false;
			var tWidth:int 			= 0;
			var tHeight:int 		= 0;
			var index:int 		= 0;
			var initialText:String;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				var textLines:Array = textRuns[i].characters.split("%n%");
				
				for (var j:int = 0; j < textLines.length; j++)
				{
					if (textLines[j].length != 0) // find if the current line string is empty or not if empty next record will be a new line
					{
						
						initialText += '<p align="' + textRuns[i].textAttrs.alignment + '">' +
									'<font face="' + textRuns[i].textAttrs.face + 
										'" size="' + textRuns[i].textAttrs.size + 
										'" letterSpacing="' + textRuns[i].textAttrs.lineSpacing + 
										'" kerning="1'+ 
										'" color="' + textRuns[i].textAttrs.fillColor + '">';
						initialText += textLines[j];
						initialText += '</font></p>';
						
						/**
						 * Set font
						 */
						if (!FontFactory.isFontDefined(textRuns[i].textAttrs.face))
						{
							//FontFactory.defineFont(textRuns[i].textAttrs.face, tags);
							//property.characterId 	= XFLCompiler.characterId;
						}
						
						index++;
					}
					else
					{
						nextLine = true;
					}
				}
				
			}
			//trace('----textRecords----');
			//trace(textRecords);
			/**
			 * End text record setup
			 */
			//fixOffset();
			
			defineText.initialText = initialText;
			defineText.characterId 	= property.characterId;
			
			tags.push(defineText);
			
			var CSMTextSettings:TagCSMTextSettings = new TagCSMTextSettings();
				CSMTextSettings.textId 			= defineText.characterId;
				CSMTextSettings.useFlashType 	= 1;
				CSMTextSettings.gridFit 		= 2;
				CSMTextSettings.thickness 		= 0;
				CSMTextSettings.sharpness 		= 0;
				
			//tags.push(CSMTextSettings);
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