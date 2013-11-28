package nid.xfl.compiler.abc 
{
	import flash.utils.ByteArray;
	import org.as3commons.bytecode.abc.AbcFile;
	import org.as3commons.bytecode.abc.BaseMultiname;
	import org.as3commons.bytecode.abc.enum.MultinameKind;
	import org.as3commons.bytecode.abc.enum.Opcode;
	import org.as3commons.bytecode.emit.IClassBuilder;
	import org.as3commons.bytecode.emit.ICtorBuilder;
	import org.as3commons.bytecode.emit.IMethodBuilder;
	import org.as3commons.bytecode.emit.impl.AbcBuilder;
	import org.as3commons.bytecode.emit.impl.ClassBuilder;
	import org.as3commons.bytecode.emit.impl.CtorBuilder;
	import org.as3commons.bytecode.emit.impl.MethodBuilder;
	import org.as3commons.bytecode.emit.impl.PackageBuilder;
	import org.as3commons.bytecode.emit.IPackageBuilder;
	import org.as3commons.bytecode.io.AbcSerializer;
	import org.as3commons.bytecode.swf.SWFWeaver;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class AbcGenerator 
	{
		
		public function AbcGenerator() 
		{
			
		}
		/**
		 * prepair
		 */
		public function prepair():void
		{
			
		}
		/**
		 * addSymbolClass
		 */
		public function addSymbolClass(packageName:String,className:String, frameScriptPool:Array):void
		{
			for (var i:int = 0; i < frameScriptPool.length; i++)
			{
				if (frameScriptPool[i] != null)
				{
					
				}
			}
		}
		
	}

}