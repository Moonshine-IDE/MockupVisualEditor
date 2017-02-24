package view.surfaceComponents
{
	import mx.collections.ArrayList;

	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;

	import view.ISurfaceComponent;

	public class Table extends DataGrid implements ISurfaceComponent
	{
		public static const ELEMENT_NAME:String = "table";

		public function Table()
		{
			this.mouseChildren = false;
			this.dataProvider = new ArrayList(
			[
				{ label: "One", value: 1 },
				{ label: "Two", value: 2 },
				{ label: "Three", value: 3 },
				{ label: "Four", value: 4 },
				{ label: "Five", value: 5 },
			]);
			this.columns = new ArrayList(
			[
				new GridColumn("label"),
				new GridColumn("value"),
			]);
			this.width = 200;
			this.height = 160;
			this.minWidth = 20;
			this.minHeight = 20;
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

		public function get propertyEditorClass():Class
		{
			return null;
		}
	}
}
