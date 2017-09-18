package utils
{
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	
	import view.EditingSurface;
	import view.ISurfaceComponent;
	import view.surfaceComponents.Button;
	import view.surfaceComponents.Calendar;
	import view.surfaceComponents.CheckBox;
	import view.surfaceComponents.Container;
	import view.surfaceComponents.DropDownList;
	import view.surfaceComponents.Hyperlink;
	import view.surfaceComponents.Image;
	import view.surfaceComponents.Input;
	import view.surfaceComponents.List;
	import view.surfaceComponents.RadioButton;
	import view.surfaceComponents.Table;
	import view.surfaceComponents.Tabs;
	import view.surfaceComponents.Text;
	import view.surfaceComponents.Tree;
	import view.surfaceComponents.Window;

	public class EditingSurfaceReader
	{
		private static const CLASS_LOOKUP:Object = {};
		CLASS_LOOKUP[Button.ELEMENT_NAME] = Button;
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

		public static function fromXML(surface:EditingSurface, xml:XML):void
		{
			function itemFromXML(parent:IVisualElementContainer, itemXML:XML):ISurfaceComponent
			{
				var name:String = itemXML.name();
				if(!(name in CLASS_LOOKUP))
				{
					throw new Error("Unknown item " + name);
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
	}
}
