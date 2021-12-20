package view.flex.surfaceComponents.components
{
	import mx.collections.ArrayList;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	
	import utils.MxmlCodeUtils;
	
	import view.flex.surfaceComponents.skins.TableSkin;
	import view.interfaces.IFlexSurfaceComponent;

	public class Table extends DataGrid implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "DataGrid";
		public static const ELEMENT_NAME:String = "table";

		public function Table()
		{
			super();

            this.setStyle("skinClass", TableSkin);
            this.setStyle("color", "#6A6A6A");
            this.setStyle("fontSize", 12);

			this.mouseChildren = false;
			this.dataProvider = new ArrayList(
			[
				{ label: "One", value: 1 },
				{ label: "Two", value: 2 },
				{ label: "Three", value: 3 },
				{ label: "Four", value: 4 },
				{ label: "Five", value: 5 }
			]);
			this.columns = new ArrayList(
			[
				new GridColumn("label"),
				new GridColumn("value")
			]);
			this.width = 200;
			this.height = 160;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];
		}

        public function get propertyEditorClass():Class
        {
            return null;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }
		
		private var _isSelected:Boolean;
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}

        public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
		}

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            setCommonXMLAttributes(xml);

			var columnsXML:XML = new XML("<columns></columns>");
            columnsXML.addNamespace(sparkNamespace);
            columnsXML.setNamespace(sparkNamespace);

			var arrayListXML:XML = new XML("<ArrayList></ArrayList>");
            arrayListXML.addNamespace(sparkNamespace);
            arrayListXML.setNamespace(sparkNamespace);

            columnsXML.appendChild(arrayListXML);
            for(var i:int = 0; i < columnsLength; i++)
			{
				var gridColumn:XML = new XML("<GridColumn></GridColumn>");
                gridColumn.addNamespace(sparkNamespace);
                gridColumn.setNamespace(sparkNamespace);

				var clmn:GridColumn = columns.getItemAt(i) as GridColumn;
				gridColumn.@headerText = clmn.headerText;

                arrayListXML.appendChild(gridColumn);
			}

            xml.appendChild(columnsXML);
			
            return xml;
        }

		public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
		public function toRora():XML
        {
            return null;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
		}
    }
}
