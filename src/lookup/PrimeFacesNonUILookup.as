package lookup
{
	import components.Container;
	import components.GridItem;
	import components.GridRow;
	import components.NavigatorContent;
	import components.common.RootDiv;
	import components.primeFaces.AutoCompleteDropDownList;
	import components.primeFaces.Button;
	import components.primeFaces.Calendar;
	import components.primeFaces.DataTable;
	import components.primeFaces.Fieldset;
	import components.primeFaces.Grid;
	import components.primeFaces.Include;
	import components.primeFaces.InputMask;
	import components.primeFaces.InputNumber;
	import components.primeFaces.InputText;
	import components.primeFaces.InputTextarea;
	import components.primeFaces.MainApplication;
	import components.primeFaces.OutputLabel;
	import components.primeFaces.PanelGrid;
	import components.primeFaces.SelectBooleanCheckbox;
	import components.primeFaces.SelectOneListbox;
	import components.primeFaces.SelectOneMenu;
	import components.primeFaces.SelectOneRadio;
	import components.primeFaces.TabView;
	import components.primeFaces.TextEditor;
	import components.primeFaces.Tree;

	import interfaces.ILookup;

	public class PrimeFacesNonUILookup implements ILookup
	{
		private var _lookup:Object;

		public function PrimeFacesNonUILookup()
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
			this.lookup["RootDiv"] = RootDiv;
			this.lookup["MainApplication"] = MainApplication;
			this.lookup[Container.ELEMENT_NAME] = Container;
			this.lookup[GridRow.GRIDROW_NAME] = GridRow;
			this.lookup[GridItem.GRIDITEM_NAME] = GridItem;
			this.lookup[NavigatorContent.NAVIGATORCONTENT_NAME] = NavigatorContent;

			this.lookup[TabView.ELEMENT_NAME] = TabView;
			this.lookup[PanelGrid.ELEMENT_NAME] = PanelGrid;
			this.lookup[Grid.ELEMENT_NAME] = Grid;
			this.lookup[Include.ELEMENT_NAME] = Include;
			this.lookup[Button.ELEMENT_NAME] = Button;
			this.lookup[OutputLabel.ELEMENT_NAME] = OutputLabel;
			this.lookup[InputText.ELEMENT_NAME] = InputText;
			this.lookup[DataTable.ELEMENT_NAME] = DataTable;
			this.lookup[Fieldset.ELEMENT_NAME] = Fieldset;
			this.lookup[SelectOneMenu.ELEMENT_NAME] = SelectOneMenu;
			this.lookup[TextEditor.ELEMENT_NAME] = TextEditor;
			this.lookup[InputTextarea.ELEMENT_NAME] = InputTextarea;
			this.lookup[Calendar.ELEMENT_NAME] = Calendar;
			this.lookup[SelectBooleanCheckbox.ELEMENT_NAME] = SelectBooleanCheckbox;
			this.lookup[SelectOneRadio.ELEMENT_NAME] = SelectOneRadio;
			this.lookup[InputMask.ELEMENT_NAME] = InputMask;
			this.lookup[InputNumber.ELEMENT_NAME] = InputNumber;
			this.lookup[Tree.ELEMENT_NAME] = Tree;
			this.lookup[AutoCompleteDropDownList.ELEMENT_NAME] = AutoCompleteDropDownList;
			this.lookup[SelectOneListbox.ELEMENT_NAME] = SelectOneListbox;
		}
	}
}
