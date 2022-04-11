package lookup
{
	import components.Container;
	import components.GridItem;
	import components.GridRow;
	import components.NavigatorContent;
	import components.common.RootDiv;

	import interfaces.ILookup;

	public class FlexNonUILookup implements ILookup
	{
		private var _lookup:Object;

		public function FlexNonUILookup()
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
			this.lookup[Container.ELEMENT_NAME] = Container;
			this.lookup[GridRow.GRIDROW_NAME] = GridRow;
			this.lookup[GridItem.GRIDITEM_NAME] = GridItem;
			this.lookup[NavigatorContent.NAVIGATORCONTENT_NAME] = NavigatorContent;
		}
	}
}
