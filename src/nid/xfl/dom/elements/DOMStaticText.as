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
	public class DOMStaticText implements IElement 
	{
		public static  var TYPE:uint = 1;
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
		public var textRecords:Vector.<SWFTextRecord>;
		public var displayText:TextField;
		private var yOffset:int;
		private var begin:Boolean;
		private var firstLine:Boolean;
		
		public function DOMStaticText(data:XML=null) 
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
				FontFactory.registerFont(textRuns[i].textAttrs.face,textRuns[i].characters);
			}
		}
		
		/**
		 * Publish 
		 */
		public function publish(tags:Vector.<ITag>,  property:Object):void
		{
			var recordLength:int = 0;
			var defineText:TagDefineText = new TagDefineText();
			
			var textBounds:SWFRectangle = new SWFRectangle();
				textBounds.xmin = 0
				textBounds.xmax = width * 20;
				textBounds.ymin = 0
				textBounds.ymax = height * 20;
			defineText.textBounds = textBounds;
			
			var textMatrix:SWFMatrix  = new SWFMatrix();
				defineText.textMatrix = textMatrix;
			
			
			/**
			 *  Setup text records
			 */
			property.yOffset 		= 0;
			textRecords 			= new Vector.<SWFTextRecord>();
			begin 					= true;
			firstLine 				= true;
			var newLine:Boolean 	= true;
			var nextLine:Boolean 	= false;
			var tWidth:int 			= 0;
			var tHeight:int 		= 0;
			var index:int 			= 0;
			var lineSpacing:Number	= 0;
			var initialRecord:SWFTextRecord;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				trace('textRuns['+i+']:'+textRuns[i].characters);
				var textLines:Array = textRuns[i].characters.split("%n%");
				
				lineSpacing = textRuns[i].textAttrs.lineSpacing;
				
				for (var j:int = 0; j < textLines.length; j++)
				{
					/**
					 * find if the current line string is empty or not,
					 * if empty next record will be a new line
					 */
					
					if (textLines[j].length != 0) 
					{
						var textRecord:SWFTextRecord = new SWFTextRecord();
							textRecord.index = index;
						/**
						 * check whether the record is first record , 
						 * new line record forwarded from previous record 
						 * or length of line string is greater than 1 
						 * if greater than one this must be a new line record
						 * */
						if (begin || nextLine || (textLines.length > 1  && j > 0))
						{
							
							updateInitialRecord(initialRecord, tWidth, tHeight, yOffset, lineSpacing);
							trace('new line:', begin, nextLine, yOffset);
							newLine 		= false;
							nextLine 		= false;
							tWidth			= 0;
							initialRecord 	= textRecord;
						}
						
						/**
						 * Set font
						 */
						textRecord.hasFont 	= true;
						textRecord.fontFace = textRuns[i].textAttrs.face;
						if (!FontFactory.isFontDefined(textRuns[i].textAttrs.face))
						{
							FontFactory.defineFont(textRuns[i].textAttrs.face, tags);
							textRecord.fontId 		= FontFactory.fontId(textRuns[i].textAttrs.face);
							property.characterId 	= XFLCompiler.characterId;
						}else { textRecord.fontId	= FontFactory.fontId(textRuns[i].textAttrs.face); }
						
						/**
						 * Set font color and font size
						 */
						textRecord.hasColor 	= true;
						textRecord.textColor 	= textRuns[i].textAttrs.fillColor;
						textRecord.textHeight 	= textRuns[i].textAttrs.bitmapSize;
						textRecord.alignment 	= textRuns[i].textAttrs.alignment;
						//trace('size:' + textRuns[i].textAttrs.bitmapSize);
						/**
						 * Set glyphs of the text record
						 */
						textRecord.glyphEntries = FontFactory.glyphEntries(textRuns[i].textAttrs.face, textLines[j], textRuns[i].textAttrs.size);
						
						tWidth += FontFactory.glyphsWidth(textRecord.glyphEntries);
						//tHeight = tHeight < textRecord.textHeight?textRecord.textHeight:tHeight;
						tHeight = textRecord.textHeight;
						
						/* tested ok */
						if ( i == textRuns.length - 1 && j == textLines.length - 1)
						{
							updateInitialRecord(initialRecord, tWidth, tHeight, yOffset, lineSpacing);
						}
						
						textRecords.push(textRecord);
						index++;
					}
					else
					{
						nextLine = true;
						
						if ( i == textRuns.length - 1 && j == textLines.length - 1)
						{
							updateInitialRecord(initialRecord, tWidth, tHeight, yOffset, lineSpacing);
						}
					}
				}
			}
			//trace('----textRecords----');
			//trace(textRecords);
			/**
			 * End text record setup
			 */
			//fixOffset();
			
			defineText.records 		= textRecords;
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
		
		private function updateInitialRecord(initialRecord:SWFTextRecord, tWidth:int, tHeight:int, _yOffset:int, _lineSpacing:Number):void
		{
			if (initialRecord != null)
			{
				initialRecord.hasXOffset = true;
				
				switch(initialRecord.alignment)
				{
					case "left":
					{
						initialRecord.xOffset = 0;
					}
					break;
					
					case "center":
					{
						initialRecord.xOffset = ((width * 20) / 2) - ( tWidth / 2);
						//trace('xOffset:' + initialRecord.xOffset, 'tWidth:' + tWidth, 'width:' + width);
					}
					break;
					
					case "right":
					{
						initialRecord.xOffset = (width * 20) - tWidth;
					}
					break;
				}
				var ascent:Number = FontFactory.ascent(initialRecord.fontFace, tHeight) + _yOffset;
				//trace('ascent:' + ascent);
				//initialRecord.yOffset += tHeight + _yOffset;
				initialRecord.hasYOffset = true;
				initialRecord.yOffset += ascent;
				initialRecord.yOffset += firstLine?0:FontFactory.descent(initialRecord.fontFace, tHeight);
				yOffset = initialRecord.yOffset;
				
				//trace('index :'+initialRecord.index,initialRecord);
				textRecords[initialRecord.index] = initialRecord;
				firstLine = false;
			}
			if (yOffset > 0) yOffset += (_lineSpacing * 20);
			begin = false;
		}
		
		
		protected function fixOffset():void
		{
			var recordObj:Object = { };
			var yOffset:int = 0;
			var tWidth:int = 0;
			var tHeight:int = 0;
			var index:int = 0;
			var begin:Boolean = true;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				
				for (var j:int = 0; j < textRuns[i].textRecords.length; j++)
				{
					
					//trace(textRuns[i].textRecords[j]);
					
					var main_end:Boolean = ((i == textRuns.length - 1) && (j == textRuns[i].textRecords.length - 1));
					var sub_end:Boolean = (j == textRuns[i].textRecords.length - 1);
					var isValidRecord:Boolean;
					
					if (textRuns[i].newLine || main_end || sub_end)
					{
						isValidRecord = true;
						
						if (main_end || sub_end)
						{
							if (textRuns[i].textRecords[j] != null)
							{
								recordObj.record = textRuns[i].textRecords[j];
								tWidth += FontFactory.glyphsWidth(textRuns[i].textRecords[j].glyphEntries);
								tHeight = (tHeight < textRuns[i].textRecords[j].textHeight)?(textRuns[i].textRecords[j].textHeight):tHeight;
							}
							else
							{
								delete recordObj.record;
								textRuns[i].textRecords.pop();
								isValidRecord = false;
							}
						}
						
						if (recordObj.record != undefined) 
						{
							switch(textRuns[i].textAttrs.alignment)
							{
								case "left":
								{
									recordObj.record.xOffset = 0;
								}
								break;
								
								case "center":
								{
									recordObj.record.xOffset = ((width * 20) / 2) - ( tWidth / 2);
									//trace('xOffset:' + recordObj.record.xOffset, 'tWidth:' + tWidth, 'width:' + width);
								}
								break;
								
								case "right":
								{
									recordObj.record.xOffset = (width * 20) - tWidth;
								}
								break;
							}
							
							recordObj.record.yOffset += tHeight + yOffset;
							recordObj.record.yOffset += FontFactory.ascent(textRuns[i].textAttrs.face, tHeight) + yOffset;
							recordObj.record.yOffset += begin?0:FontFactory.descent(textRuns[i].textAttrs.face, tHeight);
							
							//trace('yOffset:' + recordObj.record.yOffset, 'tHeight:' + tHeight, 'pyOffset:' + yOffset);
							
							if (recordObj.i != undefined)
							{
								textRuns[recordObj.i].textRecords[recordObj.j].xOffset = recordObj.record.xOffset;
								textRuns[recordObj.i].textRecords[recordObj.j].yOffset = recordObj.record.yOffset;
							}
							
							yOffset = recordObj.record.yOffset;
							tWidth = 0;
							begin = false;
						}
						
						if (isValidRecord)
						{
							recordObj.record = textRuns[i].textRecords[j];
							recordObj.i = i;
							recordObj.j = j;
							recordObj.tHeight = textRuns[i].textRecords[j].textHeight;
						}
					}
					
					if (isValidRecord)
					{
						tWidth += FontFactory.glyphsWidth(textRuns[i].textRecords[j].glyphEntries);
						tHeight = (tHeight < textRuns[i].textRecords[j].textHeight)?(textRuns[i].textRecords[j].textHeight):tHeight;
					}
				}
			}
			
			textRecords = new Vector.<SWFTextRecord>();
			
			for (var k:int = 0; k < textRuns.length; k++)
			{
				textRuns[k].update(textRecords);
			}
			//trace('textRecords:'+textRecords);
		}
		
		public function createDisplay():DisplayObject
		{			
			displayText = new TextField();
				//displayText.background = true;
				if (name != "") displayText.name = name;
				displayText.backgroundColor = 0xcccccc;
				displayText.selectable = false;
				displayText.multiline = true;
				displayText.wordWrap = false;
				displayText.width = width + 5;
				displayText.height = height + 5;
			
			displayText.transform.matrix = _matrix;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				textRuns[i].appendText(displayText);
			}
			
			return displayText;
		}
	}

}