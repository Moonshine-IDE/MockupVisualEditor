package utils
{
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;

	import view.EditingSurface;
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
	import view.interfaces.ISurfaceComponent;
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
    import view.primeFaces.surfaceComponents.components.PanelGrid;
    import view.primeFaces.surfaceComponents.components.SelectBooleanCheckbox;
	import view.primeFaces.surfaceComponents.components.TabView;

    public class EditingSurfaceReader
	{
		public static var CLASS_LOOKUP:Object;
		
		public static function fromXML(surface:EditingSurface, xml:XML, visualEditorType:String):void
		{
			initReader(visualEditorType);

			function itemFromXML(parent:IVisualElementContainer, itemXML:XML):ISurfaceComponent
			{
				var name:String = itemXML.localName();
				if(!(name in CLASS_LOOKUP))
				{
                    var elements:XMLList = itemXML.elements();
                    var elementCount:int = elements.length();
                    for(var i:int = 0; i < elementCount; i++)
                    {
                        var elementXML:XML = elements[i];
                        return itemFromXML(parent, elementXML);
                    }
					return null;
				}
				var type:Class = CLASS_LOOKUP[name];
				var item:ISurfaceComponent = new type() as ISurfaceComponent;
				if(item === null)
				{
					throw new Error("Failed to create surface component: " + name);
				}
				item.fromXML(itemXML, itemFromXML);
				parent.addElement(IVisualElement(item));
				surface.addItem(item);
				return item;
			}
			var elements:XMLList = xml.elements();
			var elementCount:int = elements.length();
			for(var i:int = 0; i < elementCount; i++)
			{
				var elementXML:XML = elements[i];
				itemFromXML(surface, elementXML);
			}
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
                CLASS_LOOKUP[Container.ELEMENT_NAME] = Container;
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
				CLASS_LOOKUP[Include.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Include;
				CLASS_LOOKUP[TabView.ELEMENT_NAME] = TabView;
				CLASS_LOOKUP[view.primeFaces.surfaceComponents.components.Tree.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Tree;
                CLASS_LOOKUP[DataTable.ELEMENT_NAME] = DataTable;
				CLASS_LOOKUP[Div.ELEMENT_NAME] = Div;
				CLASS_LOOKUP[Grid.ELEMENT_NAME] = Grid;
				CLASS_LOOKUP[PanelGrid.ELEMENT_NAME] = PanelGrid;
            }
		}
	}
}
