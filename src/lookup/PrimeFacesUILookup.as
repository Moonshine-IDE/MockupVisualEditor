package lookup
{
	import interfaces.ILookup;

	import view.primeFaces.surfaceComponents.components.*;
	import view.primeFaces.supportClasses.GridItem;
	import view.primeFaces.supportClasses.GridRow;
	import view.primeFaces.supportClasses.NavigatorContent;
	import view.primeFaces.surfaceComponents.components.Div;

	public class PrimeFacesUILookup implements ILookup
	{
		private var _lookup:Object;

		public function PrimeFacesUILookup()
		{
			_lookup = {};

			initLookupComponents();
		}

		public function get lookup():Object
		{
			return _lookup;
		}

		private function initLookupComponents():void
		{
			this.lookup[view.primeFaces.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
					view.primeFaces.surfaceComponents.components.MainApplication;
			this.lookup[view.primeFaces.surfaceComponents.components.Button.ELEMENT_NAME] =
					view.primeFaces.surfaceComponents.components.Button;
			this.lookup[InputMask.ELEMENT_NAME] = InputMask;
			this.lookup[InputNumber.ELEMENT_NAME] = InputNumber;
			this.lookup[AutoCompleteDropDownList.ELEMENT_NAME] = AutoCompleteDropDownList;
			this.lookup[OutputLabel.ELEMENT_NAME] = OutputLabel;
			this.lookup[Fieldset.ELEMENT_NAME] = Fieldset;
			this.lookup[InputTextarea.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.InputTextarea;
			this.lookup[InputText.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.InputText;
			this.lookup[SelectBooleanCheckbox.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectBooleanCheckbox;
			this.lookup[SelectOneRadio.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneRadio;
			this.lookup[SelectOneMenu.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneMenu;
			this.lookup[Include.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Include;
			this.lookup[TextEditor.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.TextEditor;
			this.lookup[TabView.ELEMENT_NAME] = TabView;
			this.lookup[view.primeFaces.surfaceComponents.components.Tree.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Tree;
			this.lookup[DataTable.ELEMENT_NAME] = DataTable;
			this.lookup[Div.ELEMENT_NAME] = Div;
			this.lookup[Grid.ELEMENT_NAME] = Grid;
			this.lookup[PanelGrid.ELEMENT_NAME] = PanelGrid;
			this.lookup[OutputPanel.ELEMENT_NAME] = OutputPanel;
			this.lookup[view.primeFaces.surfaceComponents.components.Calendar.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Calendar;
			this.lookup[RootDiv.ELEMENT_NAME] = RootDiv;
			this.lookup[SelectOneListbox.ELEMENT_NAME] = SelectOneListbox;
			this.lookup[view.primeFaces.supportClasses.Container.ELEMENT_NAME] = view.primeFaces.supportClasses.Container;
			this.lookup[GridItem.ELEMENT_NAME] = GridItem;
			this.lookup[GridRow.ELEMENT_NAME] = GridRow;
			this.lookup[NavigatorContent.ELEMENT_NAME] = NavigatorContent;
		}
	}
}
