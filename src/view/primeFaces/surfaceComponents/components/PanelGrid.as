package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElement;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;

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
    [Exclude(name="heightOutput", kind="property")]
    [Exclude(name="widthOutput", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="addRowsWithColumnsToBody", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces panelGrid component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     *
     * <strong>Example 1:</strong>
     * <pre>
     * &lt;PanelGrid
     * <b>Attributes</b>
     * width="100"
     * height="30"/&gt;
     * &lt;Header name="header"&gt;
     *  &lt;Row&gt;
     *    &lt;Column&gt;Header Title 1&lt;/Column&gt;
     *    &lt;Column&gt;Header Title 2&lt;/Column&gt;
     *  &lt;/Row&gt;
     * &lt;/Header&gt;
     *  &lt;Row&gt;
     *    &lt;Column&gt;
     *      some control (ex: OutputLabel) which displays text
     *    &lt;/Column&gt;
     *    &lt;Column&gt;
     *      some control (ex: OutputLabel) which displays text
     *    &lt;/Column&gt;
     *  &lt;/Row&gt;
     * &lt;/PanelGrid&gt;
     * </pre>
     *
     * <strong>Example 2 - With control:</strong>
     * <pre>
     * &lt;PanelGrid
     * <b>Attributes</b>
     * width="100"
     * height="30"/&gt;
     * &lt;Header name="header"&gt;
     *  &lt;Row&gt;
     *    &lt;Column&gt;Header Title 1&lt;/Column&gt;
     *    &lt;Column&gt;Header Title 2&lt;/Column&gt;
     *  &lt;/Row&gt;
     * &lt;/Header&gt;
     *  &lt;Row&gt;
     *    &lt;Column&gt;
     *      &lt;Div class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"&gt;
     *          &lt;OutputLabel width="100" height="30" value="Label"/&gt;
     *      &lt;/Div&gt;
     *    &lt;/Column&gt;
     *    &lt;Column&gt;
     *      &lt;Div class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"&gt;
     *          &lt;OutputLabel width="100" height="30" value="Label"/&gt;
     *      &lt;/Div&gt;
     *    &lt;/Column&gt;
     *  &lt;/Row&gt;
     * &lt;/PanelGrid&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     *
     *
     * <strong>Output for Example 1:</strong>
     * <pre>
     * &lt;p:panelGrid
     * <b>Attributes</b>
     * width="100"
     * height="30"/&gt;
     *   &lt;f:facet name="header"&gt;
     *       &lt;p:row&gt;
     *        &lt;p:column&gt;Header Title 1&lt;/p:column&gt;
     *        &lt;p:column&gt;Header Title 2&lt;/p:column&gt;
     *       &lt;/p:row&gt;
     *   &lt;/f:facet&gt;
     *  &lt;p:row&gt;
     *    &lt;p:column&gt;
     *      &lt;div class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
     *    &lt;/p:column&gt;
     *    &lt;p:column&gt;
     *      &lt;div class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
     *    &lt;/p:column&gt;
     *  &lt;/p:row&gt;
     * &lt;/p:panelGrid&gt;
     * </pre>
     *
     * <strong>Output for Example 2:</strong>
     * <pre>
     * &lt;p:panelGrid
     * <b>Attributes</b>
     * width="100"
     * height="30"/&gt;
     *   &lt;f:facet name="header"&gt;
     *       &lt;p:row&gt;
     *        &lt;p:column&gt;Header Title 1&lt;/p:column&gt;
     *        &lt;p:column&gt;Header Title 2&lt;/p:column&gt;
     *       &lt;/p:row&gt;
     *   &lt;/f:facet&gt;
     *  &lt;p:row&gt;
     *    &lt;p:column&gt;&lt;p:outputLabel style="width:100px;height:30px;" value="Label Text"/&gt;&lt;/p:column&gt;
     *    &lt;p:column&gt;&lt;p:outputLabel style="width:100px;height:30px;" value="Label Text"/&gt;&lt;/p:column&gt;
     *  &lt;/p:row&gt;
     * &lt;/p:panelGrid&gt;
     * </pre>
     */
    public class PanelGrid extends Table implements IPrimeFacesSurfaceComponent, IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "panelGrid";
        public static const ELEMENT_NAME:String = "PanelGrid";

        private var bodyRowsXML:XMLList;
        private var thisCallbackXML:Function;

        private var contentChanged:Boolean;

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

            this.addEventListener(Event.ADDED_TO_STAGE, onPanelGridAddedRemovedFromStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, onPanelGridAddedRemovedFromStage);
            this.addEventListener(Event.RESIZE, onPanelGridResize);
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

        public function get isSelected():Boolean
        {
            return _isSelected;
        }

        public function set isSelected(value:Boolean):void
        {
            _isSelected = value;
        }

        private var _cdataXML:XML;

        public function get cdataXML():XML
        {
            return _cdataXML;
        }

        private var _cdataInformation:String;

        public function get cdataInformation():String
        {
            return _cdataInformation;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;PanelGrid percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:panelGrid style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;PanelGrid width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:panelGrid style="width:120px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;PanelGrid percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:panelGrid style="height:80%;"/&gt;</listing>
         */
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;PanelGrid height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:panelGrid style="height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        override public function set height(value:Number):void
        {
            super.height = value;
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
			var v:Object;
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
					for each (v in value)
					{
						if (isRemoval)
						{
							deleteIndex = v.parent.getElementIndex(v.object);
							v.parent.removeElementAt(deleteIndex);
						}
						else
						{
							if (nameField == "removeColumnAt" || nameField == "removeRowAt")
                            {
                                v.parent.addElementAt(v.object, v.index);
                            }
							else
                            {
                                v.parent.addElement(v.object);
                            }
						}
					}
					
					if (nameField == "addColumnAt" || nameField == "removeColumnAt")
                    {
                        this._columnCount = isRemoval ? this._columnCount - 1 : this._columnCount + 1;
                    }
					else if (nameField == "addRowAt" || nameField == "removeRowAt")
                    {
                        this._rowCount = isRemoval ? this._rowCount - 1 : this._rowCount + 1;
                    }

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

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@rowCount = this.rowCount;
            xml.@columnCount = this.columnCount;

            if (this.headerRowCount > 0)
            {
                xml.@headerRowCount = this.headerRowCount;
                var header:XML = new XML("<Header/>");
                header.@name = "header";
                toHeaderVisualXML(header);

                xml.appendChild(header);
            }

            toBodyVisualXML(xml);

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

            this.bodyRowsXML = xml.Row;
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
                    this.headerRowCount = -1;
                }
            }

            if (this.hasHeader)
            {
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
            }

            if ("@rowCount" in xml)
            {
                this.rowCount = xml.@rowCount;
            }
            else
            {
                rCount = bodyRowsXML.length();
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
                var columns:XMLList = bodyRowsXML[0].Column;
                var colCount:int = columns.length();
                if (colCount > 0)
                {
                    this.columnCount = colCount;
                }
                else
                {
                    this.columnCount = 1;
                }
            }

            thisCallbackXML = callback;
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
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			var componentsArray:Array = [];
			var organizerItem:OrganizerItem;
			var element:IPrimeFacesSurfaceComponent;
			var gridRow:GridRow;
			var gridCol:GridItem;
			var row:int;
			
			// returning particular tab index item
			if (params.length > 0)
			{
				if (params[0] == "addRowAt")
				{
					parseRowItems(this, this.body.getElementIndex(params[1] as GridRow));
				}
				else if (params[0] == "addColumnAt")
				{
					for (row = 0; row < this.body.numElements; row++)
					{
						gridCol = (this.body.getElementAt(row) as GridRow).getElementAt(params[2]) as GridItem;
						element = gridCol.getElementAt(0) as IPrimeFacesSurfaceComponent;
						organizerItem = element.getComponentsChildren();
						
						if (organizerItem)
						{
							organizerItem.type = OrganizerItem.TYPE_CELL;
							componentsArray.push(organizerItem);
						}
					}
				}
			}
			else
			{
				// return usual component reference
				for (row = 0; row < this.body.numElements; row++)
				{
					parseRowItems(this, row);
				}
			}
			
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, (componentsArray.length > 0) ? componentsArray : []));
			
			// @local
			// parse back items inside gridRow
			function parseRowItems(grid:PanelGrid, rowIndex:int):void
			{
				gridRow = grid.body.getElementAt(rowIndex) as GridRow;
				for (var col:int = 0; col < gridRow.numElements; col++)
				{
					gridCol = gridRow.getElementAt(col) as GridItem;
					element = gridCol.getElementAt(0) as IPrimeFacesSurfaceComponent;
					
					organizerItem = element.getComponentsChildren();
					if (organizerItem) 
					{
						organizerItem.name = "R"+ (rowIndex+1) +":C"+ (col+1);
						organizerItem.type = OrganizerItem.TYPE_CELL;
						componentsArray.push(organizerItem);
					}
				}
			}
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
            var tmpArr:Array = this.hasHeader ? addColumnToRow(this.header, headerRowCount - 1, 1) : [];
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

            if (this.hasHeader)
            {
                var colItem:IVisualElement = this.header.removeColumn(0, columnIndex);
                tmpArr.push({object: colItem, parent: this.header.getElementAt(0), index: columnIndex});
            }

            _columnCount -= 1;

            this.invalidateBorders();
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeColumnAt", tmpArr, tmpArr);
            dispatchEvent(new Event("columnsRemoved"));

            return colItem;
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (contentChanged)
            {
                callLater(adjustContainerSize);
                contentChanged = false;
            }
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (this.widthOutputChanged)
            {
                this.percentWidth = 100;
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
		
		override protected function createChildren():void
		{
			super.createChildren();
			commitProperties();
		}

        private function onPanelGridAddedRemovedFromStage(event:Event):void
        {
            if (event.type == Event.ADDED_TO_STAGE)
            {
                this.addEventListener(Event.RESIZE, onPanelGridResize);
            }
            else if (event.type == Event.REMOVED_FROM_STAGE)
            {
                this.removeEventListener(Event.RESIZE, onPanelGridResize);
            }
        }

        private function onPanelGridResize(event:Event):void
        {
            contentChanged = true;
        }

        private function toHeaderVisualXML(xml:XML):void
        {
            for (var row:int = 0; row < headerRowCount; row++)
            {
                var rowXML:XML = new XML("<Row/>");
                for (var col:int = 0; col < columnCount; col++)
                {
                    var xmlValue:String = "<Column>" + this.header.getTitle(row, col) + "</Column>";
                    var colXML:XML = new XML(xmlValue);

                    rowXML.appendChild(colXML);
                }
                xml.appendChild(rowXML);
            }
        }

        private function toBodyVisualXML(xml:XML):void
        {
            for (var row:int = 0; row < rowCount; row++)
            {
                var gridRow:GridRow = this.body.getElementAt(row) as GridRow;
                var rowXML:XML = new XML("<Row/>");
                for (var col:int = 0; col < columnCount; col++)
                {
                    var gridItem:GridItem = gridRow.getElementAt(col) as GridItem;
                    var item:IPrimeFacesSurfaceComponent = gridItem.getElementAt(0) as IPrimeFacesSurfaceComponent;
                    if (item === null) continue;

                    var xmlValue:String = "<Column></Column>";

                    var colXML:XML = new XML(xmlValue);
                    colXML.appendChild(item.toXML());

                    rowXML.appendChild(colXML);
                }
                xml.appendChild(rowXML);
            }
        }

        private function toCodeHeader(xml:XML):void
        {
            if (!this.hasHeader) return;

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
                var gridRow:GridRow = this.body.getElementAt(row) as GridRow;
                var rowXML:XML = new XML("<row/>");
                rowXML.addNamespace(primeFacesNamespace);
                rowXML.setNamespace(primeFacesNamespace);
                for (var col:int = 0; col < this.columnCount; col++)
                {
                    var gridItem:GridItem = gridRow.getElementAt(col) as GridItem;
                    var divContent:Div = gridItem.getElementAt(0) as Div;

                    var colXML:XML = new XML("<column></column>");
                    colXML.addNamespace(primeFacesNamespace);
                    colXML.setNamespace(primeFacesNamespace);

                    colXML.appendChild(divContent.toCode());

                    rowXML.appendChild(colXML);
                }

                xml.appendChild(rowXML);
            }
        }

        override protected function addRowsWithColumnsToBody():void
        {
            super.addRowsWithColumnsToBody();

            createChildrenFromXML();
        }

        private function createChildrenFromXML():void
        {
            if (!bodyRowsXML && thisCallbackXML == null) return;

            var bodyRowCount:int = this.body.numElements;
            for (var rowIndex:int = 0; rowIndex < bodyRowCount; rowIndex++)
            {
                var rowItem:GridRow = this.body.getElementAt(rowIndex) as GridRow;
                var columnsXML:XMLList = bodyRowsXML[rowIndex].Column;
                for (var colIndex:int = 0; colIndex < this.columnCount; colIndex++)
                {
                    var colItem:GridItem = rowItem.getElementAt(colIndex) as GridItem;
                    var container:Div = colItem.getElementAt(0) as Div;
                    container.percentHeight = Number.NaN;

                    var colXML:XML = columnsXML[colIndex];
                    var divs:XMLList = colXML.Div;
                    var divPercentHeight:Number = Number.NaN;

                    if (divs.length() > 0)
                    {
                        var divXMLList:XMLList = divs.children();
                        //Make transition only if div contains children, if not it does not needed.
                        if (divXMLList.length() > 0)
                        {
                            var divXML:XML = divs[0];
                            if ("@percentHeight" in divXML)
                            {
                                divPercentHeight = divXML.@percentHeight;
                                delete divXML.@percentHeight;
                            }

                            container.fromXML(divXML, thisCallbackXML);
                        }
                    }
                    else
                    {
                        for each (var columnContent:XML in colXML)
                        {
                            if (columnContent)
                            {
                                thisCallbackXML(container, columnContent);
                            }
                        }
                    }

                    contentChanged = true;
                    this.invalidateDisplayList();
                }
            }

            if (bodyRowCount > 0)
            {
                bodyRowsXML = null;
                thisCallbackXML = null;
            }
        }

        private function adjustContainerSize():void
        {
            var bodyRowCount:int = this.body.numElements;
            for (var rowIndex:int = 0; rowIndex < bodyRowCount; rowIndex++)
            {
                var row:GridRow = this.body.getElementAt(rowIndex) as GridRow;
                for (var colIndex:int = 0; colIndex < this.columnCount; colIndex++)
                {
                    var column:GridItem = row.getElementAt(colIndex) as GridItem;
                    var div:Div = column.getElementAt(0) as Div;
                    if (div.height < column.height)
                    {
                        div.percentHeight = 100;
                    }
                }
            }
        }
    }
}