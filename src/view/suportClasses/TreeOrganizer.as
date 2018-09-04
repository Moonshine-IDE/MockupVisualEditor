package view.suportClasses
{
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.controls.Tree;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	
	import data.OrganizerItem;
	
	use namespace mx_internal;
	
	public class TreeOrganizer extends Tree
	{
		public function TreeOrganizer()
		{
			super();
			
			dragEnabled = dropEnabled = dragMoveEnabled = true;
			this.setStyle("borderStyle", "none");
			labelFunction = formattedValue;
		}
		
		override protected function dragDropHandler(event:DragEvent):void
		{
			var items:Array = event.dragSource.dataForFormat("treeItems") as Array;
			var droppedIndex:int;
			var oldParentStack:OrganizerItem;
			var droppedParentStack:OrganizerItem = _dropData.parent as OrganizerItem; <!-- dropped to the parent -->
			
			// let's concentrae on one item at once
			// drag functionlity 
			oldParentStack = getParentItem(items[0]) as OrganizerItem; <!-- dragged from the parent -->
			
			super.dragDropHandler(event);
			
			// re-check again to get actual
			// dropped index relative to the parent
			for (var i:int = 0; i < items.length; i++) 
			{ 
				droppedIndex = getChildIndexInParent(getParentItem(items[i]), items[i]); <!-- relative index to target parent -->
			}
			
			// finally proceed to change level
			updateComponentLevel(oldParentStack, droppedParentStack, droppedIndex);
		}
		
		protected function updateComponentLevel(from:OrganizerItem, to:OrganizerItem, toIndex:int):void
		{
			// TEST CODE
			// GOING TO BE CHANGE
			(to.item as IVisualElementContainer).addElementAt(from.item as IVisualElement, toIndex);
		}
		
		private function getChildIndexInParent(parent:Object, child:Object):int
		{
			var index:int = 0;
			if (!parent)
			{
				var cursor:IViewCursor = ICollectionView(iterator.view).createCursor();
				while (!cursor.afterLast)
				{
					if (child === cursor.current)
						break;
					index++;
					cursor.moveNext();
				}
			}
			else
			{
				if (parent != null && 
					_dataDescriptor.isBranch(parent, iterator.view) &&
					_dataDescriptor.hasChildren(parent, iterator.view))
				{
					var children:ICollectionView = getChildren(parent, iterator.view);
					if (children.contains(child))
					{
						cursor = children.createCursor();
						while (!cursor.afterLast)
						{
							if (child === cursor.current)
								break;
							cursor.moveNext();
							index++;
						}
						
					}
					else 
					{
						//throw new Error("Parent item does not contain specified child: " + itemToUID(child));
					}
				}
			}
			return index;
		}
		
		private function formattedValue(item:Object):String
		{
			return item.name;
		}
	}
}