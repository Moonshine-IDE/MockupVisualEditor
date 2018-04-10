package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.collections.ArrayCollection;
    import mx.collections.ArrayList;
    
    import spark.components.DataGrid;
    import spark.components.gridClasses.GridColumn;
    
    import data.DataProviderListItem;
    
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

            this.mouseChildren = false;
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
                "emptyMessageChanged",
				"change"
            ];

            fillDataTable();
        }

        private function fillDataTable():void
        {
			_tableColumnDescriptor = new ArrayCollection();
			
			var tmpTableVO:DataProviderListItem = new DataProviderListItem();
			tmpTableVO.label = "Year";
			_tableColumnDescriptor.addItem(tmpTableVO);
			
			tmpTableVO = new DataProviderListItem();
			tmpTableVO.label = "Brand";
			_tableColumnDescriptor.addItem(tmpTableVO);
			
			generateColumns();
        }
		
		private function generateColumns():void
		{
			var dp:ArrayList = new ArrayList();
			
			columns = new ArrayList();
			for each (var i:DataProviderListItem in _tableColumnDescriptor.source)
			{
				var tmpColumn:GridColumn = new GridColumn();
				tmpColumn.headerText = tmpColumn.dataField = i.label;
				columns.addItem(tmpColumn);
			}
			
			this.invalidateDisplayList();
		}
		
		private var _tableVar:String = "";
		
		[Bindable("change")]
		public function get tableVar():String
		{
			return _tableVar;
		}
		public function set tableVar(value:String):void
		{
			if (_tableVar == value) return;
			
			_tableVar = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private var _tableValue:String = "";
		public function get tableValue():String
		{
			return _tableValue;
		}
		public function set tableValue(value:String):void
		{
			_tableValue = value;
		}
		
		private var _tableColumnDescriptor:ArrayCollection;
		public function get tableColumnDescriptor():ArrayCollection
		{
			return _tableColumnDescriptor;
		}
		public function set tableColumnDescriptor(value:ArrayCollection):void
		{
			_tableColumnDescriptor = value;
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
			var hNamespace:Namespace = new Namespace("h", "http://xmlns.jcp.org/jsf/html");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@paginator = this.paginator;
            xml.@resizableColumns = this.resizableColumns;
            xml.@emptyMessage = this.emptyMessage;
			
			var column:XML;
			var outputText:XML;
			for each (var i:DataProviderListItem in tableColumnDescriptor)
			{
				column = new XML("<column/>");
				column.addNamespace(primeFacesNamespace);
				column.setNamespace(primeFacesNamespace);
				column.@headerText = i.label;
				
				outputText = new XML("<outputText/>");
				outputText.addNamespace(hNamespace);
				outputText.setNamespace(hNamespace);
				outputText.@value = "#{"+ tableVar +"."+ i.value +"}";
				
				column.appendChild(outputText);
				xml.appendChild(column);
			}

            return xml;
        }
    }
}