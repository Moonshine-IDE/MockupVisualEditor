package view.forms
{
	import mx.core.mx_internal;
	
	import spark.components.DropDownList;
	import spark.utils.LabelUtil;

	use namespace mx_internal;
	
	public class CustomDropDownList extends DropDownList
	{
		public var labelDisplayFunction:Function;
		
		public function CustomDropDownList()
		{
			super();
		}
		
		override mx_internal function updateLabelDisplay(displayItem:* = undefined):void
		{
			if (labelDisplay)
			{
				if (displayItem == undefined)
					displayItem = selectedItem;
				if (displayItem != null && displayItem != undefined)
				{
					labelDisplay.text = (labelDisplayFunction != null) ? labelDisplayFunction(displayItem) :
						LabelUtil.itemToLabel(displayItem, labelField, labelFunction);
				}
				else
				{
					labelDisplay.text = prompt;
				}
			}
		}
	}
}