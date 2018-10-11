package view.suportClasses
{
	import flash.geom.Point;
	
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.containers.Grid;
	import mx.controls.Tree;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	
	import data.OrganizerItem;
	
	import view.interfaces.IDropAcceptableComponent;
	import view.interfaces.IHistorySurfaceComponent;
	import view.primeFaces.surfaceComponents.components.PanelGrid;
	import view.primeFaces.surfaceComponents.components.TabView;
	import view.suportClasses.events.PropertyEditorChangeEvent;
	
	use namespace mx_internal;
	
	[Event(name="propertyEditorItemMoved",type="view.suportClasses.events.PropertyEditorChangeEvent")]
	public class TreeOrganizer extends Tree
	{
		public var rootContainer:IVisualElementContainer;
		
		private var isDropLocationIsChildren:Boolean;
		
		public function TreeOrganizer()
		{
			super();
			
			dragEnabled = dropEnabled = dragMoveEnabled = true;
			this.setStyle("borderStyle", "none");
			labelFunction = formattedValue;
		}
		
		override protected function dragDropHandler(event:DragEvent):void
		{
			var droppedParentStack:OrganizerItem = _dropData.parent as OrganizerItem; <!-- dropped to the parent -->
			var items:Array = event.dragSource.dataForFormat("treeItems") as Array;
			
			// let's concentrae on one item at once
			// drag functionlity 
			var draggedStack:OrganizerItem = items[0] as OrganizerItem; <!-- dragged item -->
			
			// probable termination
			// calculate target drop index before continue
			// to terminate based on target component's type
			var droppedIndex:int = getDropIndexToTarget(event);
			//if (!droppedParentStack && droppedIndex >= rootContainer.numElements) droppedIndex = rootContainer.numElements - 1;
			
			if (!isAcceptableDrop(droppedParentStack, draggedStack, droppedIndex))
			{
				event.preventDefault();
				hideDropFeedback(event);
				return;
			}
			
			super.dragDropHandler(event);
			
			for (var i:int = 0; i < items.length; i++)
			{ 
				droppedIndex = getChildIndexInParent(getParentItem(items[i]), items[i]); <!-- relative index to target parent -->
			}
			
			// finally proceed to change level
			updateComponentLevel(draggedStack, droppedParentStack, droppedIndex);
		}
		
		protected function updateComponentLevel(dragged:OrganizerItem, to:OrganizerItem, toIndex:int):void
		{
			var isRootContainer:Boolean;
			var selectedItemIndexToParent:int = IVisualElementContainer(dragged.item.owner).getElementIndex(dragged.item as IVisualElement);
			var tmpChangeRef:PropertyChangeReference = new PropertyChangeReference(dragged.item as IHistorySurfaceComponent);
			tmpChangeRef.fieldLastValue = {fieldClassIndexToParent: selectedItemIndexToParent, fieldClassParent: dragged.item.owner as IVisualElementContainer};
			
			if (!to && rootContainer && (rootContainer is IDropAcceptableComponent))
			{
				(rootContainer as IDropAcceptableComponent).dropElementAt(dragged.item as IVisualElement, toIndex);
				isRootContainer = true;				
			}
			else if (to.item is IDropAcceptableComponent)
				(to.item as IDropAcceptableComponent).dropElementAt(dragged.item as IVisualElement, toIndex);
			
			selectedItem = dragged;
			
			tmpChangeRef.fieldNewValue = {fieldClassIndexToParent: toIndex, fieldClassParent: isRootContainer ? rootContainer : to.item};
			this.dispatchEvent(new PropertyEditorChangeEvent(PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_MOVED, tmpChangeRef));
		}
		
		private function testDropLocationIfChildren(source:OrganizerItem, target:OrganizerItem):void
		{
			if (isDropLocationIsChildren) return;
			if (source === target) 
			{
				isDropLocationIsChildren = true;
				return;
			}
			if (source.children && source.children.length > 0)
			{
				for each (var i:OrganizerItem in source.children)
				{
					if (i === target)
					{
						isDropLocationIsChildren = true;
						return;
					}
					if (i.children && i.children.length > 0)
					{
						testDropLocationIfChildren(i, target);
					}
				}
			}
		}
		
		private function isAcceptableDrop(target:OrganizerItem, source:OrganizerItem, droppedIndex:int):Boolean
		{
			// test 0:: do not let things dropped outside of main div
			if (!target) return false;
			
			// test 1:: parent can't be drop in its children
			isDropLocationIsChildren = false;
			testDropLocationIfChildren(source, target);
			if (isDropLocationIsChildren) return false;
			
			// test 2:: component internal logic
			if (!target) 
			{
				if (source.name.indexOf(":") != -1 || 
					source.type == OrganizerItem.TYPE_CELL || 
					source.type == OrganizerItem.TYPE_TAB) return false;
				else return true;
			}
			
			// do not let anything drgged direct to the grid
			if (target.item is Grid || target.item is TabView || target.item is PanelGrid) return false;
			// don't let cells to be dragged
			if (source.type == OrganizerItem.TYPE_CELL || source.type == OrganizerItem.TYPE_TAB) return false;
			
			return true;
		}
		
		private function getDropIndexToTarget(event:DragEvent):int
		{
			var rowCount:int = rowInfo.length;
			var rowNum:int = 0;
			var yy:int = rowInfo[rowNum].height;
			var pt:Point = globalToLocal(new Point(event.stageX, event.stageY));
			while (rowInfo[rowNum] && pt.y >= yy)
			{
				if (rowNum != rowInfo.length-1)
				{
					rowNum++;
					yy += rowInfo[rowNum].height;
				}
				else
				{
					// now we're past all rows.  adding a pixel or two should be enough.
					// at this point yOffset doesn't really matter b/c we're past all elements
					// but might as well try to keep it somewhat correct
					yy += rowInfo[rowNum].height;
					rowNum++;
				}
			}
			
			var lastRowY:Number = rowNum < rowInfo.length ? rowInfo[rowNum].y : (rowInfo[rowNum-1].y + rowInfo[rowNum-1].height);
			var yOffset:Number = pt.y - lastRowY;
			
			rowNum += verticalScrollPosition;
			
			var parent:Object;
			var index:int;
			var numItems:int = collection ? collection.length : 0;
			
			var topItem:Object = (rowNum > _verticalScrollPosition && rowNum <= numItems) ? 
				listItems[rowNum - _verticalScrollPosition - 1][0].data : null;
			var bottomItem:Object = (rowNum - verticalScrollPosition < rowInfo.length && rowNum < numItems) ? 
				listItems[rowNum - _verticalScrollPosition][0].data  : null;
			
			var topParent:Object = collection ? getParentItem(topItem) : null;
			var bottomParent:Object = collection ? getParentItem(bottomItem) : null;
			
			// check their relationship
			if (yOffset > rowHeight * .5 && 
				isItemOpen(bottomItem) &&
				_dataDescriptor.isBranch(bottomItem, iterator.view) &&
				(!_dataDescriptor.hasChildren(bottomItem, iterator.view) ||
					_dataDescriptor.getChildren(bottomItem, iterator.view).length == 0))
			{
				// we'll get here if we're dropping into an empty folder.
				// we have to be in the lower 50% of the row, otherwise
				// we're "between" rows.
				parent = bottomItem;
				index = 0;
			}
			else if (!topItem && !rowNum == rowCount)
			{
				parent = collection ? getParentItem(bottomItem) : null;
				index =  bottomItem ? getChildIndexInParent(parent, bottomItem) : 0;
				rowNum = 0;
			}
			else if (bottomItem && bottomParent == topItem)
			{
				// we're dropping in the first item of a folder, that's an easy one
				parent = topItem;
				index = 0;
			}
			else if (topItem && bottomItem && topParent == bottomParent)
			{
				parent = collection ? getParentItem(topItem) : null;
				index = iterator ? getChildIndexInParent(parent, bottomItem) : 0;
			}
			else
			{
				//we're dropping at the end of a folder.  Pay attention to the position.
				if (topItem && (yOffset < (rowHeight * .5)))
				{
					// ok, we're on the top half of the bottomItem.
					parent = topParent;
					index = getChildIndexInParent(parent, topItem) + 1; // insert after
				}
				else if (!bottomItem)
				{
					parent = null;
					if ((rowNum - verticalScrollPosition) == 0)
						index = 0;
					else if (collection)
						index = collection.length;
					else index = 0;
				}
				else
				{
					parent = bottomParent;
					index = getChildIndexInParent(parent, bottomItem);
				}
			}
			
			return index;
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