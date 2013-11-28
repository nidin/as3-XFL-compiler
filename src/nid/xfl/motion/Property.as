package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class Property 
	{
		public var enabled:int;
		public var id:String;
		public var ignoreTimeMap:int;
		public var readonly:int;
		public var visible:int;
		public var keyframe:Vector.<Keyframe>;
		
		public function Property(data:XML=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XML):void
		{
			enabled 		= data.@enabled;
			id 				= data.@id;
			ignoreTimeMap 	= data.@ignoreTimeMap;
			readonly 		= data.@readonly;
			visible 		= data.@visible;
			
			keyframe = null;
			keyframe = new Vector.<Keyframe>();
			
			for (var i:int = 0; i < data.Keyframe.length(); i++)
			{
				keyframe.push(new Keyframe(data.Keyframe[i]));
			}
			
		}
		
	}

}