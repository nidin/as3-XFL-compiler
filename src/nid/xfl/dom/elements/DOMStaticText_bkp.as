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
	import nid.xfl.data.display.FrameElement;
	import nid.xfl.data.text.FontObject;
	import nid.xfl.dom.*;
	import nid.xfl.interfaces.*;
	import nid.xfl.XFLCompiler;
	/**
	 * ...
	 * @author Nidin Vinayak
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
		
		public var selected:Boolean;
		public var left:Number;
		public var width:Number;
		public var height:Number;
		public var isSelectable:Boolean;
		public var textRuns:Vector.<DOMTextRun>;
		public var textRecords:Vector.<SWFTextRecord>;
		public var displayText:TextField;
		
		public function DOMStaticText(data:XML=null) 
		{
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			
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
			
			var records:Vector.<SWFTextRecord> = new Vector.<SWFTextRecord>();
			//var prevTextRecord:SWFTextRecord;
			//var yOffset:int=0;
			//
			//for (var i:int = 0; i < textRuns.length; i++)
			//{
				//var _textRuns:Array = textRuns[i].characters.split("%n%")
				//
				//if (_textRuns[_textRuns.length - 1].length == 0)
				//{
					//_textRuns.pop();
				//}
				//
				//for (var j:int = 0; j < _textRuns.length; j++)
				//{
					//var textRecord:SWFTextRecord = new SWFTextRecord();
					//
					///**
					 //* Set font ID
					 //*/
					//if (!FontFactory.isFontDefined(textRuns[i].textAttrs.face))
					//{
						//FontFactory.defineFont(textRuns[i].textAttrs.face, tags);
						//textRecord.hasFont 		= true;
						//textRecord.fontId 		= property.characterId;
						//property.characterId 	= XFLCompiler.characterId
					//}
					//else 
					//{
						//var fontId:uint = FontFactory.fontId(textRuns[i].textAttrs.face);
						//
						//if(prevTextRecord != null && prevTextRecord.fontId == fontId)
						//{
							//textRecord.hasFont 	= true;
							//textRecord.fontId 	= fontId;
						//}
						//else
						//{
							//textRecord.hasFont 	= true;
							//textRecord.fontId 	= fontId;
						//}
						//
					//}
					//
					///**
					 //* Set font color
					 //*/
					//textRecord.hasColor 	= true;
					//textRecord.textColor 	= textRuns[i].textAttrs.fillColor;
					//
					//textRecord.textHeight 	= textRuns[i].textAttrs.bitmapSize;
					//
					//textRecord.hasYOffset 	= true;
					//textRecord.yOffset 		= textRecord.textHeight + ((textRecord.textHeight + 100) * recordLength + (prevTextRecord!=null?(textRuns[i].textAttrs.lineSpacing * 20):0))
					//
					//textRecord.glyphEntries = FontFactory.glyphEntries(textRuns[i].textAttrs.face, _textRuns[j],textRuns[i].textAttrs.size);
					//
					//switch(textRuns[i].textAttrs.alignment)
					//{
						//case "left":
						//{
							//textRecord.hasXOffset 	= true;
							//textRecord.xOffset 		= 0;
						//}
						//break;
						//
						//case "center":
						//{
							//textRecord.hasXOffset 	= true;
							//textRecord.xOffset 		= ((width * 20) / 2) - (FontFactory.glyphsWidth(textRecord.glyphEntries) / 2);
						//}
						//break;
						//
						//case "right":
						//{
							//textRecord.hasXOffset 	= true;
							//textRecord.xOffset 		= (width * 20) - FontFactory.glyphsWidth(textRecord.glyphEntries);
						//}
						//break;
					//}
					//
					//if (textRecord.glyphEntries.length > 0) records.push(textRecord);
					//
					//recordLength++;
					//prevTextRecord = textRecord;
				//}
			//}
			
			var newLine:Boolean = true;
			textRecords 		= new Vector.<SWFTextRecord>();
			property.yOffset 	= 0;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				newLine = textRuns[i].appendTextRecord(textRecords, tags, property, newLine);
			}
			
			fixOffset();
			
			defineText.records 		= records;
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
	/*	public function publish():void
		{
			var newLine:Boolean = true;
			textRecords 		= new Vector.<SWFTextRecord>();
			property.yOffset 	= 0;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				newLine = textRuns[i].appendTextRecord(textRecords, tags, property, newLine);
			}
			
			fixOffset();
		}*/
		protected function fixOffset():void
		{
			var startRecord:SWFTextRecord;
			var xOffset:int = 0;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				
				for (var j:int = 0; j < textRuns[i].textRecords.length; j++)
				{
					if (textRuns[i].newLine)
					{
						if (startRecord != null)
						{
							switch(textRuns[i - 1].textAttrs.alignment)
							{
								case "center":
								{
									startRecord.xOffset = ((width * 20) / 2) - ( xOffset / 2);
								}
								break;
								
								case "right":
								{
									startRecord.xOffset = (width * 20) - xOffset;
								}
								break;
							}
						}
						
						startRecord = textRuns[i].textRecords[textRuns[i].textRecords.length - 1];
						xOffset = 0;
					}
					
					xOffset += FontFactory.glyphsWidth(textRuns[i].textRecords[textRuns[i].textRecords.length - 1].glyphEntries);
					
				}
			}
		}
		
		public function createDisplay():DisplayObject
		{			
			displayText = new TextField();
				//displayText.background = true;
				displayText.backgroundColor = 0xcccccc;
				displayText.selectable = false;
				displayText.multiline = true;
				displayText.wordWrap = false;
				displayText.width = width + 5;
				displayText.height = height + 15;
			
			displayText.transform.matrix = _matrix;
			
			for (var i:int = 0; i < textRuns.length; i++)
			{
				textRuns[i].appendText(displayText);
			}
			
			return displayText;
		}
	}

}