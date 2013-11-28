package nid.xfl.editor.avm 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import nid.xfl.core.TimeLine;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class AVMEnvironment
	{
		
		static public var fps:Number = 24;
		static public var masterTimer:Timer = new Timer(int(1000/fps));
		
		public var timeline:TimeLine;
		public var running:Boolean;
		
		/**
		 * This is a monotonic avm class
		 */
		private static var avm:AVMEnvironment;
		public static function getInstance():AVMEnvironment
		{
			if (avm == null){ avm = new AVMEnvironment(); return avm;}
			else return avm;
		}
		
		public function AVMEnvironment() 
		{
			
		}
		public function render(target:TimeLine):void
		{
			timeline = target;
			masterTimer.addEventListener(TimerEvent.TIMER, updateDisplay);
			setTimeout(masterTimer.start, 10);
			running = true;
			
			trace('TF:' + timeline.totalFrames);
			
		}
		public function playPause(e:MouseEvent):void
		{
			running = running?pause(): resume();
		}
		public function pause():Boolean
		{
			masterTimer.stop();
			return false;
		}
		public function resume():Boolean
		{
			masterTimer.start();
			return true;
		}
		internal function updateDisplay(e:TimerEvent):void
		{
			//trace('CF:' + timeline.currentFrame);
			//trace('-');
			timeline.updateDisplay();
			
		}
	}

}