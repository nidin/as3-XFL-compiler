package nid.xfl.data.script 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Actionscript 
	{
		public var codes:Array;
		public var script:String;
		
		public function Actionscript(data:XMLList=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
			
		}
		public function parse(data:XMLList):void
		{
			script = String(data.script);
			codes = script.split(";");
		}
		public function toString(indent:uint = 0):String
		{
			return codes.join(';');
		}
		
	}

}