package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Metadata 
	{
		public var names:Vector.<Name>;
		public var settings:Settings;
		
		public function Metadata(data:XMLList=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:XMLList):void
		{
			names = null;
			names = new Vector.<Name>();
			
			for (var i:int = 0; i < data.names.name.length(); i++)
			{
				names.push(new Name(data.names.name[i]));
			}
			settings = null;
			settings = new Settings(data.Settings);
		}
		
	}

}
