package utils
{
    import converter.Converter;

    import interfaces.ISurface;

	import view.flex.surfaceComponents.components.Button;
	import view.flex.surfaceComponents.components.Calendar;
	import view.flex.surfaceComponents.components.CheckBox;
	import view.flex.surfaceComponents.components.Container;
	import view.flex.surfaceComponents.components.DropDownList;
	import view.flex.surfaceComponents.components.Hyperlink;
	import view.flex.surfaceComponents.components.Image;
	import view.flex.surfaceComponents.components.Input;
	import view.flex.surfaceComponents.components.List;
	import view.flex.surfaceComponents.components.MainApplication;
	import view.flex.surfaceComponents.components.RadioButton;
	import view.flex.surfaceComponents.components.Table;
	import view.flex.surfaceComponents.components.Tabs;
	import view.flex.surfaceComponents.components.Text;
	import view.flex.surfaceComponents.components.Tree;
	import view.flex.surfaceComponents.components.Window;
    import view.primeFaces.supportClasses.Container;
    import view.primeFaces.surfaceComponents.components.AutoCompleteDropDownList;
	import view.primeFaces.surfaceComponents.components.Button;
	import view.primeFaces.surfaceComponents.components.DataTable;
	import view.primeFaces.surfaceComponents.components.Div;
	import view.primeFaces.surfaceComponents.components.Fieldset;
	import view.primeFaces.surfaceComponents.components.Grid;
	import view.primeFaces.surfaceComponents.components.Include;
	import view.primeFaces.surfaceComponents.components.InputMask;
	import view.primeFaces.surfaceComponents.components.InputNumber;
	import view.primeFaces.surfaceComponents.components.InputText;
	import view.primeFaces.surfaceComponents.components.InputTextarea;
	import view.primeFaces.surfaceComponents.components.MainApplication;
	import view.primeFaces.surfaceComponents.components.OutputLabel;
	import view.primeFaces.surfaceComponents.components.OutputPanel;
	import view.primeFaces.surfaceComponents.components.PanelGrid;
    import view.primeFaces.surfaceComponents.components.RootDiv;
    import view.primeFaces.surfaceComponents.components.SelectBooleanCheckbox;
    import view.primeFaces.surfaceComponents.components.SelectOneListbox;
    import view.primeFaces.surfaceComponents.components.SelectOneMenu;
	import view.primeFaces.surfaceComponents.components.SelectOneRadio;
	import view.primeFaces.surfaceComponents.components.TabView;
	import view.primeFaces.surfaceComponents.components.TextEditor;
	import view.primeFaces.supportClasses.GridItem;
	import view.primeFaces.supportClasses.GridRow;
	import view.primeFaces.supportClasses.NavigatorContent;

    public class EditingSurfaceReader
	{
        public static var CLASS_LOOKUP:Object;
        private static var conv:Converter;

		public static function fromXML(surface:ISurface, xml:XML, visualEditorType:String):void
		{
            initReader(visualEditorType);
            conv = Converter.getInstance(CLASS_LOOKUP);
            conv.fromXML(surface, xml);
		}

		private static function initReader(visualEditorType:String):void
		{
            CLASS_LOOKUP = {};

			if (visualEditorType == VisualEditorType.FLEX)
            {
                CLASS_LOOKUP[view.flex.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
                        view.flex.surfaceComponents.components.MainApplication;

                CLASS_LOOKUP[view.flex.surfaceComponents.components.Button.ELEMENT_NAME] =
                        view.flex.surfaceComponents.components.Button;
                CLASS_LOOKUP[view.flex.surfaceComponents.components.Container.ELEMENT_NAME] = view.flex.surfaceComponents.components.Container;
                CLASS_LOOKUP[Calendar.ELEMENT_NAME] = Calendar;
                CLASS_LOOKUP[CheckBox.ELEMENT_NAME] = CheckBox;
                CLASS_LOOKUP[DropDownList.ELEMENT_NAME] = DropDownList;
                CLASS_LOOKUP[Hyperlink.ELEMENT_NAME] = Hyperlink;
                CLASS_LOOKUP[Image.ELEMENT_NAME] = Image;
                CLASS_LOOKUP[Input.ELEMENT_NAME] = Input;
                CLASS_LOOKUP[List.ELEMENT_NAME] = List;
                CLASS_LOOKUP[RadioButton.ELEMENT_NAME] = RadioButton;
                CLASS_LOOKUP[Table.ELEMENT_NAME] = Table;
                CLASS_LOOKUP[Tabs.ELEMENT_NAME] = Tabs;
                CLASS_LOOKUP[Text.ELEMENT_NAME] = Text;
                CLASS_LOOKUP[Tree.ELEMENT_NAME] = Tree;
                CLASS_LOOKUP[Window.ELEMENT_NAME] = Window;
            }
			else
            {
                CLASS_LOOKUP[view.primeFaces.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
                        view.primeFaces.surfaceComponents.components.MainApplication;
                CLASS_LOOKUP[view.primeFaces.surfaceComponents.components.Button.ELEMENT_NAME] =
                        view.primeFaces.surfaceComponents.components.Button;
				CLASS_LOOKUP[InputMask.ELEMENT_NAME] = InputMask;
				CLASS_LOOKUP[InputNumber.ELEMENT_NAME] = InputNumber;
				CLASS_LOOKUP[AutoCompleteDropDownList.ELEMENT_NAME] = AutoCompleteDropDownList;
				CLASS_LOOKUP[OutputLabel.ELEMENT_NAME] = OutputLabel;
				CLASS_LOOKUP[Fieldset.ELEMENT_NAME] = Fieldset;
				CLASS_LOOKUP[InputTextarea.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.InputTextarea;
				CLASS_LOOKUP[InputText.ELEMENT_NAME] = InputText;
				CLASS_LOOKUP[SelectBooleanCheckbox.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectBooleanCheckbox;
				CLASS_LOOKUP[SelectOneRadio.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneRadio;
				CLASS_LOOKUP[SelectOneMenu.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneMenu;
				CLASS_LOOKUP[Include.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Include;
				CLASS_LOOKUP[TextEditor.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.TextEditor;
				CLASS_LOOKUP[TabView.ELEMENT_NAME] = TabView;
				CLASS_LOOKUP[view.primeFaces.surfaceComponents.components.Tree.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Tree;
                CLASS_LOOKUP[DataTable.ELEMENT_NAME] = DataTable;
				CLASS_LOOKUP[Div.ELEMENT_NAME] = Div;
				CLASS_LOOKUP[Grid.ELEMENT_NAME] = Grid;
				CLASS_LOOKUP[PanelGrid.ELEMENT_NAME] = PanelGrid;
				CLASS_LOOKUP[OutputPanel.ELEMENT_NAME] = OutputPanel;
				CLASS_LOOKUP[view.primeFaces.surfaceComponents.components.Calendar.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Calendar;
				CLASS_LOOKUP[RootDiv.ELEMENT_NAME] = RootDiv;
				CLASS_LOOKUP[SelectOneListbox.ELEMENT_NAME] = SelectOneListbox;
				CLASS_LOOKUP[view.primeFaces.supportClasses.Container.ELEMENT_NAME] = view.primeFaces.supportClasses.Container;
				CLASS_LOOKUP[GridItem.ELEMENT_NAME] = GridItem;
				CLASS_LOOKUP[GridRow.ELEMENT_NAME] = GridRow;
				CLASS_LOOKUP[NavigatorContent.ELEMENT_NAME] = NavigatorContent;
            }
		}
	}
}
