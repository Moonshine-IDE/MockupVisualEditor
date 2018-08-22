package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import mx.containers.GridItem;

    import mx.containers.GridRow;
    import mx.core.IVisualElement;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IComponentSizeOutput;
    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.PanelGridPropertyEditor;
    import view.primeFaces.supportClasses.table.Table;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;

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
    public class PanelGrid extends Table implements IPrimeFacesSurfaceComponent, IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput
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
                "panelGridValueChanged",
				"widthOutputChanged",
				"heightOutputChanged",
				"titleChanged"
            ];
        }

        private var _widthOutput:Boolean = true;
        private var widthOutputChanged:Boolean;

        [Bindable("widthOutputChanged")]
        public function get widthOutput():Boolean
        {
            return _widthOutput;
        }

        public function set widthOutput(value:Boolean):void
        {
			if (_widthOutput != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "widthOutput", _widthOutput, value);
				_widthOutput = value;

                if (!value)
                {
                    widthOutputChanged = true;
                    this.invalidateProperties();
                }

				dispatchEvent(new Event("widthOutputChanged"));
			}
        }

        private var _heightOutput:Boolean = true;
        private var heightOutputChanged:Boolean;

        [Bindable("heightOutputChanged")]
        public function get heightOutput():Boolean
        {
            return _heightOutput;
        }

        public function set heightOutput(value:Boolean):void
        {
			if (_heightOutput != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "heightOutput", _heightOutput, value);
				_heightOutput = value;

                if (!value)
                {
                    heightOutputChanged = true;
                    this.invalidateProperties();
                }

				dispatchEvent(new Event("heightOutputChanged"));
			}
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
		
		[Exclude(name="isSelected", kind="property")]
        public function get isSelected():Boolean
        {
            return _isSelected;
        }

        public function set isSelected(value:Boolean):void
        {
            _isSelected = value;
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
		
		override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, fieldName, oldValue, newValue);
			if (fieldName == "titleChanged") dispatchEvent(new Event(fieldName));
		}
		
		public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			var deleteIndex:int;
			var i:Object;
			var isRemoval:Boolean;
			switch(nameField)
			{
				case "titleChanged":
					value.parent.text = value.value;
					dispatchEvent(new Event(Grid.EVENT_CHILDREN_UPDATED));
					break;
				case "addColumnAt":
				case "addRowAt":
				case "removeColumnAt":
				case "removeRowAt":
					if ((value as Array).length == 0) return;
					
					try
					{
						isRemoval = true;
						deleteIndex = value[0].parent.getElementIndex(value[0].object);
					}
					catch (e:Error)
					{
						isRemoval = false;
					}
					for each (i in value)
					{
						if (isRemoval)
						{
							deleteIndex = i.parent.getElementIndex(i.object);
							i.parent.removeElementAt(deleteIndex);
						}
						else
						{
							if (nameField == "removeColumnAt" || nameField == "removeRowAt") i.parent.addElementAt(i.object, i.index);
							else i.parent.addElement(i.object);
						}
					}
					
					if (nameField == "addColumnAt" || nameField == "removeColumnAt") this._columnCount = isRemoval ? this._columnCount - 1 : this._columnCount + 1;
					else if (nameField == "addRowAt" || nameField == "removeRowAt") this._rowCount = isRemoval ? this._rowCount - 1 : this._rowCount + 1;
					dispatchEvent(new Event(Grid.EVENT_CHILDREN_UPDATED));
					break;
				default:
					this[nameField.toString()] = value;
					break;
			}
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
            var header:XMLList = xml.Header.Row;
            var rCount:int = 0;

            if ("@headerRowCount" in xml)
            {
                this.headerRowCount = xml.@headerRowCount;
            }
            else
            {
                rCount = header.length();
                if (rCount > 0)
                {
                    this.headerRowCount = rCount;
                }
                else
                {
                    this.headerRowCount = 1;
                }
            }

			this.headerRowTitles = [];
			for (var headerIndex:int = 0; headerIndex < this.headerRowCount; headerIndex++)
			{
				var tmpArr:Array = [];
				for each (var headerTitle:XML in header[headerIndex].Column)
				{
					tmpArr.push(headerTitle.toString());
				}
				
				headerRowTitles.push(tmpArr);
			}

            if ("@rowCount" in xml)
            {
                this.rowCount = xml.@rowCount;
            }
            else
            {
                rCount = bodyRows.length();
                if (rCount > 0)
                {
                    this.rowCount = rCount;
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
                var colCount = columns.length();
                if (colCount > 0)
                {
                    this.columnCount = colCount;
                }
                else
                {
                    this.columnCount = 1;
                }
            }

            this.callLater(createChildrenFromXML, [bodyRows, callback]);
        }

        public function toCode():XML
        {
			var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);

            toCodeHeader(xml);
            toCodeBody(xml);

            return xml;
        }

        public function addRow():void
        {
            var rowItem:GridRow = this.body.addRow() as GridRow;

            _rowCount += 1;

            var selectedRowIndex:int = rowCount - 1;
			var tmpArr:Array = addColumnToRow(this.body, selectedRowIndex, columnCount - 1);

            this.invalidateBorders();
			
			// @note
			// #devsena
			// it looks like the existing code auto-adds one column
			// while creating a new row - and subsequent column addition
			// returns a non-negative cell array by addColumnToRow therefore.
			// we have to manually adds the initial row/column to our array
			tmpArr.unshift({object:rowItem.getElementAt(0), parent:rowItem});
			// also adds the row against this.body reference at very end
			tmpArr.push({object:rowItem, parent:this.body});
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addRowAt", tmpArr, tmpArr);
            dispatchEvent(new Event("rowAdded"));
        }

        public function addColumn():void
        {
            var tmpArr:Array = addColumnToRow(this.header, headerRowCount - 1, 1);
            for (var row:int = 0; row < this.rowCount; row++)
            {
				tmpArr = tmpArr.concat(addColumnToRow(this.body, row, 1));
            }

            _columnCount += 1;
            this.invalidateBorders();
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addColumnAt", tmpArr, tmpArr);
            dispatchEvent(new Event("columnsAdded"));
        }

        public function removeRow(index:int):IVisualElement
        {
            if (_rowCount == 1) return null;

            var rowItem:IVisualElement = this.body.removeRow(index);

            _rowCount -= 1;

            this.invalidateBorders();
			
			var tmpArr:Array = [{object: rowItem, parent:this.body, index: index}];
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeRowAt", tmpArr, tmpArr);
            dispatchEvent(new Event("rowRemoved"));

            return rowItem;
        }

        public function removeColumn(columnIndex:int):IVisualElement
        {
            if (_columnCount == 1) return null;
			
			var tmpArr:Array = [];
            for (var row:int = 0; row < this.rowCount; row++)
            {
				tmpArr.push({object:this.body.removeColumn(row, columnIndex), parent:this.body.getElementAt(row), index:columnIndex});
            }

            var colItem:IVisualElement = this.header.removeColumn(0, columnIndex);
			tmpArr.push({object:colItem, parent:this.header.getElementAt(0), index:columnIndex});

            _columnCount -= 1;

            this.invalidateBorders();
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeColumnAt", tmpArr, tmpArr);
            dispatchEvent(new Event("columnsRemoved"));

            return colItem;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (this.widthOutputChanged)
            {
                this.percentWidth = Number.NaN;
                this.width = Number.NaN;
                this.widthOutputChanged = false;
            }

            if (this.heightOutputChanged)
            {
                this.percentHeight = Number.NaN;
                this.height = Number.NaN;
                this.heightOutputChanged = false;
            }
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
                    else
                    {
                        xmlValue = "<Column></Column>";
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

        private function createChildrenFromXML(bodyRows:XMLList, callback:Function):void
        {
            for (var rowIndex:int = 0; rowIndex < this.rowCount; rowIndex++)
            {
                var rowItem:GridRow = this.body.getElementAt(rowIndex) as GridRow;
                var columnsXML:XMLList = bodyRows[rowIndex].Column;
                for (var colIndex:int = 0; colIndex < this.columnCount; colIndex++)
                {
                    var colItem:GridItem = rowItem.getElementAt(colIndex) as GridItem;
                    var container:Div = colItem.getElementAt(0) as Div;
                    var colXML:XML = columnsXML[colIndex];

                    for each (var columnContent:XML in colXML)
                    {
                        if (columnContent)
                        {
                            callback(container, columnContent);
                        }
                    }
                }
            }
        }
    }
}