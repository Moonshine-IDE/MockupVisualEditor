package data
{
	[Bindable] public class SelectItem
	{
		public var itemLabel:String;
		public var itemValue:String;
		public var itemVar:String;
		public var value:String;
		public var isSelected:Boolean;
		
		public function SelectItem()
		{
		}
		
		public function isItemChanged(comparedTo:Object):Boolean
		{
			if (comparedTo.hasOwnProperty("itemLabel") && comparedTo.itemLabel != this.itemLabel) return true;
			if (comparedTo.hasOwnProperty("itemValue") && comparedTo.itemValue != this.itemValue) return true;
			if (comparedTo.hasOwnProperty("itemVar") && comparedTo.itemVar != this.itemVar) return true;
			if (comparedTo.hasOwnProperty("value") && comparedTo.value != this.value) return true;
			if (comparedTo.hasOwnProperty("isSelected") && comparedTo.isSelected != this.isSelected) return true;
			
			return false;
		}
		
		public function updateItemWith(value:SelectItem):void
		{
			this.itemLabel = value.itemLabel;
			this.itemValue = value.itemValue;
			this.itemVar = value.itemVar;
			this.value = value.value;
			this.isSelected = value.isSelected;
		}
	}
}
