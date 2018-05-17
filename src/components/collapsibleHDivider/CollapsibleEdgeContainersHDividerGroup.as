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