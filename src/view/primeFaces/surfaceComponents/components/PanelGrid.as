package view.primeFaces.surfaceComponents.components
{
    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.BasicPropertyEditor;
    import view.primeFaces.propertyEditors.PanelGridPropertyEditor;
    import view.primeFaces.supportClasses.table.Table;

    public class PanelGrid extends Table implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "panelGrid";
        public static const ELEMENT_NAME:String = "PanelGrid";

        public function PanelGrid()
        {
            super();

            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "itemRemoved",
                "itemAdded"
            ];
        }

        public function get propertyEditorClass():Class
        {
            return PanelGridPropertyEditor;
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

            var header:XML = new XML("<Header/>");
            header.@name = "header";
            toVisualXML(header, this.headerRowCount, this.columnCount);
            xml.appendChild(header);

            toVisualXML(xml, this.body.numElements, this.columnCount);

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            var header:XMLList = xml.Header;
            var rows:XMLList = xml.Row;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            toCodeHeader(xml);
            toCodeBody(xml);

            return xml;
        }

        public function addRow():void
        {
            this.body.addRow();

            _rowCount += 1;

            var selectedRowIndex:int = rowCount - 1;
            addColumnToRow(this.body, selectedRowIndex, columnCount - 1);

            this.invalidateBorders();
        }

        public function addColumn():void
        {
            addColumnToRow(this.header, headerRowCount - 1, 1);
            for (var row:int = 0; row < this.rowCount; row++)
            {
                addColumnToRow(this.body, row, 1);
            }

            _columnCount += 1;
            this.invalidateBorders();
        }

        private function toVisualXML(xml:XML, rowCount:int, columnCount:int):void
        {
            for (var row:int = 0; row < rowCount; row++)
            {
                var rowXML:XML = new XML("<Row/>");
                for (var col:int = 0; col < columnCount; col++)
                {
                    var colXML:XML = new XML("<Column>Text</Column>");
                    rowXML.appendChild(colXML);
                }
                xml.appendChild(rowXML);
            }
        }

        private function toCodeHeader(xml:XML):void
        {
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            var facetNamespace:Namespace = new Namespace("f", "http://xmlns.jcp.org/jsf/core");
            var facet:XML = new XML("<facet/>");
            facet.addNamespace(facetNamespace);
            facet.setNamespace(facetNamespace);

            facet.@name = "header";

            for (var row:int = 0; row < this.headerRowCount; row++)
            {
                var rowXML:XML = new XML("<row/>");
                rowXML.addNamespace(primeFacesNamespace);
                rowXML.setNamespace(primeFacesNamespace);
                for (var col:int = 0; col < this.columnCount; col++)
                {
                    var colXML:XML = new XML("<column>Header Text</column>");
                    colXML.addNamespace(primeFacesNamespace);
                    colXML.setNamespace(primeFacesNamespace);

                    rowXML.appendChild(colXML);
                }

                facet.appendChild(rowXML);
            }

            xml.appendChild(facet);
        }

        private function toCodeBody(xml:XML):void
        {
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");

            var bodyRowCount:int = this.body.numElements;
            for (var row:int = 0; row < bodyRowCount; row++)
            {
                var rowXML:XML = new XML("<row/>");
                rowXML.addNamespace(primeFacesNamespace);
                rowXML.setNamespace(primeFacesNamespace);
                for (var col:int = 0; col < this.columnCount; col++)
                {
                    var colXML:XML = new XML("<column>Text</column>");
                    colXML.addNamespace(primeFacesNamespace);
                    colXML.setNamespace(primeFacesNamespace);

                    rowXML.appendChild(colXML);
                }

                xml.appendChild(rowXML);
            }
        }

        override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {

        }
    }
}
