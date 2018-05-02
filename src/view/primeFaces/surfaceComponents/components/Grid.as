package view.primeFaces.surfaceComponents.components
{
    import mx.containers.Grid;
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElement;
    import mx.core.ScrollPolicy;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.GridPropertyEditor;
    import view.suportClasses.events.SurfaceComponentEvent;

    public class Grid extends mx.containers.Grid implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
        public static const ELEMENT_NAME:String = "Grid";

        private static const MAX_COLUMN_COUNT:int = 12;
        private static const MIN_COLUMN_COUNT:int = 1;
        private static const MIN_ROW_COUNT:int = 1;

        private var currentColumnColor:String = "red";

        public function Grid()
        {
            super();

            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;

            this.setStyle("verticalGap", 1);
            this.setStyle("horizontalGap", 1);
            this.setStyle("verticalScrollPolicy", ScrollPolicy.OFF);
            this.setStyle("horizontalScrollPolicy", ScrollPolicy.OFF);

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "requestedColumnCountChanged",
                "requestedRowCountChanged"
            ];

            this.ensureCreateInitialColumn();
        }

        private var _oldSelectedRow:int;
        public function get oldSelectedRow():int
        {
            return _oldSelectedRow;
        }

        private var _selectedRow:int;

        [Bindable]
        public function get selectedRow():int
        {
            return _selectedRow;
        }

        public function set selectedRow(value:int):void
        {
            if (_selectedRow != value)
            {
                _oldSelectedRow = _selectedRow;
                _selectedRow = value;
            }
        }

        private var _oldSelectedColumn:int;
        public function get oldSelectedColumn():int
        {
            return _oldSelectedColumn;
        }

        private var _selectedColumn:int;

        [Bindable]
        public function get selectedColumn():int
        {
            return _selectedColumn;
        }

        public function set selectedColumn(value:int):void
        {
            if (_selectedColumn != value)
            {
                _oldSelectedColumn = _selectedColumn;
                _selectedColumn = value;
            }
        }

        public function get propertyEditorClass():Class
        {
            return GridPropertyEditor;
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

            var gridRowNumElements:int = this.numElements;
            for (var row:int = 0; row < gridRowNumElements; row++)
            {
                var rowXML:XML = new XML("<Row />");
                rowXML["@class"] = "ui-g";

                var gridRow:GridRow = this.getElementAt(row) as GridRow;
                var gridColumnNumElements:int = gridRow.numElements;
                for (var col:int = 0; col < gridColumnNumElements; col++)
                {
                    var gridCol:GridItem = gridRow.getElementAt(col) as GridItem;
                    var div:Div = gridCol.getElementAt(0) as Div;

                    var colXML:XML = new XML("<Column />");
                    colXML["@class"] = this.getClassNameBasedOnColumns(gridRow);

                    colXML.appendChild(div.toXML());

                    rowXML.appendChild(colXML);
                }

                xml.appendChild(rowXML);
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            var elementsXML:XMLList = xml.elements();
            if (elementsXML.length() > 0)
            {
                this.removeAllElements();

                var childCount:int = elementsXML.length();
                for(var row:int = 0; row < childCount; row++)
                {
                    var rowXML:XML = elementsXML[row];
                    var colListXML:XMLList = rowXML.elements();

                    var gridRow:GridRow = new GridRow();
                    gridRow.percentWidth = gridRow.percentHeight = 100;

                    var colCount:int = colListXML.length();
                    for (var col:int = 0; col < colCount; col++)
                    {
                        var colXML:XML = colListXML[col];
                        if (colXML.length() > 0)
                        {
                            var gridItem:GridItem = new GridItem();
                            gridItem.setStyle("backgroundColor", "#a8a8a8");
                            gridItem.percentWidth = gridItem.percentHeight = 100;

                            var divXMLList:XMLList = colXML.elements();
                            var divXML:XML = divXMLList[0];

                            var div:Div = new Div();
                            div.percentWidth = div.percentHeight = 100;
                            currentColumnColor = currentColumnColor == "red" ? "yellow" : "red";
                            div.setStyle("borderColor", currentColumnColor);

                            gridItem.addElement(div);
                            gridRow.addElement(gridItem);

                            div.fromXML(divXML, callback);
                        }
                    }

                    this.addElement(gridRow);
                }
            }
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            var gridRowNumElements:int = this.numElements;
            for (var row:int = 0; row < gridRowNumElements; row++)
            {
                var rowXML:XML = new XML("<div />");
                rowXML["@class"] = "ui-g";

                var gridRow:GridRow = this.getElementAt(row) as GridRow;
                var gridColumnNumElements:int = gridRow.numElements;
                for (var col:int = 0; col < gridColumnNumElements; col++)
                {
                    var gridCol:GridItem = gridRow.getElementAt(col) as GridItem;
                    var div:Div = gridCol.getElementAt(0) as Div;

                    var colXML:XML = new XML("<div />");
                    colXML["@class"] = this.getClassNameBasedOnColumns(gridRow);

                    colXML.appendChild(div.toCode());

                    rowXML.appendChild(colXML);
                }

                xml.appendChild(rowXML);
            }

            return xml;
        }

        public function addRow():void
        {
            var gridItem:GridItem = this.ensureCreateInitialColumn();
            var addedElements:Array = [gridItem.getElementAt(0)];

            dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, addedElements));

            this.selectedRow += 1;
            this.selectedColumn = 0;
        }

        public function removeRow(index:int):IVisualElement
        {
            if (this.numElements > MIN_ROW_COUNT)
            {
                currentColumnColor = currentColumnColor == "red" ? "yellow" : "red";
                var removedElement:GridRow = this.getElementAt(index) as GridRow;

                var removedItems:Array = [];
                var numRemovedElements:int = removedElement.numElements;
                for (var row:int = 0; row < numRemovedElements; row++)
                {
                    var gridItem:GridItem = removedElement.getElementAt(row) as GridItem;
                    removedItems.push(gridItem.getElementAt(0));
                }

                removedElement = this.removeElement(removedElement) as GridRow;
                if (removedElement)
                {
                    dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentRemoved, removedItems));
                }

                var selRow:int = this.selectedRow - 1;
                this.selectedRow = selRow == -1 ? 0 : selRow;

                return removedElement;
            }

            return null;
        }

        public function addColumn(rowIndex:int):void
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements < MAX_COLUMN_COUNT)
            {
                gridRow.percentWidth = gridRow.percentHeight = 100;

                var gridItem:GridItem = new GridItem();
                gridItem.setStyle("backgroundColor", "#a8a8a8");
                gridItem.percentWidth = gridItem.percentHeight = 100;

                var div:Div = new Div();
                div.percentWidth = div.percentHeight = 100;
                currentColumnColor = currentColumnColor == "red" ? "yellow" : "red";
                div.setStyle("borderColor", currentColumnColor);

                gridItem.addElement(div);
                gridRow.addElement(gridItem);

                this.selectedColumn += 1;

                dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, [div]));
            }
        }

        public function removeColumn(rowIndex:int, columnIndex:int):IVisualElement
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements > MIN_COLUMN_COUNT)
            {
                currentColumnColor = currentColumnColor == "red" ? "yellow" : "red";
                var removedColumn:IVisualElement = gridRow.removeElementAt(columnIndex);

                var selColumn:int = this.selectedColumn - 1;
                this.selectedColumn = selColumn == -1 ? 0 : selColumn;

                return removedColumn;
            }

            return null;
        }

        private function ensureCreateInitialColumn():GridItem
        {
            var gridRow:GridRow = new GridRow();
            gridRow.percentWidth = gridRow.percentHeight = 100;
            var gridItem:GridItem = new GridItem();
            gridItem.setStyle("backgroundColor", "#a8a8a8");
            gridItem.percentWidth = gridItem.percentHeight = 100;

            var div:Div = new Div();
            div.percentWidth = div.percentHeight = 100;
            currentColumnColor = currentColumnColor == "red" ? "yellow" : "red";
            div.setStyle("borderColor", currentColumnColor);

            gridItem.addElement(div);
            gridRow.addElement(gridItem);

            this.addElement(gridRow);

            return gridItem;
        }

        private function getClassNameBasedOnColumns(gridRow:GridRow):String
        {
            var uigDefaultValue:int = Math.ceil(MAX_COLUMN_COUNT / gridRow.numElements);
            var uigDefault:String = "ui-g-" + uigDefaultValue;
            var uigDesktop:String = "ui-lg-" + uigDefaultValue;

            var uigOtherScreensValue:int = Math.ceil(uigDefaultValue / 2);
            var uigPhones:String = "ui-sm-" + uigOtherScreensValue;
            var uigTablets:String = "ui-md-" + uigOtherScreensValue;
            var uigBigScreens:String = "ui-xl-" + uigDefaultValue;

            return uigDefault + " " + uigDesktop + " " + uigPhones + " " + uigTablets + " " + uigBigScreens;
        }
    }
}
