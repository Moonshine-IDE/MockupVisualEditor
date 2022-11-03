////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the Server Side Public License, version 1,
//  as published by MongoDB, Inc.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  Server Side Public License for more details.
//
//  You should have received a copy of the Server Side Public License
//  along with this program. If not, see
//
//  http://www.mongodb.com/licensing/server-side-public-license
//
//  As a special exception, the copyright holders give permission to link the
//  code of portions of this program with the OpenSSL library under certain
//  conditions as described in each individual source file and distribute
//  linked combinations including the program with the OpenSSL library. You
//  must comply with the Server Side Public License in all respects for
//  all of the code used other than as permitted herein. If you modify file(s)
//  with this exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do so,
//  delete this exception statement from your version. If you delete this
//  exception statement from all source files in the program, then also delete
//  it in the license file.
//
////////////////////////////////////////////////////////////////////////////////
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