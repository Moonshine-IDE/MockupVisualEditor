package data
{
	[Bindable]
	public class ComponentListItem
	{
		public function ComponentListItem(name:String = null, type:Class = null)
		{
			this.name = name;
			this.type = type;
		}

		public var name:String;
		public var type:Class;
	}
}
