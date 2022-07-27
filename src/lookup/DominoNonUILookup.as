package lookup
{
	import components.GridRow;
	import components.GridItem;
	import components.NavigatorContent;
	import components.common.Div;
	import components.domino.Body;
	import components.domino.DominoButton;
	import components.domino.DominoCalendar;
	import components.domino.DominoComputedText;
	import components.domino.DominoInputText;
	import components.domino.DominoLabel;
	import components.domino.DominoParagraph;
	import components.domino.DominoSection;
	import components.domino.DominoTabView;
	import components.domino.DominoTable;
	import components.domino.MainApplication;
	import components.domino.DominoSubForm;

	import interfaces.ILookup;

	public class DominoNonUILookup implements ILookup
	{
		private var _lookup:Object;

		public function DominoNonUILookup()
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
			this.lookup[MainApplication.ELEMENT_NAME] = Body;
			this.lookup["Body"] = Body;
			this.lookup["RootDiv"] = Body;

			this.lookup[Div.ELEMENT_NAME] = Div;
			this.lookup[GridItem.GRIDITEM_NAME] = GridItem;
			this.lookup[GridRow.GRIDROW_NAME] = GridRow;
			this.lookup[NavigatorContent.NAVIGATORCONTENT_NAME] = NavigatorContent;

			this.lookup[DominoInputText.ELEMENT_NAME] = DominoInputText;
			this.lookup[DominoLabel.ELEMENT_NAME] = DominoLabel;
			this.lookup[DominoButton.ELEMENT_NAME] = DominoButton;
			this.lookup[DominoComputedText.ELEMENT_NAME] = DominoComputedText;
			this.lookup["Grid"] = DominoTable;
			this.lookup[DominoTable.ELEMENT_NAME] = DominoTable;
			this.lookup[DominoTabView.ELEMENT_NAME] = DominoTabView;
			this.lookup[DominoSection.ELEMENT_NAME] = DominoSection;
			this.lookup[DominoCalendar.ELEMENT_NAME] = DominoCalendar;
			this.lookup[DominoParagraph.ELEMENT_NAME] = DominoParagraph;
			this.lookup[DominoSubForm.ELEMENT_NAME] = DominoSubForm;
		}
	}
}
