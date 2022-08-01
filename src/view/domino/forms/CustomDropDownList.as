package view.domino.forms
{
	import mx.core.mx_internal;
	import mx.events.ToolTipEvent;
	
	import spark.components.DropDownList;
	import spark.utils.LabelUtil;
	
	import utils.MoonshineBridgeUtils;
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import flash.events.Event;
	import mx.core.IFactory;
	
	use namespace mx_internal;
	
	public class CustomDropDownList extends DropDownList
	{
		public var labelDisplayFunction:Function;
		public var showTooltipFunction:Function;


		
		public function CustomDropDownList()
		{
			super();

			//some times ,the moonshineBridge will return null, so I add some code in this case
			if(MoonshineBridgeUtils.moonshineBridge!=null){
				this.addEventListener(ToolTipEvent.TOOL_TIP_CREATE, MoonshineBridgeUtils.moonshineBridge.getCustomTooltipFunction(), false, 0, true);
				this.addEventListener(ToolTipEvent.TOOL_TIP_SHOW, MoonshineBridgeUtils.moonshineBridge.getPositionTooltipFunction(), false, 0, true);
			}
		
			
		}
		override public function set dataProvider(value:IList):void
        {
            if (this.dataProvider)
                this.dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE,
                    dataProvider_collectionChangeHandler);

            if (value)
                value.addEventListener(CollectionEvent.COLLECTION_CHANGE, _collectionChangeHandler, false, 0, true);

            var _itemRenderer:IFactory = this.itemRenderer;
            this.itemRenderer = null;
            this.itemRenderer = _itemRenderer; 

            super.dataProvider = value;
        }
		private function _collectionChangeHandler(event:Event):void
        {
            if (event is CollectionEvent)
            {
                var ce:CollectionEvent = CollectionEvent(event);

                // We don't need to refresh if any collection element will change.
                if(ce.kind != CollectionEventKind.UPDATE)
                {
                    var _itemRenderer:IFactory = this.itemRenderer;
                    this.itemRenderer = null;
                    this.itemRenderer = _itemRenderer;
                }
            }
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