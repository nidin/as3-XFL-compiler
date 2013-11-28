package nid.xfl.utils 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class XMLFormater 
	{
		
		public function XMLFormater() 
		{
			
		}
		static public function format(value:String):XML
		{
			value = NSRemover.remove(value);
			value = value.replace(/&#xD;/g, "%n%");
			
			return new XML(value);
		}
	}

}