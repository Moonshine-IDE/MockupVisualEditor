package view.forms
{
	import mx.core.mx_internal;
	import mx.events.ToolTipEvent;
	
	import spark.components.DropDownList;
	import spark.utils.LabelUtil;
	
	import utils.MoonshineBridgeUtils;
	
	use namespace mx_internal;
	
	public class CustomDropDownList extends DropDownList
	{
		public var labelDisplayFunction:Function;
		public var showTooltipFunction:Function;
		
		public function CustomDropDownList()
		{
			super();
			
			this.addEventListener(ToolTipEvent.TOOL_TIP_CREATE, MoonshineBridgeUtils.moonshineBridge.getCustomTooltipFunction(), false, 0, true);
			this.addEventListener(ToolTipEvent.TOOL_TIP_SHOW, MoonshineBridgeUtils.moonshineBridge.getPositionTooltipFunction(), false, 0, true);
		}
		
		override mx_internal function updateLabelDisplay(displayItem:* = undefined):void
		{
			if (labelDisplay)
			{
				if (displayItem == undefined)
					displayItem = selectedItem;
				if (displayItem != null && displayItem != undefined)
				{
					if (labelDisplayFunction != null)
					{
						labelDisplay.text = labelDisplayFunction(displayItem);
						toolTip = (showTooltipFunction != null) ? showTooltipFunction(displayItem) : labelDisplay.text;
					}
					else
					{
						toolTip = labelDisplay.text = LabelUtil.itemToLabel(displayItem, labelField, labelFunction);
					}
				}
				else
				{
					labelDisplay.text = prompt;
				}
			}
		}
	}
}