package nid.xfl.core
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class MovieClip2 extends MovieClip 
	{
		private var frames:Vector.<DisplayObject>;
		private var index:int;
		
		public function addFrame(element:DisplayObject, frame:Object = null):void
		{
			if (frame == null)
			{
				frames.push(element);
			}
			else
			{
				frames.push(element);
			}
		}		
		public function removeFrame(frame:Object = null):void
		{
			if (frame == null)
			{
				frames.pop();
			}
			else
			{
				frames.splice(int(frame)-1, 1);
			}
		}
		
		/**
		 * Over rides
		 */
		override public function get totalFrames():int 
		{
			return frames.length;
		}
		override public function get currentFrame():int 
		{
			return index;
		}
		
		public function MovieClip2() 
		{
			frames = new Vector.<DisplayObject>();
		}
		
		override public function gotoAndStop(frame:Object, scene:String = null):void 
		{
			flushFrame();
			index = int(frame);
			addChild(frames[index-1]);
		}
		
		internal function flushFrame():void
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				removeChild(getChildAt(i));
			}
		}
	}

}