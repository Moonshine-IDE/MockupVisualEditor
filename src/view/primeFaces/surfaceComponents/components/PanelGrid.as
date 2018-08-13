package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import mx.core.IVisualElement;

    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceComponent;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.PanelGridPropertyEditor;
    import view.primeFaces.supportClasses.table.Table;
    import view.suportClasses.PropertyChangeReference;

    [Exclude(name="addRow", kind="method")]
    [Exclude(name="addColumn", kind="method")]
    [Exclude(name="removeRow", kind="method")]
    [Exclude(name="removeColumn", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]

    /**
     * <p>Representation of PrimeFaces panelGrid component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;PanelGrid
     * <b>Attributes</b>
     * width="100"
     * height="30"/&gt;
     * &lt;Header name="header"&gt;
     *  &lt;Row&gt;
     *    &lt;Column&gt;Some Text&lt;/Column&gt;
     *  &lt;/Row&gt;
     *  &lt;/Header&gt;
     *  &lt;Row&gt;
     *    &lt;Column&gt;Some Text&lt;/Column&gt;
     *  &lt;/Row&gt;
     *  &lt;Row&gt;
     *    &lt;Column&gt;Some Text&lt;/Column&gt;
     *  &lt;/Row&gt;
     * &lt;/PanelGrid&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:panelGrid
     * <b>Attributes</b>
     * width="100"
     * height="30"/&gt;
     *   &lt;f:facet name="header"&gt;
     *       &lt;p:row&gt;
     *        &lt;p:column&gt;Some Text&lt;/p:column&gt;
     *       &lt;/p:row&gt;
     *   &lt;/f:facet&gt;
     *  &lt;p:row&gt;
     *    &lt;p:column&gt;Some Text&lt;/p:column&gt;
     *  &lt;/p:row&gt;
     *  &lt;p:row&gt;
     *    &lt;p:column&gt;Some Text&lt;/p:column&gt;
     *  &lt;/p:row&gt;
     * &lt;/p:panelGrid&gt;
     * </pre>
     */
    public class PanelGrid extends Table implements IPrimeFacesSurfaceComponent, IHistorySurfaceComponent
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
                "rowAdded",
                "columnsAdded",
                "rowRemoved",
                "columnsRemoved",
                "panelGridValueChanged"
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

        private var _propertyChangeFieldReference:PropertyChangeReference;
        public function get propertyChangeFieldReference():PropertyChangeReference
        {
            return _propertyChangeFieldReference;
        }

        public function set propertyChangeFieldReference(value:PropertyChangeReference):void
        {
            _propertyChangeFieldReference = value;
        }

        private var _isUpdating:Boolean;
        public function get isUpdating():Boolean
        {
            return _isUpdating;
        }

        public function set isUpdating(value:Boolean):void
        {
            _isUpdating = value;
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

        private var _panelGridValue:String = "";

        [Bindable("panelGridValueChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Column&gt;#{value}&lt;Column/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:column&gt;#{value}&lt;p:column/&gt;</listing>
         */
        public function get panelGridValue():String
        {
            return _panelGridValue;
        }

        public function set panelGridValue(value:String):void
        {
            if (_panelGridValue == value) return;

            _panelGridValue = value;

            dispatchEvent(new Event("panelGridValueChanged"));
        }

        /**
         * <p>PrimeFaces: <strong>headerRowCount (Optional)</strong></p>
         *
         * @default "1"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;PanelGrid headerRowCount="1"/&gt;</listing>
         */
        override public function get headerRowCount():int
        {
            return super.headerRowCount;
        }

        /**
         * <p>PrimeFaces: <strong>rowCount (Optional)</strong></p>
         *
         * @default "1"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;PanelGrid rowCount="1"/&gt;</listing>
         */
        override public function get rowCount():int
        {
            return super.rowCount;
        }

        /**
         * <p>PrimeFaces: <strong>columnCount (Optional)</strong></p>
         *
         * @default "1"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;PanelGrid columnCount="1"/&gt;</listing>
         */
        override public function get columnCount():int
        {
            return super.columnCount;
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@headerRowCount = this.headerRowCount;
            xml.@rowCount = this.rowCount;
            xml.@columnCount = this.columnCount;

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

            var bodyRows:XMLList = xml.Row;
            var rowCount:int = 1;
            var columnCount:int = 1;

            if ("@headerRowCount" in xml)
            {
                this.headerRowCount = xml.@headerRowCount;
            }
            else
            {
                var header:XMLList = xml.Header.Row;
                rowCount = header.length();
                if (rowCount > 0)
                {
                    this.headerRowCount = rowCount;
                }
                else
                {
                    this.headerRowCount = 1;
                }
            }

            if ("@rowCount" in xml)
            {
                this.rowCount = xml.@rowCount;
            }
            else
            {
                rowCount = bodyRows.length();
                if (rowCount > 0)
                {
                    this.rowCount = rowCount;
                }
                else
                {
                    this.rowCount = 1;
                }
            }

            if ("@columnCount" in xml)
            {
                this.columnCount = xml.@columnCount;
            }
            else
            {
                var columns:XMLList = bodyRows[0].Column;
                columnCount = columns.length();
                if (columnCount > 0)
                {
                    this.columnCount = columnCount;
                }
                else
                {
                    this.columnCount = 1;
                }
            }
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

            dispatchEvent(new Event("rowAdded"));
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

            dispatchEvent(new Event("columnsAdded"));
        }

        public function removeRow(index:int):IVisualElement
        {
            if (_rowCount == 1) return null;

            var rowItem:IVisualElement = this.body.removeRow(index);

            _rowCount -= 1;

            this.invalidateBorders();

            dispatchEvent(new Event("rowRemoved"));

            return rowItem;
        }

        public function removeColumn(columnIndex:int):IVisualElement
        {
            if (_columnCount == 1) return null;

            for (var row:int = 0; row < this.rowCount; row++)
            {
                this.body.removeColumn(row, columnIndex);
            }

            var colItem:IVisualElement = this.header.removeColumn(0, columnIndex);

            _columnCount -= 1;

            this.invalidateBorders();

            dispatchEvent(new Event("columnsRemoved"));

            return colItem;
        }

        private function toVisualXML(xml:XML, rowCount:int, columnCount:int):void
        {
            var isHeader:Boolean = "@name" in xml;
            for (var row:int = 0; row < rowCount; row++)
            {
                var rowXML:XML = new XML("<Row/>");
                for (var col:int = 0; col < columnCount; col++)
                {
                    var xmlValue:String;
                    if (isHeader)
                    {
                        xmlValue = "<Column>" + this.header.getTitle(row, col) + "</Column>";
                    }
                    else if (!this.panelGridValue)
                    {
                        xmlValue = "<Column></Column>";
                    }
                    else
                    {
                        xmlValue = "<Column>#{" + this.panelGridValue + "}</Column>";
                    }

                    var colXML:XML = new XML(xmlValue);
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
                    var headerTitle:String = header.getTitle(row, col);
                    var colXML:XML = new XML("<column>" + headerTitle + "</column>");
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
