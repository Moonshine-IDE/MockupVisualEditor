package lookup
{
	import view.flex.surfaceComponents.components.*;
	import interfaces.ILookup;

	public class FlexUILookup implements ILookup
	{
		private var _lookup:Object;

		public function FlexUILookup()
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
			this.lookup[view.flex.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
					view.flex.surfaceComponents.components.MainApplication;

			this.lookup[view.flex.surfaceComponents.components.Button.ELEMENT_NAME] =
					view.flex.surfaceComponents.components.Button;

			this.lookup[view.flex.surfaceComponents.components.Container.ELEMENT_NAME] =
					view.flex.surfaceComponents.components.Container;

			this.lookup[Calendar.ELEMENT_NAME] = Calendar;
			this.lookup[CheckBox.ELEMENT_NAME] = CheckBox;
			this.lookup[DropDownList.ELEMENT_NAME] = DropDownList;
			this.lookup[Hyperlink.ELEMENT_NAME] = Hyperlink;
			this.lookup[Image.ELEMENT_NAME] = Image;
			this.lookup[Input.ELEMENT_NAME] = Input;
			this.lookup[List.ELEMENT_NAME] = List;
			this.lookup[RadioButton.ELEMENT_NAME] = RadioButton;
			this.lookup[Table.ELEMENT_NAME] = Table;
			this.lookup[Tabs.ELEMENT_NAME] = Tabs;
			this.lookup[Text.ELEMENT_NAME] = Text;
			this.lookup[Tree.ELEMENT_NAME] = Tree;
			this.lookup[Window.ELEMENT_NAME] = Window;
		}
	}
}
