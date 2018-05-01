package view.models
{
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	
	import view.VisualEditor;
	import view.events.PropertyEditorChangeEvent;
	import view.interfaces.ISurfaceComponent;

	public class PropertyChangeReferenceVO
	{
		public var eventType:String;
		
		public var fieldName:String;
		public var fieldLastValue:*;
		public var fieldNewValue:*;
		
		public var fieldClass:ISurfaceComponent;
		public var fieldClassIndexToParent:int = -1;
		public var fieldClassParent:IVisualElementContainer;
		
		public function PropertyChangeReferenceVO(fieldClass:ISurfaceComponent, fieldName:String=null, fieldLastValue:*=null, fieldNewValue:*=null)
		{
			this.fieldName = fieldName;
			this.fieldLastValue = fieldLastValue;
			this.fieldNewValue = fieldNewValue;
			this.fieldClass = fieldClass;
		}
		
		public function reverse(editor:VisualEditor):void
		{
			fieldClass["isUpdating"] = true;
			
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
				fieldClass["isUpdating"] = false;
			});
		}
		
		public function restore(editor:VisualEditor):void
		{
			fieldClass["isUpdating"] = true;
			
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
				fieldClass["isUpdating"] = false;
			});
		}
		
		protected function deleteItem(editor:VisualEditor):void
		{
			editor.editingSurface.deleteItem(fieldClass);
		}
		
		protected function addItem(editor:VisualEditor):void
		{
			if (fieldClassParent && (fieldClassIndexToParent != -1))
			{
				editor.editingSurface.addItem(fieldClass);
				fieldClassParent.addElementAt(fieldClass as IVisualElement, fieldClassIndexToParent);
			}
		}
		
		protected function changeItem(value:*):void
		{
			// against assigning multiple field changes
			if (value is Array)
			{
				for each (var i:Object in fieldNewValue)
				{
					fieldClass["restorePropertyOnChangeReference"](i.field, i.value);
				}
			}
			else if (fieldName)
			{
				// assigning single field change
				fieldClass["restorePropertyOnChangeReference"](fieldName, value);
			}
		}
	}
}