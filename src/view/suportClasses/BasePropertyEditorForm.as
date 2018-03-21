package view.suportClasses
{
	import flash.events.Event;

    import mx.core.IVisualElement;

    import spark.components.Form;

	import view.EditingSurface;

	import view.interfaces.IPropertyEditor;

	import view.interfaces.ISurfaceComponent;

	[Event(name="change",type="flash.events.Event")]
	[Event(name="propertyEditorChanged",type="flash.events.Event")]
	public class BasePropertyEditorForm extends Form implements IPropertyEditor
	{
		public function BasePropertyEditorForm()
		{
            this.addEventListener(Event.REMOVED, propertyEditor_removedHandler);
		}

		private var _surface:EditingSurface;

		public function get surface():EditingSurface
		{
			return this._surface;
		}

		public function set surface(value:EditingSurface):void
		{
			this._surface = value;
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

			this._selectedItem = value;
			this.dispatchEvent(new Event(Event.CHANGE));
		}

        private function registerPropertyChangedEvents(surfaceComponent:ISurfaceComponent):void
        {
            if (!surfaceComponent.propertiesChangedEvents) return;

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

            var propertiesChangedEventsCount:int = surfaceComponent.propertiesChangedEvents.length;
            for(var i:int = 0; i < propertiesChangedEventsCount; i++)
            {
                surfaceComponent.removeEventListener(surfaceComponent.propertiesChangedEvents[i], onSelectedItemPropertyChanged);
            }
        }

        private function onSelectedItemPropertyChanged(event:Event):void
        {
            dispatchEvent(new Event("propertyEditorChanged", true));
        }

        protected function propertyEditor_removedHandler(event:Event):void
        {
            var object:IVisualElement = event.target as IVisualElement;
            if (object === this)
            {
                unregisterPropertyChangedEvents(_selectedItem);
            }
        }
	}
}
