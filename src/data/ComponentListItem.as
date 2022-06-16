package data
{
	[Bindable]
	public class ComponentListItem
	{
		public function ComponentListItem(name:String = null, type:Class = null, maxSize:Object = null)
		{
			this.name = name;
			this.type = type;
			this.maxSize = maxSize;
		}

		public var name:String;
		public var type:Class;
		public var maxSize:Object;
	}
}
