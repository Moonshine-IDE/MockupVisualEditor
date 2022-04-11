package lookup
{
	import interfaces.ILookup;

	import view.domino.surfaceComponents.components.*;
	import view.primeFaces.supportClasses.GridItem;
	import view.primeFaces.supportClasses.GridRow;
	import view.primeFaces.supportClasses.NavigatorContent;
	import view.primeFaces.surfaceComponents.components.Div;

	public class DominoUILookup implements ILookup
	{
		private var _lookup:Object;

		public function DominoUILookup()
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
			//TODO: Piotr - move this classes to more general package
			this.lookup[GridItem.ELEMENT_NAME] = GridItem;
			this.lookup[GridRow.ELEMENT_NAME] = GridRow;
			this.lookup[Div.ELEMENT_NAME] = Div;

			this.lookup[DominoInputText.ELEMENT_NAME] = DominoInputText;
			this.lookup[DominoLabel.ELEMENT_NAME] = DominoLabel;
			this.lookup[DominoButton.ELEMENT_NAME] = DominoButton;
			this.lookup[DominoComputedText.ELEMENT_NAME] = DominoComputedText;
			this.lookup[DominoTable.ELEMENT_NAME] = DominoTable;
			this.lookup[DominoTabView.ELEMENT_NAME] = DominoTabView;
			this.lookup[NavigatorContent.ELEMENT_NAME] = NavigatorContent;
			this.lookup[DominoSection.ELEMENT_NAME] = DominoSection;
			this.lookup[view.primeFaces.supportClasses.Container.ELEMENT_NAME] = view.primeFaces.supportClasses.Container;
			this.lookup[DominoCalendar.ELEMENT_NAME] =DominoCalendar;
			this.lookup[DominoParagraph.ELEMENT_NAME] =DominoParagraph;
			this.lookup[view.domino.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
					view.domino.surfaceComponents.components.MainApplication;
		}
	}
}
