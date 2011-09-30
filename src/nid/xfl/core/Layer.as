package nid.xfl.core 
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	import flash.utils.Dictionary;
	import nid.geom.DMatrix;
	import nid.utils.MatrixConvertor;
	import nid.xfl.compiler.swf.data.SWFButtonRecord;
	import nid.xfl.compiler.swf.tags.ITag;
	import nid.xfl.dom.DOMFrame;
	import nid.xfl.dom.DOMLayer;
	import nid.xfl.dom.elements.DOMSymbolInstance;
	import nid.xfl.interfaces.IXFilter;
	import nid.xfl.motion.EasingEquations;
	import nid.xfl.motion.TweenTypes;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Layer extends Sprite
	{
		public var totalFrames:int = 0;
		public var layerType:String;
		public var hasParentLayer:Boolean;
		public var parentLayerIndex:int;
		public var clipDepth:int;
		public var frames:Vector.<Frame>;
		public var timeline:Dictionary = new Dictionary();
		public var currentIndex:int = 0;
		public var stop:Boolean;
		public var depthOffset:int = 0;
		public var isPublished:Boolean;
		public var isScaned:Boolean;
		
		private var display:Sprite;
		
		public function Layer(data:DOMLayer=null) 
		{
			frames = new Vector.<Frame>();
			
			if (data != null)
			{
				construct(data);
			}
		}
		public function construct(data:DOMLayer):void
		{
			name 			 = data.name;
			layerType 		 = data.layerType;
			parentLayerIndex = data.parentLayerIndex;
			hasParentLayer	 = data.hasParentLayer;
			
			var frame:Frame;
			
			for (var f:int = 0; f < data.domframes.length; f++)
			{
				if (data.domframes[f].duration > 0)
				{
					for (var i:int = data.domframes[f].index; i < data.domframes[f].index + data.domframes[f].duration; i++)
					{
						if (i > data.domframes[f].index && data.domframes.length > f)
						{
							//frame = frames[i - 1].clone(f == (data.domframes.length - 1));
							frame = frames[i - 1].clone();
							applyProperties(frame, data, i, f);
						}
						else
						{
							frame = new Frame(data.domframes[f]);
							//trace('alpha:'+frame.elements[0].alpha);
						}
						
						addFrameAt(frame, i, i > data.domframes[f].index);
						frames.push(frame);
						frame.sid = frames.length;
						totalFrames++;
					}
				}
				else
				{
					frame = new Frame(data.domframes[f]);
					addFrameAt(frame, data.domframes[f].index);
					frames.push(frame);
					frame.sid = frames.length;
					totalFrames++;
				}
			}
		}
		internal function applyProperties(frame:Frame, data:DOMLayer, i:int, f:int):void
		{
			
			/**
			 * Apply Tween
			 */
			switch(data.domframes[f].tweenType)
			{
				case TweenTypes.SHAPE:
				{
					//TODO: MorphCurves
				}
				break;
				
				case TweenTypes.MOTION:
				{
					/**
					 * Classic Motion Tween
					 */
					var mat:Matrix  = frame.elements[0].display.transform.matrix;
					
					if (frame.elements[0].isTimeline)
					{
						var bcpx:Number = frame.elements[0].timeline.centerPoint3DX;
						var bcpy:Number = frame.elements[0].timeline.centerPoint3DY;
						var bcpz:Number = frame.elements[0].timeline.centerPoint3DZ;
					}
					
					if (data.domframes.length > f)
					{
						if (data.domframes[f + 1].elements[0] is DOMSymbolInstance)
						{
							var symbol:DOMSymbolInstance = DOMSymbolInstance(data.domframes[f + 1].elements[0]);
							var ccpx:Number = symbol.centerPoint3DX - bcpx;
							var ccpy:Number = symbol.centerPoint3DY - bcpy;
							var ccpz:Number = symbol.centerPoint3DZ - bcpz;
							
							var iftrs:Vector.<IXFilter> = symbol._filters;
						}
						
						if (data.domframes[f].elements[0] is DOMSymbolInstance)
						{
							var bftrs:Vector.<IXFilter> = DOMSymbolInstance(data.domframes[f].elements[0])._filters;
						}
						
						var bmat:DMatrix  = MatrixConvertor.convert(data.domframes[f].tweenMatrix);
						var imat:DMatrix  = MatrixConvertor.convert(data.domframes[f + 1].tweenMatrix);
						var cmat:DMatrix  = new DMatrix();
						
						var t:Number	= i + 1 - data.domframes[f].index;
						var d:Number	= data.domframes[f].duration + 1;
						var acc:Number	= data.domframes[f].acceleration;
						var tp:Point	= data.domframes[f].transformationPoint;
						
						cmat.tx	= imat.tx - bmat.tx;
						cmat.ty	= imat.ty - bmat.ty;
						
						cmat.scaleX = imat.scaleX - bmat.scaleX;
						cmat.scaleY = imat.scaleY - bmat.scaleY;
						cmat.rotation  = imat.rotation - bmat.rotation;
						
						var bcpt:Point = new Point(bcpx, bcpy);
						var ccpt:Point = new Point(ccpx, ccpy);
						
						EasingEquations.easeMatrix(mat, bmat, cmat, tp, bcpt, ccpt, t, d, acc);
						
						//mat.tx = EasingEquations.ease(t, bx, cx, d, acc);
						//mat.ty = EasingEquations.ease(t, by, cy, d, acc);
						
						var alpha_b:Number = data.domframes[f].color.alphaMultiplier;
						var alpha_c:Number = data.domframes[f + 1].color.alphaMultiplier - data.domframes[f].color.alphaMultiplier;
						
						/**
						 * Apply Color Transform
						 */
						if (frame.hasColorTransform)
						{
							if (data.domframes[f + 1].color.alphaMultiplier == data.domframes[f].color.alphaMultiplier)
							{
								frame.colorTransform.alphaMultiplier = data.domframes[f].color.alphaMultiplier;
							}
							else 
							{
								frame.colorTransform.alphaMultiplier = EasingEquations.ease(t, alpha_b, alpha_c, d, acc);
							}
						}
						
						/**
						 * Apply Filters
						 */
						
						if (iftrs != null)
						{
							frame.hasFilter = true;
							frame._filters = EasingEquations.easeFilters(t, bftrs, iftrs , d, acc);
						}
						
					}
					
					frame.matrix = mat;
					
				}
				break;
				
				case TweenTypes.MOTION_OBJECT:
				{
					
				}
				break;
			}
		}
		public function addFrame(frame:Frame, extension:Boolean = false):void
		{
			timeline[++currentIndex] = frame;
			timeline[currentIndex].extension = extension;
		}
		public function addFrameAt(frame:Frame, index:int = 0, extension:Boolean = false):void
		{
			timeline[index] = frame;
			timeline[index].extension = extension;
		}
		public function removeFrame(frame:Frame):void
		{
			timeline[currentIndex] = null;
			delete timeline[currentIndex--];
		}
		public function removeFrameAt(index:int = 0):void
		{
			timeline[index] = null;
			delete timeline[index];
		}
		
		public function gotoAndStop(frame:Object,depth:int):void
		{
			flush();
			if (frame is String)
			{
				//TODO: jump to label
			}
			else if (frame is Number)
			{
				
				var _fi:int = int(frame) - 1;
				var _fo:Frame = timeline[_fi];
				
				if (_fo != null)
				{
					display.addChild(_fo);
					_fo.updateDisplay();
					stop = _fo.stop == true?true:stop;
				}
				else if (totalFrames <= _fi  && timeline[totalFrames - 1] != null)
				{
					_fo = timeline[totalFrames - 1];
					
					display.addChild(_fo);
					_fo.updateDisplay();
					stop = _fo.stop == true?true:stop;
				}
				else
				{
					//trace('null frame:', int(frame), 'depth:' + depth);
				}
				
			}
		}
		internal function flush():void
		{
			if (display != null && this.contains(display))
			{
				removeChild(display);
			}
			display = null;
			display = new Sprite();
			addChild(display);
		}
		
		/**
		 *  Scan layer for depth offset calculation
		 */
		public function scan(property:Object):void
		{
			var _property:Object = { depth:0 }
			
			for (var i:int = 0; i < frames.length; i++)
			{
				frames[i].scan(_property, layerType);
			}
			
			//trace('parent:' + property.parent);
			//trace('_property.depth:' + _property.depth);
			
			depthOffset 	= property.depth + _property.depth;
			property.depth 	= depthOffset;
			
			if (hasParentLayer)
			{
				//if (property.clipDepths == undefined) property.clipDepths = new Object();
				property.clipDepths[parentLayerIndex] = depthOffset;
			}
			isScaned = true;
			//trace('depthOffset:' + depthOffset);
		}
		public function publish(f:int, tags:Vector.<ITag>, property:Object, sub_tags:Vector.<ITag> = null, isButton:Boolean = false, characters:Vector.<SWFButtonRecord> = null ):void
		{
			if (frames.length > f)
			{
				isPublished = true;
				property.depthOffset = depthOffset;
				frames[f].publish(tags, property, sub_tags, isButton, characters, layerType, clipDepth);
			}
		}
		/**
		 * Save modifications
		 */
		public function save(f:int):void
		{
			if (frames.length > f)
			{
				frames[f].save();
			}
		}
	}

}