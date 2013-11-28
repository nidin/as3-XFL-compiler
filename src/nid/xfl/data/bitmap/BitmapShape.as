package nid.xfl.data.bitmap 
{
	import nid.xfl.compiler.swf.data.SWFShapeRecord;
	import nid.xfl.compiler.swf.data.SWFShapeRecordStraightEdge;
	import nid.xfl.compiler.swf.data.SWFShapeRecordStyleChange;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class BitmapShape
	{
		
		public function BitmapShape() 
		{
			
		}
		static public function createBitmapShapeRecord(width:Number, height:Number):Vector.<SWFShapeRecord>
		{
			var shapeRecord:Vector.<SWFShapeRecord> = new Vector.<SWFShapeRecord>();
			
			var moveTo:SWFShapeRecordStyleChange 		= new SWFShapeRecordStyleChange();
			var horizontal_1:SWFShapeRecordStraightEdge = new SWFShapeRecordStraightEdge();
			var vectical_1:SWFShapeRecordStraightEdge 	= new SWFShapeRecordStraightEdge();
			var horizontal_2:SWFShapeRecordStraightEdge = new SWFShapeRecordStraightEdge();
			var vectical_2:SWFShapeRecordStraightEdge 	= new SWFShapeRecordStraightEdge();
			
			moveTo.stateMoveTo = true;
			moveTo.stateFillStyle1 = true;
			moveTo.fillStyle1 = 2;
			
			horizontal_1.deltaX = width * 20;
			vectical_1.deltaY = height * 20;
			vectical_1.vertLineFlag = true;
			horizontal_2.deltaX = -(width * 20);
			vectical_2.deltaY = -(height * 20);
			vectical_2.vertLineFlag = true;
			
			shapeRecord.push(moveTo);
			shapeRecord.push(horizontal_1);
			shapeRecord.push(vectical_1);
			shapeRecord.push(horizontal_2);
			shapeRecord.push(vectical_2);
			
			return shapeRecord;
		}
	}

}