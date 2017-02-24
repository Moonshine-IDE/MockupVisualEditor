package view.surfaceComponents
{
	import data.DataProviderListItem;

	import mx.collections.ArrayList;

	import spark.components.List;

	import view.ISurfaceComponent;
	import view.propertyEditors.ListPropertyEditor;

	public class List extends spark.components.List
		implements ISurfaceComponent, IDataProviderComponent
	{
		public static const ELEMENT_NAME:String = "list";

		public function List()
		{
			this.mouseChildren = false;
			this.dataProvider = new ArrayList(
			[
				new DataProviderListItem("One"),
				new DataProviderListItem("Two"),
				new DataProviderListItem("Three"),
				new DataProviderListItem("Four"),
				new DataProviderListItem("Five"),
			]);
			this.width = 120;
			this.height = 120;
			this.minWidth = 20;
			this.minHeight = 20;
		}

		public function get propertyEditorClass():Class
		{
			return ListPropertyEditor;
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@x = this.x;
			xml.@y = this.y;
			xml.@width = this.width;
			xml.@height = this.height;
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
		}
	}
}
