////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) STARTcloud, Inc. 2015-2022. All rights reserved.
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
				
				case PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_MOVED:
					moveItem(editor, fieldLastValue);
					break;
				
				default:
					changeItem(fieldLastValue, editor);
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
				
				case PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_MOVED:
					moveItem(editor, fieldNewValue);
					break;
				
				default:
					changeItem(fieldNewValue, editor);
					break;
			}
			
			fieldClass["callLater"](function():void
			{
				fieldClass.isUpdating = false;
			});
		}
		
		protected function deleteItem(editor:VisualEditor):void
		{
			editor.editingSurface.organizer.isRefreshTree = false;
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
				editor.editingSurface.organizer.addDroppedElement(fieldClassParent as IVisualElement, fieldClass as IVisualElement, fieldClassIndexToParent);
			}
		}
		
		protected function moveItem(editor:VisualEditor, stateValue:Object):void
		{
			deleteItem(editor);
			fieldClassParent = stateValue.fieldClassParent;
			fieldClassIndexToParent = stateValue.fieldClassIndexToParent;
			fieldClass["callLater"](function():void
			{
				editor.editingSurface.organizer.isRefreshTree = true;
				addItem(editor);
			});
		}
		
		/*protected function moveItem(editor:VisualEditor, from:Object, to:Object):void
		{
			editor.editingSurface.deleteItem(fieldClass as ISurfaceComponent);
		}*/
		
		protected function changeItem(value:*, editor:VisualEditor):void
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
			
			editor.componentsOrganizer.updateItemWithPropertyChanges(this, true);
		}
	}
}