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
package view.suportClasses
{
    import flash.events.Event;
    import flash.events.FocusEvent;

    import mx.core.EventPriority;

    import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;

    import spark.components.Group;
	
	import utils.MoonshineBridgeUtils;
	
	import view.EditingSurface;
	import view.VisualEditor;
    import view.interfaces.IHistorySurfaceComponent;
	import view.interfaces.IPropertyEditor;
	import view.interfaces.ISurfaceComponent;
	import view.suportClasses.events.PropertyEditorChangeEvent;

	[Event(name="change",type="flash.events.Event")]
    [Event(name="propertyEditorChanged",type="view.suportClasses.events.PropertyEditorChangeEvent")]
	[Event(name="propertyEditorItemDeleting",type="view.suportClasses.events.PropertyEditorChangeEvent")]
	public class BasePropertyEditor extends Group implements IPropertyEditor
	{
		public function BasePropertyEditor()
		{
			this.addEventListener(Event.ADDED, propertyEditor_addedHandler);
			this.addEventListener(Event.REMOVED, propertyEditor_removedHandler);
		}

        private var childrenForFocus:Array;

        private var _propertyEditors:Vector.<IPropertyEditor> = new <IPropertyEditor>[];
		private var _surface:EditingSurface;

		public function get surface():EditingSurface
		{
			return this._surface;
		}

		public function set surface(value:EditingSurface):void
		{
			if(this._surface === value)
			{
				return;
			}

			this._surface = value;

			var editorCount:int = this._propertyEditors.length;
			for(var i:int = 0; i < editorCount; i++)
			{
				var editor:IPropertyEditor = this._propertyEditors[i];
				editor.surface = this._surface;
			}
		}

		private var _selectedItem:ISurfaceComponent = null;

		[Bindable("change")]
		public function get selectedItem():ISurfaceComponent
		{
			return this._selectedItem;
		}

		public function set selectedItem(value:ISurfaceComponent):void
		{
			if(this._selectedItem === value)
			{
				return;
			}

			if (value)
			{
				registerPropertyChangedEvents(value);
			}

			_selectedItem = value;

			var editorCount:int = this._propertyEditors.length;
			for(var j:int = 0; j < editorCount; j++)
			{
				var editor:IPropertyEditor = this._propertyEditors[j];
				editor.selectedItem = this._selectedItem;
			}
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function beforeSelectedItemDeletes(event:Event):void
		{
			var selectedItemIndexToParent:int = IVisualElementContainer(_selectedItem.owner).getElementIndex(_selectedItem as IVisualElement);
			if ((event.target is IHistorySurfaceComponent) && !event.target.isUpdating)
			{
				var tmpChangeRef:PropertyChangeReference = new PropertyChangeReference(_selectedItem as IHistorySurfaceComponent);
				tmpChangeRef.fieldClassIndexToParent = selectedItemIndexToParent;
				tmpChangeRef.fieldClassParent = _selectedItem.owner as IVisualElementContainer;
				dispatchEvent(new PropertyEditorChangeEvent(PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_DELETING, tmpChangeRef));
			}
		}
		
        private function onSelectedItemPropertyChanged(event:Event):void
        {
			if ((event.target is IHistorySurfaceComponent) && event.target.propertyChangeFieldReference && !event.target.isUpdating)
			{
				// if a pending event, pass after the property editor being removed
				// from the editor panel - at this stage the parent is null and we
				// have no way to dispatch the event through its expected parent to
				// the history manager (#279)
				// in that case call the expected parent reference from the Moonshine
				var editor:VisualEditor = MoonshineBridgeUtils.getVisualEditorComponent();
				if (editor) 
				{
					editor.propertyEditor.dispatchEvent(new PropertyEditorChangeEvent(PropertyEditorChangeEvent.PROPERTY_EDITOR_CHANGED, event.target.propertyChangeFieldReference));
					editor.componentsOrganizer.updateItemWithPropertyChanges(event.target.propertyChangeFieldReference);
				}
			}
			
		    //dispatchEvent(new Event("propertyEditorChanged", true));
        }

		private function populatePropertyEditors(target:IVisualElement):void
		{
			if(target is IPropertyEditor)
			{
				var editor:IPropertyEditor = IPropertyEditor(target);
				this._propertyEditors.push(editor);
				editor.surface = this._surface;
				editor.selectedItem = this._selectedItem;
                editor.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, onEditorFocusChange, false, EventPriority.DEFAULT_HANDLER);
			}

			if(target is IVisualElementContainer)
			{
				var container:IVisualElementContainer = IVisualElementContainer(target);
				var elementCount:int = container.numElements;
				for(var i:int = 0; i < elementCount; i++)
				{
					var element:IVisualElement = container.getElementAt(i);
					this.populatePropertyEditors(element);
				}
			}
		}

        private function onEditorFocusChange(event:FocusEvent):void
        {
            if (event.isDefaultPrevented())
                return;

			if (this.childrenForFocus)
			{
				event.preventDefault();

                var childrenFocusCount:int = this.childrenForFocus.length;
				for (var i:int = 0; i < childrenFocusCount; i++)
				{
					if (this.childrenForFocus[i] == event.target)
					{
						i = event.shiftKey ? i - 1 : i + 1;
                        if (i < 0)
                        {
                            this.childrenForFocus[childrenFocusCount - 1].setFocus();
                        }
						else if (i < childrenFocusCount)
						{
                            this.childrenForFocus[i].setFocus();
						}
						else
						{
                            this.childrenForFocus[0].setFocus();
						}
                        break;
					}
				}
			}
        }

        private function propertyEditor_addedHandler(event:Event):void
        {
            var object:IVisualElement = event.target as IVisualElement;
            if(object === null || object === this)
            {
                return;
            }
            this.populatePropertyEditors(object);
			this.collectChildrenForFocus();
        }

        private function propertyEditor_removedHandler(event:Event):void
        {
            var object:IVisualElement = event.target as IVisualElement;
            if (object === this)
            {
                this.removeEventListener(Event.ADDED, propertyEditor_addedHandler);
                this.removeEventListener(Event.REMOVED, propertyEditor_removedHandler);

                unregisterPropertyChangedEvents(_selectedItem);

                this.cleanupPropertyEditors(object);

				childrenForFocus = null;
            }
        }

		private function cleanupPropertyEditors(target:IVisualElement):void
		{
			if(target is IPropertyEditor)
			{
				var editor:IPropertyEditor = IPropertyEditor(target);
				var index:int = this._propertyEditors.indexOf(editor);
				if(index !== -1)
				{
					this._propertyEditors.removeAt(index);
				}
				editor.selectedItem = null;
				editor.surface = null;
                editor.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, onEditorFocusChange);
			}

			if(target is IVisualElementContainer)
			{
				var container:IVisualElementContainer = IVisualElementContainer(target);
				var elementCount:int = container.numElements;
				for(var i:int = 0; i < elementCount; i++)
				{
					var element:IVisualElement = container.getElementAt(i);
					this.cleanupPropertyEditors(element);
				}
			}
		}

        private function registerPropertyChangedEvents(surfaceComponent:ISurfaceComponent):void
        {
            if (!surfaceComponent.propertiesChangedEvents) return;
			
			surfaceComponent.addEventListener(PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_DELETING, beforeSelectedItemDeletes, false, 0, true);

            var propertiesChangedEventsCount:int = surfaceComponent.propertiesChangedEvents.length;
            for(var i:int = 0; i < propertiesChangedEventsCount; i++)
            {
                surfaceComponent.addEventListener(surfaceComponent.propertiesChangedEvents[i], onSelectedItemPropertyChanged);
            }
        }

        private function unregisterPropertyChangedEvents(surfaceComponent:ISurfaceComponent):void
        {
            if (!surfaceComponent) return;
            if (!surfaceComponent.propertiesChangedEvents) return;
			
			surfaceComponent.removeEventListener(PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_DELETING, beforeSelectedItemDeletes);
			
			// call this later after bypassing any pending
			// event from the component
			surfaceComponent["callLater"](function():void
			{
				var propertiesChangedEventsCount:int = surfaceComponent.propertiesChangedEvents.length;
	            for(var i:int = 0; i < propertiesChangedEventsCount; i++)
	            {
	                surfaceComponent.removeEventListener(surfaceComponent.propertiesChangedEvents[i], onSelectedItemPropertyChanged);
	            }
			});
        }

        private function collectChildrenForFocus():void
        {
			childrenForFocus = [];
            var propertyEditorsCount:int = _propertyEditors.length;
            for (var i:int = 0; i < propertyEditorsCount; i++)
            {
                var childrenFocusForm:BasePropertyEditorForm = _propertyEditors[i] as BasePropertyEditorForm;

                if (childrenFocusForm && childrenFocusForm.hasChildToFocus)
                {
                    childrenForFocus.push.apply(this, childrenFocusForm.childrenForFocus);
                }
            }
        }
    }
}
