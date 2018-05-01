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
		public var fieldClass_parent:IVisualElementContainer;
		
		public function PropertyChangeReferenceVO(fieldName:String, fieldLastValue:*, fieldNewValue:*, fieldClass:ISurfaceComponent)
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
				{
					if (fieldClass_parent && (fieldClassIndexToParent != -1))
					{
						editor.editingSurface.addItem(fieldClass);
						fieldClass_parent.addElementAt(fieldClass as IVisualElement, fieldClassIndexToParent);
					}
					break;
				}
					
				default:
				{
					if (fieldLastValue is Array)
					{
						for each (var i:Object in fieldLastValue)
						{
							fieldClass["restorePropertyOnChangeReference"](i.field, i.value);
						}
					}
					else if (fieldName)
						fieldClass["restorePropertyOnChangeReference"](fieldName, fieldLastValue);
					break;
				}
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
				{
					editor.editingSurface.deleteItem(fieldClass);
					break;
				}
					
				default:
				{
					if (fieldNewValue is Array)
					{
						for each (var i:Object in fieldNewValue)
						{
							fieldClass["restorePropertyOnChangeReference"](i.field, i.value);
						}
					}
					else if (fieldName)
						fieldClass["restorePropertyOnChangeReference"](fieldName, fieldNewValue);
					break;
				}
			}
			
			fieldClass["callLater"](function():void
			{
				fieldClass["isUpdating"] = false;
			});
		}
	}
}