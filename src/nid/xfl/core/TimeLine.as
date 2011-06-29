package nid.xfl.core 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	import nid.xfl.compiler.mediator.ScriptPool;
	import nid.xfl.compiler.swf.data.SWFSymbol;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagEnd;
	import nid.xfl.compiler.swf.tags.TagShowFrame;
	import nid.xfl.dom.DOMDocument;
	import nid.xfl.dom.DOMTimeline;
	import nid.xfl.dom.elements.DOMSymbolInstance;
	import nid.xfl.editor.avm.AVMEnvironment;
	import nid.xfl.interfaces.IFilter;
	import nid.xfl.XFLCompiler;
	import nid.xfl.XFLDocument;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class TimeLine extends Sprite
	{
		/**
		 * XFL Document reference
		 */
		public var doc:DOMDocument;
		
		public var totalFrames:int = 1;
		public var instanceName:String;
		public var currentFrame:int = 0;
		public var depth:int = 0;
		public var layers:Vector.<Layer>
		public var stop:Boolean;
		public var matrix:Matrix;
		public var _filters:Vector.<IFilter>;
		public var centerPoint3DX:Number;
		public var centerPoint3DY:Number;
		public var centerPoint3DZ:Number;
		
		public function TimeLine(data:DOMTimeline=null,refdoc:DOMDocument=null) 
		{
			doc = refdoc;
			depth = XFLObject.level++;
			
			layers = new Vector.<Layer>();
			
			if (data != null)
			{
				construct(data);
			}
		}
		public function construct(domTimeline:DOMTimeline):void
		{
			name = domTimeline.name == null?"":domTimeline.name;
			
			for (var l:int = domTimeline.domlayers.length-1; l >= 0; l--)
			{
				var layer:Layer = new Layer(domTimeline.domlayers[l]);
				layers.push(layer);
				addChild(layer);
				totalFrames = totalFrames < layer.totalFrames?layer.totalFrames:totalFrames;
			}
			//trace('timeline :'+domTimeline.name+',totalFrames:' + totalFrames);
		}
		public function getTimelineByName(tl_name:String):TimeLine
		{
			var f_elements:Vector.<FrameElement>;
			
			for (var i:int = 0; i < layers.length; i++)
			{
				f_elements = layers[i].frames[currentFrame == 0?0:currentFrame-1].elements;
				
				for (var j:int = 0; j < f_elements.length; j++)
				{
					trace('element.display.name:[' + j + ']' + f_elements[j].display.name);
					
					if (f_elements[j].isTimeline && f_elements[j].timeline.instanceName == tl_name)
					{
						return f_elements[j].timeline;
					}
				}
			}
			
			return null;
		}
		public function nextFrame():void
		{
			
		}
		public function previousFrame():void
		{
			
		}
		public function gotoAndStop(frame:int):void
		{
			currentFrame = frame;
			
			if (currentFrame < totalFrames)
			{
				for (var i:int = 0; i < layers.length; i++)
				{
					layers[i].gotoAndStop(currentFrame, depth);
					stop = layers[i].stop == true?true:stop;
				}
			}
		}
		public function updateDisplay():void
		{
			if (totalFrames > 2)
			{
				//trace('start CF:' + currentFrame, 'TF:' + totalFrames);
			}
			
			if (currentFrame >= totalFrames)
			{
				if(!stop)
				currentFrame = 1;
			}
			else
			{
				if (!stop)
				{
					currentFrame = currentFrame + 1;
				}
			}
			
			if (totalFrames > 2)
			{
				//trace('frame:' + currentFrame);
			}
			
			for (var i:int = 0; i < layers.length; i++)
			{
				layers[i].gotoAndStop(currentFrame, depth);
				stop = layers[i].stop == true?true:stop;
			}
			
			if (totalFrames > 2)
			{
				//trace('end CF:' + currentFrame, 'TF:' + totalFrames);
			}
			
		}
		public function scan():void
		{
			var property:Object = { depth:0 }
			property.parent = "SubTimeline";
			
			for (var l:int = 0; l < layers.length; l++)
			{
				layers[l].scan(property);
			}
		}
		public function publish(tags:Vector.<ITag>, property:Object, sub_tags:Vector.<ITag> = null):void
		{
			
			for (var i:int = 0; i < totalFrames; i++)
			{
				property.depth = 1
				property.scriptPool = new ScriptPool(i);
				
				for (var l:int = 0; l < layers.length; l++)
				{
					if (i < layers[l].frames.length && layers[l].frames[i] != null)
					{
						layers[l].publish(i, tags, property, sub_tags);
					}
				}
				
				if (property.scriptPool.script.length > 0)
				property.frameScriptPool.push(property.scriptPool);
				
				sub_tags.push(new TagShowFrame());
			}
			sub_tags.push(new TagEnd());
			
		}

	}

}