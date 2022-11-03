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
package components.collapsibleHDivider
{
    import spark.containers.HDividerGroup;
    import spark.containers.Divider;
    import mx.core.IVisualElement;
    import flash.events.MouseEvent;

	public class CollapsibleEdgeContainersHDividerGroup extends HDividerGroup
	{
		private var isDragging:Boolean;
		private var firstDividerOldWidth:Number;
		private var lastDividerOldWidth:Number;
		
		public function CollapsibleEdgeContainersHDividerGroup()
		{
			super();
		}
		
		override protected function createNewDivider(firstChild:IVisualElement, secondChild:IVisualElement, dividerClass : Class = null):Divider
		{
            var result:Divider = new CollapsibleEdgeContainersHDivider();
            result.addEventListener(MouseEvent.MOUSE_OVER , super.onDividerMouseOver);
            result.addEventListener(MouseEvent.MOUSE_OUT , super.onDividerMouseOut);
            result.addEventListener(MouseEvent.MOUSE_DOWN , super.onDividerMouseDown);
            result.addEventListener(MouseEvent.MOUSE_UP, this.onDividerClick);
            result.upOrRightNeighbour = firstChild;
            result.downOrLeftNeighbour = secondChild;

            dividers.push(result);

			return result;
		}
		
		override protected function removeDivider(index:int):Boolean
		{
            var result : Boolean = false;
            var divider : Divider = getElementAt(index) as Divider;
            if (divider)
            {
                divider.removeEventListener(MouseEvent.MOUSE_OVER , super.onDividerMouseOver);
                divider.removeEventListener(MouseEvent.MOUSE_OUT , super.onDividerMouseOut);
                divider.removeEventListener(MouseEvent.MOUSE_DOWN , super.onDividerMouseDown);
                divider.removeEventListener(MouseEvent.MOUSE_UP, this.onDividerClick);

                super.removeElement( divider );
                result = true;
            }

			return result;
		}		
		
		override protected function stopDividerDrag():void
		{
			super.stopDividerDrag();	
		}		
		
		override protected function onDividerMouseMove(e:MouseEvent):void
		{
			super.onDividerMouseMove(e);
			
			this.isDragging = true;
		}
		
		protected function onDividerClick(event:MouseEvent):void
		{
			if (!this.isDragging)
			{
				var divider:Divider = event.currentTarget as Divider;
				
				if (this.isFirstDivider(divider))
				{
					if (divider.upOrRightNeighbour.width == 0)
					{
						divider.upOrRightNeighbour.width = firstDividerOldWidth;
						divider.downOrLeftNeighbour.width -= firstDividerOldWidth;
					}			
			        else
					{		
					    this.firstDividerOldWidth = divider.upOrRightNeighbour.width;
						divider.downOrLeftNeighbour.width += divider.upOrRightNeighbour.width;
						divider.upOrRightNeighbour.width = 0;
					}
				}
				else if (this.isLastDivider(divider))
				{
				    if (divider.downOrLeftNeighbour.width == 0)
				    {
						divider.downOrLeftNeighbour.width = this.lastDividerOldWidth;
						divider.upOrRightNeighbour.width -= this.lastDividerOldWidth;
				    }				
				    else 
				    {
						this.lastDividerOldWidth = divider.downOrLeftNeighbour.width;
						divider.upOrRightNeighbour.width += divider.downOrLeftNeighbour.width;
						divider.downOrLeftNeighbour.width = 0;
					}				
				}
			}
			
			this.isDragging = false;
		}
		
		private function isFirstDivider(divider:Divider):Boolean
		{
			if (!divider || this.dividers.length == 0) return false;
			
			return this.dividers[0] === divider;
		}
		
		private function isLastDivider(divider:Divider):Boolean
		{
			if (!divider || this.dividers.length == 0) return false;
			
			var lastIndex:int = this.dividers.length - 1;
			return this.dividers[lastIndex] === divider;
		}
	}
}