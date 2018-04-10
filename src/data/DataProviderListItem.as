package data
{
	[Bindable]
	public class DataProviderListItem
	{
		public function DataProviderListItem(label:String = null)
		{
			this.label = label;
		}

		public var label:String;
		public var value:String;
	}
}
