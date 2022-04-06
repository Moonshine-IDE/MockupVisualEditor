package utils
{
	import converter.DominoConverter;
	import converter.PrimeFacesConverter;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import surface.DominoLookup;
	import surface.FlexLookup;
	import surface.PrimeFacesLookup;

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

	import view.domino.surfaceComponents.components.DominoInputText;
	import view.domino.surfaceComponents.components.DominoLabel;
	import view.domino.surfaceComponents.components.DominoComputedText;
	import view.domino.surfaceComponents.components.DominoTable;
	import view.domino.surfaceComponents.components.DominoSection;
	import view.domino.surfaceComponents.components.DominoParagraph;
	import view.domino.surfaceComponents.components.DominoTabView;
	import view.domino.surfaceComponents.components.MainApplication;
	import view.domino.surfaceComponents.components.DominoButton;
	import view.domino.surfaceComponents.components.DominoCalendar;
	import surface.SurfaceMockup;
    public class EditingSurfaceReader
	{
        public static var CLASS_LOOKUP:ILookup;
        private static var conv:PrimeFacesConverter;
		private static var domino_conv:DominoConverter;

		public static function fromXML(surface:ISurface, xml:XML, visualEditorType:String):void
		{
            initReader(visualEditorType);
			if(visualEditorType == VisualEditorType.DOMINO)
			{
				domino_conv = DominoConverter.getInstance(CLASS_LOOKUP);
            	domino_conv.fromXML(surface, xml);
			}
			else
			{
				conv = PrimeFacesConverter.getInstance(CLASS_LOOKUP);
            	conv.fromXML(surface, xml);
			}
         
		}

		public static function fromXMLAutoConvert( xml:XML):SurfaceMockup 
		{
			initReader(VisualEditorType.DOMINO);
			domino_conv = DominoConverter.getInstance(CLASS_LOOKUP);
			var surfaceModel:SurfaceMockup =  domino_conv.fromXMLOnly(xml);

			return surfaceModel;
		}

		private static function initReader(visualEditorType:String):void
		{
			if (visualEditorType == VisualEditorType.DOMINO)
			{
				CLASS_LOOKUP = new DominoLookup();
				CLASS_LOOKUP.lookup[DominoInputText.ELEMENT_NAME] = DominoInputText;
				CLASS_LOOKUP.lookup[DominoLabel.ELEMENT_NAME] = DominoLabel;
				CLASS_LOOKUP.lookup[DominoButton.ELEMENT_NAME] = DominoButton;
				CLASS_LOOKUP.lookup[DominoComputedText.ELEMENT_NAME] = DominoComputedText;
				CLASS_LOOKUP.lookup[DominoTable.ELEMENT_NAME] = DominoTable;
				CLASS_LOOKUP.lookup[DominoTabView.ELEMENT_NAME] = DominoTabView;
				CLASS_LOOKUP.lookup[NavigatorContent.ELEMENT_NAME] = NavigatorContent;
				CLASS_LOOKUP.lookup[DominoSection.ELEMENT_NAME] = DominoSection;
				CLASS_LOOKUP.lookup[GridItem.ELEMENT_NAME] = GridItem;
				CLASS_LOOKUP.lookup[GridRow.ELEMENT_NAME] = GridRow;
				CLASS_LOOKUP.lookup[Div.ELEMENT_NAME] = Div;
				CLASS_LOOKUP.lookup[view.primeFaces.supportClasses.Container.ELEMENT_NAME] = view.primeFaces.supportClasses.Container;
				CLASS_LOOKUP.lookup[DominoCalendar.ELEMENT_NAME] =DominoCalendar;
				CLASS_LOOKUP.lookup[DominoParagraph.ELEMENT_NAME] =DominoParagraph;
				CLASS_LOOKUP.lookup[view.domino.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
                        view.domino.surfaceComponents.components.MainApplication;
			}
			else if (visualEditorType == VisualEditorType.FLEX)
			{
				CLASS_LOOKUP = new FlexLookup();
				CLASS_LOOKUP.lookup[view.flex.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
                        view.flex.surfaceComponents.components.MainApplication;

				CLASS_LOOKUP.lookup[view.flex.surfaceComponents.components.Button.ELEMENT_NAME] =
                        view.flex.surfaceComponents.components.Button;
				CLASS_LOOKUP.lookup[view.flex.surfaceComponents.components.Container.ELEMENT_NAME] = view.flex.surfaceComponents.components.Container;
				CLASS_LOOKUP.lookup[Calendar.ELEMENT_NAME] = Calendar;
				CLASS_LOOKUP.lookup[CheckBox.ELEMENT_NAME] = CheckBox;
				CLASS_LOOKUP.lookup[DropDownList.ELEMENT_NAME] = DropDownList;
				CLASS_LOOKUP.lookup[Hyperlink.ELEMENT_NAME] = Hyperlink;
				CLASS_LOOKUP.lookup[Image.ELEMENT_NAME] = Image;
				CLASS_LOOKUP.lookup[Input.ELEMENT_NAME] = Input;
				CLASS_LOOKUP.lookup[List.ELEMENT_NAME] = List;
				CLASS_LOOKUP.lookup[RadioButton.ELEMENT_NAME] = RadioButton;
				CLASS_LOOKUP.lookup[Table.ELEMENT_NAME] = Table;
				CLASS_LOOKUP.lookup[Tabs.ELEMENT_NAME] = Tabs;
				CLASS_LOOKUP.lookup[Text.ELEMENT_NAME] = Text;
				CLASS_LOOKUP.lookup[Tree.ELEMENT_NAME] = Tree;
				CLASS_LOOKUP.lookup[Window.ELEMENT_NAME] = Window;
            }
			else
            {
				CLASS_LOOKUP = new PrimeFacesLookup();
				CLASS_LOOKUP.lookup[view.primeFaces.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
                        view.primeFaces.surfaceComponents.components.MainApplication;
				CLASS_LOOKUP.lookup[view.primeFaces.surfaceComponents.components.Button.ELEMENT_NAME] =
                        view.primeFaces.surfaceComponents.components.Button;
				CLASS_LOOKUP.lookup[InputMask.ELEMENT_NAME] = InputMask;
				CLASS_LOOKUP.lookup[InputNumber.ELEMENT_NAME] = InputNumber;
				CLASS_LOOKUP.lookup[AutoCompleteDropDownList.ELEMENT_NAME] = AutoCompleteDropDownList;
				CLASS_LOOKUP.lookup[OutputLabel.ELEMENT_NAME] = OutputLabel;
				CLASS_LOOKUP.lookup[Fieldset.ELEMENT_NAME] = Fieldset;
				CLASS_LOOKUP.lookup[InputTextarea.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.InputTextarea;
				CLASS_LOOKUP.lookup[InputText.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.InputText;
				CLASS_LOOKUP.lookup[SelectBooleanCheckbox.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectBooleanCheckbox;
				CLASS_LOOKUP.lookup[SelectOneRadio.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneRadio;
				CLASS_LOOKUP.lookup[SelectOneMenu.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneMenu;
				CLASS_LOOKUP.lookup[Include.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Include;
				CLASS_LOOKUP.lookup[TextEditor.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.TextEditor;
				CLASS_LOOKUP.lookup[TabView.ELEMENT_NAME] = TabView;
				CLASS_LOOKUP.lookup[view.primeFaces.surfaceComponents.components.Tree.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Tree;
				CLASS_LOOKUP.lookup[DataTable.ELEMENT_NAME] = DataTable;
				CLASS_LOOKUP.lookup[Div.ELEMENT_NAME] = Div;
				CLASS_LOOKUP.lookup[Grid.ELEMENT_NAME] = Grid;
				CLASS_LOOKUP.lookup[PanelGrid.ELEMENT_NAME] = PanelGrid;
				CLASS_LOOKUP.lookup[OutputPanel.ELEMENT_NAME] = OutputPanel;
				CLASS_LOOKUP.lookup[view.primeFaces.surfaceComponents.components.Calendar.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Calendar;
				CLASS_LOOKUP.lookup[RootDiv.ELEMENT_NAME] = RootDiv;
				CLASS_LOOKUP.lookup[SelectOneListbox.ELEMENT_NAME] = SelectOneListbox;
				CLASS_LOOKUP.lookup[view.primeFaces.supportClasses.Container.ELEMENT_NAME] = view.primeFaces.supportClasses.Container;
				CLASS_LOOKUP.lookup[GridItem.ELEMENT_NAME] = GridItem;
				CLASS_LOOKUP.lookup[GridRow.ELEMENT_NAME] = GridRow;
				CLASS_LOOKUP.lookup[NavigatorContent.ELEMENT_NAME] = NavigatorContent;
            }
		}
	}
}
