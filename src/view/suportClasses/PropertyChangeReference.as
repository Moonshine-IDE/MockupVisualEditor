package view.suportClasses
{
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	
	import view.VisualEditor;
	import view.interfaces.IHistorySurfaceComponent;
	import view.interfaces.ISurfaceComponent;
	import view.suportClasses.events.PropertyEditorChangeEvent;

	public class PropertyChangeReference
	{
		public var eventType:String;
		
		public var fieldName:String;
		public var fieldLastValue:*;
		public var fieldNewValue:*;
		
		public var fieldClass:IHistorySurfaceComponent;
		public var fieldClassIndexToParent:int = -1;
		public var fieldClassParent:IVisualElementContainer;
		
		public function PropertyChangeReference(fieldClass:IHistorySurfaceComponent, fieldName:String=null, fieldLastValue:*=null, fieldNewValue:*=null)
		{
			this.fieldName = fieldName;
			this.fieldLastValue = fieldLastValue;
			this.fieldNewValue = fieldNewValue;
			this.fieldClass = fieldClass;
		}
		
		public function undo(editor:VisualEditor):void
		{
			fieldClass.isUpdating = true;
			
			switch(eventType)
			{
				case PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_DELETING:
					addItem(editor);
					break;
				
				case PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_ADDING:
					deleteItem(editor);
					break;
				
				default:
					changeItem(fieldLastValue);
					break;
			}
			
			fieldClass["callLater"](function():void
			{
				fieldClass.isUpdating = false;
			});
		}
		
		public function redo(editor:VisualEditor):void
		{
			fieldClass.isUpdating = true;
			
			switch(eventType)
			{
				case PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_DELETING:
					deleteItem(editor);
					break;
					
				case PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_ADDING:
					addItem(editor);
					break;
				
				default:
					changeItem(fieldNewValue);
					break;
			}
			
			fieldClass["callLater"](function():void
			{
				fieldClass.isUpdating = false;
			});
		}
		
		protected function deleteItem(editor:VisualEditor):void
		{
			editor.editingSurface.deleteItem(fieldClass as ISurfaceComponent);
		}
		
		protected function addItem(editor:VisualEditor):void
		{
			if (fieldClassParent && (fieldClassIndexToParent != -1))
			{
				editor.editingSurface.addItem(fieldClass as ISurfaceComponent);
				if (fieldClassIndexToParent > fieldClassParent.numElements)
				{
					fieldClassIndexToParent = fieldClassParent.numElements == 0 ? 0 : fieldClassParent.numElements - 1;
				}
				fieldClassParent.addElementAt(fieldClass as IVisualElement, fieldClassIndexToParent);
			}
		}
		
		protected function changeItem(value:*):void
		{
			// against assigning multiple field changes
			if (value is Array)
			{
				for each (var i:Object in value)
				{
					fieldClass[i.field] = i.value;
				}
			}
			else if (fieldName)
			{
				// assigning single field change
				fieldClass[fieldName] = value;
			}
		}
	}
}