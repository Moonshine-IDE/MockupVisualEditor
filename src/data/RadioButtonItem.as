package data
{
	[Bindable] public class RadioButtonItem
	{
		public var itemLabel:String;
		public var itemValue:String;
		public var itemVar:String;
		public var value:String;
		public var isSelected:Boolean;
		
		public function RadioButtonItem(itemLabel:String, itemValue:String, isSelected:Boolean = false)
		{
			this.itemLabel = itemLabel;
			this.itemValue = itemValue;
			this.isSelected = isSelected;
		}
	}
}
