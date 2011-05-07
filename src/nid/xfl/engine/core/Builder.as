package nid.xfl.engine.core 
{
	import nid.xfl.core.XFLObject;
	import nid.xfl.engine.data.ActionData;
	import nid.xfl.engine.data.DisplayData;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Builder extends Assembler
	{
		/**
		 * Intermediate data for display objects and action script 
		 * objects in xfl
		 */
		protected var display_data:DisplayData;
		protected var action_data:ActionData;
		
		public function Builder() 
		{
			
		}
		
		public function build(xflobj:XFLObject):void
		{
			/**
			 * @STEP 1: build display data
			 * @STEP 2: build action data
			 * @STEP 3: assemble display and action data
			 * @STEP 4: compile swf
			 */
			
			xflobj
			
		}
	}

}