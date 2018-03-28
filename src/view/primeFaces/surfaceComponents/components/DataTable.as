package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import mx.collections.ArrayList;

    import spark.components.DataGrid;
    import spark.utils.DataItem;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.DataTablePropertyEditor;

    public class DataTable extends DataGrid implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "dataTable";
        public static const ELEMENT_NAME:String = "DataTable";

        private static const NO_RECORDS_FOUND:String = "No records found.";

        public function DataTable()
        {
            super();

            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;
            this.resizableColumns = false;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "resizableColumnsChanged",
                "paginatorChanged",
                "emptyMessageChanged"
            ];

            fillDataTable();
        }

        private function fillDataTable():void
        {
            var dp:ArrayList = new ArrayList();

            var dataItem:DataItem = new DataItem();
            dataItem.Year = "1981";
            dataItem.Brand = "Volkswagen";
            dataItem.Color = "Maroon";

            dp.addItem(dataItem);

            dataItem = new DataItem();
            dataItem.Year = "1977";
            dataItem.Brand = "Ford";
            dataItem.Color = "Black";

            dp.addItem(dataItem);

            dataItem = new DataItem();
            dataItem.Year = "2008";
            dataItem.Brand = "Renault";
            dataItem.Color = "Brown";

            dp.addItem(dataItem);

            this.dataProvider = dp;
        }

        private var _emptyMessage:String = NO_RECORDS_FOUND;

        [Bindable(event="emptyMessageChanged")]
        public function get emptyMessage():String
        {
            return _emptyMessage;
        }

        public function set emptyMessage(value:String):void
        {
            if (_emptyMessage != value)
            {
                _emptyMessage = value;
                dispatchEvent(new Event("emptyMessageChanged"));
            }
        }

        private var _paginator:Boolean;

        [Bindable(event="paginatorChanged")]
        public function get paginator():Boolean
        {
            return _paginator;
        }

        public function set paginator(value:Boolean):void
        {
            if (_paginator != value)
            {
                _paginator = value;
                dispatchEvent(new Event("paginatorChanged"));
            }
        }

        public function get propertyEditorClass():Class
        {
            return DataTablePropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@paginator = this.paginator;
            xml.@resizableColumns = this.resizableColumns;
            xml.@emptyMessage = this.emptyMessage;

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.paginator = xml.@paginator == "true";
            this.resizableColumns = xml.@resizableColumns == "true";
            this.emptyMessage = !xml.@emptyMessage ? NO_RECORDS_FOUND : xml.@emptyMessage;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            xml.@paginator = this.paginator;
            xml.@resizableColumns = this.resizableColumns;
            xml.@emptyMessage = this.emptyMessage;

            var column:XML = new XML("<column/>");
            column.addNamespace(primeFacesNamespace);
            column.setNamespace(primeFacesNamespace);
            column.@headerText = "Year";
            xml.appendChild(column);

            column = new XML("<column/>");
            column.addNamespace(primeFacesNamespace);
            column.setNamespace(primeFacesNamespace);
            column.@headerText = "Brand";
            xml.appendChild(column);

            column = new XML("<column/>");
            column.addNamespace(primeFacesNamespace);
            column.setNamespace(primeFacesNamespace);
            column.@headerText = "Color";
            xml.appendChild(column);

            return xml;
        }
    }
}
