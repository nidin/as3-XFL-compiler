package nid.xfl.motion 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class PropertyContainer 
	{
		public var id:String;
		public var propertyContainer:Vector.<PropertyContainer>;
		public var property:Vector.<Property>;
		
		public function PropertyContainer(data:*=null) 
		{			
			if (data != null)
			{
				parse(data);
			}
		}
		public function parse(data:*):void
		{
			var i :int = 0;
			
			id = data.@id;
			
			propertyContainer = null;
			
			if (data.PropertyContainer.length() > 0)
			{
				propertyContainer = new Vector.<PropertyContainer>();
				
				for (i  = 0; i < data.PropertyContainer.length(); i++)
				{
					propertyContainer.push(new PropertyContainer(data.PropertyContainer[i]));
				}
			}
			
			property = null;
			
			if (data.Property.length() > 0)
			{
				property = null;
				property = new Vector.<Property>();
				
				for (i = 0; i < data.Property.length(); i++)
				{
					property.push(new Property(data.Property[i]));
				}
			}
			
		}
		
	}

}