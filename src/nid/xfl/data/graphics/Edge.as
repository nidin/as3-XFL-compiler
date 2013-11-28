package nid.xfl.data.graphics 
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import nid.xfl.compiler.swf.data.SWFRectangle;
	import nid.xfl.compiler.swf.data.SWFShapeRecord;
	import nid.xfl.compiler.swf.data.SWFShapeRecordCurvedEdge;
	import nid.xfl.compiler.swf.data.SWFShapeRecordStraightEdge;
	import nid.xfl.compiler.swf.data.SWFShapeRecordStyleChange;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.utils.Math2;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class Edge 
	{
		public var shapeRecord:Vector.<SWFShapeRecord>;
		public var shapeBounds:SWFRectangle;
		
		public var stateNewStyles:Boolean = false;
		public var stateLineStyle:Boolean = false;
		public var stateFillStyle1:Boolean = true;
		public var stateFillStyle0:Boolean = true;
		public var stateMoveTo:Boolean = false;
		
		public var strokeStyle:int=0;
		public var fillStyle0:int=0;
		public var fillStyle1:int = 0;
		
		public var edgeXML:XML;
		public var commands:Array;
		public var valid:Boolean;
		private var refX:Number;
		private var refY:Number;
		private var matrix:Matrix;
		private var inited:Boolean;
		
		public var offset:Number = 1;
		
		public function Edge(data:XML,records:Vector.<SWFShapeRecord>,bounds:SWFRectangle,mat:Matrix) 
		{
			shapeRecord = records;
			shapeBounds = bounds;
			matrix = mat;
			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			if (String(data.@edges) == "") 
			{
				valid = false;
				return;
			}
			valid = true;
			edgeXML = data;
			
			commands = [];
			
			var edgeData:String = String(data.@edges);
			
			strokeStyle = int(data.@strokeStyle);
			fillStyle0 = int(data.@fillStyle0);
			fillStyle1 = int(data.@fillStyle1);
			
			stateFillStyle0 = fillStyle0 == 0?false:true;
			//stateFillStyle1 = fillStyle1 == 0?false:true;
			
			//trace("fillStyle0:" + fillStyle0 );
			//trace("fillStyle1:" + fillStyle1 );
			
			edgeData = edgeData.replace(/[!]/g, " ! ");
			edgeData = edgeData.replace(/[|\/]/g, " | ");
			edgeData = edgeData.replace(/[\[\]]/g, " [ ");
			
			var cmds:Array = edgeData.split(" ");
			//trace(cmds);
			
			refX=0;
			refY=0;
			
			for (var i:int = 0; i < cmds.length; i++)
			{
				//trace('cmds['+i+']:' + cmds[i]);
				switch(cmds[i])
				{
					case "!":
					{
						
						var moveX:Number = (Number(cmds[i + 1].replace(/S(.*?)[0-9]/g, "")) + (matrix.tx * 20)) / offset;
						var moveY:Number = (Number(cmds[i + 2].replace(/S(.*?)[0-9]/g, "")) + (matrix.ty * 20)) / offset;
						
						if (refX != moveX || refY != moveY)
						{
							commands.push(["!", moveX, moveY]);
							
							var MoveRecord:SWFShapeRecordStyleChange = new SWFShapeRecordStyleChange();
								MoveRecord.stateFillStyle0 = stateFillStyle0;
								MoveRecord.stateFillStyle1 = stateFillStyle1;
								MoveRecord.lineStyle 	= strokeStyle;
								MoveRecord.fillStyle0 	= fillStyle0;
								MoveRecord.fillStyle1 	= fillStyle1;
								MoveRecord.stateMoveTo = true;
								//MoveRecord.moveDeltaX	= refX == 0?moveX:moveX - refX;
								//MoveRecord.moveDeltaY	= refY == 0?moveY:moveY - refY;
								MoveRecord.moveDeltaX	= moveX;
								MoveRecord.moveDeltaY	= moveY;
							
							shapeRecord.push(MoveRecord);
							
							refX = moveX;
							refY = moveY;
							
							calculateBounds();
						}
						//trace("!", moveX, moveY);
						if (!inited)
						{
							if (shapeBounds.xmin == 0) shapeBounds.xmin = refX;
							if (shapeBounds.ymin == 0) shapeBounds.ymin = refY;
							if (shapeBounds.xmax == 11000) shapeBounds.xmax = 0;
							if (shapeBounds.ymax == 8000) shapeBounds.ymax = 0;
							inited = true;
						}
					}
					break;
					
					case "|":
					{
						var X:Number = (Number(cmds[i + 1].replace(/S(.*?)[0-9]/g, "")) + (matrix.tx * 20)) / offset;
						var Y:Number = (Number(cmds[i + 2].replace(/S(.*?)[0-9]/g, "")) + (matrix.ty * 20)) / offset;
						
						//trace("|", X, Y);
						commands.push(["|", X, Y]);
						
						var LineRecord:SWFShapeRecordStraightEdge = new SWFShapeRecordStraightEdge();
							
						if (refX == X) LineRecord.vertLineFlag = true;
						else if (refY != Y)LineRecord.generalLineFlag = true;
						
						LineRecord.deltaX = X - refX;
						LineRecord.deltaY = Y - refY;
						
						shapeRecord.push(LineRecord);
						
						refX = X;
						refY = Y;
						calculateBounds();
					}
					break;
					
					case "[":
					{
						var controlX:Number = (Number(String(cmds[i + 1].replace(/S(.*?)[0-9]/g, "")).replace("#","0x").split(".")[0]) + (matrix.tx * 20)) / offset;
						var controlY:Number = (Number(String(cmds[i + 2].replace(/S(.*?)[0-9]/g, "")).replace("#","0x").split(".")[0]) + (matrix.ty * 20)) / offset;
						var anchorX:Number = (Number(String(cmds[i + 3].replace(/S(.*?)[0-9]/g, "")).replace("#","0x").split(".")[0]) + (matrix.ty * 20)) / offset;
						var anchorY:Number = (Number(String(cmds[i + 4].replace(/S(.*?)[0-9]/g, "")).replace("#","0x").split(".")[0]) + (matrix.ty * 20)) / offset;
						
						//trace("[", controlX, controlY, anchorX, anchorY);
						commands.push(["[", controlX, controlY, anchorX, anchorY] );
						
						var CurveRecord:SWFShapeRecordCurvedEdge = new SWFShapeRecordCurvedEdge ();
						
						CurveRecord.controlDeltaX = controlX - refX;
						CurveRecord.controlDeltaY = controlY - refY;
						CurveRecord.anchorDeltaX = anchorX - (controlX - refX) - refX;
						CurveRecord.anchorDeltaY = anchorY - (controlY - refY) - refY;
						
						//trace("[", "anchors:" , CurveRecord.anchorDeltaX, CurveRecord.anchorDeltaY);
						
						shapeRecord.push(CurveRecord);
						
						refX = anchorX;
						refY = anchorY;
						calculateBounds();
					}
					break;
				}
			}
		}
		private function calculateBounds():void
		{
			//trace('xmin:' + shapeBounds.xmin, 'refX:' + refX);
			//trace('xmax:' + shapeBounds.xmax, 'refX:' + refX);
			//trace('ymax:' + shapeBounds.ymax, 'refY:' + refY);
			shapeBounds.xmin = shapeBounds.xmin > refX?refX : shapeBounds.xmin;
			shapeBounds.xmax = shapeBounds.xmax < refX?refX : shapeBounds.xmax;
			shapeBounds.ymin = shapeBounds.ymin > refY?refY : shapeBounds.ymin;
			shapeBounds.ymax = shapeBounds.ymax < refY?refY : shapeBounds.ymax;
			
			//trace('xmin:' + shapeBounds.xmin, 'xmax:' + shapeBounds.xmax, 'ymin:' + shapeBounds.ymin, 'ymax:' + shapeBounds.ymax);
		}
	}

}