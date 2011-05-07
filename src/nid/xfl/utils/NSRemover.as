package nid.xfl.utils 
{
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class NSRemover 
	{
		
		static public var xmlnsPattern:RegExp = new RegExp("xmlns[^\"]*\"[^\"]*\"", "gi");
		
		public function NSRemover() 
		{
			
		}
		static public function remove(value:String):String
		{
			return value.replace(xmlnsPattern, "");
		}
		
	}

}