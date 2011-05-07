package nid.xfl.core 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import nid.xfl.core.TimeLine;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	dynamic public class FrameElement extends Sprite
	{
		public var characterId:int;
		public var matrix:Matrix;
		public var type:String = "none-timeline";
		public var isTimeline:Boolean;
		public var timeline:TimeLine;
		public var button:Button2;
		public var display:DisplayObject;
		
		public function FrameElement(obj:DisplayObject=null)
		{
			if (obj == null) return ;
			name = obj.name;
			display = obj;
			matrix 	= display.transform.matrix;
			addChild(display);
			
			if (display is TimeLine)
			{
				type = "timeline";
				isTimeline = true;
				timeline = display as TimeLine;
			}
			else if (display is Button2)
			{
				type = "button";
				isTimeline = false;
				button = display as Button2;
			}
			else
			{
				isTimeline = false;
			}
		}
		
		public function update(frame:Object=null):void
		{
			if (isTimeline)
			{
				timeline.updateDisplay();
				if (frame != null) timeline.currentFrame = int(frame);
			}
			else if (type == "button")
			{
				button.gotoAndStop(1);
				if (frame != null) button.currentFrame = int(frame);
			}
		}
	}

}