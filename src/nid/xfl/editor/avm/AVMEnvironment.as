package nid.xfl.editor.avm 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import nid.xfl.core.XFLObject;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class AVMEnvironment
	{
		
		static public var fps:Number = 24;
		static public var masterTimer:Timer = new Timer(int(1000/fps));
		
		public var xflObj:XFLObject;
		public var running:Boolean;
		
		public function AVMEnvironment() 
		{
			
		}
		public function render(target:XFLObject):void
		{
			xflObj = target;
			masterTimer.addEventListener(TimerEvent.TIMER, updateDisplay);
			setTimeout(masterTimer.start, 10);
			running = true;
			
			trace('TF:' + xflObj.totalFrames);
			
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
			//trace('CF:' + xflObj.currentFrame);
			//trace('-');
			xflObj.updateDisplay();
			
		}
	}

}