package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import mx.containers.Grid;
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElement;
    import mx.core.ScrollPolicy;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.GridPropertyEditor;
    import view.primeFaces.supportClasses.events.GridEvent;

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

          //  this.setStyle("backgroundColor", "#a8a8a8");
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

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            var elementsXML:XMLList = xml.elements();
            if (elementsXML.length() > 0)
            {
                this.removeAllElements();
            }
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            return xml;
        }

        public function addRow():void
        {
            var addedElements:Array = [this.ensureCreateInitialRow()];

            dispatchEvent(new GridEvent(GridEvent.GridElementAdded, addedElements));
        }

        public function removeRow(index:int):IVisualElement
        {
            if (this.numElements > MIN_ROW_COUNT)
            {
                currentColumnColor = currentColumnColor == "red" ? "yellow" : "red";
                var removedElement:GridRow = this.getElementAt(index) as GridRow;

                var removedItems:Array = [];
                var numRemovedElements:int = removedElement.numElements;
                for (var i:int = 0; i < numRemovedElements; i++)
                {
                    removedItems.push(removedElement.getElementAt(i));
                }

                removedElement = this.removeElement(removedElement) as GridRow;
                if (removedElement)
                {
                    dispatchEvent(new GridEvent(GridEvent.GridElementRemoved, removedItems));
                }

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

                dispatchEvent(new GridEvent(GridEvent.GridElementAdded, [gridItem]));
            }
        }

        public function removeColumn(rowIndex:int, columnIndex:int):IVisualElement
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements > MIN_COLUMN_COUNT)
            {
                currentColumnColor = currentColumnColor == "red" ? "yellow" : "red";
                return gridRow.removeElementAt(columnIndex);
            }

            return null;
        }

        override protected function createChildren():void
        {
            this.ensureCreateInitialRow();
            super.createChildren();
        }

        private function ensureCreateInitialRow():GridItem
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
    }
}
