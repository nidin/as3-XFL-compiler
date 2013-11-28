package nid.xfl.compiler.abc 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class AsmGenerator 
	{
		
		public function AsmGenerator() 
		{
			
		}
		static public function generateCtor(scriptPool:Array):String
		{
			var asm:String='';
			asm += 'getlocal_0\t';
			asm += 'pushscope\t';
			asm += 'getlocal_0\t';
			asm += 'constructsuper arguments count: 0\t';
			asm += 'findpropstrict addFrameScript\t';
			asm += 'pushbyte 0\t';
            asm += 'getlocal_0\t';
            asm += 'getproperty abc_fla::frame1\t';
            asm += 'callpropvoid addFrameScript  arguments count: 2\t';
            asm += 'returnvoid ';
			return asm;
		}
		static public function generate(scriptPool:Array):void
		{
			
		}
	}

}