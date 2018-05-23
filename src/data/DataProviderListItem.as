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
		
		public function updateItemWith(value:DataProviderListItem):void
		{
			this.label = value.label;
			this.value = value.value;
		}
	}
}
