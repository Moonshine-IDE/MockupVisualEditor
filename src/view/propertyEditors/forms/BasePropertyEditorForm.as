package view.propertyEditors.forms
{
	import flash.events.Event;

	import spark.components.Form;

	import view.EditingSurface;

	import view.IPropertyEditor;

	import view.ISurfaceComponent;

	[Event(name="change",type="flash.events.Event")]

	public class BasePropertyEditorForm extends Form implements IPropertyEditor
	{
		public function BasePropertyEditorForm()
		{
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
			this._selectedItem = value;
			this.dispatchEvent(new Event(Event.CHANGE));
		}
	}
}
