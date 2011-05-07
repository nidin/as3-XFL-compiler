package nid.xfl.core 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nid.xfl.compiler.mediator.ScriptPool;
	import nid.xfl.compiler.swf.data.SWFButtonRecord;
	import nid.xfl.compiler.swf.data.SWFColorTransformWithAlpha;
	import nid.xfl.compiler.swf.data.SWFMatrix;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.compiler.swf.tags.TagEnd;
	import nid.xfl.compiler.swf.tags.TagShowFrame;
	import nid.xfl.dom.DOMDocument;
	import nid.xfl.dom.DOMTimeline;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Button2 extends Sprite 
	{
		public var doc:DOMDocument;
		
		public var totalFrames:int = 1;
		public var instanceName:String;
		public var currentFrame:int = 0;
		public var depth:int = 0;
		public var layers:Vector.<Layer>
		public var stop:Boolean;
		public var currentState:String = "up";
		
		public function Button2(data:DOMTimeline=null,refdoc:DOMDocument=null) 
		{
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, function(e:Event):void { currentState = "over";  over(); } );
			this.addEventListener(MouseEvent.MOUSE_OUT, function(e:Event):void { currentState = "out"; out(); } );
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e:Event):void { currentState = "down"; down(); } );
			this.addEventListener(MouseEvent.MOUSE_UP, function(e:Event):void { currentState = "up"; up(); } );
			
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
			
			gotoAndStop(1);
		}
		
		public function over():void { gotoAndStop(2) }
		public function out():void { gotoAndStop(1) }
		public function up():void { gotoAndStop(1) }
		public function down():void { gotoAndStop(3) }
		
		public function gotoAndStop(frame:int):void
		{
			currentFrame = frame;
			
			if (currentFrame <= totalFrames)
			{
				for (var i:int = 0; i < layers.length; i++)
				{
					layers[i].gotoAndStop(currentFrame, depth);
				}
			}
		}
		public function updateDisplay():void
		{
			if (this.hitTestPoint(stage.mouseX, stage.mouseY)) return;
			
			switch(currentState)
			{
				case "over"	:over(); break;
				case "out"	:out(); break;
				case "down"	:down(); break;
				case "up"	:up(); break;
			}
		}
		public function scan():void
		{
			var property:Object = { depth:0 }
			property.parent 	= "SubTimeline";
			
			for (var l:int = 0; l < layers.length; l++)
			{
				layers[l].scan(property);
			}
		}
		public function publish(tags:Vector.<ITag>, property:Object, sub_tags:Vector.<ITag> = null):Vector.<SWFButtonRecord>
		{
			
			var characters:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
			
			for (var i:int = 0; i < 4; i++)
			{
				trace('--frame:' + i + '--');
				property.depth = 1
				property.scriptPool = new ScriptPool(i);
				
				for (var l:int = 0; l < layers.length; l++)
				{
					if (i < layers[l].frames.length && layers[l].frames[i] != null)
					{
						layers[l].publish(i, tags, property, sub_tags, true, characters);
					}
					
				}
				
				if (property.scriptPool.script.length > 0)
				property.frameScriptPool.push(property.scriptPool);
				
				sub_tags.push(new TagShowFrame());
				
			}
			sub_tags.push(new TagEnd());
			
			return characters;
		}
	}

}